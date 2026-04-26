import { CharacterAlignment } from "../types/CharacterAlignmentTypes";

/**
 * Segments a Telugu word into individual letter units (one per Telugu
 * codepoint such as a consonant, vowel sign, or modifier mark) and pairs
 * each unit with the Latin letters it produces in ISO-15919 style.
 *
 * Used as a runtime fallback when the database does not yet have a
 * hand-curated character alignment for a given token.
 *
 * Letter-unit rules:
 *   - An independent vowel emits its full Latin form (e.g. ఆ → ā).
 *   - A consonant emits its base letters; if no vowel sign or virama
 *     immediately follows, the inherent 'a' is appended (e.g. ద → da,
 *     but ద followed by ి emits just 'd' and the matra emits 'i').
 *   - A virama attaches to its preceding consonant chip (so the chip
 *     reads as the bare consonant with no inherent vowel).
 *   - A vowel sign (matra) is its own chip with the vowel's Latin form.
 *   - Anusvara / visarga / candrabindu are their own chips.
 *
 * Hand-curated rows in `token_character_alignments` always take
 * precedence at the data layer.
 */

const VIRAMA_CODEPOINT = 0x0C4D;
const ANUSVARA_CODEPOINT = 0x0C02;
const VISARGA_CODEPOINT = 0x0C03;
const CANDRABINDU_CODEPOINT = 0x0C01;
const COMBINING_ANUSVARA_ABOVE = 0x0C00;
const LENGTH_MARK_CODEPOINT = 0x0C55;
const AI_LENGTH_MARK_CODEPOINT = 0x0C56;
const NUKTA_CODEPOINT = 0x0C3C;

/**
 * Map from a Telugu independent vowel codepoint to its ISO-15919 form.
 */
const INDEPENDENT_VOWEL_TO_LATIN: Record<number, string> = {
    0x0C05: "a",
    0x0C06: "ā",
    0x0C07: "i",
    0x0C08: "ī",
    0x0C09: "u",
    0x0C0A: "ū",
    0x0C0B: "r̥",
    0x0C60: "r̥̄",
    0x0C0C: "l̥",
    0x0C61: "l̥̄",
    0x0C0E: "e",
    0x0C0F: "ē",
    0x0C10: "ai",
    0x0C12: "o",
    0x0C13: "ō",
    0x0C14: "au",
};

/**
 * Map from a Telugu vowel sign (matra) codepoint to its Latin form.
 */
const VOWEL_SIGN_TO_LATIN: Record<number, string> = {
    0x0C3E: "ā",
    0x0C3F: "i",
    0x0C40: "ī",
    0x0C41: "u",
    0x0C42: "ū",
    0x0C43: "r̥",
    0x0C44: "r̥̄",
    0x0C46: "e",
    0x0C47: "ē",
    0x0C48: "ai",
    0x0C4A: "o",
    0x0C4B: "ō",
    0x0C4C: "au",
    0x0C62: "l̥",
    0x0C63: "l̥̄",
};

/**
 * Map from a Telugu consonant codepoint to its base ISO-15919 letters
 * WITHOUT the inherent 'a'. The 'a' is appended later only when no vowel
 * sign and no virama follow.
 */
const CONSONANT_TO_LATIN_BASE: Record<number, string> = {
    0x0C15: "k",
    0x0C16: "kh",
    0x0C17: "g",
    0x0C18: "gh",
    0x0C19: "ṅ",
    0x0C1A: "c",
    0x0C1B: "ch",
    0x0C1C: "j",
    0x0C1D: "jh",
    0x0C1E: "ñ",
    0x0C1F: "ṭ",
    0x0C20: "ṭh",
    0x0C21: "ḍ",
    0x0C22: "ḍh",
    0x0C23: "ṇ",
    0x0C24: "t",
    0x0C25: "th",
    0x0C26: "d",
    0x0C27: "dh",
    0x0C28: "n",
    0x0C2A: "p",
    0x0C2B: "ph",
    0x0C2C: "b",
    0x0C2D: "bh",
    0x0C2E: "m",
    0x0C2F: "y",
    0x0C30: "r",
    0x0C31: "ṟ",
    0x0C32: "l",
    0x0C33: "ḷ",
    0x0C35: "v",
    0x0C36: "ś",
    0x0C37: "ṣ",
    0x0C38: "s",
    0x0C39: "h",
};

