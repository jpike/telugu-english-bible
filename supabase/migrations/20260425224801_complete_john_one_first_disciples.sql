/*
  # Complete John 1 with the calling of the first disciples (verses 35-51)

  1. Content additions
    - Adds John 1:35 through 1:51 (17 verses), completing John chapter 1.
    - Covers Andrew, Simon Peter, Philip, and Nathanael being called as Jesus' first disciples.
    - Each verse upserts BSI-style Telugu, WEB English, and ISO-15919 transliteration.
    - Each verse seeds aligned `verse_tokens` with per-verse alignment groups.

  2. Strategy
    - Idempotent: verses upserted by (chapter_id, verse_number); tokens cleared and re-inserted per verse.
    - No schema changes; data only.

  3. Notes
    - With this migration, John 1 becomes the second fully-complete chapter (after Genesis 1).
    - Curated character alignments are not seeded; the runtime AksharaSegmenter handles per-character coloring.
*/

DO $$
DECLARE
    chapter_id_var bigint;
    verse_id_var bigint;
BEGIN
    SELECT id INTO chapter_id_var FROM chapters WHERE book_id = 43 AND chapter_number = 1;

    -- VERSE 35
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 35,
        'మరునాడు మరల యోహానును అతని శిష్యులలో ఇద్దరును నిలుచుండగా,',
        'Again, the next day, John was standing with two of his disciples,',
        'marunāḍu marala yōhānunu atani śiṣyulalō iddaranu nilucuṇḍagā,')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మరునాడు', 'marunāḍu', 'the next day', 1),
        (verse_id_var, 2, 'మరల', 'marala', 'Again', 2),
        (verse_id_var, 3, 'యోహానును', 'yōhānunu', 'John', 3),
        (verse_id_var, 4, 'అతని', 'atani', 'his', 4),
        (verse_id_var, 5, 'శిష్యులలో', 'śiṣyulalō', 'of disciples', 5),
        (verse_id_var, 6, 'ఇద్దరును', 'iddaranu', 'two', 6),
        (verse_id_var, 7, 'నిలుచుండగా,', 'nilucuṇḍagā,', 'was standing,', 7);

    -- VERSE 36
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 36,
        'యేసు నడుచుచుండగా అతడు ఆయనవైపు చూచి—ఇదిగో దేవుని గొఱ్ఱెపిల్ల అని చెప్పెను.',
        'and he looked at Jesus as he walked, and said, "Behold, the Lamb of God!"',
        'yēsu naḍucucuṇḍagā ataḍu āyanavaipu cūci—idigō dēvuni gor̥r̥epilla ani ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యేసు', 'yēsu', 'Jesus', 1),
        (verse_id_var, 2, 'నడుచుచుండగా', 'naḍucucuṇḍagā', 'as walked', 2),
        (verse_id_var, 3, 'అతడు', 'ataḍu', 'he', 3),
        (verse_id_var, 4, 'ఆయనవైపు', 'āyanavaipu', 'at him', 1),
        (verse_id_var, 5, 'చూచి—', 'cūci—', 'looked—', 4),
        (verse_id_var, 6, 'ఇదిగో', 'idigō', 'Behold', 5),
        (verse_id_var, 7, 'దేవుని', 'dēvuni', 'of God', 6),
        (verse_id_var, 8, 'గొఱ్ఱెపిల్ల', 'gor̥r̥epilla', 'the Lamb', 7),
        (verse_id_var, 9, 'అని', 'ani', 'saying', 8),
        (verse_id_var, 10, 'చెప్పెను.', 'ceppenu.', 'said.', 9);

    -- VERSE 37
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 37,
        'ఆ యిద్దరు శిష్యులు అతడు చెప్పిన మాట విని యేసును వెంబడించిరి.',
        'The two disciples heard him speak, and they followed Jesus.',
        'ā yiddaru śiṣyulu ataḍu ceppina māṭa vinī yēsunu veṃbaḍiñciri.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆ', 'ā', 'The', 1),
        (verse_id_var, 2, 'యిద్దరు', 'yiddaru', 'two', 2),
        (verse_id_var, 3, 'శిష్యులు', 'śiṣyulu', 'disciples', 3),
        (verse_id_var, 4, 'అతడు', 'ataḍu', 'him', 4),
        (verse_id_var, 5, 'చెప్పిన', 'ceppina', 'speak', 5),
        (verse_id_var, 6, 'మాట', 'māṭa', 'word', 6),
        (verse_id_var, 7, 'విని', 'vinī', 'heard', 7),
        (verse_id_var, 8, 'యేసును', 'yēsunu', 'Jesus', 8),
        (verse_id_var, 9, 'వెంబడించిరి.', 'veṃbaḍiñciri.', 'and they followed.', 9);

    -- VERSE 38
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 38,
        'యేసు వెనుక తిరిగి, వారు తన్ను వెంబడించుట చూచి—మీరేమి వెదకుచున్నారని వారినడుగగా, వారు—రబ్బీ, నీవు ఎక్కడ కాపురమున్నావని ఆయన నడిగిరి. రబ్బీ అను మాటకు బోధకుడని అర్థము.',
        'Jesus turned, and saw them following, and said to them, "What are you looking for?" They said to him, "Rabbi" (which is to say, being interpreted, Teacher), "where are you staying?"',
        'yēsu venuka tirigi, vāru tannu veṃbaḍiñcuṭa cūci—mīrēmi vedakucunnārani vārinaḍugagā, vāru—rabbī, nīvu ekkaḍa kāpuramunnāvani āyana naḍigiri. rabbī anu māṭaku bōdhakuḍani arthamu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యేసు', 'yēsu', 'Jesus', 1),
        (verse_id_var, 2, 'వెనుక', 'venuka', 'around', 2),
        (verse_id_var, 3, 'తిరిగి,', 'tirigi,', 'turned,', 3),
        (verse_id_var, 4, 'వారు', 'vāru', 'them', 4),
        (verse_id_var, 5, 'తన్ను', 'tannu', 'him', 1),
        (verse_id_var, 6, 'వెంబడించుట', 'veṃbaḍiñcuṭa', 'following', 5),
        (verse_id_var, 7, 'చూచి—', 'cūci—', 'and saw—', 6),
        (verse_id_var, 8, 'మీరేమి', 'mīrēmi', 'What you', 7),
        (verse_id_var, 9, 'వెదకుచున్నారని', 'vedakucunnārani', 'are looking for', 8),
        (verse_id_var, 10, 'వారినడుగగా,', 'vārinaḍugagā,', 'said to them,', 9),
        (verse_id_var, 11, 'వారు—', 'vāru—', 'They—', 4),
        (verse_id_var, 12, 'రబ్బీ,', 'rabbī,', 'Rabbi,', 10),
        (verse_id_var, 13, 'నీవు', 'nīvu', 'you', 11),
        (verse_id_var, 14, 'ఎక్కడ', 'ekkaḍa', 'where', 12),
        (verse_id_var, 15, 'కాపురమున్నావని', 'kāpuramunnāvani', 'are staying', 13),
        (verse_id_var, 16, 'ఆయన', 'āyana', 'him', 1),
        (verse_id_var, 17, 'నడిగిరి.', 'naḍigiri.', 'said to.', 14),
        (verse_id_var, 18, 'రబ్బీ', 'rabbī', 'Rabbi', 10),
        (verse_id_var, 19, 'అను', 'anu', 'which is', 15),
        (verse_id_var, 20, 'మాటకు', 'māṭaku', 'word', 16),
        (verse_id_var, 21, 'బోధకుడని', 'bōdhakuḍani', 'Teacher', 17),
        (verse_id_var, 22, 'అర్థము.', 'arthamu.', 'means.', 18);

    -- VERSE 39
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 39,
        'ఆయన—వచ్చి చూడుడని వారితో చెప్పగా, వారు వెళ్లి ఆయన కాపురమున్న స్థలము చూచి, ఆ దినము ఆయనయొద్ద ఉండిరి. అప్పుడు పగటిసమయము ఇంచుమించు నాలుగు గంటలు.',
        'He said to them, "Come, and see." They came and saw where he was staying, and they stayed with him that day. It was about the tenth hour.',
        'āyana—vacci cūḍuḍani vāritō ceppagā, vāru veḷḷi āyana kāpuramunna sthalamu cūci, ā dinamu āyanayodda uṇḍiri. appuḍu pagaṭisamayamu iñcumiñcu nālugu gaṇṭalu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆయన—', 'āyana—', 'He—', 1),
        (verse_id_var, 2, 'వచ్చి', 'vacci', 'Come', 2),
        (verse_id_var, 3, 'చూడుడని', 'cūḍuḍani', 'and see', 3),
        (verse_id_var, 4, 'వారితో', 'vāritō', 'to them', 4),
        (verse_id_var, 5, 'చెప్పగా,', 'ceppagā,', 'said,', 5),
        (verse_id_var, 6, 'వారు', 'vāru', 'They', 4),
        (verse_id_var, 7, 'వెళ్లి', 'veḷḷi', 'came', 6),
        (verse_id_var, 8, 'ఆయన', 'āyana', 'he', 1),
        (verse_id_var, 9, 'కాపురమున్న', 'kāpuramunna', 'was staying', 7),
        (verse_id_var, 10, 'స్థలము', 'sthalamu', 'where', 8),
        (verse_id_var, 11, 'చూచి,', 'cūci,', 'and saw,', 3),
        (verse_id_var, 12, 'ఆ', 'ā', 'that', 9),
        (verse_id_var, 13, 'దినము', 'dinamu', 'day', 10),
        (verse_id_var, 14, 'ఆయనయొద్ద', 'āyanayodda', 'with him', 1),
        (verse_id_var, 15, 'ఉండిరి.', 'uṇḍiri.', 'they stayed.', 11),
        (verse_id_var, 16, 'అప్పుడు', 'appuḍu', 'It was', 12),
        (verse_id_var, 17, 'పగటిసమయము', 'pagaṭisamayamu', 'hour', 13),
        (verse_id_var, 18, 'ఇంచుమించు', 'iñcumiñcu', 'about', 14),
        (verse_id_var, 19, 'నాలుగు', 'nālugu', 'tenth', 15),
        (verse_id_var, 20, 'గంటలు.', 'gaṇṭalu.', 'the.', 13);

    -- VERSE 40
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 40,
        'యోహాను మాట విని ఆయనను వెంబడించిన ఆ యిద్దరిలో ఒకడు సీమోను పేతురు సహోదరుడైన అంద్రెయ.',
        'One of the two who heard John, and followed him, was Andrew, Simon Peter''s brother.',
        'yōhānu māṭa vinī āyananu veṃbaḍiñcina ā yiddarilō okaḍu sīmōnu pēturu sahōdaruḍaina andreya.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యోహాను', 'yōhānu', 'John', 1),
        (verse_id_var, 2, 'మాట', 'māṭa', 'word', 2),
        (verse_id_var, 3, 'విని', 'vinī', 'who heard', 3),
        (verse_id_var, 4, 'ఆయనను', 'āyananu', 'him', 4),
        (verse_id_var, 5, 'వెంబడించిన', 'veṃbaḍiñcina', 'and followed', 5),
        (verse_id_var, 6, 'ఆ', 'ā', 'the', 6),
        (verse_id_var, 7, 'యిద్దరిలో', 'yiddarilō', 'of two', 7),
        (verse_id_var, 8, 'ఒకడు', 'okaḍu', 'One', 8),
        (verse_id_var, 9, 'సీమోను', 'sīmōnu', 'Simon', 9),
        (verse_id_var, 10, 'పేతురు', 'pēturu', 'Peter''s', 10),
        (verse_id_var, 11, 'సహోదరుడైన', 'sahōdaruḍaina', 'brother', 11),
        (verse_id_var, 12, 'అంద్రెయ.', 'andreya.', 'was Andrew.', 12);

    -- VERSE 41
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 41,
        'ఇతడు మొదట తన సహోదరుడైన సీమోనును చూచి—మేము మెస్సీయను కనుగొంటిమని అతనితో చెప్పెను. మెస్సీయ అను మాటకు అభిషిక్తుడు అని అర్థము.',
        'He first found his own brother, Simon, and said to him, "We have found the Messiah!" (which is, being interpreted, Christ).',
        'itaḍu modaṭa tana sahōdaruḍaina sīmōnunu cūci—mēmu messīyanu kanugoṇṭimani atanitō ceppenu. messīya anu māṭaku abhiṣiktuḍu ani arthamu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఇతడు', 'itaḍu', 'He', 1),
        (verse_id_var, 2, 'మొదట', 'modaṭa', 'first', 2),
        (verse_id_var, 3, 'తన', 'tana', 'his own', 3),
        (verse_id_var, 4, 'సహోదరుడైన', 'sahōdaruḍaina', 'brother', 4),
        (verse_id_var, 5, 'సీమోనును', 'sīmōnunu', 'Simon', 5),
        (verse_id_var, 6, 'చూచి—', 'cūci—', 'found—', 6),
        (verse_id_var, 7, 'మేము', 'mēmu', 'We', 7),
        (verse_id_var, 8, 'మెస్సీయను', 'messīyanu', 'the Messiah', 8),
        (verse_id_var, 9, 'కనుగొంటిమని', 'kanugoṇṭimani', 'have found', 9),
        (verse_id_var, 10, 'అతనితో', 'atanitō', 'to him', 10),
        (verse_id_var, 11, 'చెప్పెను.', 'ceppenu.', 'and said.', 11),
        (verse_id_var, 12, 'మెస్సీయ', 'messīya', 'Messiah', 8),
        (verse_id_var, 13, 'అను', 'anu', 'which is', 12),
        (verse_id_var, 14, 'మాటకు', 'māṭaku', 'word', 13),
        (verse_id_var, 15, 'అభిషిక్తుడు', 'abhiṣiktuḍu', 'Christ', 14),
        (verse_id_var, 16, 'అని', 'ani', 'being interpreted', 15),
        (verse_id_var, 17, 'అర్థము.', 'arthamu.', 'means.', 16);

    -- VERSE 42
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 42,
        'అతడు అతనిని యేసు యొద్దకు తోడుకొనిరాగా యేసు అతని వైపు చూచి—నీవు యోహాను కుమారుడవైన సీమోనువు; నీవు కేఫా అనబడుదువని చెప్పెను. కేఫా అను మాటకు రాయి అని అర్థము.',
        'He brought him to Jesus. Jesus looked at him, and said, "You are Simon the son of Jonah. You shall be called Cephas" (which is by interpretation, Peter).',
        'ataḍu atanini yēsu yoddaku tōḍukoniraagā yēsu atani vaipu cūci—nīvu yōhānu kumāruḍavaina sīmōnuvu; nīvu kēphā anabaḍuduvani ceppenu. kēphā anu māṭaku rāyi ani arthamu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అతడు', 'ataḍu', 'He', 1),
        (verse_id_var, 2, 'అతనిని', 'atanini', 'him', 2),
        (verse_id_var, 3, 'యేసు', 'yēsu', 'Jesus', 3),
        (verse_id_var, 4, 'యొద్దకు', 'yoddaku', 'to', 4),
        (verse_id_var, 5, 'తోడుకొనిరాగా', 'tōḍukoniraagā', 'brought', 5),
        (verse_id_var, 6, 'యేసు', 'yēsu', 'Jesus', 3),
        (verse_id_var, 7, 'అతని', 'atani', 'him', 2),
        (verse_id_var, 8, 'వైపు', 'vaipu', 'at', 6),
        (verse_id_var, 9, 'చూచి—', 'cūci—', 'looked—', 7),
        (verse_id_var, 10, 'నీవు', 'nīvu', 'You', 8),
        (verse_id_var, 11, 'యోహాను', 'yōhānu', 'of Jonah', 9),
        (verse_id_var, 12, 'కుమారుడవైన', 'kumāruḍavaina', 'the son', 10),
        (verse_id_var, 13, 'సీమోనువు;', 'sīmōnuvu;', 'are Simon;', 11),
        (verse_id_var, 14, 'నీవు', 'nīvu', 'You', 8),
        (verse_id_var, 15, 'కేఫా', 'kēphā', 'Cephas', 12),
        (verse_id_var, 16, 'అనబడుదువని', 'anabaḍuduvani', 'shall be called', 13),
        (verse_id_var, 17, 'చెప్పెను.', 'ceppenu.', 'said.', 14),
        (verse_id_var, 18, 'కేఫా', 'kēphā', 'Cephas', 12),
        (verse_id_var, 19, 'అను', 'anu', 'which is', 15),
        (verse_id_var, 20, 'మాటకు', 'māṭaku', 'word', 16),
        (verse_id_var, 21, 'రాయి', 'rāyi', 'Peter', 17),
        (verse_id_var, 22, 'అని', 'ani', 'by interpretation', 18),
        (verse_id_var, 23, 'అర్థము.', 'arthamu.', 'means.', 19);

    -- VERSE 43
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 43,
        'మరునాడు ఆయన గలిలయకు వెళ్లగోరి ఫిలిప్పును కనుగొని—నన్ను వెంబడించుమని అతనితో చెప్పెను.',
        'On the next day, he was determined to go out into Galilee, and he found Philip. Jesus said to him, "Follow me."',
        'marunāḍu āyana galilayaku veḷḷagōri philippunu kanugoni—nannu veṃbaḍiñcumani atanitō ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మరునాడు', 'marunāḍu', 'On the next day', 1),
        (verse_id_var, 2, 'ఆయన', 'āyana', 'he', 2),
        (verse_id_var, 3, 'గలిలయకు', 'galilayaku', 'into Galilee', 3),
        (verse_id_var, 4, 'వెళ్లగోరి', 'veḷḷagōri', 'was determined to go', 4),
        (verse_id_var, 5, 'ఫిలిప్పును', 'philippunu', 'Philip', 5),
        (verse_id_var, 6, 'కనుగొని—', 'kanugoni—', 'and found—', 6),
        (verse_id_var, 7, 'నన్ను', 'nannu', 'me', 7),
        (verse_id_var, 8, 'వెంబడించుమని', 'veṃbaḍiñcumani', 'Follow', 8),
        (verse_id_var, 9, 'అతనితో', 'atanitō', 'to him', 9),
        (verse_id_var, 10, 'చెప్పెను.', 'ceppenu.', 'said.', 10);

    -- VERSE 44
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 44,
        'ఫిలిప్పు అంద్రెయ పేతురుల పట్టణమైన బేత్సయిదావాడు.',
        'Now Philip was from Bethsaida, of the city of Andrew and Peter.',
        'philippu andreya pēturula paṭṭaṇamaina bētsayidāvāḍu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఫిలిప్పు', 'philippu', 'Philip', 1),
        (verse_id_var, 2, 'అంద్రెయ', 'andreya', 'of Andrew', 2),
        (verse_id_var, 3, 'పేతురుల', 'pēturula', 'and Peter', 3),
        (verse_id_var, 4, 'పట్టణమైన', 'paṭṭaṇamaina', 'of the city', 4),
        (verse_id_var, 5, 'బేత్సయిదావాడు.', 'bētsayidāvāḍu.', 'was from Bethsaida.', 5);

    -- VERSE 45
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 45,
        'ఫిలిప్పు నతనయేలును కనుగొని—ధర్మశాస్త్రములో మోషేయు ప్రవక్తలును ఎవనిగూర్చి వ్రాసిరో ఆయనను కనుగొంటిమి; ఆయన యోసేపు కుమారుడైన నజరేతు యేసు అని అతనితో చెప్పెను.',
        'Philip found Nathanael, and said to him, "We have found him, of whom Moses in the law, and the prophets, wrote: Jesus of Nazareth, the son of Joseph."',
        'philippu nataniyēlunu kanugoni—dharmaśāstramulō mōṣēyu pravaktalunu evanigūrci vrāsirō āyananu kanugoṇṭimi; āyana yōsēpu kumāruḍaina najarētu yēsu ani atanitō ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఫిలిప్పు', 'philippu', 'Philip', 1),
        (verse_id_var, 2, 'నతనయేలును', 'nataniyēlunu', 'Nathanael', 2),
        (verse_id_var, 3, 'కనుగొని—', 'kanugoni—', 'found—', 3),
        (verse_id_var, 4, 'ధర్మశాస్త్రములో', 'dharmaśāstramulō', 'in the law', 4),
        (verse_id_var, 5, 'మోషేయు', 'mōṣēyu', 'Moses', 5),
        (verse_id_var, 6, 'ప్రవక్తలును', 'pravaktalunu', 'and the prophets', 6),
        (verse_id_var, 7, 'ఎవనిగూర్చి', 'evanigūrci', 'of whom', 7),
        (verse_id_var, 8, 'వ్రాసిరో', 'vrāsirō', 'wrote', 8),
        (verse_id_var, 9, 'ఆయననుకనుగొంటిమి;', 'āyananukanugoṇṭimi;', 'We have found him;', 9),
        (verse_id_var, 10, 'ఆయన', 'āyana', 'he', 10),
        (verse_id_var, 11, 'యోసేపు', 'yōsēpu', 'of Joseph', 11),
        (verse_id_var, 12, 'కుమారుడైన', 'kumāruḍaina', 'the son', 12),
        (verse_id_var, 13, 'నజరేతు', 'najarētu', 'of Nazareth', 13),
        (verse_id_var, 14, 'యేసు', 'yēsu', 'Jesus', 14),
        (verse_id_var, 15, 'అని', 'ani', 'saying', 15),
        (verse_id_var, 16, 'అతనితో', 'atanitō', 'to him', 16),
        (verse_id_var, 17, 'చెప్పెను.', 'ceppenu.', 'said.', 17);

    -- VERSE 46
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 46,
        'అందుకు నతనయేలు—నజరేతులోనుండి మంచిదేదైనను రాగలదా అని అతనితో అనగా, ఫిలిప్పు—వచ్చి చూడుమని అతనితో చెప్పెను.',
        'Nathanael said to him, "Can any good thing come out of Nazareth?" Philip said to him, "Come and see."',
        'anduku nataniyēlu—najarētulōnuṇḍi mañcidēdainanu rāgaladā ani atanitō anagā, philippu—vacci cūḍumani atanitō ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అందుకు', 'anduku', 'said', 1),
        (verse_id_var, 2, 'నతనయేలు—', 'nataniyēlu—', 'Nathanael—', 2),
        (verse_id_var, 3, 'నజరేతులోనుండి', 'najarētulōnuṇḍi', 'out of Nazareth', 3),
        (verse_id_var, 4, 'మంచిదేదైనను', 'mañcidēdainanu', 'any good thing', 4),
        (verse_id_var, 5, 'రాగలదా', 'rāgaladā', 'Can come', 5),
        (verse_id_var, 6, 'అని', 'ani', 'asking', 6),
        (verse_id_var, 7, 'అతనితో', 'atanitō', 'to him', 7),
        (verse_id_var, 8, 'అనగా,', 'anagā,', 'said,', 1),
        (verse_id_var, 9, 'ఫిలిప్పు—', 'philippu—', 'Philip—', 8),
        (verse_id_var, 10, 'వచ్చి', 'vacci', 'Come', 9),
        (verse_id_var, 11, 'చూడుమని', 'cūḍumani', 'and see', 10),
        (verse_id_var, 12, 'అతనితో', 'atanitō', 'to him', 7),
        (verse_id_var, 13, 'చెప్పెను.', 'ceppenu.', 'said.', 1);

    -- VERSE 47
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 47,
        'యేసు నతనయేలు తనయొద్దకు వచ్చుట చూచి—ఇదిగో యితడు నిజముగా ఇశ్రాయేలీయుడు, ఇతనియందు ఏ కపటమును లేదని అతనినిగూర్చి చెప్పెను.',
        'Jesus saw Nathanael coming to him, and said about him, "Behold, an Israelite indeed, in whom is no deceit!"',
        'yēsu nataniyēlu tanayoddaku vaccuṭa cūci—idigō yitaḍu nijamugā iśrāyēlīyuḍu, itaniyandu ē kapaṭamunu lēdani ataninigūrci ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యేసు', 'yēsu', 'Jesus', 1),
        (verse_id_var, 2, 'నతనయేలు', 'nataniyēlu', 'Nathanael', 2),
        (verse_id_var, 3, 'తనయొద్దకు', 'tanayoddaku', 'to him', 3),
        (verse_id_var, 4, 'వచ్చుట', 'vaccuṭa', 'coming', 4),
        (verse_id_var, 5, 'చూచి—', 'cūci—', 'saw—', 5),
        (verse_id_var, 6, 'ఇదిగో', 'idigō', 'Behold', 6),
        (verse_id_var, 7, 'యితడు', 'yitaḍu', 'this man', 7),
        (verse_id_var, 8, 'నిజముగా', 'nijamugā', 'indeed', 8),
        (verse_id_var, 9, 'ఇశ్రాయేలీయుడు,', 'iśrāyēlīyuḍu,', 'an Israelite,', 9),
        (verse_id_var, 10, 'ఇతనియందు', 'itaniyandu', 'in whom', 10),
        (verse_id_var, 11, 'ఏ', 'ē', 'no', 11),
        (verse_id_var, 12, 'కపటమును', 'kapaṭamunu', 'deceit', 12),
        (verse_id_var, 13, 'లేదని', 'lēdani', 'is', 13),
        (verse_id_var, 14, 'అతనినిగూర్చి', 'ataninigūrci', 'about him', 14),
        (verse_id_var, 15, 'చెప్పెను.', 'ceppenu.', 'said.', 15);

    -- VERSE 48
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 48,
        'నతనయేలు—నన్ను నీకెట్లు తెలియునని ఆయన నడుగగా యేసు—ఫిలిప్పు నిన్ను పిలువక మునుపే నీవు ఆ అంజూరపుచెట్టు క్రింద ఉన్నప్పుడే నిన్ను చూచితినని అతనితో చెప్పెను.',
        'Nathanael said to him, "How do you know me?" Jesus answered him, "Before Philip called you, when you were under the fig tree, I saw you."',
        'nataniyēlu—nannu nīkeṭlu teliyunani āyana naḍugagā yēsu—philippu ninnu piluvaka munupē nīvu ā añjūrapuceṭṭu krinda unnappuḍē ninnu cūcitinani atanitō ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నతనయేలు—', 'nataniyēlu—', 'Nathanael—', 1),
        (verse_id_var, 2, 'నన్ను', 'nannu', 'me', 2),
        (verse_id_var, 3, 'నీకెట్లు', 'nīkeṭlu', 'How do you', 3),
        (verse_id_var, 4, 'తెలియునని', 'teliyunani', 'know', 4),
        (verse_id_var, 5, 'ఆయన', 'āyana', 'said to him', 5),
        (verse_id_var, 6, 'నడుగగా', 'naḍugagā', 'asking', 6),
        (verse_id_var, 7, 'యేసు—', 'yēsu—', 'Jesus answered—', 7),
        (verse_id_var, 8, 'ఫిలిప్పు', 'philippu', 'Philip', 8),
        (verse_id_var, 9, 'నిన్ను', 'ninnu', 'you', 9),
        (verse_id_var, 10, 'పిలువక', 'piluvaka', 'called', 10),
        (verse_id_var, 11, 'మునుపే', 'munupē', 'Before', 11),
        (verse_id_var, 12, 'నీవు', 'nīvu', 'you', 9),
        (verse_id_var, 13, 'ఆ', 'ā', 'the', 12),
        (verse_id_var, 14, 'అంజూరపుచెట్టు', 'añjūrapuceṭṭu', 'fig tree', 13),
        (verse_id_var, 15, 'క్రింద', 'krinda', 'under', 14),
        (verse_id_var, 16, 'ఉన్నప్పుడే', 'unnappuḍē', 'when were', 15),
        (verse_id_var, 17, 'నిన్ను', 'ninnu', 'you', 9),
        (verse_id_var, 18, 'చూచితినని', 'cūcitinani', 'I saw', 16),
        (verse_id_var, 19, 'అతనితో', 'atanitō', 'to him', 17),
        (verse_id_var, 20, 'చెప్పెను.', 'ceppenu.', 'said.', 18);

    -- VERSE 49
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 49,
        'నతనయేలు—రబ్బీ, నీవు దేవుని కుమారుడవు, నీవు ఇశ్రాయేలు రాజవు అని ఆయనకు ఉత్తరమిచ్చెను.',
        'Nathanael answered him, "Rabbi, you are the Son of God! You are King of Israel!"',
        'nataniyēlu—rabbī, nīvu dēvuni kumāruḍavu, nīvu iśrāyēlu rājavu ani āyanaku uttaramiccenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నతనయేలు—', 'nataniyēlu—', 'Nathanael—', 1),
        (verse_id_var, 2, 'రబ్బీ,', 'rabbī,', 'Rabbi,', 2),
        (verse_id_var, 3, 'నీవు', 'nīvu', 'you', 3),
        (verse_id_var, 4, 'దేవుని', 'dēvuni', 'of God', 4),
        (verse_id_var, 5, 'కుమారుడవు,', 'kumāruḍavu,', 'are the Son,', 5),
        (verse_id_var, 6, 'నీవు', 'nīvu', 'You', 3),
        (verse_id_var, 7, 'ఇశ్రాయేలు', 'iśrāyēlu', 'of Israel', 6),
        (verse_id_var, 8, 'రాజవు', 'rājavu', 'are King', 7),
        (verse_id_var, 9, 'అని', 'ani', 'saying', 8),
        (verse_id_var, 10, 'ఆయనకు', 'āyanaku', 'to him', 9),
        (verse_id_var, 11, 'ఉత్తరమిచ్చెను.', 'uttaramiccenu.', 'answered.', 10);

    -- VERSE 50
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 50,
        'అందుకు యేసు—అంజూరపుచెట్టు క్రింద నిన్ను చూచితినని నేను చెప్పినందున నీవు నమ్ముచున్నావా? వీటికంటె గొప్ప కార్యములు చూచెదవని అతనితో చెప్పెను.',
        'Jesus answered him, "Because I told you, ''I saw you underneath the fig tree,'' do you believe? You will see greater things than these!"',
        'anduku yēsu—añjūrapuceṭṭu krinda ninnu cūcitinani nēnu ceppinanduna nīvu nammucunnāvā? vīṭikaṇṭe goppa kāryamulu cūcedavani atanitō ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అందుకు', 'anduku', 'answered', 1),
        (verse_id_var, 2, 'యేసు—', 'yēsu—', 'Jesus—', 2),
        (verse_id_var, 3, 'అంజూరపుచెట్టు', 'añjūrapuceṭṭu', 'the fig tree', 3),
        (verse_id_var, 4, 'క్రింద', 'krinda', 'underneath', 4),
        (verse_id_var, 5, 'నిన్ను', 'ninnu', 'you', 5),
        (verse_id_var, 6, 'చూచితినని', 'cūcitinani', 'I saw', 6),
        (verse_id_var, 7, 'నేను', 'nēnu', 'I', 7),
        (verse_id_var, 8, 'చెప్పినందున', 'ceppinanduna', 'told', 8),
        (verse_id_var, 9, 'నీవు', 'nīvu', 'you', 5),
        (verse_id_var, 10, 'నమ్ముచున్నావా?', 'nammucunnāvā?', 'do believe?', 9),
        (verse_id_var, 11, 'వీటికంటె', 'vīṭikaṇṭe', 'than these', 10),
        (verse_id_var, 12, 'గొప్ప', 'goppa', 'greater', 11),
        (verse_id_var, 13, 'కార్యములు', 'kāryamulu', 'things', 12),
        (verse_id_var, 14, 'చూచెదవని', 'cūcedavani', 'You will see', 13),
        (verse_id_var, 15, 'అతనితో', 'atanitō', 'to him', 14),
        (verse_id_var, 16, 'చెప్పెను.', 'ceppenu.', 'said.', 1);

    -- VERSE 51
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 51,
        'మరియు ఆయన—ఆకాశము తెరవబడుటయు, దేవుని దూతలు మనుష్యకుమారునిమీదుగా ఎక్కుచు దిగుచునుండుటయు మీరు చూతురని మీతో నిశ్చయముగా చెప్పుచున్నానని అతనితో చెప్పెను.',
        'He said to him, "Most certainly, I tell you, hereafter you will see heaven opened, and the angels of God ascending and descending on the Son of Man."',
        'mariyu āyana—ākāśamu teravabaḍuṭayu, dēvuni dūtalu manuṣyakumārunimīdugā ekkucu digucunuṇḍuṭayu mīru cūturani mītō niścayamugā ceppucunnānani atanitō ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మరియు', 'mariyu', 'And', 1),
        (verse_id_var, 2, 'ఆయన—', 'āyana—', 'He—', 2),
        (verse_id_var, 3, 'ఆకాశము', 'ākāśamu', 'heaven', 3),
        (verse_id_var, 4, 'తెరవబడుటయు,', 'teravabaḍuṭayu,', 'opened,', 4),
        (verse_id_var, 5, 'దేవుని', 'dēvuni', 'of God', 5),
        (verse_id_var, 6, 'దూతలు', 'dūtalu', 'the angels', 6),
        (verse_id_var, 7, 'మనుష్యకుమారునిమీదుగా', 'manuṣyakumārunimīdugā', 'on the Son of Man', 7),
        (verse_id_var, 8, 'ఎక్కుచు', 'ekkucu', 'ascending', 8),
        (verse_id_var, 9, 'దిగుచునుండుటయు', 'digucunuṇḍuṭayu', 'and descending', 9),
        (verse_id_var, 10, 'మీరు', 'mīru', 'you', 10),
        (verse_id_var, 11, 'చూతురని', 'cūturani', 'will see', 11),
        (verse_id_var, 12, 'మీతో', 'mītō', 'to you', 10),
        (verse_id_var, 13, 'నిశ్చయముగా', 'niścayamugā', 'Most certainly', 12),
        (verse_id_var, 14, 'చెప్పుచున్నానని', 'ceppucunnānani', 'I tell', 13),
        (verse_id_var, 15, 'అతనితో', 'atanitō', 'to him', 14),
        (verse_id_var, 16, 'చెప్పెను.', 'ceppenu.', 'said.', 15);
END $$;