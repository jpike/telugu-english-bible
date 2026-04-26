/*
  # Seed complete Psalm 139 (the all-knowing, ever-present God)

  1. Content additions
    - Creates chapter row for Psalms 139 (book_id=19, chapter_number=139) if absent.
    - Seeds all 24 verses with BSI-style Telugu, WEB English, ISO-15919 transliteration.
    - Seeds aligned verse_tokens with per-verse alignment_group integers so words colour-link.

  2. Strategy
    - Idempotent: chapter and verses upserted by natural keys; tokens cleared and re-inserted per verse.
    - No schema changes; data only.

  3. Notes
    - David''s psalm exalting God''s omniscience, omnipresence, and creative wonder.
*/

DO $$
DECLARE
    chapter_id_var bigint;
    verse_id_var bigint;
BEGIN
    INSERT INTO chapters (book_id, chapter_number)
    VALUES (19, 139)
    ON CONFLICT (book_id, chapter_number) DO UPDATE SET chapter_number = EXCLUDED.chapter_number
    RETURNING id INTO chapter_id_var;

    -- VERSE 1
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 1,
        'యెహోవా, నీవు నన్ను పరిశోధించి తెలిసికొనియున్నావు.',
        'Yahweh, you have searched me, and you know me.',
        'yehōvā, nīvu nannu pariśōdhiñci telisikoniyunnāvu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యెహోవా,', 'yehōvā,', 'Yahweh,', 1),
        (verse_id_var, 2, 'నీవు', 'nīvu', 'you', 2),
        (verse_id_var, 3, 'నన్ను', 'nannu', 'me', 3),
        (verse_id_var, 4, 'పరిశోధించి', 'pariśōdhiñci', 'have searched', 4),
        (verse_id_var, 5, 'తెలిసికొనియున్నావు.', 'telisikoniyunnāvu.', 'and know.', 5);

    -- VERSE 2
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 2,
        'నేను కూర్చుండుట నేను లేచుట నీకు తెలియును దూరమునుండియే నీవు నా తలంపులు గ్రహించుచున్నావు.',
        'You know my sitting down and my rising up. You perceive my thoughts from afar.',
        'nēnu kūrcuṃḍuṭa nēnu lēcuṭa nīku teliyunu dūramunuṃḍiyē nīvu nā talaṃpulu grahiñcucunnāvu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నేను', 'nēnu', 'my', 1),
        (verse_id_var, 2, 'కూర్చుండుట', 'kūrcuṃḍuṭa', 'sitting down', 2),
        (verse_id_var, 3, 'నేను', 'nēnu', 'my', 1),
        (verse_id_var, 4, 'లేచుట', 'lēcuṭa', 'rising up', 3),
        (verse_id_var, 5, 'నీకు', 'nīku', 'you', 4),
        (verse_id_var, 6, 'తెలియును', 'teliyunu', 'know', 5),
        (verse_id_var, 7, 'దూరమునుండియే', 'dūramunuṃḍiyē', 'from afar', 6),
        (verse_id_var, 8, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 9, 'నా', 'nā', 'my', 1),
        (verse_id_var, 10, 'తలంపులు', 'talaṃpulu', 'thoughts', 7),
        (verse_id_var, 11, 'గ్రహించుచున్నావు.', 'grahiñcucunnāvu.', 'perceive.', 8);

    -- VERSE 3
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 3,
        'నా నడకను నా పడకను నీవు పరిశీలన చేసియున్నావు నా చర్యలన్నిటిని నీవు బాగుగా తెలిసికొనియున్నావు.',
        'You search out my path and my lying down, and are acquainted with all my ways.',
        'nā naḍakanu nā paḍakanu nīvu pariśīlana cēsiyunnāvu nā caryalanniṭini nīvu bāgugā telisikoniyunnāvu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నా', 'nā', 'my', 1),
        (verse_id_var, 2, 'నడకను', 'naḍakanu', 'path', 2),
        (verse_id_var, 3, 'నా', 'nā', 'my', 1),
        (verse_id_var, 4, 'పడకను', 'paḍakanu', 'lying down', 3),
        (verse_id_var, 5, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 6, 'పరిశీలన', 'pariśīlana', 'search out', 5),
        (verse_id_var, 7, 'చేసియున్నావు', 'cēsiyunnāvu', 'have', 6),
        (verse_id_var, 8, 'నా', 'nā', 'my', 1),
        (verse_id_var, 9, 'చర్యలన్నిటిని', 'caryalanniṭini', 'all ways', 7),
        (verse_id_var, 10, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 11, 'బాగుగా', 'bāgugā', 'well', 8),
        (verse_id_var, 12, 'తెలిసికొనియున్నావు.', 'telisikoniyunnāvu.', 'are acquainted with.', 9);

    -- VERSE 4
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 4,
        'యెహోవా, నా నాలుకకు రాని మాట ఏదైనను నీకు పూర్తిగా తెలిసేయున్నది.',
        'For there is not a word on my tongue, but, behold, Yahweh, you know it altogether.',
        'yehōvā, nā nālukaku rāni māṭa ēdainanu nīku pūrtigā telisēyunnadi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యెహోవా,', 'yehōvā,', 'Yahweh,', 1),
        (verse_id_var, 2, 'నా', 'nā', 'my', 2),
        (verse_id_var, 3, 'నాలుకకు', 'nālukaku', 'on tongue', 3),
        (verse_id_var, 4, 'రాని', 'rāni', 'not', 4),
        (verse_id_var, 5, 'మాట', 'māṭa', 'a word', 5),
        (verse_id_var, 6, 'ఏదైనను', 'ēdainanu', 'there is', 6),
        (verse_id_var, 7, 'నీకు', 'nīku', 'you', 7),
        (verse_id_var, 8, 'పూర్తిగా', 'pūrtigā', 'altogether', 8),
        (verse_id_var, 9, 'తెలిసేయున్నది.', 'telisēyunnadi.', 'know it.', 9);

    -- VERSE 5
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 5,
        'వెనుక ముందులందు నీవు నన్ను ఆవరించియున్నావు నీ చేతిని నాపైన ఉంచియున్నావు.',
        'You hem me in behind and before. You laid your hand on me.',
        'venuka muṃdulaṃdu nīvu nannu āvariñciyunnāvu nī cētini nāpaina uṃciyunnāvu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'వెనుక', 'venuka', 'behind', 1),
        (verse_id_var, 2, 'ముందులందు', 'muṃdulaṃdu', 'and before', 2),
        (verse_id_var, 3, 'నీవు', 'nīvu', 'you', 3),
        (verse_id_var, 4, 'నన్ను', 'nannu', 'me', 4),
        (verse_id_var, 5, 'ఆవరించియున్నావు', 'āvariñciyunnāvu', 'hem in', 5),
        (verse_id_var, 6, 'నీ', 'nī', 'your', 6),
        (verse_id_var, 7, 'చేతిని', 'cētini', 'hand', 7),
        (verse_id_var, 8, 'నాపైన', 'nāpaina', 'on me', 8),
        (verse_id_var, 9, 'ఉంచియున్నావు.', 'uṃciyunnāvu.', 'laid.', 9);

    -- VERSE 6
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 6,
        'ఆ జ్ఞానము నాకు మించినది అది అతిశయమైనది అది నాకు అందశక్యము కాదు.',
        'This knowledge is beyond me. It''s lofty. I can''t attain it.',
        'ā jñānamu nāku miñcinadi adi atiśayamainadi adi nāku aṃdaśakyamu kādu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆ', 'ā', 'this', 1),
        (verse_id_var, 2, 'జ్ఞానము', 'jñānamu', 'knowledge', 2),
        (verse_id_var, 3, 'నాకు', 'nāku', 'me', 3),
        (verse_id_var, 4, 'మించినది', 'miñcinadi', 'is beyond', 4),
        (verse_id_var, 5, 'అది', 'adi', 'it', 5),
        (verse_id_var, 6, 'అతిశయమైనది', 'atiśayamainadi', 'is lofty', 6),
        (verse_id_var, 7, 'అది', 'adi', 'it', 5),
        (verse_id_var, 8, 'నాకు', 'nāku', 'I', 3),
        (verse_id_var, 9, 'అందశక్యము', 'aṃdaśakyamu', 'can attain', 7),
        (verse_id_var, 10, 'కాదు.', 'kādu.', 'can''t.', 8);

    -- VERSE 7
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 7,
        'నీ ఆత్మయొద్దనుండి నేను ఎక్కడికి పోగలను? నీ సన్నిధినుండి నేనెక్కడికి పారిపోగలను?',
        'Where could I go from your Spirit? Or where could I flee from your presence?',
        'nī ātmayoddanuṃḍi nēnu ekkaḍiki pōgalanu? nī sannidhinuṃḍi nēnekkaḍiki pāripōgalanu?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 2, 'ఆత్మయొద్దనుండి', 'ātmayoddanuṃḍi', 'from Spirit', 2),
        (verse_id_var, 3, 'నేను', 'nēnu', 'I', 3),
        (verse_id_var, 4, 'ఎక్కడికి', 'ekkaḍiki', 'where', 4),
        (verse_id_var, 5, 'పోగలను?', 'pōgalanu?', 'could go?', 5),
        (verse_id_var, 6, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 7, 'సన్నిధినుండి', 'sannidhinuṃḍi', 'from presence', 6),
        (verse_id_var, 8, 'నేనెక్కడికి', 'nēnekkaḍiki', 'where could I', 7),
        (verse_id_var, 9, 'పారిపోగలను?', 'pāripōgalanu?', 'flee?', 8);

    -- VERSE 8
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 8,
        'నేను ఆకాశమునకెక్కినను నీవు అక్కడను ఉన్నావు నేను పాతాళమందు పడకవేసికొనినను నీవు అక్కడను ఉన్నావు.',
        'If I ascend up into heaven, you are there. If I make my bed in Sheol, behold, you are there!',
        'nēnu ākāśamunakekkinanu nīvu akkaḍanu unnāvu nēnu pātāḷamaṃdu paḍakavēsikoninanu nīvu akkaḍanu unnāvu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 2, 'ఆకాశమునకెక్కినను', 'ākāśamunakekkinanu', 'if ascend into heaven', 2),
        (verse_id_var, 3, 'నీవు', 'nīvu', 'you', 3),
        (verse_id_var, 4, 'అక్కడను', 'akkaḍanu', 'there', 4),
        (verse_id_var, 5, 'ఉన్నావు', 'unnāvu', 'are', 5),
        (verse_id_var, 6, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 7, 'పాతాళమందు', 'pātāḷamaṃdu', 'in Sheol', 6),
        (verse_id_var, 8, 'పడకవేసికొనినను', 'paḍakavēsikoninanu', 'if make bed', 7),
        (verse_id_var, 9, 'నీవు', 'nīvu', 'you', 3),
        (verse_id_var, 10, 'అక్కడను', 'akkaḍanu', 'there', 4),
        (verse_id_var, 11, 'ఉన్నావు.', 'unnāvu.', 'are.', 5);

    -- VERSE 9
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 9,
        'నేను వేకువ రెక్కలు కట్టుకొని సముద్రపు దిగంతములలో నివసించినను',
        'If I take the wings of the dawn, and settle in the uttermost parts of the sea;',
        'nēnu vēkuva rekkalu kaṭṭukoni samudrapu digaṃtamulalō nivasiñcinanu')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 2, 'వేకువ', 'vēkuva', 'of the dawn', 2),
        (verse_id_var, 3, 'రెక్కలు', 'rekkalu', 'the wings', 3),
        (verse_id_var, 4, 'కట్టుకొని', 'kaṭṭukoni', 'if take', 4),
        (verse_id_var, 5, 'సముద్రపు', 'samudrapu', 'of the sea', 5),
        (verse_id_var, 6, 'దిగంతములలో', 'digaṃtamulalō', 'in the uttermost parts', 6),
        (verse_id_var, 7, 'నివసించినను', 'nivasiñcinanu', 'and settle', 7);

    -- VERSE 10
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 10,
        'అక్కడను నీ చెయ్యి నన్ను నడిపించును నీ కుడిచెయ్యి నన్ను పట్టుకొనును.',
        'Even there your hand will lead me, and your right hand will hold me.',
        'akkaḍanu nī ceyyi nannu naḍipiñcunu nī kuḍiceyyi nannu paṭṭukonunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అక్కడను', 'akkaḍanu', 'even there', 1),
        (verse_id_var, 2, 'నీ', 'nī', 'your', 2),
        (verse_id_var, 3, 'చెయ్యి', 'ceyyi', 'hand', 3),
        (verse_id_var, 4, 'నన్ను', 'nannu', 'me', 4),
        (verse_id_var, 5, 'నడిపించును', 'naḍipiñcunu', 'will lead', 5),
        (verse_id_var, 6, 'నీ', 'nī', 'your', 2),
        (verse_id_var, 7, 'కుడిచెయ్యి', 'kuḍiceyyi', 'right hand', 6),
        (verse_id_var, 8, 'నన్ను', 'nannu', 'me', 4),
        (verse_id_var, 9, 'పట్టుకొనును.', 'paṭṭukonunu.', 'will hold.', 7);

    -- VERSE 11
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 11,
        'అంధకారము నన్ను కప్పును, నన్ను ఆవరించు వెలుగు రాత్రియై పోవును అని నేననుకొనినను',
        'If I say, "Surely the darkness will overwhelm me; the light around me will be night;"',
        'aṃdhakāramu nannu kappunu, nannu āvariñcu velugu rātriyai pōvunu ani nēnanukoninanu')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అంధకారము', 'aṃdhakāramu', 'the darkness', 1),
        (verse_id_var, 2, 'నన్ను', 'nannu', 'me', 2),
        (verse_id_var, 3, 'కప్పును,', 'kappunu,', 'will overwhelm,', 3),
        (verse_id_var, 4, 'నన్ను', 'nannu', 'me', 2),
        (verse_id_var, 5, 'ఆవరించు', 'āvariñcu', 'around', 4),
        (verse_id_var, 6, 'వెలుగు', 'velugu', 'the light', 5),
        (verse_id_var, 7, 'రాత్రియై', 'rātriyai', 'be night', 6),
        (verse_id_var, 8, 'పోవును', 'pōvunu', 'will', 7),
        (verse_id_var, 9, 'అని', 'ani', 'surely', 8),
        (verse_id_var, 10, 'నేననుకొనినను', 'nēnanukoninanu', 'if I say', 9);

    -- VERSE 12
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 12,
        'నీకు అంధకారము అంధకారముగా నుండదు రాత్రి పగటివలె నీకు వెలుగుగా నుండును అంధకారమును వెలుగును నీకు ఏకరీతిగా నున్నవి.',
        'even the darkness doesn''t hide from you, but the night shines as the day. The darkness is like light to you.',
        'nīku aṃdhakāramu aṃdhakāramugā nuṃḍadu rātri pagaṭivale nīku velugugā nuṃḍunu aṃdhakāramunu velugunu nīku ēkarītigā nunnavi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీకు', 'nīku', 'from you', 1),
        (verse_id_var, 2, 'అంధకారము', 'aṃdhakāramu', 'the darkness', 2),
        (verse_id_var, 3, 'అంధకారముగా', 'aṃdhakāramugā', 'as darkness', 2),
        (verse_id_var, 4, 'నుండదు', 'nuṃḍadu', 'doesn''t hide', 3),
        (verse_id_var, 5, 'రాత్రి', 'rātri', 'the night', 4),
        (verse_id_var, 6, 'పగటివలె', 'pagaṭivale', 'as the day', 5),
        (verse_id_var, 7, 'నీకు', 'nīku', 'to you', 1),
        (verse_id_var, 8, 'వెలుగుగా', 'velugugā', 'shines', 6),
        (verse_id_var, 9, 'నుండును', 'nuṃḍunu', 'is', 7),
        (verse_id_var, 10, 'అంధకారమును', 'aṃdhakāramunu', 'darkness', 2),
        (verse_id_var, 11, 'వెలుగును', 'velugunu', 'and light', 8),
        (verse_id_var, 12, 'నీకు', 'nīku', 'to you', 1),
        (verse_id_var, 13, 'ఏకరీతిగా', 'ēkarītigā', 'alike', 9),
        (verse_id_var, 14, 'నున్నవి.', 'nunnavi.', 'are.', 7);

    -- VERSE 13
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 13,
        'నా అంతరింద్రియములను నీవు సృజించితివి నా తల్లి గర్భమందు నన్ను నిర్మించితివి.',
        'For you formed my inmost being. You knit me together in my mother''s womb.',
        'nā aṃtariṃdriyamulanu nīvu sr̥jiñcitivi nā talli garbhamaṃdu nannu nirmiñcitivi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నా', 'nā', 'my', 1),
        (verse_id_var, 2, 'అంతరింద్రియములను', 'aṃtariṃdriyamulanu', 'inmost being', 2),
        (verse_id_var, 3, 'నీవు', 'nīvu', 'you', 3),
        (verse_id_var, 4, 'సృజించితివి', 'sr̥jiñcitivi', 'formed', 4),
        (verse_id_var, 5, 'నా', 'nā', 'my', 1),
        (verse_id_var, 6, 'తల్లి', 'talli', 'mother''s', 5),
        (verse_id_var, 7, 'గర్భమందు', 'garbhamaṃdu', 'in womb', 6),
        (verse_id_var, 8, 'నన్ను', 'nannu', 'me', 7),
        (verse_id_var, 9, 'నిర్మించితివి.', 'nirmiñcitivi.', 'knit together.', 8);

    -- VERSE 14
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 14,
        'నీవు నన్ను భయంకరమును ఆశ్చర్యమునైన రీతిగా సృజించితివి అందుకు నేను నీకు కృతజ్ఞతాస్తుతులు చెల్లించుచున్నాను నీ కార్యములు ఆశ్చర్యకరములు.',
        'I will give thanks to you, for I am fearfully and wonderfully made. Your works are wonderful. My soul knows that very well.',
        'nīvu nannu bhayaṃkaramunu āścaryamunaina rītigā sr̥jiñcitivi aṃduku nēnu nīku kr̥tajñatāstutulu cellincucunnānu nī kāryamulu āścaryakaramulu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీవు', 'nīvu', 'you', 1),
        (verse_id_var, 2, 'నన్ను', 'nannu', 'me', 2),
        (verse_id_var, 3, 'భయంకరమును', 'bhayaṃkaramunu', 'fearfully', 3),
        (verse_id_var, 4, 'ఆశ్చర్యమునైన', 'āścaryamunaina', 'and wonderfully', 4),
        (verse_id_var, 5, 'రీతిగా', 'rītigā', 'in way', 5),
        (verse_id_var, 6, 'సృజించితివి', 'sr̥jiñcitivi', 'made', 6),
        (verse_id_var, 7, 'అందుకు', 'aṃduku', 'for', 7),
        (verse_id_var, 8, 'నేను', 'nēnu', 'I', 8),
        (verse_id_var, 9, 'నీకు', 'nīku', 'to you', 9),
        (verse_id_var, 10, 'కృతజ్ఞతాస్తుతులు', 'kr̥tajñatāstutulu', 'thanks', 10),
        (verse_id_var, 11, 'చెల్లించుచున్నాను', 'cellincucunnānu', 'will give', 11),
        (verse_id_var, 12, 'నీ', 'nī', 'your', 12),
        (verse_id_var, 13, 'కార్యములు', 'kāryamulu', 'works', 13),
        (verse_id_var, 14, 'ఆశ్చర్యకరములు.', 'āścaryakaramulu.', 'are wonderful.', 14);

    -- VERSE 15
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 15,
        'నేను రహస్యమందు పుట్టినప్పుడు భూమియొక్క గుహలయందు విచిత్రముగా నిర్మింపబడినప్పుడు నా శరీరము నీకు మరుగైయుండలేదు.',
        'My frame wasn''t hidden from you, when I was made in secret, woven together in the depths of the earth.',
        'nēnu rahasyamaṃdu puṭṭinappuḍu bhūmiyokka guhalayaṃdu vicitramugā nirmiṃpabaḍinappuḍu nā śarīramu nīku marugaiyuṃḍalēdu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 2, 'రహస్యమందు', 'rahasyamaṃdu', 'in secret', 2),
        (verse_id_var, 3, 'పుట్టినప్పుడు', 'puṭṭinappuḍu', 'when was made', 3),
        (verse_id_var, 4, 'భూమియొక్క', 'bhūmiyokka', 'of the earth', 4),
        (verse_id_var, 5, 'గుహలయందు', 'guhalayaṃdu', 'in the depths', 5),
        (verse_id_var, 6, 'విచిత్రముగా', 'vicitramugā', 'wonderfully', 6),
        (verse_id_var, 7, 'నిర్మింపబడినప్పుడు', 'nirmiṃpabaḍinappuḍu', 'woven together', 7),
        (verse_id_var, 8, 'నా', 'nā', 'my', 8),
        (verse_id_var, 9, 'శరీరము', 'śarīramu', 'frame', 9),
        (verse_id_var, 10, 'నీకు', 'nīku', 'from you', 10),
        (verse_id_var, 11, 'మరుగైయుండలేదు.', 'marugaiyuṃḍalēdu.', 'wasn''t hidden.', 11);

    -- VERSE 16
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 16,
        'నేను పిండమునై యుండగా నీ కన్నులు నన్ను చూచెను నియమింపబడిన దినములలో ఒక్కటైనను రాకమునుపే నా దినములన్నియు నీ గ్రంథములో లిఖితములాయెను.',
        'Your eyes saw my body. In your book they were all written, the days that were ordained for me, when as yet there were none of them.',
        'nēnu piṃḍamunai yuṃḍagā nī kannulu nannu cūcenu niyamiṃpabaḍina dinamulalō okkaṭainanu rākamunupē nā dinamulanniyu nī graṃthamulō likhitamulāyenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నేను', 'nēnu', 'my', 1),
        (verse_id_var, 2, 'పిండమునై', 'piṃḍamunai', 'unformed body', 2),
        (verse_id_var, 3, 'యుండగా', 'yuṃḍagā', 'when', 3),
        (verse_id_var, 4, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 5, 'కన్నులు', 'kannulu', 'eyes', 5),
        (verse_id_var, 6, 'నన్ను', 'nannu', 'me', 6),
        (verse_id_var, 7, 'చూచెను', 'cūcenu', 'saw', 7),
        (verse_id_var, 8, 'నియమింపబడిన', 'niyamiṃpabaḍina', 'were ordained', 8),
        (verse_id_var, 9, 'దినములలో', 'dinamulalō', 'in days', 9),
        (verse_id_var, 10, 'ఒక్కటైనను', 'okkaṭainanu', 'when none', 10),
        (verse_id_var, 11, 'రాకమునుపే', 'rākamunupē', 'as yet there were', 11),
        (verse_id_var, 12, 'నా', 'nā', 'my', 1),
        (verse_id_var, 13, 'దినములన్నియు', 'dinamulanniyu', 'all days', 9),
        (verse_id_var, 14, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 15, 'గ్రంథములో', 'graṃthamulō', 'in book', 12),
        (verse_id_var, 16, 'లిఖితములాయెను.', 'likhitamulāyenu.', 'were written.', 13);

    -- VERSE 17
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 17,
        'దేవా, నీ తలంపులు నాకెంత ప్రియమైనవి! వాటి మొత్తము ఎంతో గొప్పది.',
        'How precious to me are your thoughts, God! How vast is the sum of them!',
        'dēvā, nī talaṃpulu nākeṃta priyamainavi! vāṭi mottamu eṃtō goppadi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'దేవా,', 'dēvā,', 'God,', 1),
        (verse_id_var, 2, 'నీ', 'nī', 'your', 2),
        (verse_id_var, 3, 'తలంపులు', 'talaṃpulu', 'thoughts', 3),
        (verse_id_var, 4, 'నాకెంత', 'nākeṃta', 'how to me', 4),
        (verse_id_var, 5, 'ప్రియమైనవి!', 'priyamainavi!', 'precious are!', 5),
        (verse_id_var, 6, 'వాటి', 'vāṭi', 'of them', 6),
        (verse_id_var, 7, 'మొత్తము', 'mottamu', 'the sum', 7),
        (verse_id_var, 8, 'ఎంతో', 'eṃtō', 'how vast', 8),
        (verse_id_var, 9, 'గొప్పది.', 'goppadi.', 'is.', 9);

    -- VERSE 18
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 18,
        'నేను వాటిని లెక్కింపగా అవి ఇసుకకంటెను ఎక్కువగా ఉన్నవి. నేను మేల్కొనునప్పుడు నీ సన్నిధిని ఉన్నాను.',
        'If I would count them, they are more in number than the sand. When I wake up, I am still with you.',
        'nēnu vāṭini lekkiṃpagā avi isukakaṃṭenu ekkuvagā unnavi. nēnu mēlkonunappuḍu nī sannidhini unnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 2, 'వాటిని', 'vāṭini', 'them', 2),
        (verse_id_var, 3, 'లెక్కింపగా', 'lekkiṃpagā', 'if would count', 3),
        (verse_id_var, 4, 'అవి', 'avi', 'they', 4),
        (verse_id_var, 5, 'ఇసుకకంటెను', 'isukakaṃṭenu', 'than the sand', 5),
        (verse_id_var, 6, 'ఎక్కువగా', 'ekkuvagā', 'more in number', 6),
        (verse_id_var, 7, 'ఉన్నవి.', 'unnavi.', 'are.', 7),
        (verse_id_var, 8, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 9, 'మేల్కొనునప్పుడు', 'mēlkonunappuḍu', 'when wake up', 8),
        (verse_id_var, 10, 'నీ', 'nī', 'with you', 9),
        (verse_id_var, 11, 'సన్నిధిని', 'sannidhini', 'still', 10),
        (verse_id_var, 12, 'ఉన్నాను.', 'unnānu.', 'am.', 7);

    -- VERSE 19
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 19,
        'దేవా, నీవు నిశ్చయముగా దుష్టులను సంహరించెదవు; నరహంతకులారా, నాయొద్దనుండి తొలగిపోవుడి.',
        'If only you, God, would kill the wicked. Get away from me, you bloodthirsty men!',
        'dēvā, nīvu niścayamugā duṣṭulanu saṃhariñcedavu; narahaṃtakulārā, nāyoddanuṃḍi tolagipōvuḍi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'దేవా,', 'dēvā,', 'God,', 1),
        (verse_id_var, 2, 'నీవు', 'nīvu', 'you', 2),
        (verse_id_var, 3, 'నిశ్చయముగా', 'niścayamugā', 'if only', 3),
        (verse_id_var, 4, 'దుష్టులను', 'duṣṭulanu', 'the wicked', 4),
        (verse_id_var, 5, 'సంహరించెదవు;', 'saṃhariñcedavu;', 'would kill;', 5),
        (verse_id_var, 6, 'నరహంతకులారా,', 'narahaṃtakulārā,', 'you bloodthirsty men,', 6),
        (verse_id_var, 7, 'నాయొద్దనుండి', 'nāyoddanuṃḍi', 'from me', 7),
        (verse_id_var, 8, 'తొలగిపోవుడి.', 'tolagipōvuḍi.', 'get away.', 8);

    -- VERSE 20
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 20,
        'వారు నిన్నుగూర్చి కపటోపాయములు పన్నుదురు నీ శత్రువులు తమ్మును హెచ్చించుకొనుటకు నీ నామమును వ్యర్థముగా ఎత్తుదురు.',
        'For they speak against you wickedly. Your enemies take your name in vain.',
        'vāru ninnugūrci kapaṭōpāyamulu pannuduru nī śatruvulu tammunu hecciñcukonuṭaku nī nāmamunu vyarthamugā ettuduru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'వారు', 'vāru', 'they', 1),
        (verse_id_var, 2, 'నిన్నుగూర్చి', 'ninnugūrci', 'against you', 2),
        (verse_id_var, 3, 'కపటోపాయములు', 'kapaṭōpāyamulu', 'wickedly', 3),
        (verse_id_var, 4, 'పన్నుదురు', 'pannuduru', 'speak', 4),
        (verse_id_var, 5, 'నీ', 'nī', 'your', 5),
        (verse_id_var, 6, 'శత్రువులు', 'śatruvulu', 'enemies', 6),
        (verse_id_var, 7, 'తమ్మును', 'tammunu', 'themselves', 7),
        (verse_id_var, 8, 'హెచ్చించుకొనుటకు', 'hecciñcukonuṭaku', 'to exalt', 8),
        (verse_id_var, 9, 'నీ', 'nī', 'your', 5),
        (verse_id_var, 10, 'నామమును', 'nāmamunu', 'name', 9),
        (verse_id_var, 11, 'వ్యర్థముగా', 'vyarthamugā', 'in vain', 10),
        (verse_id_var, 12, 'ఎత్తుదురు.', 'ettuduru.', 'take.', 11);

    -- VERSE 21
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 21,
        'యెహోవా, నిన్ను ద్వేషించువారిని నేను ద్వేషింపను? నీమీద లేచువారిని నేను అసహ్యించుకొనను?',
        'Yahweh, don''t I hate those who hate you? Am I not grieved with those who rise up against you?',
        'yehōvā, ninnu dvēṣiñcuvārini nēnu dvēṣiṃpanu? nīmīda lēcuvārini nēnu asahyiñcukonanu?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యెహోవా,', 'yehōvā,', 'Yahweh,', 1),
        (verse_id_var, 2, 'నిన్ను', 'ninnu', 'you', 2),
        (verse_id_var, 3, 'ద్వేషించువారిని', 'dvēṣiñcuvārini', 'those who hate', 3),
        (verse_id_var, 4, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 5, 'ద్వేషింపను?', 'dvēṣiṃpanu?', 'don''t hate?', 5),
        (verse_id_var, 6, 'నీమీద', 'nīmīda', 'against you', 6),
        (verse_id_var, 7, 'లేచువారిని', 'lēcuvārini', 'those who rise up', 7),
        (verse_id_var, 8, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 9, 'అసహ్యించుకొనను?', 'asahyiñcukonanu?', 'am not grieved?', 8);

    -- VERSE 22
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 22,
        'వారు నాకు పూర్ణ శత్రువులు పూర్ణ ద్వేషముతో నేను వారిని ద్వేషించుచున్నాను.',
        'I hate them with perfect hatred. They have become my enemies.',
        'vāru nāku pūrṇa śatruvulu pūrṇa dvēṣamutō nēnu vārini dvēṣiñcucunnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'వారు', 'vāru', 'they', 1),
        (verse_id_var, 2, 'నాకు', 'nāku', 'my', 2),
        (verse_id_var, 3, 'పూర్ణ', 'pūrṇa', 'have become', 3),
        (verse_id_var, 4, 'శత్రువులు', 'śatruvulu', 'enemies', 4),
        (verse_id_var, 5, 'పూర్ణ', 'pūrṇa', 'perfect', 5),
        (verse_id_var, 6, 'ద్వేషముతో', 'dvēṣamutō', 'with hatred', 6),
        (verse_id_var, 7, 'నేను', 'nēnu', 'I', 7),
        (verse_id_var, 8, 'వారిని', 'vārini', 'them', 8),
        (verse_id_var, 9, 'ద్వేషించుచున్నాను.', 'dvēṣiñcucunnānu.', 'hate.', 9);

    -- VERSE 23
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 23,
        'దేవా, నన్ను పరిశోధించి నా హృదయమును తెలిసికొనుము నన్ను పరీక్షించి నా ఆలోచనలను తెలిసికొనుము.',
        'Search me, God, and know my heart. Try me, and know my thoughts.',
        'dēvā, nannu pariśōdhiñci nā hr̥dayamunu telisikonumu nannu parīkṣiñci nā ālōcanalanu telisikonumu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'దేవా,', 'dēvā,', 'God,', 1),
        (verse_id_var, 2, 'నన్ను', 'nannu', 'me', 2),
        (verse_id_var, 3, 'పరిశోధించి', 'pariśōdhiñci', 'search', 3),
        (verse_id_var, 4, 'నా', 'nā', 'my', 4),
        (verse_id_var, 5, 'హృదయమును', 'hr̥dayamunu', 'heart', 5),
        (verse_id_var, 6, 'తెలిసికొనుము', 'telisikonumu', 'and know', 6),
        (verse_id_var, 7, 'నన్ను', 'nannu', 'me', 2),
        (verse_id_var, 8, 'పరీక్షించి', 'parīkṣiñci', 'try', 7),
        (verse_id_var, 9, 'నా', 'nā', 'my', 4),
        (verse_id_var, 10, 'ఆలోచనలను', 'ālōcanalanu', 'thoughts', 8),
        (verse_id_var, 11, 'తెలిసికొనుము.', 'telisikonumu.', 'and know.', 6);

    -- VERSE 24
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 24,
        'నీ దృష్టికి నాయందు చెడుమార్గమున్నదేమో చూడుము నిత్యమార్గమున నన్ను నడిపింపుము.',
        'See if there is any wicked way in me, and lead me in the everlasting way.',
        'nī dr̥ṣṭiki nāyaṃdu ceḍumārgamunnadēmō cūḍumu nityamārgamuna nannu naḍipiṃpumu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 2, 'దృష్టికి', 'dr̥ṣṭiki', 'sight', 2),
        (verse_id_var, 3, 'నాయందు', 'nāyaṃdu', 'in me', 3),
        (verse_id_var, 4, 'చెడుమార్గమున్నదేమో', 'ceḍumārgamunnadēmō', 'if any wicked way', 4),
        (verse_id_var, 5, 'చూడుము', 'cūḍumu', 'see', 5),
        (verse_id_var, 6, 'నిత్యమార్గమున', 'nityamārgamuna', 'in the everlasting way', 6),
        (verse_id_var, 7, 'నన్ను', 'nannu', 'me', 7),
        (verse_id_var, 8, 'నడిపింపుము.', 'naḍipiṃpumu.', 'and lead.', 8);
END $$;
