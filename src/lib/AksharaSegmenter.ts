import { CharacterAlignment } from "../types/CharacterAlignmentTypes";

/**
 * Segments a Telugu word into aksharas (orthographic syllables) and
 * produces an approximate ISO-15919-style transliteration for each
 * akshara. Used as a runtime fallback when the database does not yet
 * have a hand-curated character alignment for a given token.
 *
 * An "akshara" is a visual unit that begins with either an independent
 * vowel or a consonant, optionally followed by:
 *   - a vowel sign (matra) that overrides the consonant's inherent 'a'
 *   - one or more virama-joined consonants (conjunct cluster)
 *   - combining marks like anusvara, visarga, candrabindu, length marks
 *
 * The segmenter intentionally produces approximate transliterations.
 * Hand-curated rows in `token_character_alignments` always take
 * precedence at the data layer.
 */

const VIRAMA_CODEPOINT = 0x0C4D;
const ANUSVARA_CODEPOINT = 0x0C02;
const VISARGA_CODEPOINT = 0x0C03;
const CANDRABINDU_CODEPOINT = 0x0C01;
const COMBINING_ANUSVARA_ABOVE = 0x0C00;

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
    return "";
}

function is_attaching_codepoint(codepoint: number): boolean
{
    return (
        is_vowel_sign(codepoint)
        || codepoint === VIRAMA_CODEPOINT
        || codepoint === ANUSVARA_CODEPOINT
        || codepoint === VISARGA_CODEPOINT
        || codepoint === CANDRABINDU_CODEPOINT
        || codepoint === COMBINING_ANUSVARA_ABOVE
        || codepoint === 0x0C55
        || codepoint === 0x0C56
        || codepoint === 0x0C3C
    );
}

function transliterate_akshara(akshara_text: string): string
{
    const codepoints = Array.from(akshara_text).map((char) => char.codePointAt(0) ?? 0);
    let result = "";
    let pending_consonant_needs_inherent_vowel = false;

    function flush_inherent_vowel(): void
    {
        if (pending_consonant_needs_inherent_vowel)
        {
            result += "a";
            pending_consonant_needs_inherent_vowel = false;
        }
    }

    for (let codepoint_index = 0; codepoint_index < codepoints.length; codepoint_index++)
    {
        const codepoint = codepoints[codepoint_index];

        if (is_consonant(codepoint))
        {
            flush_inherent_vowel();
            result += CONSONANT_TO_LATIN_BASE[codepoint];
            pending_consonant_needs_inherent_vowel = true;
            continue;
        }

        if (is_independent_vowel(codepoint))
        {
            flush_inherent_vowel();
            result += INDEPENDENT_VOWEL_TO_LATIN[codepoint];
            continue;
        }

        if (is_vowel_sign(codepoint))
        {
            result += VOWEL_SIGN_TO_LATIN[codepoint];
            pending_consonant_needs_inherent_vowel = false;
            continue;
        }

        if (codepoint === VIRAMA_CODEPOINT)
        {
            pending_consonant_needs_inherent_vowel = false;
            continue;
        }

        const standalone_mark = transliterate_standalone_mark(codepoint);
        if (standalone_mark.length > 0)
        {
            flush_inherent_vowel();
            result += standalone_mark;
            continue;
        }

        flush_inherent_vowel();
        result += String.fromCodePoint(codepoint);
    }

    flush_inherent_vowel();
    return result;
}

function split_into_akshara_strings(telugu_word: string): string[]
{
    const codepoints = Array.from(telugu_word).map((char) => char.codePointAt(0) ?? 0);
    const aksharas: string[] = [];
    let current = "";

    for (let codepoint_index = 0; codepoint_index < codepoints.length; codepoint_index++)
    {
        const codepoint = codepoints[codepoint_index];
        const character = String.fromCodePoint(codepoint);

        if (current.length === 0)
        {
            current = character;
            continue;
        }

        if (is_attaching_codepoint(codepoint))
        {
            current += character;
            continue;
        }

        const previous_codepoint = current.codePointAt(current.length - 1) ?? 0;
        if (previous_codepoint === VIRAMA_CODEPOINT && is_consonant(codepoint))
        {
            current += character;
            continue;
        }

        aksharas.push(current);
        current = character;
    }

    if (current.length > 0)
    {
        aksharas.push(current);
    }

    return aksharas;
}

/**
 * Computes a runtime CharacterAlignment list for a Telugu word.
 *
 * @param telugu_word The Telugu source word to break into aksharas.
 * @returns One CharacterAlignment per akshara, in left-to-right order,
 *   each with its own per-token color group starting at 1.
 */
export function segment_word_into_alignments(telugu_word: string): CharacterAlignment[]
{
    const akshara_strings = split_into_akshara_strings(telugu_word);
    const alignments: CharacterAlignment[] = [];

    for (let akshara_index = 0; akshara_index < akshara_strings.length; akshara_index++)
    {
        const akshara_text = akshara_strings[akshara_index];
        const transliteration_text = transliterate_akshara(akshara_text);
        alignments.push({
            position: akshara_index + 1,
            telugu_grapheme: akshara_text,
            transliteration_chars: transliteration_text,
            char_group: akshara_index + 1,
        });
    }

    return alignments;
}
