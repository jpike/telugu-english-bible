/*
  # Seed the complete book of Philemon (all 25 verses)

  1. Content additions
    - Creates the chapters row for Philemon 1 if missing.
    - Adds Philemon 1:1 through 1:25 (25 verses), making Philemon the second fully-complete book in the library (after Jude).
    - Each verse upserts BSI-style Telugu, WEB English, and ISO-15919 transliteration.
    - Each verse seeds aligned `verse_tokens` with per-verse alignment groups.

  2. Strategy
    - Idempotent: chapter row, verses, and tokens are upserted/recreated safely.
    - No schema changes; data only.

  3. Notes
    - Curated character alignments are not seeded; the runtime AksharaSegmenter handles per-character coloring.
*/

DO $$
DECLARE
    chapter_id_var bigint;
    verse_id_var bigint;
BEGIN
    INSERT INTO chapters (book_id, chapter_number)
    VALUES (57, 1)
    ON CONFLICT (book_id, chapter_number) DO UPDATE SET chapter_number = EXCLUDED.chapter_number
    RETURNING id INTO chapter_id_var;

    -- VERSE 1
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 1,
        'క్రీస్తుయేసు ఖైదీయైన పౌలును, సహోదరుడైన తిమోతియు మన ప్రియుడును జతపనివాడునైన ఫిలేమోనుకును,',
        'Paul, a prisoner of Christ Jesus, and Timothy our brother, to Philemon, our beloved fellow worker,',
        'krīstuyēsu khaidīyaina paulunu, sahōdaruḍaina timōtiyu mana priyuḍunu jatapanivāḍunaina philēmōnukunu,')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'క్రీస్తుయేసు', 'krīstuyēsu', 'of Christ Jesus', 1),
        (verse_id_var, 2, 'ఖైదీయైన', 'khaidīyaina', 'a prisoner', 2),
        (verse_id_var, 3, 'పౌలును,', 'paulunu,', 'Paul,', 3),
        (verse_id_var, 4, 'సహోదరుడైన', 'sahōdaruḍaina', 'our brother', 4),
        (verse_id_var, 5, 'తిమోతియు', 'timōtiyu', 'and Timothy', 5),
        (verse_id_var, 6, 'మన', 'mana', 'our', 6),
        (verse_id_var, 7, 'ప్రియుడును', 'priyuḍunu', 'beloved', 7),
        (verse_id_var, 8, 'జతపనివాడునైన', 'jatapanivāḍunaina', 'fellow worker', 8),
        (verse_id_var, 9, 'ఫిలేమోనుకును,', 'philēmōnukunu,', 'to Philemon,', 9);

    -- VERSE 2
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 2,
        'మన సహోదరియైన అప్ఫియకును, తోడి యోధుడైన అర్ఖిప్పునకును, నీ యింట ఉన్న సంఘమునకును శుభమని వ్రాయుచున్నాము.',
        'to the beloved Apphia, to Archippus, our fellow soldier, and to the assembly in your house:',
        'mana sahōdariyaina apphiyakunu, tōḍi yōdhuḍaina arkhippunakunu, nī yiṇṭa unna saṅghamunakunu śubhamani vrāyucunnāmu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మన', 'mana', 'our', 1),
        (verse_id_var, 2, 'సహోదరియైన', 'sahōdariyaina', 'beloved', 2),
        (verse_id_var, 3, 'అప్ఫియకును,', 'apphiyakunu,', 'to Apphia,', 3),
        (verse_id_var, 4, 'తోడి', 'tōḍi', 'fellow', 4),
        (verse_id_var, 5, 'యోధుడైన', 'yōdhuḍaina', 'soldier', 5),
        (verse_id_var, 6, 'అర్ఖిప్పునకును,', 'arkhippunakunu,', 'to Archippus,', 6),
        (verse_id_var, 7, 'నీ', 'nī', 'your', 7),
        (verse_id_var, 8, 'యింట', 'yiṇṭa', 'in house', 8),
        (verse_id_var, 9, 'ఉన్న', 'unna', 'is', 9),
        (verse_id_var, 10, 'సంఘమునకును', 'saṅghamunakunu', 'and to the assembly', 10),
        (verse_id_var, 11, 'శుభమని', 'śubhamani', 'greetings', 11),
        (verse_id_var, 12, 'వ్రాయుచున్నాము.', 'vrāyucunnāmu.', 'we write.', 12);

    -- VERSE 3
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 3,
        'మన తండ్రియైన దేవునినుండియు ప్రభువైన యేసుక్రీస్తునుండియు కృపయు సమాధానమును మీకు కలుగును గాక.',
        'Grace to you and peace from God our Father and the Lord Jesus Christ.',
        'mana taṇḍriyaina dēvuninuṇḍiyu prabhuvaina yēsukrīstunuṇḍiyu kr̥payu samādhānamunu mīku kalugunu gāka.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మన', 'mana', 'our', 1),
        (verse_id_var, 2, 'తండ్రియైన', 'taṇḍriyaina', 'Father', 2),
        (verse_id_var, 3, 'దేవునినుండియు', 'dēvuninuṇḍiyu', 'from God', 3),
        (verse_id_var, 4, 'ప్రభువైన', 'prabhuvaina', 'the Lord', 4),
        (verse_id_var, 5, 'యేసుక్రీస్తునుండియు', 'yēsukrīstunuṇḍiyu', 'and from Jesus Christ', 5),
        (verse_id_var, 6, 'కృపయు', 'kr̥payu', 'Grace', 6),
        (verse_id_var, 7, 'సమాధానమును', 'samādhānamunu', 'and peace', 7),
        (verse_id_var, 8, 'మీకు', 'mīku', 'to you', 8),
        (verse_id_var, 9, 'కలుగును', 'kalugunu', 'be', 9),
        (verse_id_var, 10, 'గాక.', 'gāka.', '.', 10);

    -- VERSE 4
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 4,
        'నా ప్రార్థనలయందు నీ పేరు ఎత్తుచు, నా దేవునికి ఎల్లప్పుడును కృతజ్ఞతాస్తుతులు చెల్లించుచున్నాను.',
        'I thank my God always, making mention of you in my prayers,',
        'nā prārthanalayandu nī pēru ettucu, nā dēvuniki ellappuḍunu kr̥tajñatāstutulu cellistucunnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నా', 'nā', 'my', 1),
        (verse_id_var, 2, 'ప్రార్థనలయందు', 'prārthanalayandu', 'in prayers', 2),
        (verse_id_var, 3, 'నీ', 'nī', 'you', 3),
        (verse_id_var, 4, 'పేరు', 'pēru', 'mention', 4),
        (verse_id_var, 5, 'ఎత్తుచు,', 'ettucu,', 'making,', 5),
        (verse_id_var, 6, 'నా', 'nā', 'my', 1),
        (verse_id_var, 7, 'దేవునికి', 'dēvuniki', 'God', 6),
        (verse_id_var, 8, 'ఎల్లప్పుడును', 'ellappuḍunu', 'always', 7),
        (verse_id_var, 9, 'కృతజ్ఞతాస్తుతులు', 'kr̥tajñatāstutulu', 'thanks', 8),
        (verse_id_var, 10, 'చెల్లించుచున్నాను.', 'cellistucunnānu.', 'I give.', 9);

    -- VERSE 5
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 5,
        'ప్రభువైన యేసుయందును పరిశుద్ధులందరియందును నీకు కలిగియున్న ప్రేమను విశ్వాసమును గూర్చి విని కృతజ్ఞతలు చెల్లించుచున్నాను;',
        'hearing of your love, and of the faith which you have toward the Lord Jesus, and toward all the saints;',
        'prabhuvaina yēsuyandunu pariśuddhulandariyandunu nīku kaligiyunna prēmanu viśvāsamunu gūrci vinī kr̥tajñatalu cellistucunnānu;')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ప్రభువైన', 'prabhuvaina', 'the Lord', 1),
        (verse_id_var, 2, 'యేసుయందును', 'yēsuyandunu', 'toward Jesus', 2),
        (verse_id_var, 3, 'పరిశుద్ధులందరియందును', 'pariśuddhulandariyandunu', 'toward all the saints', 3),
        (verse_id_var, 4, 'నీకు', 'nīku', 'you have', 4),
        (verse_id_var, 5, 'కలిగియున్న', 'kaligiyunna', 'which', 5),
        (verse_id_var, 6, 'ప్రేమను', 'prēmanu', 'love', 6),
        (verse_id_var, 7, 'విశ్వాసమును', 'viśvāsamunu', 'and faith', 7),
        (verse_id_var, 8, 'గూర్చి', 'gūrci', 'of', 8),
        (verse_id_var, 9, 'విని', 'vinī', 'hearing', 9),
        (verse_id_var, 10, 'కృతజ్ఞతలు', 'kr̥tajñatalu', 'thanks', 10),
        (verse_id_var, 11, 'చెల్లించుచున్నాను;', 'cellistucunnānu;', 'I give;', 11);

    -- VERSE 6
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 6,
        'క్రీస్తునందు మనకు కలుగు ప్రతి శ్రేష్ఠమైన వరమునుగూర్చిన అనుభవపూర్వకమైన జ్ఞానమువలన నీ విశ్వాస భాగస్వామ్యము సఫలమగును గాక.',
        'that the fellowship of your faith may become effective, in the knowledge of every good thing which is in us in Christ Jesus.',
        'krīstunandu manaku kalugu prati śrēṣṭhamaina varamunugūrcina anubhavapūrvakamaina jñānamuvalana nī viśvāsa bhāgasvāmyamu saphalamagunu gāka.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'క్రీస్తునందు', 'krīstunandu', 'in Christ', 1),
        (verse_id_var, 2, 'మనకు', 'manaku', 'in us', 2),
        (verse_id_var, 3, 'కలుగు', 'kalugu', 'which is', 3),
        (verse_id_var, 4, 'ప్రతి', 'prati', 'every', 4),
        (verse_id_var, 5, 'శ్రేష్ఠమైన', 'śrēṣṭhamaina', 'good', 5),
        (verse_id_var, 6, 'వరమునుగూర్చిన', 'varamunugūrcina', 'thing', 6),
        (verse_id_var, 7, 'అనుభవపూర్వకమైన', 'anubhavapūrvakamaina', 'experiential', 7),
        (verse_id_var, 8, 'జ్ఞానమువలన', 'jñānamuvalana', 'in the knowledge', 8),
        (verse_id_var, 9, 'నీ', 'nī', 'your', 9),
        (verse_id_var, 10, 'విశ్వాస', 'viśvāsa', 'of faith', 10),
        (verse_id_var, 11, 'భాగస్వామ్యము', 'bhāgasvāmyamu', 'fellowship', 11),
        (verse_id_var, 12, 'సఫలమగును', 'saphalamagunu', 'may become effective', 12),
        (verse_id_var, 13, 'గాక.', 'gāka.', '.', 13);

    -- VERSE 7
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 7,
        'సహోదరుడా, పరిశుద్ధుల హృదయములు నీవలన విశ్రాంతి పొందినందున, నీ ప్రేమనుబట్టి నాకు విశేషమైన ఆనందమును ఆదరణయు కలిగెను.',
        'For we have much joy and comfort in your love, because the hearts of the saints have been refreshed through you, brother.',
        'sahōdaruḍā, pariśuddhula hr̥dayamulu nīvalana viśrānti pondinanduna, nī prēmanubaṭṭi nāku viśēṣamaina ānandamunu ādaraṇayu kaligenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'సహోదరుడా,', 'sahōdaruḍā,', 'brother,', 1),
        (verse_id_var, 2, 'పరిశుద్ధుల', 'pariśuddhula', 'of the saints', 2),
        (verse_id_var, 3, 'హృదయములు', 'hr̥dayamulu', 'the hearts', 3),
        (verse_id_var, 4, 'నీవలన', 'nīvalana', 'through you', 4),
        (verse_id_var, 5, 'విశ్రాంతి', 'viśrānti', 'refreshed', 5),
        (verse_id_var, 6, 'పొందినందున,', 'pondinanduna,', 'have been,', 6),
        (verse_id_var, 7, 'నీ', 'nī', 'your', 7),
        (verse_id_var, 8, 'ప్రేమనుబట్టి', 'prēmanubaṭṭi', 'in love', 8),
        (verse_id_var, 9, 'నాకు', 'nāku', 'we have', 9),
        (verse_id_var, 10, 'విశేషమైన', 'viśēṣamaina', 'much', 10),
        (verse_id_var, 11, 'ఆనందమును', 'ānandamunu', 'joy', 11),
        (verse_id_var, 12, 'ఆదరణయు', 'ādaraṇayu', 'and comfort', 12),
        (verse_id_var, 13, 'కలిగెను.', 'kaligenu.', 'are.', 13);

    -- VERSE 8
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 8,
        'కావున యుక్తమైనదానిని ఆజ్ఞాపించుటకు క్రీస్తునందు నాకు బహు ధైర్యము కలిగియున్నను,',
        'Therefore though I have all boldness in Christ to command you that which is appropriate,',
        'kāvuna yuktamainadānini ājñāpiñcuṭaku krīstunandu nāku bahu dhairyamu kaligiyunnanu,')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కావున', 'kāvuna', 'Therefore', 1),
        (verse_id_var, 2, 'యుక్తమైనదానిని', 'yuktamainadānini', 'that which is appropriate', 2),
        (verse_id_var, 3, 'ఆజ్ఞాపించుటకు', 'ājñāpiñcuṭaku', 'to command', 3),
        (verse_id_var, 4, 'క్రీస్తునందు', 'krīstunandu', 'in Christ', 4),
        (verse_id_var, 5, 'నాకు', 'nāku', 'I have', 5),
        (verse_id_var, 6, 'బహు', 'bahu', 'all', 6),
        (verse_id_var, 7, 'ధైర్యము', 'dhairyamu', 'boldness', 7),
        (verse_id_var, 8, 'కలిగియున్నను,', 'kaligiyunnanu,', 'though,', 8);

    -- VERSE 9
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 9,
        'వృద్ధుడనైన పౌలు అను నేను, ఇప్పుడు క్రీస్తుయేసు ఖైదీయై యుండి, ప్రేమనుబట్టి బ్రతిమాలుట మేలని యెంచుచున్నాను.',
        'yet for love''s sake I rather beg, being such a one as Paul, the aged, but also a prisoner of Jesus Christ.',
        'vr̥ddhuḍanaina paulu anu nēnu, ippuḍu krīstuyēsu khaidīyai yuṇḍi, prēmanubaṭṭi bratimāluṭa mēlani yeñcucunnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'వృద్ధుడనైన', 'vr̥ddhuḍanaina', 'the aged', 1),
        (verse_id_var, 2, 'పౌలు', 'paulu', 'Paul', 2),
        (verse_id_var, 3, 'అను', 'anu', 'as', 3),
        (verse_id_var, 4, 'నేను,', 'nēnu,', 'I,', 4),
        (verse_id_var, 5, 'ఇప్పుడు', 'ippuḍu', 'also', 5),
        (verse_id_var, 6, 'క్రీస్తుయేసు', 'krīstuyēsu', 'of Jesus Christ', 6),
        (verse_id_var, 7, 'ఖైదీయై', 'khaidīyai', 'a prisoner', 7),
        (verse_id_var, 8, 'యుండి,', 'yuṇḍi,', 'being,', 8),
        (verse_id_var, 9, 'ప్రేమనుబట్టి', 'prēmanubaṭṭi', 'for love''s sake', 9),
        (verse_id_var, 10, 'బ్రతిమాలుట', 'bratimāluṭa', 'beg', 10),
        (verse_id_var, 11, 'మేలని', 'mēlani', 'rather', 11),
        (verse_id_var, 12, 'యెంచుచున్నాను.', 'yeñcucunnānu.', 'I think.', 12);

    -- VERSE 10
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 10,
        'నా బంధకములలో నేను కనిన నా కుమారుడైన ఒనేసిమునుగూర్చి నిన్ను బ్రతిమాలుచున్నాను.',
        'I beg you for my child, whom I have become the father of in my chains, Onesimus,',
        'nā bandhakamulalō nēnu kanina nā kumāruḍaina onēsimunugūrci ninnu bratimālucunnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నా', 'nā', 'my', 1),
        (verse_id_var, 2, 'బంధకములలో', 'bandhakamulalō', 'in chains', 2),
        (verse_id_var, 3, 'నేను', 'nēnu', 'I', 3),
        (verse_id_var, 4, 'కనిన', 'kanina', 'have become father of', 4),
        (verse_id_var, 5, 'నా', 'nā', 'my', 1),
        (verse_id_var, 6, 'కుమారుడైన', 'kumāruḍaina', 'child', 5),
        (verse_id_var, 7, 'ఒనేసిమునుగూర్చి', 'onēsimunugūrci', 'Onesimus', 6),
        (verse_id_var, 8, 'నిన్ను', 'ninnu', 'you', 7),
        (verse_id_var, 9, 'బ్రతిమాలుచున్నాను.', 'bratimālucunnānu.', 'I beg.', 8);

    -- VERSE 11
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 11,
        'అతడు మునుపు నీకు నిష్ప్రయోజనమైనవాడే గాని, యిప్పుడు నీకును నాకును ప్రయోజనకరమైనవాడాయెను.',
        'who once was useless to you, but now is useful to you and to me.',
        'ataḍu munupu nīku niṣprayōjanamainavāḍē gāni, yippuḍu nīkunu nākunu prayōjanakaramainavāḍāyenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అతడు', 'ataḍu', 'who', 1),
        (verse_id_var, 2, 'మునుపు', 'munupu', 'once', 2),
        (verse_id_var, 3, 'నీకు', 'nīku', 'to you', 3),
        (verse_id_var, 4, 'నిష్ప్రయోజనమైనవాడే', 'niṣprayōjanamainavāḍē', 'was useless', 4),
        (verse_id_var, 5, 'గాని,', 'gāni,', 'but,', 5),
        (verse_id_var, 6, 'యిప్పుడు', 'yippuḍu', 'now', 6),
        (verse_id_var, 7, 'నీకును', 'nīkunu', 'to you', 3),
        (verse_id_var, 8, 'నాకును', 'nākunu', 'and to me', 7),
        (verse_id_var, 9, 'ప్రయోజనకరమైనవాడాయెను.', 'prayōjanakaramainavāḍāyenu.', 'is useful.', 8);

    -- VERSE 12
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 12,
        'అతనిని, అనగా నా ప్రాణముతో సమానమైనవానిని, నీయొద్దకు తిరిగి పంపియున్నాను;',
        'I am sending him back. Therefore receive him, that is, my own heart,',
        'atanini, anagā nā prāṇamutō samānamainavānini, nīyoddaku tirigi pampiyunnānu;')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అతనిని,', 'atanini,', 'him,', 1),
        (verse_id_var, 2, 'అనగా', 'anagā', 'that is', 2),
        (verse_id_var, 3, 'నా', 'nā', 'my own', 3),
        (verse_id_var, 4, 'ప్రాణముతో', 'prāṇamutō', 'with heart', 4),
        (verse_id_var, 5, 'సమానమైనవానిని,', 'samānamainavānini,', 'equal,', 5),
        (verse_id_var, 6, 'నీయొద్దకు', 'nīyoddaku', 'to you', 6),
        (verse_id_var, 7, 'తిరిగి', 'tirigi', 'back', 7),
        (verse_id_var, 8, 'పంపియున్నాను;', 'pampiyunnānu;', 'I am sending;', 8);

    -- VERSE 13
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 13,
        'సువార్తనుబట్టి నాకుగల బంధకములలో నీకు ప్రతిగా అతడు నాకు పరిచారము చేయునట్లు, అతనిని నాయొద్దనే ఉంచుకొనవలెనని యుండెను.',
        'whom I desired to keep with me, that on your behalf he might serve me in my chains for the Good News.',
        'suvārtanubaṭṭi nākugala bandhakamulalō nīku pratigā ataḍu nāku paricāramu cēyunaṭlu, atanini nāyoddanē uñcukonavalenani yuṇḍenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'సువార్తనుబట్టి', 'suvārtanubaṭṭi', 'for the Good News', 1),
        (verse_id_var, 2, 'నాకుగల', 'nākugala', 'my', 2),
        (verse_id_var, 3, 'బంధకములలో', 'bandhakamulalō', 'in chains', 3),
        (verse_id_var, 4, 'నీకు', 'nīku', 'on your behalf', 4),
        (verse_id_var, 5, 'ప్రతిగా', 'pratigā', 'instead', 5),
        (verse_id_var, 6, 'అతడు', 'ataḍu', 'he', 6),
        (verse_id_var, 7, 'నాకు', 'nāku', 'me', 7),
        (verse_id_var, 8, 'పరిచారము', 'paricāramu', 'might serve', 8),
        (verse_id_var, 9, 'చేయునట్లు,', 'cēyunaṭlu,', 'that,', 9),
        (verse_id_var, 10, 'అతనిని', 'atanini', 'whom', 10),
        (verse_id_var, 11, 'నాయొద్దనే', 'nāyoddanē', 'with me', 7),
        (verse_id_var, 12, 'ఉంచుకొనవలెనని', 'uñcukonavalenani', 'to keep', 11),
        (verse_id_var, 13, 'యుండెను.', 'yuṇḍenu.', 'I desired.', 12);

    -- VERSE 14
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 14,
        'అయితే నీ ఉపకారము బలవంతముచేతనైనట్టుగా కాక స్వేచ్ఛాపూర్వకముగా ఉండవలెనని, నీ సమ్మతిలేక యేమియు చేయుటకు నాకు మనస్సు లేకపోయెను.',
        'But I was willing to do nothing without your consent, that your goodness would not be as of necessity, but of free will.',
        'ayitē nī upakāramu balavantamucētanainaṭṭugā kāka svēcchāpūrvakamugā uṇḍavalenani, nī sammatilēka yēmiyu cēyuṭaku nāku manassu lēkapōyenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అయితే', 'ayitē', 'But', 1),
        (verse_id_var, 2, 'నీ', 'nī', 'your', 2),
        (verse_id_var, 3, 'ఉపకారము', 'upakāramu', 'goodness', 3),
        (verse_id_var, 4, 'బలవంతముచేతనైనట్టుగా', 'balavantamucētanainaṭṭugā', 'as of necessity', 4),
        (verse_id_var, 5, 'కాక', 'kāka', 'not', 5),
        (verse_id_var, 6, 'స్వేచ్ఛాపూర్వకముగా', 'svēcchāpūrvakamugā', 'of free will', 6),
        (verse_id_var, 7, 'ఉండవలెనని,', 'uṇḍavalenani,', 'would be,', 7),
        (verse_id_var, 8, 'నీ', 'nī', 'your', 2),
        (verse_id_var, 9, 'సమ్మతిలేక', 'sammatilēka', 'without consent', 8),
        (verse_id_var, 10, 'యేమియు', 'yēmiyu', 'nothing', 9),
        (verse_id_var, 11, 'చేయుటకు', 'cēyuṭaku', 'to do', 10),
        (verse_id_var, 12, 'నాకు', 'nāku', 'I', 11),
        (verse_id_var, 13, 'మనస్సు', 'manassu', 'willing', 12),
        (verse_id_var, 14, 'లేకపోయెను.', 'lēkapōyenu.', 'was.', 13);

    -- VERSE 15
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 15,
        'ఎందుకనగా నీవు అతని శాశ్వతముగా అట్టి పెట్టుకొనుటకే అతడు కొంతకాలము నీయొద్దనుండి యెడబాసి యుండెనేమో;',
        'For perhaps he was therefore separated from you for a while, that you would have him forever,',
        'endukanagā nīvu atani śāśvatamugā aṭṭi peṭṭukonuṭakē ataḍu kontakālamu nīyoddanuṇḍi yeḍabāsi yuṇḍenēmō;')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఎందుకనగా', 'endukanagā', 'For perhaps', 1),
        (verse_id_var, 2, 'నీవు', 'nīvu', 'you', 2),
        (verse_id_var, 3, 'అతని', 'atani', 'him', 3),
        (verse_id_var, 4, 'శాశ్వతముగా', 'śāśvatamugā', 'forever', 4),
        (verse_id_var, 5, 'అట్టి', 'aṭṭi', 'such', 5),
        (verse_id_var, 6, 'పెట్టుకొనుటకే', 'peṭṭukonuṭakē', 'would have', 6),
        (verse_id_var, 7, 'అతడు', 'ataḍu', 'he', 3),
        (verse_id_var, 8, 'కొంతకాలము', 'kontakālamu', 'for a while', 7),
        (verse_id_var, 9, 'నీయొద్దనుండి', 'nīyoddanuṇḍi', 'from you', 8),
        (verse_id_var, 10, 'యెడబాసి', 'yeḍabāsi', 'separated', 9),
        (verse_id_var, 11, 'యుండెనేమో;', 'yuṇḍenēmō;', 'was therefore;', 10);

    -- VERSE 16
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 16,
        'ఇకమీదట దాసుడుగా కాక దాసునికంటె ఎక్కువవానిగాను, ప్రియ సహోదరునిగాను నీయొద్దనుండునట్లు అతడు ఎడబాసెనేమో. అతడు నాకు ప్రియ సహోదరుడు; అతడు శరీరవిషయములోను ప్రభువు విషయములోను నీకు మరి విశేషముగా ప్రియ సహోదరుడు కాడా?',
        'no longer as a slave, but more than a slave, a beloved brother—especially to me, but how much rather to you, both in the flesh and in the Lord.',
        'ikamīdaṭa dāsuḍugā kāka dāsunikaṇṭe ekkuvavānigānu, priya sahōdarunigānu nīyoddanuṇḍunaṭlu ataḍu eḍabāsenēmō. ataḍu nāku priya sahōdaruḍu; ataḍu śarīraviṣayamulōnu prabhuvu viṣayamulōnu nīku mari viśēṣamugā priya sahōdaruḍu kāḍā?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఇకమీదట', 'ikamīdaṭa', 'no longer', 1),
        (verse_id_var, 2, 'దాసుడుగా', 'dāsuḍugā', 'as a slave', 2),
        (verse_id_var, 3, 'కాక', 'kāka', 'but', 3),
        (verse_id_var, 4, 'దాసునికంటె', 'dāsunikaṇṭe', 'than a slave', 2),
        (verse_id_var, 5, 'ఎక్కువవానిగాను,', 'ekkuvavānigānu,', 'more,', 4),
        (verse_id_var, 6, 'ప్రియ', 'priya', 'a beloved', 5),
        (verse_id_var, 7, 'సహోదరునిగాను', 'sahōdarunigānu', 'brother', 6),
        (verse_id_var, 8, 'నీయొద్దనుండునట్లు', 'nīyoddanuṇḍunaṭlu', 'with you', 7),
        (verse_id_var, 9, 'అతడు', 'ataḍu', 'he', 8),
        (verse_id_var, 10, 'ఎడబాసెనేమో.', 'eḍabāsenēmō.', 'was separated.', 9),
        (verse_id_var, 11, 'అతడు', 'ataḍu', 'he', 8),
        (verse_id_var, 12, 'నాకు', 'nāku', 'to me', 10),
        (verse_id_var, 13, 'ప్రియ', 'priya', 'beloved', 5),
        (verse_id_var, 14, 'సహోదరుడు;', 'sahōdaruḍu;', 'brother;', 6),
        (verse_id_var, 15, 'అతడు', 'ataḍu', 'he', 8),
        (verse_id_var, 16, 'శరీరవిషయములోను', 'śarīraviṣayamulōnu', 'in the flesh', 11),
        (verse_id_var, 17, 'ప్రభువు', 'prabhuvu', 'in the Lord', 12),
        (verse_id_var, 18, 'విషయములోను', 'viṣayamulōnu', 'and', 13),
        (verse_id_var, 19, 'నీకు', 'nīku', 'to you', 14),
        (verse_id_var, 20, 'మరి', 'mari', 'how much', 15),
        (verse_id_var, 21, 'విశేషముగా', 'viśēṣamugā', 'rather', 16),
        (verse_id_var, 22, 'ప్రియ', 'priya', 'beloved', 5),
        (verse_id_var, 23, 'సహోదరుడు', 'sahōdaruḍu', 'brother', 6),
        (verse_id_var, 24, 'కాడా?', 'kāḍā?', 'is he not?', 17);

    -- VERSE 17
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 17,
        'కావున నీవు నన్ను నీ జతదారుడని యెంచితివా, నన్ను అంగీకరించునట్లుగానే అతనిని అంగీకరించుము.',
        'If then you count me a partner, receive him as you would receive me.',
        'kāvuna nīvu nannu nī jatadāruḍani yeñcitivā, nannu aṅgīkariñcunaṭlugānē atanini aṅgīkariñcumu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కావున', 'kāvuna', 'If then', 1),
        (verse_id_var, 2, 'నీవు', 'nīvu', 'you', 2),
        (verse_id_var, 3, 'నన్ను', 'nannu', 'me', 3),
        (verse_id_var, 4, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 5, 'జతదారుడని', 'jatadāruḍani', 'a partner', 5),
        (verse_id_var, 6, 'యెంచితివా,', 'yeñcitivā,', 'count,', 6),
        (verse_id_var, 7, 'నన్ను', 'nannu', 'me', 3),
        (verse_id_var, 8, 'అంగీకరించునట్లుగానే', 'aṅgīkariñcunaṭlugānē', 'as you would receive', 7),
        (verse_id_var, 9, 'అతనిని', 'atanini', 'him', 8),
        (verse_id_var, 10, 'అంగీకరించుము.', 'aṅgīkariñcumu.', 'receive.', 9);

    -- VERSE 18
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 18,
        'అతడు నీకు ఏమైన నష్టము కలుగజేసిన యెడలను, నీకు ఏమైన ఋణమున్న యెడలను, అది నా లెక్కలో నున్నట్టుగా ఎంచుకొనుము.',
        'But if he has wronged you at all, or owes you anything, put that to my account.',
        'ataḍu nīku ēmaina naṣṭamu kalugajēsina yeḍalanu, nīku ēmaina r̥ṇamunna yeḍalanu, adi nā lekkalō nunnaṭṭugā eñcukonumu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అతడు', 'ataḍu', 'he', 1),
        (verse_id_var, 2, 'నీకు', 'nīku', 'you', 2),
        (verse_id_var, 3, 'ఏమైన', 'ēmaina', 'at all', 3),
        (verse_id_var, 4, 'నష్టము', 'naṣṭamu', 'wrong', 4),
        (verse_id_var, 5, 'కలుగజేసిన', 'kalugajēsina', 'has done', 5),
        (verse_id_var, 6, 'యెడలను,', 'yeḍalanu,', 'But if,', 6),
        (verse_id_var, 7, 'నీకు', 'nīku', 'you', 2),
        (verse_id_var, 8, 'ఏమైన', 'ēmaina', 'anything', 7),
        (verse_id_var, 9, 'ఋణమున్న', 'r̥ṇamunna', 'owes', 8),
        (verse_id_var, 10, 'యెడలను,', 'yeḍalanu,', 'or,', 9),
        (verse_id_var, 11, 'అది', 'adi', 'that', 10),
        (verse_id_var, 12, 'నా', 'nā', 'my', 11),
        (verse_id_var, 13, 'లెక్కలో', 'lekkalō', 'to account', 12),
        (verse_id_var, 14, 'నున్నట్టుగా', 'nunnaṭṭugā', 'put', 13),
        (verse_id_var, 15, 'ఎంచుకొనుము.', 'eñcukonumu.', 'reckon.', 14);

    -- VERSE 19
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 19,
        'పౌలను నేను నా స్వహస్తముతో వ్రాయుచున్నాను, నేనే దాని తీర్చెదను—నీ స్వంత ప్రాణముకూడ నాకు ఋణపడియున్నావని నేను చెప్పనేల?',
        'I, Paul, write this with my own hand: I will repay it (not to mention to you that you owe to me even your own self besides).',
        'paulanu nēnu nā svahastamutō vrāyucunnānu, nēnē dāni tīrcedanu—nī svanta prāṇamukūḍa nāku r̥ṇapaḍiyunnāvani nēnu ceppanēla?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'పౌలను', 'paulanu', 'Paul', 1),
        (verse_id_var, 2, 'నేను', 'nēnu', 'I', 2),
        (verse_id_var, 3, 'నా', 'nā', 'my own', 3),
        (verse_id_var, 4, 'స్వహస్తముతో', 'svahastamutō', 'with hand', 4),
        (verse_id_var, 5, 'వ్రాయుచున్నాను,', 'vrāyucunnānu,', 'write this,', 5),
        (verse_id_var, 6, 'నేనే', 'nēnē', 'I will', 2),
        (verse_id_var, 7, 'దాని', 'dāni', 'it', 6),
        (verse_id_var, 8, 'తీర్చెదను—', 'tīrcedanu—', 'repay—', 7),
        (verse_id_var, 9, 'నీ', 'nī', 'your own', 8),
        (verse_id_var, 10, 'స్వంత', 'svanta', 'self', 9),
        (verse_id_var, 11, 'ప్రాణముకూడ', 'prāṇamukūḍa', 'even', 10),
        (verse_id_var, 12, 'నాకు', 'nāku', 'to me', 11),
        (verse_id_var, 13, 'ఋణపడియున్నావని', 'r̥ṇapaḍiyunnāvani', 'you owe', 12),
        (verse_id_var, 14, 'నేను', 'nēnu', 'I', 2),
        (verse_id_var, 15, 'చెప్పనేల?', 'ceppanēla?', 'not to mention?', 13);

    -- VERSE 20
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 20,
        'అవును సహోదరుడా, ప్రభువునందు నాకు నీవలన ఆనందము కలుగనిమ్ము; క్రీస్తునందు నా హృదయమునకు విశ్రాంతి కలుగజేయుము.',
        'Yes, brother, let me have joy from you in the Lord. Refresh my heart in the Lord.',
        'avunu sahōdaruḍā, prabhuvunandu nāku nīvalana ānandamu kaluganimmu; krīstunandu nā hr̥dayamunaku viśrānti kalugajēyumu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అవును', 'avunu', 'Yes', 1),
        (verse_id_var, 2, 'సహోదరుడా,', 'sahōdaruḍā,', 'brother,', 2),
        (verse_id_var, 3, 'ప్రభువునందు', 'prabhuvunandu', 'in the Lord', 3),
        (verse_id_var, 4, 'నాకు', 'nāku', 'me', 4),
        (verse_id_var, 5, 'నీవలన', 'nīvalana', 'from you', 5),
        (verse_id_var, 6, 'ఆనందము', 'ānandamu', 'joy', 6),
        (verse_id_var, 7, 'కలుగనిమ్ము;', 'kaluganimmu;', 'let have;', 7),
        (verse_id_var, 8, 'క్రీస్తునందు', 'krīstunandu', 'in the Lord', 3),
        (verse_id_var, 9, 'నా', 'nā', 'my', 8),
        (verse_id_var, 10, 'హృదయమునకు', 'hr̥dayamunaku', 'heart', 9),
        (verse_id_var, 11, 'విశ్రాంతి', 'viśrānti', 'Refresh', 10),
        (verse_id_var, 12, 'కలుగజేయుము.', 'kalugajēyumu.', '.', 11);

    -- VERSE 21
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 21,
        'నీ విధేయతనుగూర్చి నేను నమ్మికగా ఉండి, నేను చెప్పుదానికంటె ఎక్కువగా చేయుదువని యెరిగి నీకు వ్రాయుచున్నాను.',
        'Having confidence in your obedience, I write to you, knowing that you will do even beyond what I say.',
        'nī vidhēyatanugūrci nēnu nammikagā uṇḍi, nēnu ceppudānikaṇṭe ekkuvagā cēyuduvani yerigi nīku vrāyucunnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 2, 'విధేయతనుగూర్చి', 'vidhēyatanugūrci', 'in obedience', 2),
        (verse_id_var, 3, 'నేను', 'nēnu', 'I', 3),
        (verse_id_var, 4, 'నమ్మికగా', 'nammikagā', 'confidence', 4),
        (verse_id_var, 5, 'ఉండి,', 'uṇḍi,', 'Having,', 5),
        (verse_id_var, 6, 'నేను', 'nēnu', 'I', 3),
        (verse_id_var, 7, 'చెప్పుదానికంటె', 'ceppudānikaṇṭe', 'beyond what say', 6),
        (verse_id_var, 8, 'ఎక్కువగా', 'ekkuvagā', 'even', 7),
        (verse_id_var, 9, 'చేయుదువని', 'cēyuduvani', 'you will do', 8),
        (verse_id_var, 10, 'యెరిగి', 'yerigi', 'knowing', 9),
        (verse_id_var, 11, 'నీకు', 'nīku', 'to you', 10),
        (verse_id_var, 12, 'వ్రాయుచున్నాను.', 'vrāyucunnānu.', 'I write.', 11);

    -- VERSE 22
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 22,
        'మరియు మీ ప్రార్థనలవలన నేను మీ యొద్దకు అనుగ్రహింపబడెదనని నిరీక్షించుచున్నాను గనుక నాకు బసను ఏర్పాటు చేయుము.',
        'Also, prepare a guest room for me, for I hope that through your prayers I will be restored to you.',
        'mariyu mī prārthanalavalana nēnu mī yoddaku anugrahimpabaḍedanani nirīkṣiñcucunnānu ganuka nāku basanu ērpāṭu cēyumu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మరియు', 'mariyu', 'Also', 1),
        (verse_id_var, 2, 'మీ', 'mī', 'your', 2),
        (verse_id_var, 3, 'ప్రార్థనలవలన', 'prārthanalavalana', 'through prayers', 3),
        (verse_id_var, 4, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 5, 'మీ', 'mī', 'to you', 2),
        (verse_id_var, 6, 'యొద్దకు', 'yoddaku', 'restored', 5),
        (verse_id_var, 7, 'అనుగ్రహింపబడెదనని', 'anugrahimpabaḍedanani', 'will be', 6),
        (verse_id_var, 8, 'నిరీక్షించుచున్నాను', 'nirīkṣiñcucunnānu', 'I hope', 7),
        (verse_id_var, 9, 'గనుక', 'ganuka', 'for', 8),
        (verse_id_var, 10, 'నాకు', 'nāku', 'for me', 9),
        (verse_id_var, 11, 'బసను', 'basanu', 'a guest room', 10),
        (verse_id_var, 12, 'ఏర్పాటు', 'ērpāṭu', 'prepare', 11),
        (verse_id_var, 13, 'చేయుము.', 'cēyumu.', '.', 12);

    -- VERSE 23
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 23,
        'క్రీస్తుయేసునందు నా జతఖైదీయైన ఎపఫ్రాయును,',
        'Epaphras, my fellow prisoner in Christ Jesus, greets you,',
        'krīstuyēsunandu nā jatakhaidīyaina epaphrāyunu,')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'క్రీస్తుయేసునందు', 'krīstuyēsunandu', 'in Christ Jesus', 1),
        (verse_id_var, 2, 'నా', 'nā', 'my', 2),
        (verse_id_var, 3, 'జతఖైదీయైన', 'jatakhaidīyaina', 'fellow prisoner', 3),
        (verse_id_var, 4, 'ఎపఫ్రాయును,', 'epaphrāyunu,', 'Epaphras greets you,', 4);

    -- VERSE 24
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 24,
        'నా జతపనివారైన మార్కును, అరిస్తార్కును, దేమాయును, లూకాయును, నీకు వందనములు చెప్పుచున్నారు.',
        'as do Mark, Aristarchus, Demas, and Luke, my fellow workers.',
        'nā jatapanivāraina mārkunu, aristārkunu, dēmāyunu, lūkāyunu, nīku vandanamulu ceppucunnāru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నా', 'nā', 'my', 1),
        (verse_id_var, 2, 'జతపనివారైన', 'jatapanivāraina', 'fellow workers', 2),
        (verse_id_var, 3, 'మార్కును,', 'mārkunu,', 'Mark,', 3),
        (verse_id_var, 4, 'అరిస్తార్కును,', 'aristārkunu,', 'Aristarchus,', 4),
        (verse_id_var, 5, 'దేమాయును,', 'dēmāyunu,', 'Demas,', 5),
        (verse_id_var, 6, 'లూకాయును,', 'lūkāyunu,', 'and Luke,', 6),
        (verse_id_var, 7, 'నీకు', 'nīku', 'to you', 7),
        (verse_id_var, 8, 'వందనములు', 'vandanamulu', 'greetings', 8),
        (verse_id_var, 9, 'చెప్పుచున్నారు.', 'ceppucunnāru.', 'send.', 9);

    -- VERSE 25
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 25,
        'మన ప్రభువైన యేసుక్రీస్తు కృప మీ ఆత్మకు తోడై యుండును గాక. ఆమేన్‌.',
        'The grace of our Lord Jesus Christ be with your spirit. Amen.',
        'mana prabhuvaina yēsukrīstu kr̥pa mī ātmaku tōḍai yuṇḍunu gāka. āmēn.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మన', 'mana', 'our', 1),
        (verse_id_var, 2, 'ప్రభువైన', 'prabhuvaina', 'Lord', 2),
        (verse_id_var, 3, 'యేసుక్రీస్తు', 'yēsukrīstu', 'Jesus Christ', 3),
        (verse_id_var, 4, 'కృప', 'kr̥pa', 'The grace', 4),
        (verse_id_var, 5, 'మీ', 'mī', 'your', 5),
        (verse_id_var, 6, 'ఆత్మకు', 'ātmaku', 'spirit', 6),
        (verse_id_var, 7, 'తోడై', 'tōḍai', 'with', 7),
        (verse_id_var, 8, 'యుండును', 'yuṇḍunu', 'be', 8),
        (verse_id_var, 9, 'గాక.', 'gāka.', '.', 9),
        (verse_id_var, 10, 'ఆమేన్‌.', 'āmēn.', 'Amen.', 10);
END $$;