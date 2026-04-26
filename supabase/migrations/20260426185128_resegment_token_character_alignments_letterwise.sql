/*
  # Re-segment token_character_alignments at the per-letter level

  ## Overview
  Replaces the akshara-cluster segmentation with a per-codepoint (letter)
  segmentation so that every Telugu letter unit (consonant, vowel sign,
  modifier mark, independent vowel) gets its own alignment row paired
  with the specific Latin letters it contributes.

  ## Logic
    - Consonant alone -> base letters + inherent 'a' (e.g. ద -> da)
    - Consonant followed by vowel sign -> base letters only; the vowel
      sign emits its own row (e.g. ద ి -> "d", "i")
    - Consonant followed by virama -> the virama is attached to the
      consonant chip, base letters only, no inherent 'a' (ద ్ -> "d")
    - Independent vowel -> its Latin form (ఆ -> "ā")
    - Anusvara/visarga/candrabindu -> their own chip (ం -> "ṁ")

  ## Tables Touched
    - token_character_alignments (TRUNCATE-and-INSERT for full reseed)
*/

CREATE OR REPLACE FUNCTION segment_telugu_word(p_word text)
RETURNS TABLE (akshara_position int, akshara_text_out text, translit_out text, group_out int)
LANGUAGE plpgsql
IMMUTABLE
AS $func$
DECLARE
    consonant_to_latin jsonb := '{
        "\u0c15":"k","\u0c16":"kh","\u0c17":"g","\u0c18":"gh","\u0c19":"\u1e45",
        "\u0c1a":"c","\u0c1b":"ch","\u0c1c":"j","\u0c1d":"jh","\u0c1e":"\u00f1",
        "\u0c1f":"\u1e6d","\u0c20":"\u1e6dh","\u0c21":"\u1e0d","\u0c22":"\u1e0dh","\u0c23":"\u1e47",
        "\u0c24":"t","\u0c25":"th","\u0c26":"d","\u0c27":"dh","\u0c28":"n",
        "\u0c2a":"p","\u0c2b":"ph","\u0c2c":"b","\u0c2d":"bh","\u0c2e":"m",
        "\u0c2f":"y","\u0c30":"r","\u0c31":"\u1e5f","\u0c32":"l","\u0c33":"\u1e37",
        "\u0c35":"v","\u0c36":"\u015b","\u0c37":"\u1e63","\u0c38":"s","\u0c39":"h"
    }'::jsonb;
    independent_vowel_to_latin jsonb := '{
        "\u0c05":"a","\u0c06":"\u0101","\u0c07":"i","\u0c08":"\u012b","\u0c09":"u","\u0c0a":"\u016b",
        "\u0c0b":"r\u0325","\u0c60":"r\u0325\u0304","\u0c0c":"l\u0325","\u0c61":"l\u0325\u0304",
        "\u0c0e":"e","\u0c0f":"\u0113","\u0c10":"ai","\u0c12":"o","\u0c13":"\u014d","\u0c14":"au"
    }'::jsonb;
    vowel_sign_to_latin jsonb := '{
        "\u0c3e":"\u0101","\u0c3f":"i","\u0c40":"\u012b","\u0c41":"u","\u0c42":"\u016b",
        "\u0c43":"r\u0325","\u0c44":"r\u0325\u0304",
        "\u0c46":"e","\u0c47":"\u0113","\u0c48":"ai","\u0c4a":"o","\u0c4b":"\u014d","\u0c4c":"au",
        "\u0c62":"l\u0325","\u0c63":"l\u0325\u0304"
    }'::jsonb;
    virama_char text := U&'\0C4D';
    anusvara_char text := U&'\0C02';
    visarga_char text := U&'\0C03';
    candrabindu_char text := U&'\0C01';
    combining_anusvara_above_char text := U&'\0C00';

    chars text[];
    char_count int;
    char_idx int := 1;
    cur_char text;
    next_char text;
    glyph_text text;
    translit text;
    out_index int := 0;
BEGIN
    IF p_word IS NULL OR length(p_word) = 0 THEN
        RETURN;
    END IF;

    chars := regexp_split_to_array(p_word, '');
    char_count := array_length(chars, 1);

    WHILE char_idx <= char_count LOOP
        cur_char := chars[char_idx];
        next_char := CASE WHEN char_idx + 1 <= char_count THEN chars[char_idx + 1] ELSE '' END;
        glyph_text := cur_char;
        translit := '';

        IF consonant_to_latin ? cur_char THEN
            IF next_char = virama_char THEN
                glyph_text := cur_char || next_char;
                translit := consonant_to_latin->>cur_char;
                char_idx := char_idx + 2;
            ELSIF vowel_sign_to_latin ? next_char THEN
                translit := consonant_to_latin->>cur_char;
                char_idx := char_idx + 1;
            ELSE
                translit := (consonant_to_latin->>cur_char) || 'a';
                char_idx := char_idx + 1;
            END IF;
        ELSIF independent_vowel_to_latin ? cur_char THEN
            translit := independent_vowel_to_latin->>cur_char;
            char_idx := char_idx + 1;
        ELSIF vowel_sign_to_latin ? cur_char THEN
            translit := vowel_sign_to_latin->>cur_char;
            char_idx := char_idx + 1;
        ELSIF cur_char = virama_char THEN
            translit := '';
            char_idx := char_idx + 1;
        ELSIF cur_char = anusvara_char THEN
            translit := U&'\1E41';
            char_idx := char_idx + 1;
        ELSIF cur_char = visarga_char THEN
            translit := U&'\1E25';
            char_idx := char_idx + 1;
        ELSIF cur_char = candrabindu_char OR cur_char = combining_anusvara_above_char THEN
            translit := U&'m\0310';
            char_idx := char_idx + 1;
        ELSE
            translit := cur_char;
            char_idx := char_idx + 1;
        END IF;

        out_index := out_index + 1;
        akshara_position := out_index;
        akshara_text_out := glyph_text;
        translit_out := translit;
        group_out := out_index;
        RETURN NEXT;
    END LOOP;
END;
$func$;

DELETE FROM token_character_alignments;

INSERT INTO token_character_alignments (verse_token_id, position, telugu_grapheme, transliteration_chars, char_group)
SELECT
    vt.id AS verse_token_id,
    seg.akshara_position,
    seg.akshara_text_out,
    seg.translit_out,
    seg.group_out
FROM verse_tokens vt,
     LATERAL segment_telugu_word(vt.telugu_word) AS seg;