function is_consonant(codepoint: number): boolean
{
    return Object.prototype.hasOwnProperty.call(CONSONANT_TO_LATIN_BASE, codepoint);
}

function is_independent_vowel(codepoint: number): boolean
{
    return Object.prototype.hasOwnProperty.call(INDEPENDENT_VOWEL_TO_LATIN, codepoint);
}

function is_vowel_sign(codepoint: number): boolean
{
    return Object.prototype.hasOwnProperty.call(VOWEL_SIGN_TO_LATIN, codepoint);
}

/**
 * Returns the Latin transliteration for a "starter" codepoint such as
 * anusvara, visarga, or candrabindu when it appears without a base
 * consonant. Returns an empty string if the codepoint isn't a known
 * standalone mark.
 */
function transliterate_standalone_mark(codepoint: number): string
{
    if (codepoint === ANUSVARA_CODEPOINT)
    {
        return "ṁ";
    }
    if (codepoint === VISARGA_CODEPOINT)
    {
        return "ḥ";
    }
    if (codepoint === CANDRABINDU_CODEPOINT || codepoint === COMBINING_ANUSVARA_ABOVE)
    {
        return "m̐";
    }
    if (codepoint === LENGTH_MARK_CODEPOINT || codepoint === AI_LENGTH_MARK_CODEPOINT)
    {
        return "";
    }
    if (codepoint === NUKTA_CODEPOINT)
    {
        return "";
    }
    return "";
}

/**
 * Computes a runtime CharacterAlignment list for a Telugu word. Each
 * element corresponds to a single Telugu codepoint paired with the
 * Latin letters that codepoint contributes to the transliteration.
 *
 * @param telugu_word The Telugu source word to break into letter units.
 * @returns One CharacterAlignment per Telugu codepoint, in left-to-right
 *   order, each with its own per-token color group starting at 1.
 */
export function segment_word_into_alignments(telugu_word: string): CharacterAlignment[]
{
    const codepoints = Array.from(telugu_word).map((char) => char.codePointAt(0) ?? 0);
    const characters = Array.from(telugu_word);
    const alignments: CharacterAlignment[] = [];

    for (let codepoint_index = 0; codepoint_index < codepoints.length; codepoint_index++)
    {
        const codepoint = codepoints[codepoint_index];
        const character = characters[codepoint_index];
        const next_codepoint = codepoint_index + 1 < codepoints.length ? codepoints[codepoint_index + 1] : 0;

        let telugu_glyph = character;
        let transliteration_text = "";

        if (is_consonant(codepoint))
        {
            // A CONSONANT EMITS ITS BASE LETTERS; APPEND THE INHERENT 'a' UNLESS A
            // VOWEL SIGN OR VIRAMA IMMEDIATELY FOLLOWS, IN WHICH CASE THAT NEXT UNIT
            // PROVIDES (OR SUPPRESSES) THE VOWEL.
            const base_letters = CONSONANT_TO_LATIN_BASE[codepoint];
            const has_following_vowel_sign = is_vowel_sign(next_codepoint);
            const has_following_virama = next_codepoint === VIRAMA_CODEPOINT;

            // ATTACH A FOLLOWING VIRAMA TO THIS CONSONANT'S CHIP SO THE GLYPH READS NATURALLY.
            if (has_following_virama)
            {
                telugu_glyph = character + characters[codepoint_index + 1];
                transliteration_text = base_letters;
                codepoint_index += 1;
            }
            else if (has_following_vowel_sign)
            {
                transliteration_text = base_letters;
            }
            else
            {
                transliteration_text = base_letters + "a";
            }
        }
        else if (is_independent_vowel(codepoint))
        {
            transliteration_text = INDEPENDENT_VOWEL_TO_LATIN[codepoint];
        }
        else if (is_vowel_sign(codepoint))
        {
            transliteration_text = VOWEL_SIGN_TO_LATIN[codepoint];
        }
        else if (codepoint === VIRAMA_CODEPOINT)
        {
            // STANDALONE VIRAMA (NO PRECEDING CONSONANT TO ATTACH TO): EMIT AN EMPTY CHIP.
            transliteration_text = "";
        }
        else
        {
            const standalone = transliterate_standalone_mark(codepoint);
            transliteration_text = standalone.length > 0 ? standalone : character;
        }

        alignments.push({
            position: alignments.length + 1,
            telugu_grapheme: telugu_glyph,
            transliteration_chars: transliteration_text,
            char_group: alignments.length + 1,
        });
    }

    return alignments;
}
