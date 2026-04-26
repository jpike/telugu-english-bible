/*
  # Seed complete Luke 16 (the shrewd manager and the rich man and Lazarus)

  1. Content additions
    - Creates chapter row for Luke 16 (book_id=42, chapter_number=16) if absent.
    - Seeds all 31 verses of Luke 16 with BSI-style Telugu, WEB English, ISO-15919 transliteration.
    - Seeds aligned verse_tokens with per-verse alignment_group integers so words colour-link across languages.

  2. Strategy
    - Idempotent: chapter and verses upserted by natural keys; tokens cleared and re-inserted per verse.
    - No schema changes; data only.

  3. Notes
    - Chapter contains Jesus'' parables of the dishonest manager and the rich man and Lazarus,
      plus teachings on serving God vs. mammon and on divorce.
*/

DO $$
DECLARE
    chapter_id_var bigint;
    verse_id_var bigint;
BEGIN
    INSERT INTO chapters (book_id, chapter_number)
    VALUES (42, 16)
    ON CONFLICT (book_id, chapter_number) DO UPDATE SET chapter_number = EXCLUDED.chapter_number
    RETURNING id INTO chapter_id_var;

    -- VERSE 1
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 1,
        'మరియు ఆయన తన శిష్యులతో ఇట్లనెను—ఒక ధనవంతునియొద్ద ఒక గృహనిర్వాహకుడుండెను; వాడు అతని ఆస్తిని పాడుచేయుచున్నాడని అతనియొద్ద ఫిర్యాదు చేయబడెను.',
        'He also said to his disciples, "There was a certain rich man who had a manager. An accusation was made to him that this man was wasting his possessions.',
        'mariyu āyana tana śiṣyulatō iṭlanenu—oka dhanavaṃtuniyodda oka gr̥hanirvāhakuḍuṃḍenu; vāḍu atani āstini pāḍucēyucunnāḍani ataniyodda phiryādu cēyabaḍenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మరియు', 'mariyu', 'also', 1),
        (verse_id_var, 2, 'ఆయన', 'āyana', 'he', 2),
        (verse_id_var, 3, 'తన', 'tana', 'his', 3),
        (verse_id_var, 4, 'శిష్యులతో', 'śiṣyulatō', 'to disciples', 4),
        (verse_id_var, 5, 'ఇట్లనెను—', 'iṭlanenu—', 'said—', 5),
        (verse_id_var, 6, 'ఒక', 'oka', 'a certain', 6),
        (verse_id_var, 7, 'ధనవంతునియొద్ద', 'dhanavaṃtuniyodda', 'rich man', 7),
        (verse_id_var, 8, 'ఒక', 'oka', 'a', 6),
        (verse_id_var, 9, 'గృహనిర్వాహకుడుండెను;', 'gr̥hanirvāhakuḍuṃḍenu;', 'had a manager;', 8),
        (verse_id_var, 10, 'వాడు', 'vāḍu', 'this man', 9),
        (verse_id_var, 11, 'అతని', 'atani', 'his', 10),
        (verse_id_var, 12, 'ఆస్తిని', 'āstini', 'possessions', 11),
        (verse_id_var, 13, 'పాడుచేయుచున్నాడని', 'pāḍucēyucunnāḍani', 'was wasting', 12),
        (verse_id_var, 14, 'అతనియొద్ద', 'ataniyodda', 'to him', 13),
        (verse_id_var, 15, 'ఫిర్యాదు', 'phiryādu', 'an accusation', 14),
        (verse_id_var, 16, 'చేయబడెను.', 'cēyabaḍenu.', 'was made.', 15);

    -- VERSE 2
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 2,
        'కాబట్టి అతడు వానిని పిలిచి—నిన్నుగూర్చి నేను వినుచున్న యీ సంగతి యేమిటి? నీ గృహనిర్వాహక లెక్క అప్పగించుము; ఇకమీదట నీవు గృహనిర్వాహకుడవై యుండుటకు వీలులేదని వానితో చెప్పెను.',
        'He called him, and said to him, ''What is this that I hear about you? Give an accounting of your management, for you can no longer be manager.''',
        'kābaṭṭi ataḍu vānini pilici—ninnugūrci nēnu vinucunna yī saṃgati yēmiṭi? nī gr̥hanirvāhaka lekka appagiñcumu; ikamīdaṭa nīvu gr̥hanirvāhakuḍavai yuṃḍuṭaku vīlulēdani vānitō ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కాబట్టి', 'kābaṭṭi', 'so', 1),
        (verse_id_var, 2, 'అతడు', 'ataḍu', 'he', 2),
        (verse_id_var, 3, 'వానిని', 'vānini', 'him', 3),
        (verse_id_var, 4, 'పిలిచి—', 'pilici—', 'called—', 4),
        (verse_id_var, 5, 'నిన్నుగూర్చి', 'ninnugūrci', 'about you', 5),
        (verse_id_var, 6, 'నేను', 'nēnu', 'I', 6),
        (verse_id_var, 7, 'వినుచున్న', 'vinucunna', 'hear', 7),
        (verse_id_var, 8, 'యీ', 'yī', 'this', 8),
        (verse_id_var, 9, 'సంగతి', 'saṃgati', 'thing', 9),
        (verse_id_var, 10, 'యేమిటి?', 'yēmiṭi?', 'what is?', 10),
        (verse_id_var, 11, 'నీ', 'nī', 'your', 11),
        (verse_id_var, 12, 'గృహనిర్వాహక', 'gr̥hanirvāhaka', 'management', 12),
        (verse_id_var, 13, 'లెక్క', 'lekka', 'an accounting', 13),
        (verse_id_var, 14, 'అప్పగించుము;', 'appagiñcumu;', 'give;', 14),
        (verse_id_var, 15, 'ఇకమీదట', 'ikamīdaṭa', 'no longer', 15),
        (verse_id_var, 16, 'నీవు', 'nīvu', 'you', 16),
        (verse_id_var, 17, 'గృహనిర్వాహకుడవై', 'gr̥hanirvāhakuḍavai', 'manager', 17),
        (verse_id_var, 18, 'యుండుటకు', 'yuṃḍuṭaku', 'be', 18),
        (verse_id_var, 19, 'వీలులేదని', 'vīlulēdani', 'can', 19),
        (verse_id_var, 20, 'వానితో', 'vānitō', 'to him', 3),
        (verse_id_var, 21, 'చెప్పెను.', 'ceppenu.', 'said.', 20);

    -- VERSE 3
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 3,
        'అప్పుడా గృహనిర్వాహకుడు—నేను ఏమి చేయుదును? నా యజమానుడు ఈ గృహనిర్వాహకత్వము నాయొద్దనుండి తీసివేయుచున్నాడే; త్రవ్వ శక్తిలేదు, బిచ్చమెత్తుటకు సిగ్గుపడుచున్నాను.',
        'The manager said within himself, ''What will I do, seeing that my lord is taking away the management position from me? I don''t have strength to dig. I am ashamed to beg.',
        'appuḍā gr̥hanirvāhakuḍu—nēnu ēmi cēyudunu? nā yajamānuḍu ī gr̥hanirvāhakatvamu nāyoddanuṃḍi tīsivēyucunnāḍē; travva śaktilēdu, biccametuṭaku siggupaḍucunnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అప్పుడా', 'appuḍā', 'then', 1),
        (verse_id_var, 2, 'గృహనిర్వాహకుడు—', 'gr̥hanirvāhakuḍu—', 'the manager said—', 2),
        (verse_id_var, 3, 'నేను', 'nēnu', 'I', 3),
        (verse_id_var, 4, 'ఏమి', 'ēmi', 'what', 4),
        (verse_id_var, 5, 'చేయుదును?', 'cēyudunu?', 'will do?', 5),
        (verse_id_var, 6, 'నా', 'nā', 'my', 6),
        (verse_id_var, 7, 'యజమానుడు', 'yajamānuḍu', 'lord', 7),
        (verse_id_var, 8, 'ఈ', 'ī', 'the', 8),
        (verse_id_var, 9, 'గృహనిర్వాహకత్వము', 'gr̥hanirvāhakatvamu', 'management position', 9),
        (verse_id_var, 10, 'నాయొద్దనుండి', 'nāyoddanuṃḍi', 'from me', 10),
        (verse_id_var, 11, 'తీసివేయుచున్నాడే;', 'tīsivēyucunnāḍē;', 'is taking away;', 11),
        (verse_id_var, 12, 'త్రవ్వ', 'travva', 'to dig', 12),
        (verse_id_var, 13, 'శక్తిలేదు,', 'śaktilēdu,', 'don''t have strength,', 13),
        (verse_id_var, 14, 'బిచ్చమెత్తుటకు', 'biccametuṭaku', 'to beg', 14),
        (verse_id_var, 15, 'సిగ్గుపడుచున్నాను.', 'siggupaḍucunnānu.', 'am ashamed.', 15);

    -- VERSE 4
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 4,
        'గృహనిర్వాహకత్వములోనుండి తీసివేయబడినప్పుడు ఇతరులు నన్ను తమ యిండ్లలోనికి చేర్చుకొనునట్లుగా నేను చేయవలసినది ఇప్పుడు తెలిసికొంటిని అని తనలో తాననుకొనెను.',
        'I know what I will do, so that when I am removed from management, they may receive me into their houses.''',
        'gr̥hanirvāhakatvamulōnuṃḍi tīsivēyabaḍinappuḍu itarulu nannu tama yiṃḍlalōniki cērcukonunaṭlugā nēnu cēyavalasinadi ippuḍu telisikoṃṭini ani tanalō tānanukonenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'గృహనిర్వాహకత్వములోనుండి', 'gr̥hanirvāhakatvamulōnuṃḍi', 'from management', 1),
        (verse_id_var, 2, 'తీసివేయబడినప్పుడు', 'tīsivēyabaḍinappuḍu', 'when I am removed', 2),
        (verse_id_var, 3, 'ఇతరులు', 'itarulu', 'they', 3),
        (verse_id_var, 4, 'నన్ను', 'nannu', 'me', 4),
        (verse_id_var, 5, 'తమ', 'tama', 'their', 5),
        (verse_id_var, 6, 'యిండ్లలోనికి', 'yiṃḍlalōniki', 'into houses', 6),
        (verse_id_var, 7, 'చేర్చుకొనునట్లుగా', 'cērcukonunaṭlugā', 'may receive', 7),
        (verse_id_var, 8, 'నేను', 'nēnu', 'I', 8),
        (verse_id_var, 9, 'చేయవలసినది', 'cēyavalasinadi', 'will do', 9),
        (verse_id_var, 10, 'ఇప్పుడు', 'ippuḍu', 'now', 10),
        (verse_id_var, 11, 'తెలిసికొంటిని', 'telisikoṃṭini', 'know what', 11),
        (verse_id_var, 12, 'అని', 'ani', 'that', 12),
        (verse_id_var, 13, 'తనలో', 'tanalō', 'within himself', 13),
        (verse_id_var, 14, 'తాననుకొనెను.', 'tānanukonenu.', 'said.', 14);

    -- VERSE 5
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 5,
        'తన యజమానుని ఋణస్థులలో ప్రతివానిని పిలిచి—నీవు నా యజమానునికి చెల్లింపవలసిన ఋణమెంత? అని మొదటివానినడిగెను.',
        'Calling each one of his lord''s debtors to him, he said to the first, ''How much do you owe to my lord?''',
        'tana yajamānuni r̥ṇasthulalō prativānini pilici—nīvu nā yajamānuniki celliṃpavalasina r̥ṇameṃta? ani modaṭivāninaḍigenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'తన', 'tana', 'his', 1),
        (verse_id_var, 2, 'యజమానుని', 'yajamānuni', 'lord''s', 2),
        (verse_id_var, 3, 'ఋణస్థులలో', 'r̥ṇasthulalō', 'debtors', 3),
        (verse_id_var, 4, 'ప్రతివానిని', 'prativānini', 'each one of', 4),
        (verse_id_var, 5, 'పిలిచి—', 'pilici—', 'calling—', 5),
        (verse_id_var, 6, 'నీవు', 'nīvu', 'you', 6),
        (verse_id_var, 7, 'నా', 'nā', 'my', 7),
        (verse_id_var, 8, 'యజమానునికి', 'yajamānuniki', 'to lord', 2),
        (verse_id_var, 9, 'చెల్లింపవలసిన', 'celliṃpavalasina', 'do owe', 8),
        (verse_id_var, 10, 'ఋణమెంత?', 'r̥ṇameṃta?', 'how much?', 9),
        (verse_id_var, 11, 'అని', 'ani', 'said', 10),
        (verse_id_var, 12, 'మొదటివానినడిగెను.', 'modaṭivāninaḍigenu.', 'to the first.', 11);

    -- VERSE 6
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 6,
        'వాడు నూరు మణుగుల నూనె అని చెప్పగా—నీవు నీ చీటి తీసికొని త్వరగా కూర్చుండి యేబది మణుగులని వ్రాయుమనెను.',
        'He said, ''A hundred batos of oil.'' He said to him, ''Take your bill, and sit down quickly and write fifty.''',
        'vāḍu nūru maṇugula nūne ani ceppagā—nīvu nī cīṭi tīsikoni tvaragā kūrcuṃḍi yēbadi maṇugulani vrāyumanenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'వాడు', 'vāḍu', 'he', 1),
        (verse_id_var, 2, 'నూరు', 'nūru', 'a hundred', 2),
        (verse_id_var, 3, 'మణుగుల', 'maṇugula', 'batos', 3),
        (verse_id_var, 4, 'నూనె', 'nūne', 'of oil', 4),
        (verse_id_var, 5, 'అని', 'ani', 'said', 5),
        (verse_id_var, 6, 'చెప్పగా—', 'ceppagā—', 'replied—', 5),
        (verse_id_var, 7, 'నీవు', 'nīvu', 'you', 6),
        (verse_id_var, 8, 'నీ', 'nī', 'your', 7),
        (verse_id_var, 9, 'చీటి', 'cīṭi', 'bill', 8),
        (verse_id_var, 10, 'తీసికొని', 'tīsikoni', 'take', 9),
        (verse_id_var, 11, 'త్వరగా', 'tvaragā', 'quickly', 10),
        (verse_id_var, 12, 'కూర్చుండి', 'kūrcuṃḍi', 'sit down', 11),
        (verse_id_var, 13, 'యేబది', 'yēbadi', 'fifty', 12),
        (verse_id_var, 14, 'మణుగులని', 'maṇugulani', 'batos', 3),
        (verse_id_var, 15, 'వ్రాయుమనెను.', 'vrāyumanenu.', 'write.', 13);

    -- VERSE 7
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 7,
        'తరువాత మరియొకని చూచి—నీవు చెల్లింపవలసిన ఋణమెంత అని యడుగగా వాడు—నూరు తూముల గోధుమలనెను. అతడు—నీవు నీ చీటి తీసికొని ఎనుబది తూములని వ్రాయుమని వానితో చెప్పెను.',
        'Then he said to another, ''How much do you owe?'' He said, ''A hundred cors of wheat.'' He said to him, ''Take your bill, and write eighty.''',
        'taruvāta mariyokani cūci—nīvu celliṃpavalasina r̥ṇameṃta ani yaḍugagā vāḍu—nūru tūmula gōdhumalanenu. ataḍu—nīvu nī cīṭi tīsikoni enubadi tūmulani vrāyumani vānitō ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'తరువాత', 'taruvāta', 'then', 1),
        (verse_id_var, 2, 'మరియొకని', 'mariyokani', 'another', 2),
        (verse_id_var, 3, 'చూచి—', 'cūci—', 'he said to—', 3),
        (verse_id_var, 4, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 5, 'చెల్లింపవలసిన', 'celliṃpavalasina', 'do owe', 5),
        (verse_id_var, 6, 'ఋణమెంత', 'r̥ṇameṃta', 'how much', 6),
        (verse_id_var, 7, 'అని', 'ani', 'said', 3),
        (verse_id_var, 8, 'యడుగగా', 'yaḍugagā', 'asking', 7),
        (verse_id_var, 9, 'వాడు—', 'vāḍu—', 'he—', 8),
        (verse_id_var, 10, 'నూరు', 'nūru', 'a hundred', 9),
        (verse_id_var, 11, 'తూముల', 'tūmula', 'cors', 10),
        (verse_id_var, 12, 'గోధుమలనెను.', 'gōdhumalanenu.', 'of wheat.', 11),
        (verse_id_var, 13, 'అతడు—', 'ataḍu—', 'he—', 8),
        (verse_id_var, 14, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 15, 'నీ', 'nī', 'your', 12),
        (verse_id_var, 16, 'చీటి', 'cīṭi', 'bill', 13),
        (verse_id_var, 17, 'తీసికొని', 'tīsikoni', 'take', 14),
        (verse_id_var, 18, 'ఎనుబది', 'enubadi', 'eighty', 15),
        (verse_id_var, 19, 'తూములని', 'tūmulani', 'cors', 10),
        (verse_id_var, 20, 'వ్రాయుమని', 'vrāyumani', 'write', 16),
        (verse_id_var, 21, 'వానితో', 'vānitō', 'to him', 17),
        (verse_id_var, 22, 'చెప్పెను.', 'ceppenu.', 'said.', 3);

    -- VERSE 8
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 8,
        'అన్యాయస్థుడైన ఆ గృహనిర్వాహకుడు యుక్తిగా చేసెనని యజమానుడు వాని మెచ్చుకొనెను. వెలుగు సంబంధులకంటె ఈ లోక సంబంధులు తమ తరమునుబట్టి చూడగా యుక్తిమంతులై యున్నారు.',
        '"His lord commended the dishonest manager because he had done wisely, for the children of this world are, in their own generation, wiser than the children of the light.',
        'anyāyasthuḍaina ā gr̥hanirvāhakuḍu yuktigā cēsenani yajamānuḍu vāni meccukonenu. velugu saṃbaṃdhulakaṃṭe ī lōka saṃbaṃdhulu tama taramunubaṭṭi cūḍagā yuktimaṃtulai yunnāru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అన్యాయస్థుడైన', 'anyāyasthuḍaina', 'dishonest', 1),
        (verse_id_var, 2, 'ఆ', 'ā', 'the', 2),
        (verse_id_var, 3, 'గృహనిర్వాహకుడు', 'gr̥hanirvāhakuḍu', 'manager', 3),
        (verse_id_var, 4, 'యుక్తిగా', 'yuktigā', 'wisely', 4),
        (verse_id_var, 5, 'చేసెనని', 'cēsenani', 'had done', 5),
        (verse_id_var, 6, 'యజమానుడు', 'yajamānuḍu', 'lord', 6),
        (verse_id_var, 7, 'వాని', 'vāni', 'him', 7),
        (verse_id_var, 8, 'మెచ్చుకొనెను.', 'meccukonenu.', 'commended.', 8),
        (verse_id_var, 9, 'వెలుగు', 'velugu', 'of the light', 9),
        (verse_id_var, 10, 'సంబంధులకంటె', 'saṃbaṃdhulakaṃṭe', 'than the children', 10),
        (verse_id_var, 11, 'ఈ', 'ī', 'this', 11),
        (verse_id_var, 12, 'లోక', 'lōka', 'world', 12),
        (verse_id_var, 13, 'సంబంధులు', 'saṃbaṃdhulu', 'the children of', 10),
        (verse_id_var, 14, 'తమ', 'tama', 'their own', 13),
        (verse_id_var, 15, 'తరమునుబట్టి', 'taramunubaṭṭi', 'generation', 14),
        (verse_id_var, 16, 'చూడగా', 'cūḍagā', 'in', 15),
        (verse_id_var, 17, 'యుక్తిమంతులై', 'yuktimaṃtulai', 'wiser', 16),
        (verse_id_var, 18, 'యున్నారు.', 'yunnāru.', 'are.', 17);

    -- VERSE 9
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 9,
        'మరియు అన్యాయపు సిరివలన మీకు స్నేహితులను సంపాదించుకొనుడని మీతో చెప్పుచున్నాను; ఆ సిరి మిమ్మును వదలుకాలమందు వారు నిత్యమైన నివాసములలోనికి మిమ్మును చేర్చుకొందురు.',
        'I tell you, make for yourselves friends by means of unrighteous mammon, that when you fail, they may receive you into the eternal tents.',
        'mariyu anyāyapu sirivalana mīku snēhitulanu saṃpādiñcukonuḍani mītō ceppucunnānu; ā siri mimmunu vadalukālamaṃdu vāru nityamaina nivāsamulalōniki mimmunu cērcukoṃduru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మరియు', 'mariyu', 'also', 1),
        (verse_id_var, 2, 'అన్యాయపు', 'anyāyapu', 'unrighteous', 2),
        (verse_id_var, 3, 'సిరివలన', 'sirivalana', 'by means of mammon', 3),
        (verse_id_var, 4, 'మీకు', 'mīku', 'for yourselves', 4),
        (verse_id_var, 5, 'స్నేహితులను', 'snēhitulanu', 'friends', 5),
        (verse_id_var, 6, 'సంపాదించుకొనుడని', 'saṃpādiñcukonuḍani', 'make', 6),
        (verse_id_var, 7, 'మీతో', 'mītō', 'you', 7),
        (verse_id_var, 8, 'చెప్పుచున్నాను;', 'ceppucunnānu;', 'I tell;', 8),
        (verse_id_var, 9, 'ఆ', 'ā', 'the', 9),
        (verse_id_var, 10, 'సిరి', 'siri', 'mammon', 3),
        (verse_id_var, 11, 'మిమ్మును', 'mimmunu', 'you', 7),
        (verse_id_var, 12, 'వదలుకాలమందు', 'vadalukālamaṃdu', 'when you fail', 10),
        (verse_id_var, 13, 'వారు', 'vāru', 'they', 11),
        (verse_id_var, 14, 'నిత్యమైన', 'nityamaina', 'eternal', 12),
        (verse_id_var, 15, 'నివాసములలోనికి', 'nivāsamulalōniki', 'into tents', 13),
        (verse_id_var, 16, 'మిమ్మును', 'mimmunu', 'you', 7),
        (verse_id_var, 17, 'చేర్చుకొందురు.', 'cērcukoṃduru.', 'may receive.', 14);

    -- VERSE 10
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 10,
        'అత్యల్పమైన దానిలో నమ్మకముగా ఉండువాడు ఎక్కువ దానిలోను నమ్మకముగా ఉండును; అత్యల్పమైన దానిలో అన్యాయముగా ఉండువాడు ఎక్కువ దానిలోను అన్యాయముగా ఉండును.',
        'He who is faithful in a very little is faithful also in much. He who is dishonest in a very little is also dishonest in much.',
        'atyalpamaina dānilō nammakamugā uṃḍuvāḍu ekkuva dānilōnu nammakamugā uṃḍunu; atyalpamaina dānilō anyāyamugā uṃḍuvāḍu ekkuva dānilōnu anyāyamugā uṃḍunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అత్యల్పమైన', 'atyalpamaina', 'a very little', 1),
        (verse_id_var, 2, 'దానిలో', 'dānilō', 'in', 2),
        (verse_id_var, 3, 'నమ్మకముగా', 'nammakamugā', 'faithful', 3),
        (verse_id_var, 4, 'ఉండువాడు', 'uṃḍuvāḍu', 'he who is', 4),
        (verse_id_var, 5, 'ఎక్కువ', 'ekkuva', 'much', 5),
        (verse_id_var, 6, 'దానిలోను', 'dānilōnu', 'in', 2),
        (verse_id_var, 7, 'నమ్మకముగా', 'nammakamugā', 'faithful', 3),
        (verse_id_var, 8, 'ఉండును;', 'uṃḍunu;', 'is also;', 6),
        (verse_id_var, 9, 'అత్యల్పమైన', 'atyalpamaina', 'a very little', 1),
        (verse_id_var, 10, 'దానిలో', 'dānilō', 'in', 2),
        (verse_id_var, 11, 'అన్యాయముగా', 'anyāyamugā', 'dishonest', 7),
        (verse_id_var, 12, 'ఉండువాడు', 'uṃḍuvāḍu', 'he who is', 4),
        (verse_id_var, 13, 'ఎక్కువ', 'ekkuva', 'much', 5),
        (verse_id_var, 14, 'దానిలోను', 'dānilōnu', 'in', 2),
        (verse_id_var, 15, 'అన్యాయముగా', 'anyāyamugā', 'dishonest', 7),
        (verse_id_var, 16, 'ఉండును.', 'uṃḍunu.', 'is also.', 6);

    -- VERSE 11
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 11,
        'కాబట్టి మీరు అన్యాయపు సిరి విషయములో నమ్మకముగా ఉండని పక్షమున సత్యమైన ధనమును ఎవడు మీ వశము చేయును?',
        'If therefore you have not been faithful in the unrighteous mammon, who will commit to your trust the true riches?',
        'kābaṭṭi mīru anyāyapu siri viṣayamulō nammakamugā uṃḍani pakṣamuna satyamaina dhanamunu evaḍu mī vaśamu cēyunu?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కాబట్టి', 'kābaṭṭi', 'therefore', 1),
        (verse_id_var, 2, 'మీరు', 'mīru', 'you', 2),
        (verse_id_var, 3, 'అన్యాయపు', 'anyāyapu', 'unrighteous', 3),
        (verse_id_var, 4, 'సిరి', 'siri', 'mammon', 4),
        (verse_id_var, 5, 'విషయములో', 'viṣayamulō', 'in', 5),
        (verse_id_var, 6, 'నమ్మకముగా', 'nammakamugā', 'faithful', 6),
        (verse_id_var, 7, 'ఉండని', 'uṃḍani', 'have not been', 7),
        (verse_id_var, 8, 'పక్షమున', 'pakṣamuna', 'if', 8),
        (verse_id_var, 9, 'సత్యమైన', 'satyamaina', 'true', 9),
        (verse_id_var, 10, 'ధనమును', 'dhanamunu', 'riches', 10),
        (verse_id_var, 11, 'ఎవడు', 'evaḍu', 'who', 11),
        (verse_id_var, 12, 'మీ', 'mī', 'your', 12),
        (verse_id_var, 13, 'వశము', 'vaśamu', 'trust', 13),
        (verse_id_var, 14, 'చేయును?', 'cēyunu?', 'will commit to?', 14);

    -- VERSE 12
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 12,
        'మరియు మీరు పరులదానియందు నమ్మకముగా ఉండని పక్షమున మీ సొంత సొమ్మును మీకెవడిచ్చును?',
        'If you have not been faithful in that which is another''s, who will give you that which is your own?',
        'mariyu mīru paruladāniyaṃdu nammakamugā uṃḍani pakṣamuna mī soṃta sommunu mīkevaḍiccunu?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మరియు', 'mariyu', 'and', 1),
        (verse_id_var, 2, 'మీరు', 'mīru', 'you', 2),
        (verse_id_var, 3, 'పరులదానియందు', 'paruladāniyaṃdu', 'in another''s', 3),
        (verse_id_var, 4, 'నమ్మకముగా', 'nammakamugā', 'faithful', 4),
        (verse_id_var, 5, 'ఉండని', 'uṃḍani', 'have not been', 5),
        (verse_id_var, 6, 'పక్షమున', 'pakṣamuna', 'if', 6),
        (verse_id_var, 7, 'మీ', 'mī', 'your', 7),
        (verse_id_var, 8, 'సొంత', 'soṃta', 'own', 8),
        (verse_id_var, 9, 'సొమ్మును', 'sommunu', 'that which is', 9),
        (verse_id_var, 10, 'మీకెవడిచ్చును?', 'mīkevaḍiccunu?', 'who will give you?', 10);

    -- VERSE 13
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 13,
        'ఏ సేవకుడును ఇద్దరు యజమానులకు దాసుడుగా నుండనేరడు; వాడు ఒకని ద్వేషించి యొకని ప్రేమించును, లేదా యొకని హత్తుకొని యొకని తిరస్కరించును. మీరు దేవునికిని సిరికిని దాసులుగా నుండనేరరు.',
        'No servant can serve two masters, for either he will hate the one, and love the other; or else he will hold to one, and despise the other. You aren''t able to serve God and Mammon."',
        'ē sēvakuḍunu iddaru yajamānulaku dāsuḍugā nuṃḍanēraḍu; vāḍu okani dvēṣiñci yokani prēmiñcunu, lēdā yokani hattukoni yokani tiraskariñcunu. mīru dēvunikini sirikini dāsulugā nuṃḍanēraru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఏ', 'ē', 'no', 1),
        (verse_id_var, 2, 'సేవకుడును', 'sēvakuḍunu', 'servant', 2),
        (verse_id_var, 3, 'ఇద్దరు', 'iddaru', 'two', 3),
        (verse_id_var, 4, 'యజమానులకు', 'yajamānulaku', 'masters', 4),
        (verse_id_var, 5, 'దాసుడుగా', 'dāsuḍugā', 'as slave', 5),
        (verse_id_var, 6, 'నుండనేరడు;', 'nuṃḍanēraḍu;', 'can serve;', 6),
        (verse_id_var, 7, 'వాడు', 'vāḍu', 'he', 7),
        (verse_id_var, 8, 'ఒకని', 'okani', 'the one', 8),
        (verse_id_var, 9, 'ద్వేషించి', 'dvēṣiñci', 'will hate', 9),
        (verse_id_var, 10, 'యొకని', 'yokani', 'the other', 10),
        (verse_id_var, 11, 'ప్రేమించును,', 'prēmiñcunu,', 'love,', 11),
        (verse_id_var, 12, 'లేదా', 'lēdā', 'or else', 12),
        (verse_id_var, 13, 'యొకని', 'yokani', 'one', 8),
        (verse_id_var, 14, 'హత్తుకొని', 'hattukoni', 'will hold to', 13),
        (verse_id_var, 15, 'యొకని', 'yokani', 'the other', 10),
        (verse_id_var, 16, 'తిరస్కరించును.', 'tiraskariñcunu.', 'despise.', 14),
        (verse_id_var, 17, 'మీరు', 'mīru', 'you', 15),
        (verse_id_var, 18, 'దేవునికిని', 'dēvunikini', 'God', 16),
        (verse_id_var, 19, 'సిరికిని', 'sirikini', 'and Mammon', 17),
        (verse_id_var, 20, 'దాసులుగా', 'dāsulugā', 'as slaves', 5),
        (verse_id_var, 21, 'నుండనేరరు.', 'nuṃḍanēraru.', 'aren''t able to serve.', 18);

    -- VERSE 14
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 14,
        'ధనాపేక్షులైన పరిసయ్యులు ఈ మాటలన్నియు విని ఆయనను అపహసించుచుండగా,',
        'The Pharisees, who were lovers of money, also heard all these things, and they scoffed at him.',
        'dhanāpēkṣulaina parisayyulu ī māṭalanniyu vini āyananu apahasiñcucuṃḍagā,')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ధనాపేక్షులైన', 'dhanāpēkṣulaina', 'lovers of money', 1),
        (verse_id_var, 2, 'పరిసయ్యులు', 'parisayyulu', 'the Pharisees', 2),
        (verse_id_var, 3, 'ఈ', 'ī', 'these', 3),
        (verse_id_var, 4, 'మాటలన్నియు', 'māṭalanniyu', 'all things', 4),
        (verse_id_var, 5, 'విని', 'vini', 'heard', 5),
        (verse_id_var, 6, 'ఆయనను', 'āyananu', 'at him', 6),
        (verse_id_var, 7, 'అపహసించుచుండగా,', 'apahasiñcucuṃḍagā,', 'scoffed,', 7);

    -- VERSE 15
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 15,
        'ఆయన—మీరు మనుష్యుల యెదుట నీతిమంతులని అనిపించుకొనువారు, దేవుడు మీ హృదయములు ఎరుగును; మనుష్యులలో ఘనమైనది దేవుని యెదుట అసహ్యము.',
        'He said to them, "You are those who justify yourselves in the sight of men, but God knows your hearts. For that which is exalted among men is an abomination in the sight of God.',
        'āyana—mīru manuṣyula yeduṭa nītimaṃtulani anipiñcukonuvāru, dēvuḍu mī hr̥dayamulu erugunu; manuṣyulalō ghanamainadi dēvuni yeduṭa asahyamu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆయన—', 'āyana—', 'he said—', 1),
        (verse_id_var, 2, 'మీరు', 'mīru', 'you', 2),
        (verse_id_var, 3, 'మనుష్యుల', 'manuṣyula', 'of men', 3),
        (verse_id_var, 4, 'యెదుట', 'yeduṭa', 'in the sight', 4),
        (verse_id_var, 5, 'నీతిమంతులని', 'nītimaṃtulani', 'who justify yourselves', 5),
        (verse_id_var, 6, 'అనిపించుకొనువారు,', 'anipiñcukonuvāru,', 'are those,', 6),
        (verse_id_var, 7, 'దేవుడు', 'dēvuḍu', 'God', 7),
        (verse_id_var, 8, 'మీ', 'mī', 'your', 8),
        (verse_id_var, 9, 'హృదయములు', 'hr̥dayamulu', 'hearts', 9),
        (verse_id_var, 10, 'ఎరుగును;', 'erugunu;', 'knows;', 10),
        (verse_id_var, 11, 'మనుష్యులలో', 'manuṣyulalō', 'among men', 11),
        (verse_id_var, 12, 'ఘనమైనది', 'ghanamainadi', 'that which is exalted', 12),
        (verse_id_var, 13, 'దేవుని', 'dēvuni', 'of God', 13),
        (verse_id_var, 14, 'యెదుట', 'yeduṭa', 'in the sight', 4),
        (verse_id_var, 15, 'అసహ్యము.', 'asahyamu.', 'is an abomination.', 14);

    -- VERSE 16
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 16,
        'యోహాను కాలమువరకు ధర్మశాస్త్రమును ప్రవక్తలును ఉండిరి; ఆ కాలము మొదలుకొని దేవుని రాజ్య సువార్త ప్రకటింపబడుచున్నది, ప్రతివాడును ఆ రాజ్యములో బలవంతముగా జొరబడుచున్నాడు.',
        'The law and the prophets were until John. From that time the Good News of the Kingdom of God is preached, and everyone is forcing his way into it.',
        'yōhānu kālamuvaraku dharmaśāstramunu pravaktalunu uṃḍiri; ā kālamu modalukoni dēvuni rājya suvārta prakaṭiṃpabaḍucunnadi, prativāḍunu ā rājyamulō balavaṃtamugā jorabaḍucunnāḍu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యోహాను', 'yōhānu', 'John', 1),
        (verse_id_var, 2, 'కాలమువరకు', 'kālamuvaraku', 'until', 2),
        (verse_id_var, 3, 'ధర్మశాస్త్రమును', 'dharmaśāstramunu', 'the law', 3),
        (verse_id_var, 4, 'ప్రవక్తలును', 'pravaktalunu', 'and the prophets', 4),
        (verse_id_var, 5, 'ఉండిరి;', 'uṃḍiri;', 'were;', 5),
        (verse_id_var, 6, 'ఆ', 'ā', 'that', 6),
        (verse_id_var, 7, 'కాలము', 'kālamu', 'time', 2),
        (verse_id_var, 8, 'మొదలుకొని', 'modalukoni', 'from', 7),
        (verse_id_var, 9, 'దేవుని', 'dēvuni', 'of God', 8),
        (verse_id_var, 10, 'రాజ్య', 'rājya', 'of the Kingdom', 9),
        (verse_id_var, 11, 'సువార్త', 'suvārta', 'the Good News', 10),
        (verse_id_var, 12, 'ప్రకటింపబడుచున్నది,', 'prakaṭiṃpabaḍucunnadi,', 'is preached,', 11),
        (verse_id_var, 13, 'ప్రతివాడును', 'prativāḍunu', 'everyone', 12),
        (verse_id_var, 14, 'ఆ', 'ā', 'it', 6),
        (verse_id_var, 15, 'రాజ్యములో', 'rājyamulō', 'into', 13),
        (verse_id_var, 16, 'బలవంతముగా', 'balavaṃtamugā', 'forcing his way', 14),
        (verse_id_var, 17, 'జొరబడుచున్నాడు.', 'jorabaḍucunnāḍu.', 'is.', 15);

    -- VERSE 17
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 17,
        'ధర్మశాస్త్రములో ఒక సూక్ష్మాక్షరమైనను తప్పిపోవుటకంటె ఆకాశమును భూమియు గతించిపోవుట సులభము.',
        'But it is easier for heaven and earth to pass away, than for one tiny stroke of a pen in the law to fall.',
        'dharmaśāstramulō oka sūkṣmākṣaramainanu tappipōvuṭakaṃṭe ākāśamunu bhūmiyu gatiñcipōvuṭa sulabhamu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ధర్మశాస్త్రములో', 'dharmaśāstramulō', 'in the law', 1),
        (verse_id_var, 2, 'ఒక', 'oka', 'one', 2),
        (verse_id_var, 3, 'సూక్ష్మాక్షరమైనను', 'sūkṣmākṣaramainanu', 'tiny stroke', 3),
        (verse_id_var, 4, 'తప్పిపోవుటకంటె', 'tappipōvuṭakaṃṭe', 'than to fall', 4),
        (verse_id_var, 5, 'ఆకాశమును', 'ākāśamunu', 'heaven', 5),
        (verse_id_var, 6, 'భూమియు', 'bhūmiyu', 'and earth', 6),
        (verse_id_var, 7, 'గతించిపోవుట', 'gatiñcipōvuṭa', 'to pass away', 7),
        (verse_id_var, 8, 'సులభము.', 'sulabhamu.', 'is easier.', 8);

    -- VERSE 18
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 18,
        'తన భార్యను విడనాడి మరియొక స్త్రీని వివాహము చేసికొనువాడు వ్యభిచారము చేయుచున్నాడు; భర్త విడనాడిన దానిని వివాహము చేసికొనువాడు వ్యభిచారము చేయుచున్నాడు.',
        'Everyone who divorces his wife and marries another commits adultery. He who marries one who is divorced from a husband commits adultery.',
        'tana bhāryanu viḍanāḍi mariyoka strīni vivāhamu cēsikonuvāḍu vyabhicāramu cēyucunnāḍu; bharta viḍanāḍina dānini vivāhamu cēsikonuvāḍu vyabhicāramu cēyucunnāḍu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'తన', 'tana', 'his', 1),
        (verse_id_var, 2, 'భార్యను', 'bhāryanu', 'wife', 2),
        (verse_id_var, 3, 'విడనాడి', 'viḍanāḍi', 'who divorces', 3),
        (verse_id_var, 4, 'మరియొక', 'mariyoka', 'another', 4),
        (verse_id_var, 5, 'స్త్రీని', 'strīni', 'woman', 5),
        (verse_id_var, 6, 'వివాహము', 'vivāhamu', 'marriage', 6),
        (verse_id_var, 7, 'చేసికొనువాడు', 'cēsikonuvāḍu', 'and marries', 7),
        (verse_id_var, 8, 'వ్యభిచారము', 'vyabhicāramu', 'adultery', 8),
        (verse_id_var, 9, 'చేయుచున్నాడు;', 'cēyucunnāḍu;', 'commits;', 9),
        (verse_id_var, 10, 'భర్త', 'bharta', 'husband', 10),
        (verse_id_var, 11, 'విడనాడిన', 'viḍanāḍina', 'who is divorced from', 11),
        (verse_id_var, 12, 'దానిని', 'dānini', 'one', 12),
        (verse_id_var, 13, 'వివాహము', 'vivāhamu', 'marriage', 6),
        (verse_id_var, 14, 'చేసికొనువాడు', 'cēsikonuvāḍu', 'he who marries', 7),
        (verse_id_var, 15, 'వ్యభిచారము', 'vyabhicāramu', 'adultery', 8),
        (verse_id_var, 16, 'చేయుచున్నాడు.', 'cēyucunnāḍu.', 'commits.', 9);

    -- VERSE 19
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 19,
        'ధనవంతుడొకడుండెను. వాడు ఊదారంగు బట్టలును సన్నపు నారబట్టలును ధరించుకొని ప్రతిదినము బహుగా సుఖపడుచుండువాడు.',
        '"Now there was a certain rich man, and he was clothed in purple and fine linen, living in luxury every day.',
        'dhanavaṃtuḍokaḍuṃḍenu. vāḍu ūdāraṃgu baṭṭalunu sannapu nārabaṭṭalunu dhariñcukoni pratidinamu bahugā sukhapaḍucuṃḍuvāḍu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ధనవంతుడొకడుండెను.', 'dhanavaṃtuḍokaḍuṃḍenu.', 'a certain rich man.', 1),
        (verse_id_var, 2, 'వాడు', 'vāḍu', 'he', 2),
        (verse_id_var, 3, 'ఊదారంగు', 'ūdāraṃgu', 'purple', 3),
        (verse_id_var, 4, 'బట్టలును', 'baṭṭalunu', 'in', 4),
        (verse_id_var, 5, 'సన్నపు', 'sannapu', 'fine', 5),
        (verse_id_var, 6, 'నారబట్టలును', 'nārabaṭṭalunu', 'linen', 6),
        (verse_id_var, 7, 'ధరించుకొని', 'dhariñcukoni', 'was clothed', 7),
        (verse_id_var, 8, 'ప్రతిదినము', 'pratidinamu', 'every day', 8),
        (verse_id_var, 9, 'బహుగా', 'bahugā', 'in luxury', 9),
        (verse_id_var, 10, 'సుఖపడుచుండువాడు.', 'sukhapaḍucuṃḍuvāḍu.', 'living.', 10);

    -- VERSE 20
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 20,
        'లాజరు అను ఒక దరిద్రుడు పుండ్లతో నిండిన శరీరముతో వాని యింటి వాకిట పడియుండెను.',
        'A certain beggar, named Lazarus, was laid at his gate, full of sores,',
        'lājaru anu oka daridruḍu puṃḍlatō niṃḍina śarīramutō vāni yiṃṭi vākiṭa paḍiyuṃḍenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'లాజరు', 'lājaru', 'Lazarus', 1),
        (verse_id_var, 2, 'అను', 'anu', 'named', 2),
        (verse_id_var, 3, 'ఒక', 'oka', 'a certain', 3),
        (verse_id_var, 4, 'దరిద్రుడు', 'daridruḍu', 'beggar', 4),
        (verse_id_var, 5, 'పుండ్లతో', 'puṃḍlatō', 'of sores', 5),
        (verse_id_var, 6, 'నిండిన', 'niṃḍina', 'full', 6),
        (verse_id_var, 7, 'శరీరముతో', 'śarīramutō', 'in body', 7),
        (verse_id_var, 8, 'వాని', 'vāni', 'his', 8),
        (verse_id_var, 9, 'యింటి', 'yiṃṭi', 'house', 9),
        (verse_id_var, 10, 'వాకిట', 'vākiṭa', 'gate', 10),
        (verse_id_var, 11, 'పడియుండెను.', 'paḍiyuṃḍenu.', 'was laid.', 11);

    -- VERSE 21
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 21,
        'ధనవంతుని బల్లమీదనుండి పడు ముక్కలతో ఆకలి తీర్చుకొన గోరెను; అంతేకాదు కుక్కలు వచ్చి వాని పుండ్లు నాకెను.',
        'and desiring to be fed with the crumbs that fell from the rich man''s table. Yes, even the dogs came and licked his sores.',
        'dhanavaṃtuni ballamīdanuṃḍi paḍu mukkalatō ākali tīrcukona gōrenu; aṃtēkādu kukkalu vacci vāni puṃḍlu nākenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ధనవంతుని', 'dhanavaṃtuni', 'the rich man''s', 1),
        (verse_id_var, 2, 'బల్లమీదనుండి', 'ballamīdanuṃḍi', 'from table', 2),
        (verse_id_var, 3, 'పడు', 'paḍu', 'fell', 3),
        (verse_id_var, 4, 'ముక్కలతో', 'mukkalatō', 'with the crumbs', 4),
        (verse_id_var, 5, 'ఆకలి', 'ākali', 'hunger', 5),
        (verse_id_var, 6, 'తీర్చుకొన', 'tīrcukona', 'be fed', 6),
        (verse_id_var, 7, 'గోరెను;', 'gōrenu;', 'desiring;', 7),
        (verse_id_var, 8, 'అంతేకాదు', 'aṃtēkādu', 'yes, even', 8),
        (verse_id_var, 9, 'కుక్కలు', 'kukkalu', 'the dogs', 9),
        (verse_id_var, 10, 'వచ్చి', 'vacci', 'came', 10),
        (verse_id_var, 11, 'వాని', 'vāni', 'his', 11),
        (verse_id_var, 12, 'పుండ్లు', 'puṃḍlu', 'sores', 12),
        (verse_id_var, 13, 'నాకెను.', 'nākenu.', 'and licked.', 13);

    -- VERSE 22
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 22,
        'ఆ దరిద్రుడు చనిపోయి దేవదూతలచేత అబ్రాహాము రొమ్మున చేర్చబడెను. ధనవంతుడుకూడ చనిపోయి పాతిపెట్టబడెను.',
        'It happened that the beggar died, and that he was carried away by the angels to Abraham''s bosom. The rich man also died, and was buried.',
        'ā daridruḍu canipōyi dēvadūtalacēta abrāhāmu rommuna cērcabaḍenu. dhanavaṃtuḍukūḍa canipōyi pātipeṭṭabaḍenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆ', 'ā', 'the', 1),
        (verse_id_var, 2, 'దరిద్రుడు', 'daridruḍu', 'beggar', 2),
        (verse_id_var, 3, 'చనిపోయి', 'canipōyi', 'died', 3),
        (verse_id_var, 4, 'దేవదూతలచేత', 'dēvadūtalacēta', 'by the angels', 4),
        (verse_id_var, 5, 'అబ్రాహాము', 'abrāhāmu', 'Abraham''s', 5),
        (verse_id_var, 6, 'రొమ్మున', 'rommuna', 'bosom', 6),
        (verse_id_var, 7, 'చేర్చబడెను.', 'cērcabaḍenu.', 'was carried away to.', 7),
        (verse_id_var, 8, 'ధనవంతుడుకూడ', 'dhanavaṃtuḍukūḍa', 'the rich man also', 8),
        (verse_id_var, 9, 'చనిపోయి', 'canipōyi', 'died', 3),
        (verse_id_var, 10, 'పాతిపెట్టబడెను.', 'pātipeṭṭabaḍenu.', 'and was buried.', 9);

    -- VERSE 23
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 23,
        'పాతాళములో వాడు యాతనపడుచు, కన్నులెత్తి దూరమునుండి అబ్రాహామును అతని రొమ్మున లాజరును చూచి—',
        'In Hades, he lifted up his eyes, being in torment, and saw Abraham far off, and Lazarus at his bosom.',
        'pātāḷamulō vāḍu yātanapaḍucu, kannuletti dūramunuṃḍi abrāhāmunu atani rommuna lājarunu cūci—')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'పాతాళములో', 'pātāḷamulō', 'in Hades', 1),
        (verse_id_var, 2, 'వాడు', 'vāḍu', 'he', 2),
        (verse_id_var, 3, 'యాతనపడుచు,', 'yātanapaḍucu,', 'being in torment,', 3),
        (verse_id_var, 4, 'కన్నులెత్తి', 'kannuletti', 'lifted up his eyes', 4),
        (verse_id_var, 5, 'దూరమునుండి', 'dūramunuṃḍi', 'far off', 5),
        (verse_id_var, 6, 'అబ్రాహామును', 'abrāhāmunu', 'Abraham', 6),
        (verse_id_var, 7, 'అతని', 'atani', 'his', 7),
        (verse_id_var, 8, 'రొమ్మున', 'rommuna', 'at bosom', 8),
        (verse_id_var, 9, 'లాజరును', 'lājarunu', 'Lazarus', 9),
        (verse_id_var, 10, 'చూచి—', 'cūci—', 'and saw—', 10);

    -- VERSE 24
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 24,
        'తండ్రీ, అబ్రాహామా, నాయందు కనికరపడి నన్ను చల్లార్చుటకు లాజరు తన వ్రేలికొనను నీళ్లలో ముంచి నా నాలుకను చల్లార్చుటకు వాని పంపుము; ఈ అగ్నిజ్వాలలో నేను యాతనపడుచున్నానని కేకవేసి చెప్పెను.',
        'He cried and said, ''Father Abraham, have mercy on me, and send Lazarus, that he may dip the tip of his finger in water, and cool my tongue! For I am in anguish in this flame.''',
        'taṃḍrī, abrāhāmā, nāyaṃdu kanikarapaḍi nannu callārcuṭaku lājaru tana vrēlikonanu nīḷlalō muṃci nā nālukanu callārcuṭaku vāni paṃpumu; ī agnijvālalō nēnu yātanapaḍucunnānani kēkavēsi ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'తండ్రీ,', 'taṃḍrī,', 'Father,', 1),
        (verse_id_var, 2, 'అబ్రాహామా,', 'abrāhāmā,', 'Abraham,', 2),
        (verse_id_var, 3, 'నాయందు', 'nāyaṃdu', 'on me', 3),
        (verse_id_var, 4, 'కనికరపడి', 'kanikarapaḍi', 'have mercy', 4),
        (verse_id_var, 5, 'నన్ను', 'nannu', 'me', 3),
        (verse_id_var, 6, 'చల్లార్చుటకు', 'callārcuṭaku', 'to cool', 5),
        (verse_id_var, 7, 'లాజరు', 'lājaru', 'Lazarus', 6),
        (verse_id_var, 8, 'తన', 'tana', 'his', 7),
        (verse_id_var, 9, 'వ్రేలికొనను', 'vrēlikonanu', 'the tip of finger', 8),
        (verse_id_var, 10, 'నీళ్లలో', 'nīḷlalō', 'in water', 9),
        (verse_id_var, 11, 'ముంచి', 'muṃci', 'may dip', 10),
        (verse_id_var, 12, 'నా', 'nā', 'my', 11),
        (verse_id_var, 13, 'నాలుకను', 'nālukanu', 'tongue', 12),
        (verse_id_var, 14, 'చల్లార్చుటకు', 'callārcuṭaku', 'and cool', 5),
        (verse_id_var, 15, 'వాని', 'vāni', 'him', 13),
        (verse_id_var, 16, 'పంపుము;', 'paṃpumu;', 'send;', 14),
        (verse_id_var, 17, 'ఈ', 'ī', 'this', 15),
        (verse_id_var, 18, 'అగ్నిజ్వాలలో', 'agnijvālalō', 'in flame', 16),
        (verse_id_var, 19, 'నేను', 'nēnu', 'I', 17),
        (verse_id_var, 20, 'యాతనపడుచున్నానని', 'yātanapaḍucunnānani', 'am in anguish', 18),
        (verse_id_var, 21, 'కేకవేసి', 'kēkavēsi', 'cried', 19),
        (verse_id_var, 22, 'చెప్పెను.', 'ceppenu.', 'and said.', 20);

    -- VERSE 25
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 25,
        'అందుకు అబ్రాహాము—కుమారుడా, నీవు నీ జీవితకాలమందు నీ మంచివాటిని పొందితివి, ఆలాగుననే లాజరు చెడ్డవాటిని పొందెను; అని జ్ఞాపకము చేసికొనుము; ఇప్పుడైతే వాడిక్కడ నెమ్మదిపొందుచున్నాడు, నీవు యాతనపడుచున్నావు.',
        '"But Abraham said, ''Son, remember that you, in your lifetime, received your good things, and Lazarus, in the same way, bad things. But now here he is comforted and you are in anguish.',
        'aṃduku abrāhāmu—kumāruḍā, nīvu nī jīvitakālamaṃdu nī maṃcivāṭini poṃditivi, ālāgunanē lājaru ceḍḍavāṭini poṃdenu; ani jñāpakamu cēsikonumu; ippuḍaitē vāḍikkaḍa nemmadipoṃducunnāḍu, nīvu yātanapaḍucunnāvu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అందుకు', 'aṃduku', 'but', 1),
        (verse_id_var, 2, 'అబ్రాహాము—', 'abrāhāmu—', 'Abraham said—', 2),
        (verse_id_var, 3, 'కుమారుడా,', 'kumāruḍā,', 'Son,', 3),
        (verse_id_var, 4, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 5, 'నీ', 'nī', 'your', 5),
        (verse_id_var, 6, 'జీవితకాలమందు', 'jīvitakālamaṃdu', 'in lifetime', 6),
        (verse_id_var, 7, 'నీ', 'nī', 'your', 5),
        (verse_id_var, 8, 'మంచివాటిని', 'maṃcivāṭini', 'good things', 7),
        (verse_id_var, 9, 'పొందితివి,', 'poṃditivi,', 'received,', 8),
        (verse_id_var, 10, 'ఆలాగుననే', 'ālāgunanē', 'in the same way', 9),
        (verse_id_var, 11, 'లాజరు', 'lājaru', 'Lazarus', 10),
        (verse_id_var, 12, 'చెడ్డవాటిని', 'ceḍḍavāṭini', 'bad things', 11),
        (verse_id_var, 13, 'పొందెను;', 'poṃdenu;', 'received;', 8),
        (verse_id_var, 14, 'అని', 'ani', 'that', 12),
        (verse_id_var, 15, 'జ్ఞాపకము', 'jñāpakamu', 'remember', 13),
        (verse_id_var, 16, 'చేసికొనుము;', 'cēsikonumu;', 'do;', 13),
        (verse_id_var, 17, 'ఇప్పుడైతే', 'ippuḍaitē', 'but now', 14),
        (verse_id_var, 18, 'వాడిక్కడ', 'vāḍikkaḍa', 'here he', 15),
        (verse_id_var, 19, 'నెమ్మదిపొందుచున్నాడు,', 'nemmadipoṃducunnāḍu,', 'is comforted,', 16),
        (verse_id_var, 20, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 21, 'యాతనపడుచున్నావు.', 'yātanapaḍucunnāvu.', 'are in anguish.', 17);

    -- VERSE 26
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 26,
        'అంతేకాకుండ ఇక్కడనుండి మీ యొద్దకు దాటిపోగోరువారు దాట సాధ్యము కాకుండునట్లును, అక్కడివారు మాయొద్దకు దాటిరాగోరువారు దాటి రాకుండునట్లును, మాకును మీకును మధ్య మహా అగాధముంచబడియున్నది.',
        'Besides all this, between us and you there is a great gulf fixed, that those who want to pass from here to you are not able, and that none may cross over from there to us.''',
        'aṃtēkākuṃḍa ikkaḍanuṃḍi mī yoddaku dāṭipōgōruvāru dāṭa sādhyamu kākuṃḍunaṭlunu, akkaḍivāru māyoddaku dāṭirāgōruvāru dāṭi rākuṃḍunaṭlunu, mākunu mīkunu madhya mahā agādhamuṃcabaḍiyunnadi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అంతేకాకుండ', 'aṃtēkākuṃḍa', 'besides all this', 1),
        (verse_id_var, 2, 'ఇక్కడనుండి', 'ikkaḍanuṃḍi', 'from here', 2),
        (verse_id_var, 3, 'మీ', 'mī', 'your', 3),
        (verse_id_var, 4, 'యొద్దకు', 'yoddaku', 'to', 4),
        (verse_id_var, 5, 'దాటిపోగోరువారు', 'dāṭipōgōruvāru', 'those who want to pass', 5),
        (verse_id_var, 6, 'దాట', 'dāṭa', 'pass', 6),
        (verse_id_var, 7, 'సాధ్యము', 'sādhyamu', 'able', 7),
        (verse_id_var, 8, 'కాకుండునట్లును,', 'kākuṃḍunaṭlunu,', 'are not,', 8),
        (verse_id_var, 9, 'అక్కడివారు', 'akkaḍivāru', 'from there', 9),
        (verse_id_var, 10, 'మాయొద్దకు', 'māyoddaku', 'to us', 10),
        (verse_id_var, 11, 'దాటిరాగోరువారు', 'dāṭirāgōruvāru', 'who want to cross over', 11),
        (verse_id_var, 12, 'దాటి', 'dāṭi', 'cross', 12),
        (verse_id_var, 13, 'రాకుండునట్లును,', 'rākuṃḍunaṭlunu,', 'none may,', 13),
        (verse_id_var, 14, 'మాకును', 'mākunu', 'us', 14),
        (verse_id_var, 15, 'మీకును', 'mīkunu', 'and you', 15),
        (verse_id_var, 16, 'మధ్య', 'madhya', 'between', 16),
        (verse_id_var, 17, 'మహా', 'mahā', 'a great', 17),
        (verse_id_var, 18, 'అగాధముంచబడియున్నది.', 'agādhamuṃcabaḍiyunnadi.', 'gulf is fixed.', 18);

    -- VERSE 27
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 27,
        'అప్పుడతడు—తండ్రీ, ఆలాగైతే నా తండ్రి యింటికి లాజరును పంపవలెనని నిన్ను వేడుకొనుచున్నాను;',
        '"He said, ''I ask you therefore, father, that you would send him to my father''s house;',
        'appuḍataḍu—taṃḍrī, ālāgaitē nā taṃḍri yiṃṭiki lājarunu paṃpavalenani ninnu vēḍukonucunnānu;')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అప్పుడతడు—', 'appuḍataḍu—', 'he said—', 1),
        (verse_id_var, 2, 'తండ్రీ,', 'taṃḍrī,', 'father,', 2),
        (verse_id_var, 3, 'ఆలాగైతే', 'ālāgaitē', 'therefore', 3),
        (verse_id_var, 4, 'నా', 'nā', 'my', 4),
        (verse_id_var, 5, 'తండ్రి', 'taṃḍri', 'father''s', 5),
        (verse_id_var, 6, 'యింటికి', 'yiṃṭiki', 'to house', 6),
        (verse_id_var, 7, 'లాజరును', 'lājarunu', 'him', 7),
        (verse_id_var, 8, 'పంపవలెనని', 'paṃpavalenani', 'would send', 8),
        (verse_id_var, 9, 'నిన్ను', 'ninnu', 'you', 9),
        (verse_id_var, 10, 'వేడుకొనుచున్నాను;', 'vēḍukonucunnānu;', 'I ask;', 10);

    -- VERSE 28
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 28,
        'నాకు అయిదుగురు సహోదరులున్నారు. వారును ఈ యాతనస్థలమునకు రాకుండునట్లు వారికి సాక్ష్యమిచ్చుటకై వాని పంపుమని వేడుకొనుచున్నాననెను.',
        'for I have five brothers, that he may testify to them, so they won''t also come into this place of torment.''',
        'nāku ayidugurū sahōdarulunnāru. vārunu ī yātanasthalamunaku rākuṃḍunaṭlu vāriki sākṣyamiccuṭakai vāni paṃpumani vēḍukonucunnānanenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నాకు', 'nāku', 'I have', 1),
        (verse_id_var, 2, 'అయిదుగురు', 'ayidugurū', 'five', 2),
        (verse_id_var, 3, 'సహోదరులున్నారు.', 'sahōdarulunnāru.', 'brothers.', 3),
        (verse_id_var, 4, 'వారును', 'vārunu', 'they', 4),
        (verse_id_var, 5, 'ఈ', 'ī', 'this', 5),
        (verse_id_var, 6, 'యాతనస్థలమునకు', 'yātanasthalamunaku', 'place of torment', 6),
        (verse_id_var, 7, 'రాకుండునట్లు', 'rākuṃḍunaṭlu', 'won''t also come into', 7),
        (verse_id_var, 8, 'వారికి', 'vāriki', 'to them', 8),
        (verse_id_var, 9, 'సాక్ష్యమిచ్చుటకై', 'sākṣyamiccuṭakai', 'may testify', 9),
        (verse_id_var, 10, 'వాని', 'vāni', 'he', 10),
        (verse_id_var, 11, 'పంపుమని', 'paṃpumani', 'send', 11),
        (verse_id_var, 12, 'వేడుకొనుచున్నాననెను.', 'vēḍukonucunnānanenu.', 'said pleading.', 12);

    -- VERSE 29
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 29,
        'అందుకు అబ్రాహాము—వారియొద్ద మోషేయు ప్రవక్తలును ఉన్నారు; వారి మాటలు వినవలెనని అతనితో చెప్పగా,',
        '"But Abraham said to him, ''They have Moses and the prophets. Let them listen to them.''',
        'aṃduku abrāhāmu—vāriyodda mōṣēyu pravaktalunu unnāru; vāri māṭalu vinavalenani atanitō ceppagā,')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అందుకు', 'aṃduku', 'but', 1),
        (verse_id_var, 2, 'అబ్రాహాము—', 'abrāhāmu—', 'Abraham said—', 2),
        (verse_id_var, 3, 'వారియొద్ద', 'vāriyodda', 'they have', 3),
        (verse_id_var, 4, 'మోషేయు', 'mōṣēyu', 'Moses', 4),
        (verse_id_var, 5, 'ప్రవక్తలును', 'pravaktalunu', 'and the prophets', 5),
        (verse_id_var, 6, 'ఉన్నారు;', 'unnāru;', 'are there;', 6),
        (verse_id_var, 7, 'వారి', 'vāri', 'to them', 7),
        (verse_id_var, 8, 'మాటలు', 'māṭalu', 'words', 8),
        (verse_id_var, 9, 'వినవలెనని', 'vinavalenani', 'let them listen', 9),
        (verse_id_var, 10, 'అతనితో', 'atanitō', 'to him', 10),
        (verse_id_var, 11, 'చెప్పగా,', 'ceppagā,', 'said,', 11);

    -- VERSE 30
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 30,
        'అతడు—తండ్రీ, అబ్రాహామా, ఆలాగు అనవద్దు; మృతులలోనుండి ఒకడు వారియొద్దకు వెళ్లినయెడల వారు మారుమనస్సు పొందుదురనెను.',
        '"He said, ''No, father Abraham, but if one goes to them from the dead, they will repent.''',
        'ataḍu—taṃḍrī, abrāhāmā, ālāgu anavaddu; mr̥tulalōnuṃḍi okaḍu vāriyoddaku veḷlinayeḍala vāru mārumanassu poṃdudurananenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అతడు—', 'ataḍu—', 'he said—', 1),
        (verse_id_var, 2, 'తండ్రీ,', 'taṃḍrī,', 'father,', 2),
        (verse_id_var, 3, 'అబ్రాహామా,', 'abrāhāmā,', 'Abraham,', 3),
        (verse_id_var, 4, 'ఆలాగు', 'ālāgu', 'so', 4),
        (verse_id_var, 5, 'అనవద్దు;', 'anavaddu;', 'no;', 5),
        (verse_id_var, 6, 'మృతులలోనుండి', 'mr̥tulalōnuṃḍi', 'from the dead', 6),
        (verse_id_var, 7, 'ఒకడు', 'okaḍu', 'one', 7),
        (verse_id_var, 8, 'వారియొద్దకు', 'vāriyoddaku', 'to them', 8),
        (verse_id_var, 9, 'వెళ్లినయెడల', 'veḷlinayeḍala', 'if goes', 9),
        (verse_id_var, 10, 'వారు', 'vāru', 'they', 10),
        (verse_id_var, 11, 'మారుమనస్సు', 'mārumanassu', 'repentance', 11),
        (verse_id_var, 12, 'పొందుదురనెను.', 'poṃdudurananenu.', 'will receive.', 12);

    -- VERSE 31
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 31,
        'అందుకతడు—వారు మోషేయు, ప్రవక్తలును చెప్పిన మాటలు వినని యెడల మృతులలోనుండి ఒకడు లేచినను నమ్మరని అతనితో చెప్పెను.',
        '"He said to him, ''If they don''t listen to Moses and the prophets, neither will they be persuaded if one rises from the dead.''"',
        'aṃdukataḍu—vāru mōṣēyu, pravaktalunu ceppina māṭalu vinani yeḍala mr̥tulalōnuṃḍi okaḍu lēcinanu nammarani atanitō ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అందుకతడు—', 'aṃdukataḍu—', 'he said—', 1),
        (verse_id_var, 2, 'వారు', 'vāru', 'they', 2),
        (verse_id_var, 3, 'మోషేయు,', 'mōṣēyu,', 'to Moses,', 3),
        (verse_id_var, 4, 'ప్రవక్తలును', 'pravaktalunu', 'and the prophets', 4),
        (verse_id_var, 5, 'చెప్పిన', 'ceppina', 'spoken', 5),
        (verse_id_var, 6, 'మాటలు', 'māṭalu', 'words', 6),
        (verse_id_var, 7, 'వినని', 'vinani', 'don''t listen', 7),
        (verse_id_var, 8, 'యెడల', 'yeḍala', 'if', 8),
        (verse_id_var, 9, 'మృతులలోనుండి', 'mr̥tulalōnuṃḍi', 'from the dead', 9),
        (verse_id_var, 10, 'ఒకడు', 'okaḍu', 'one', 10),
        (verse_id_var, 11, 'లేచినను', 'lēcinanu', 'rises', 11),
        (verse_id_var, 12, 'నమ్మరని', 'nammarani', 'will not be persuaded', 12),
        (verse_id_var, 13, 'అతనితో', 'atanitō', 'to him', 13),
        (verse_id_var, 14, 'చెప్పెను.', 'ceppenu.', 'said.', 14);
END $$;
