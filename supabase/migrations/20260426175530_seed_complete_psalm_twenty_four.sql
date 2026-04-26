/*
  # Seed complete Psalm 24 (the King of Glory)

  1. Content additions
    - Creates chapter row for Psalms 24 (book_id=19, chapter_number=24) if absent.
    - Seeds all 10 verses of Psalm 24 with BSI-style Telugu, WEB English, ISO-15919 transliteration.
    - Seeds aligned verse_tokens with per-verse alignment_group integers so words colour-link across languages.

  2. Strategy
    - Idempotent: chapter and verses upserted by natural keys; tokens cleared and re-inserted per verse.
    - No schema changes; data only.

  3. Notes
    - Adds Psalm 24 alongside the existing Psalm 23 sample passage.
*/

DO $$
DECLARE
    chapter_id_var bigint;
    verse_id_var bigint;
BEGIN
    INSERT INTO chapters (book_id, chapter_number)
    VALUES (19, 24)
    ON CONFLICT (book_id, chapter_number) DO UPDATE SET chapter_number = EXCLUDED.chapter_number
    RETURNING id INTO chapter_id_var;

    -- VERSE 1
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 1,
        'భూమియు దాని సంపూర్ణతయు లోకమును దానిలో నివసించువారును యెహోవావే.',
        'The earth is Yahweh''s, with its fullness; the world, and those who dwell therein.',
        'bhūmiyu dāni saṃpūrṇatayu lōkamunu dānilō nivasiñcuvārunu yehōvāvē.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'భూమియు', 'bhūmiyu', 'the earth', 1),
        (verse_id_var, 2, 'దాని', 'dāni', 'its', 2),
        (verse_id_var, 3, 'సంపూర్ణతయు', 'saṃpūrṇatayu', 'fullness', 3),
        (verse_id_var, 4, 'లోకమును', 'lōkamunu', 'the world', 4),
        (verse_id_var, 5, 'దానిలో', 'dānilō', 'therein', 5),
        (verse_id_var, 6, 'నివసించువారును', 'nivasiñcuvārunu', 'those who dwell', 6),
        (verse_id_var, 7, 'యెహోవావే.', 'yehōvāvē.', 'is Yahweh''s.', 7);

    -- VERSE 2
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 2,
        'ఆయన సముద్రములమీద దాని స్థాపించెను నదులమీద దాని స్థిరపరచెను.',
        'For he has founded it on the seas, and established it on the floods.',
        'āyana samudramulamīda dāni sthāpiñcenu nadulamīda dāni sthiraparacenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆయన', 'āyana', 'he', 1),
        (verse_id_var, 2, 'సముద్రములమీద', 'samudramulamīda', 'on the seas', 2),
        (verse_id_var, 3, 'దాని', 'dāni', 'it', 3),
        (verse_id_var, 4, 'స్థాపించెను', 'sthāpiñcenu', 'has founded', 4),
        (verse_id_var, 5, 'నదులమీద', 'nadulamīda', 'on the floods', 5),
        (verse_id_var, 6, 'దాని', 'dāni', 'it', 3),
        (verse_id_var, 7, 'స్థిరపరచెను.', 'sthiraparacenu.', 'established.', 6);

    -- VERSE 3
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 3,
        'యెహోవా పర్వతమునకు ఎవడు ఎక్కగలడు? ఆయన పరిశుద్ధ స్థలములో ఎవడు నిలువగలడు?',
        'Who may ascend to Yahweh''s hill? Who may stand in his holy place?',
        'yehōvā parvatamunaku evaḍu ekkagalaḍu? āyana pariśuddha sthalamulō evaḍu niluvagalaḍu?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యెహోవా', 'yehōvā', 'Yahweh''s', 1),
        (verse_id_var, 2, 'పర్వతమునకు', 'parvatamunaku', 'to hill', 2),
        (verse_id_var, 3, 'ఎవడు', 'evaḍu', 'who', 3),
        (verse_id_var, 4, 'ఎక్కగలడు?', 'ekkagalaḍu?', 'may ascend?', 4),
        (verse_id_var, 5, 'ఆయన', 'āyana', 'his', 5),
        (verse_id_var, 6, 'పరిశుద్ధ', 'pariśuddha', 'holy', 6),
        (verse_id_var, 7, 'స్థలములో', 'sthalamulō', 'in place', 7),
        (verse_id_var, 8, 'ఎవడు', 'evaḍu', 'who', 3),
        (verse_id_var, 9, 'నిలువగలడు?', 'niluvagalaḍu?', 'may stand?', 8);

    -- VERSE 4
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 4,
        'శుద్ధహస్తములు నిర్మల హృదయము కలిగి తన ఆత్మను వ్యర్థమైనదాని మీద పెట్టక మోసముగా ప్రమాణము చేయనివాడే.',
        'He who has clean hands and a pure heart; who has not lifted up his soul to falsehood, and has not sworn deceitfully.',
        'śuddhahastamulu nirmala hr̥dayamu kaligi tana ātmanu vyarthamainadāni mīda peṭṭaka mōsamugā pramāṇamu cēyanivāḍē.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'శుద్ధహస్తములు', 'śuddhahastamulu', 'clean hands', 1),
        (verse_id_var, 2, 'నిర్మల', 'nirmala', 'pure', 2),
        (verse_id_var, 3, 'హృదయము', 'hr̥dayamu', 'heart', 3),
        (verse_id_var, 4, 'కలిగి', 'kaligi', 'who has', 4),
        (verse_id_var, 5, 'తన', 'tana', 'his', 5),
        (verse_id_var, 6, 'ఆత్మను', 'ātmanu', 'soul', 6),
        (verse_id_var, 7, 'వ్యర్థమైనదాని', 'vyarthamainadāni', 'falsehood', 7),
        (verse_id_var, 8, 'మీద', 'mīda', 'to', 8),
        (verse_id_var, 9, 'పెట్టక', 'peṭṭaka', 'has not lifted up', 9),
        (verse_id_var, 10, 'మోసముగా', 'mōsamugā', 'deceitfully', 10),
        (verse_id_var, 11, 'ప్రమాణము', 'pramāṇamu', 'oath', 11),
        (verse_id_var, 12, 'చేయనివాడే.', 'cēyanivāḍē.', 'has not sworn.', 12);

    -- VERSE 5
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 5,
        'వాడు యెహోవాచేత ఆశీర్వాదమును తన రక్షణకర్తయైన దేవునిచేత నీతిని పొందును.',
        'He shall receive a blessing from Yahweh, righteousness from the God of his salvation.',
        'vāḍu yehōvācēta āśīrvādamunu tana rakṣaṇakartayaina dēvunicēta nītini poṃdunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'వాడు', 'vāḍu', 'he', 1),
        (verse_id_var, 2, 'యెహోవాచేత', 'yehōvācēta', 'from Yahweh', 2),
        (verse_id_var, 3, 'ఆశీర్వాదమును', 'āśīrvādamunu', 'a blessing', 3),
        (verse_id_var, 4, 'తన', 'tana', 'his', 4),
        (verse_id_var, 5, 'రక్షణకర్తయైన', 'rakṣaṇakartayaina', 'of salvation', 5),
        (verse_id_var, 6, 'దేవునిచేత', 'dēvunicēta', 'from the God', 6),
        (verse_id_var, 7, 'నీతిని', 'nītini', 'righteousness', 7),
        (verse_id_var, 8, 'పొందును.', 'poṃdunu.', 'shall receive.', 8);

    -- VERSE 6
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 6,
        'ఆయనను వెదకువారు యాకోబు దేవుని దర్శించువారు ఈ తరమువారే. (సెలా)',
        'This is the generation of those who seek him, who seek your face—even Jacob. Selah.',
        'āyananu vedakuvāru yākōbu dēvuni darśiñcuvāru ī taramuvārē. (selā)')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆయనను', 'āyananu', 'him', 1),
        (verse_id_var, 2, 'వెదకువారు', 'vedakuvāru', 'who seek', 2),
        (verse_id_var, 3, 'యాకోబు', 'yākōbu', 'Jacob', 3),
        (verse_id_var, 4, 'దేవుని', 'dēvuni', 'God''s', 4),
        (verse_id_var, 5, 'దర్శించువారు', 'darśiñcuvāru', 'who seek face', 5),
        (verse_id_var, 6, 'ఈ', 'ī', 'this', 6),
        (verse_id_var, 7, 'తరమువారే.', 'taramuvārē.', 'is the generation.', 7),
        (verse_id_var, 8, '(సెలా)', '(selā)', 'Selah.', 8);

    -- VERSE 7
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 7,
        'ద్వారములారా, మీ తలలను ఎత్తుడి, నిత్యద్వారములారా, ఎత్తబడుడి, మహిమ గల రాజు ప్రవేశించును.',
        'Lift up your heads, you gates! Be lifted up, you everlasting doors, and the King of glory will come in.',
        'dvāramulārā, mī talalanu ettuḍi, nityadvāramulārā, ettabaḍuḍi, mahima gala rāju pravēśiñcunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ద్వారములారా,', 'dvāramulārā,', 'you gates,', 1),
        (verse_id_var, 2, 'మీ', 'mī', 'your', 2),
        (verse_id_var, 3, 'తలలను', 'talalanu', 'heads', 3),
        (verse_id_var, 4, 'ఎత్తుడి,', 'ettuḍi,', 'lift up,', 4),
        (verse_id_var, 5, 'నిత్యద్వారములారా,', 'nityadvāramulārā,', 'you everlasting doors,', 5),
        (verse_id_var, 6, 'ఎత్తబడుడి,', 'ettabaḍuḍi,', 'be lifted up,', 6),
        (verse_id_var, 7, 'మహిమ', 'mahima', 'of glory', 7),
        (verse_id_var, 8, 'గల', 'gala', 'the', 8),
        (verse_id_var, 9, 'రాజు', 'rāju', 'King', 9),
        (verse_id_var, 10, 'ప్రవేశించును.', 'pravēśiñcunu.', 'will come in.', 10);

    -- VERSE 8
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 8,
        'ఆ మహిమగల రాజు ఎవడు? బలవంతుడును పరాక్రమశాలియునైన యెహోవాయే యుద్ధశూరుడైన యెహోవాయే.',
        'Who is the King of glory? Yahweh strong and mighty, Yahweh mighty in battle.',
        'ā mahimagala rāju evaḍu? balavaṃtuḍunu parākramaśāliyunaina yehōvāyē yuddhaśūruḍaina yehōvāyē.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆ', 'ā', 'the', 1),
        (verse_id_var, 2, 'మహిమగల', 'mahimagala', 'of glory', 2),
        (verse_id_var, 3, 'రాజు', 'rāju', 'King', 3),
        (verse_id_var, 4, 'ఎవడు?', 'evaḍu?', 'who is?', 4),
        (verse_id_var, 5, 'బలవంతుడును', 'balavaṃtuḍunu', 'strong', 5),
        (verse_id_var, 6, 'పరాక్రమశాలియునైన', 'parākramaśāliyunaina', 'and mighty', 6),
        (verse_id_var, 7, 'యెహోవాయే', 'yehōvāyē', 'Yahweh', 7),
        (verse_id_var, 8, 'యుద్ధశూరుడైన', 'yuddhaśūruḍaina', 'mighty in battle', 8),
        (verse_id_var, 9, 'యెహోవాయే.', 'yehōvāyē.', 'Yahweh.', 7);

    -- VERSE 9
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 9,
        'ద్వారములారా, మీ తలలను ఎత్తుడి, నిత్యద్వారములారా, ఎత్తబడుడి, మహిమ గల రాజు ప్రవేశించును.',
        'Lift up your heads, you gates; yes, lift them up, you everlasting doors, and the King of glory will come in.',
        'dvāramulārā, mī talalanu ettuḍi, nityadvāramulārā, ettabaḍuḍi, mahima gala rāju pravēśiñcunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ద్వారములారా,', 'dvāramulārā,', 'you gates,', 1),
        (verse_id_var, 2, 'మీ', 'mī', 'your', 2),
        (verse_id_var, 3, 'తలలను', 'talalanu', 'heads', 3),
        (verse_id_var, 4, 'ఎత్తుడి,', 'ettuḍi,', 'lift up,', 4),
        (verse_id_var, 5, 'నిత్యద్వారములారా,', 'nityadvāramulārā,', 'you everlasting doors,', 5),
        (verse_id_var, 6, 'ఎత్తబడుడి,', 'ettabaḍuḍi,', 'be lifted up,', 6),
        (verse_id_var, 7, 'మహిమ', 'mahima', 'of glory', 7),
        (verse_id_var, 8, 'గల', 'gala', 'the', 8),
        (verse_id_var, 9, 'రాజు', 'rāju', 'King', 9),
        (verse_id_var, 10, 'ప్రవేశించును.', 'pravēśiñcunu.', 'will come in.', 10);

    -- VERSE 10
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 10,
        'ఆ మహిమగల రాజు ఎవడు? సైన్యములకు అధిపతియగు యెహోవా ఆయనే మహిమగల రాజు. (సెలా)',
        'Who is this King of glory? Yahweh of Armies is the King of glory! Selah.',
        'ā mahimagala rāju evaḍu? sainyamulaku adhipatiyagu yehōvā āyanē mahimagala rāju. (selā)')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆ', 'ā', 'this', 1),
        (verse_id_var, 2, 'మహిమగల', 'mahimagala', 'of glory', 2),
        (verse_id_var, 3, 'రాజు', 'rāju', 'King', 3),
        (verse_id_var, 4, 'ఎవడు?', 'evaḍu?', 'who is?', 4),
        (verse_id_var, 5, 'సైన్యములకు', 'sainyamulaku', 'of Armies', 5),
        (verse_id_var, 6, 'అధిపతియగు', 'adhipatiyagu', 'lord', 6),
        (verse_id_var, 7, 'యెహోవా', 'yehōvā', 'Yahweh', 7),
        (verse_id_var, 8, 'ఆయనే', 'āyanē', 'is he', 8),
        (verse_id_var, 9, 'మహిమగల', 'mahimagala', 'of glory', 2),
        (verse_id_var, 10, 'రాజు.', 'rāju.', 'King.', 3),
        (verse_id_var, 11, '(సెలా)', '(selā)', 'Selah.', 9);
END $$;
