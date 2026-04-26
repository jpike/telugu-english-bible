/*
  # Re-segment token_character_alignments at the akshara (syllable) level

  ## Overview
  Restores the akshara-cluster segmentation: each Telugu orthographic
  syllable is one chip paired with its full Latin transliteration
  (consonant + vowel sign + anusvara/visarga/etc together). This matches
  the visual grouping shown in the original letter-mode design where
  ఆదియందు breaks into ఆ (ā), ది (di), యం (yaṁ), దు (du).

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
    length_mark text := U&'\0C55';
    ai_length_mark text := U&'\0C56';
    nukta_char text := U&'\0C3C';

    chars text[];
    aksharas text[] := ARRAY[]::text[];
    current_akshara text := '';
    cur_char text;
    prev_char text;
    is_attaching boolean;
    is_cons boolean;
    akshara_idx int;
    cur_akshara_text text;
    char_idx int;
    inner_char text;
    translit text;
    pending_inherent_a boolean;
    standalone text;
BEGIN
    IF p_word IS NULL OR length(p_word) = 0 THEN
        RETURN;
    END IF;

    chars := regexp_split_to_array(p_word, '');

    FOR char_idx IN 1..array_length(chars, 1) LOOP
        cur_char := chars[char_idx];

        IF length(current_akshara) = 0 THEN
            current_akshara := cur_char;
            CONTINUE;
        END IF;

        is_attaching :=
            (vowel_sign_to_latin ? cur_char)
            OR cur_char = virama_char
            OR cur_char = anusvara_char
            OR cur_char = visarga_char
            OR cur_char = candrabindu_char
            OR cur_char = combining_anusvara_above_char
            OR cur_char = length_mark
            OR cur_char = ai_length_mark
            OR cur_char = nukta_char;

        IF is_attaching THEN
            current_akshara := current_akshara || cur_char;
            CONTINUE;
        END IF;

        prev_char := substr(current_akshara, length(current_akshara), 1);
        is_cons := (consonant_to_latin ? cur_char);
        IF prev_char = virama_char AND is_cons THEN
            current_akshara := current_akshara || cur_char;
            CONTINUE;
        END IF;

        aksharas := array_append(aksharas, current_akshara);
        current_akshara := cur_char;
    END LOOP;

    IF length(current_akshara) > 0 THEN
        aksharas := array_append(aksharas, current_akshara);
    END IF;

    FOR akshara_idx IN 1..COALESCE(array_length(aksharas, 1), 0) LOOP
        cur_akshara_text := aksharas[akshara_idx];
        translit := '';
        pending_inherent_a := false;

        FOR char_idx IN 1..length(cur_akshara_text) LOOP
            inner_char := substr(cur_akshara_text, char_idx, 1);

            IF consonant_to_latin ? inner_char THEN
                IF pending_inherent_a THEN
                    translit := translit || 'a';
                    pending_inherent_a := false;
                END IF;
                translit := translit || (consonant_to_latin->>inner_char);
                pending_inherent_a := true;
            ELSIF independent_vowel_to_latin ? inner_char THEN
                IF pending_inherent_a THEN
                    translit := translit || 'a';
                    pending_inherent_a := false;
                END IF;
                translit := translit || (independent_vowel_to_latin->>inner_char);
            ELSIF vowel_sign_to_latin ? inner_char THEN
                translit := translit || (vowel_sign_to_latin->>inner_char);
                pending_inherent_a := false;
            ELSIF inner_char = virama_char THEN
                pending_inherent_a := false;
            ELSE
                standalone := CASE
                    WHEN inner_char = anusvara_char THEN U&'\1E41'
                    WHEN inner_char = visarga_char THEN U&'\1E25'
                    WHEN inner_char = candrabindu_char OR inner_char = combining_anusvara_above_char THEN U&'m\0310'
                    ELSE ''
                END;
                IF length(standalone) > 0 THEN
                    IF pending_inherent_a THEN
                        translit := translit || 'a';
                        pending_inherent_a := false;
                    END IF;
                    translit := translit || standalone;
                ELSE
                    IF pending_inherent_a THEN
                        translit := translit || 'a';
                        pending_inherent_a := false;
                    END IF;
                    translit := translit || inner_char;
                END IF;
            END IF;
        END LOOP;

        IF pending_inherent_a THEN
            translit := translit || 'a';
        END IF;

        akshara_position := akshara_idx;
        akshara_text_out := cur_akshara_text;
        translit_out := translit;
        group_out := akshara_idx;
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
