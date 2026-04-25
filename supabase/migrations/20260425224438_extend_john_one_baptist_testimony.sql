/*
  # Extend John 1 with the Baptist's testimony (verses 19-34)

  1. Content additions
    - Adds John 1:19 through 1:34 (16 verses) covering John the Baptist's questioning by the Jewish delegation
      and his declaration that Jesus is the Lamb of God and the Son of God.
    - Each verse upserts BSI-style Telugu, WEB English, and ISO-15919 transliteration.
    - Each verse seeds aligned `verse_tokens` with per-verse alignment groups.

  2. Strategy
    - Idempotent: verses upserted by (chapter_id, verse_number); tokens cleared and re-inserted per verse.
    - No schema changes; data only.

  3. Notes
    - Curated character alignments are not seeded; the runtime AksharaSegmenter handles per-character coloring.
*/

DO $$
DECLARE
    chapter_id_var bigint;
    verse_id_var bigint;
BEGIN
    SELECT id INTO chapter_id_var FROM chapters WHERE book_id = 43 AND chapter_number = 1;

    -- VERSE 19
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 19,
        'నీవెవడవు అని యోహానును అడుగుటకు యూదులు యెరూషలేము నుండి యాజకులను లేవీయులను అతని యొద్దకు పంపినప్పుడు అతని సాక్ష్యమిది.',
        'This is John''s testimony, when the Jews sent priests and Levites from Jerusalem to ask him, "Who are you?"',
        'nīvevaḍavu ani yōhānunu aḍuguṭaku yūdulu yerūṣalēmu nuṇḍi yājakulanu lēvīyulanu atani yoddaku pampinappuḍu atani sākṣyamidi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీవెవడవు', 'nīvevaḍavu', 'Who are you', 1),
        (verse_id_var, 2, 'అని', 'ani', 'asking', 2),
        (verse_id_var, 3, 'యోహానును', 'yōhānunu', 'John', 3),
        (verse_id_var, 4, 'అడుగుటకు', 'aḍuguṭaku', 'to ask', 4),
        (verse_id_var, 5, 'యూదులు', 'yūdulu', 'the Jews', 5),
        (verse_id_var, 6, 'యెరూషలేము', 'yerūṣalēmu', 'Jerusalem', 6),
        (verse_id_var, 7, 'నుండి', 'nuṇḍi', 'from', 7),
        (verse_id_var, 8, 'యాజకులను', 'yājakulanu', 'priests', 8),
        (verse_id_var, 9, 'లేవీయులను', 'lēvīyulanu', 'Levites', 9),
        (verse_id_var, 10, 'అతని', 'atani', 'him', 3),
        (verse_id_var, 11, 'యొద్దకు', 'yoddaku', 'to', 10),
        (verse_id_var, 12, 'పంపినప్పుడు', 'pampinappuḍu', 'sent', 11),
        (verse_id_var, 13, 'అతని', 'atani', 'his', 3),
        (verse_id_var, 14, 'సాక్ష్యమిది.', 'sākṣyamidi.', 'this is testimony.', 12);

    -- VERSE 20
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 20,
        'అతడు ఒప్పుకొనెను, విస్మరించలేదు; నేను క్రీస్తును కాను అని ఒప్పుకొనెను.',
        'He declared, and didn''t deny, but he declared, "I am not the Christ."',
        'ataḍu oppukonenu, vismariñcalēdu; nēnu krīstunu kānu ani oppukonenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అతడు', 'ataḍu', 'He', 1),
        (verse_id_var, 2, 'ఒప్పుకొనెను,', 'oppukonenu,', 'declared,', 2),
        (verse_id_var, 3, 'విస్మరించలేదు;', 'vismariñcalēdu;', 'didn''t deny;', 3),
        (verse_id_var, 4, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 5, 'క్రీస్తును', 'krīstunu', 'the Christ', 5),
        (verse_id_var, 6, 'కాను', 'kānu', 'am not', 6),
        (verse_id_var, 7, 'అని', 'ani', 'saying', 7),
        (verse_id_var, 8, 'ఒప్పుకొనెను.', 'oppukonenu.', 'declared.', 2);

    -- VERSE 21
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 21,
        'వారు—అట్లయితే ఏమి? నీవు ఏలీయావా అని అడుగగా అతడు—కానని చెప్పెను. నీవు ఆ ప్రవక్తవా అని వారడుగగా—కానని ఉత్తరమిచ్చెను.',
        'They asked him, "What then? Are you Elijah?" He said, "I am not." "Are you the prophet?" He answered, "No."',
        'vāru—aṭlayitē ēmi? nīvu ēlīyāvā ani aḍugagā ataḍu—kānani ceppenu. nīvu ā pravaktavā ani vāraḍugagā—kānani uttaramiccenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'వారు—', 'vāru—', 'They—', 1),
        (verse_id_var, 2, 'అట్లయితే', 'aṭlayitē', 'then', 2),
        (verse_id_var, 3, 'ఏమి?', 'ēmi?', 'What?', 3),
        (verse_id_var, 4, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 5, 'ఏలీయావా', 'ēlīyāvā', 'Elijah', 5),
        (verse_id_var, 6, 'అని', 'ani', 'asked', 6),
        (verse_id_var, 7, 'అడుగగా', 'aḍugagā', 'when', 7),
        (verse_id_var, 8, 'అతడు—', 'ataḍu—', 'He—', 8),
        (verse_id_var, 9, 'కానని', 'kānani', 'I am not', 9),
        (verse_id_var, 10, 'చెప్పెను.', 'ceppenu.', 'said.', 10),
        (verse_id_var, 11, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 12, 'ఆ', 'ā', 'the', 11),
        (verse_id_var, 13, 'ప్రవక్తవా', 'pravaktavā', 'prophet', 12),
        (verse_id_var, 14, 'అని', 'ani', 'asking', 6),
        (verse_id_var, 15, 'వారడుగగా—', 'vāraḍugagā—', 'they—', 1),
        (verse_id_var, 16, 'కానని', 'kānani', 'No', 9),
        (verse_id_var, 17, 'ఉత్తరమిచ్చెను.', 'uttaramiccenu.', 'answered.', 13);

    -- VERSE 22
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 22,
        'కావున వారు—నీవెవడవు? మమ్ము పంపినవారికి మేము ఉత్తరమిచ్చునట్లు చెప్పుము; నిన్నుగూర్చి నీవేమి చెప్పుకొనుచున్నావని అడిగిరి.',
        'They said therefore to him, "Who are you? Give us an answer to take back to those who sent us. What do you say about yourself?"',
        'kāvuna vāru—nīvevaḍavu? mammu pampinavāriki mēmu uttaramiccunaṭlu ceppumu; ninnugūrci nīvēmi ceppukonucunnāvani aḍigiri.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కావున', 'kāvuna', 'therefore', 1),
        (verse_id_var, 2, 'వారు—', 'vāru—', 'They—', 2),
        (verse_id_var, 3, 'నీవెవడవు?', 'nīvevaḍavu?', 'Who are you?', 3),
        (verse_id_var, 4, 'మమ్ము', 'mammu', 'us', 4),
        (verse_id_var, 5, 'పంపినవారికి', 'pampinavāriki', 'to those who sent', 5),
        (verse_id_var, 6, 'మేము', 'mēmu', 'we', 6),
        (verse_id_var, 7, 'ఉత్తరమిచ్చునట్లు', 'uttaramiccunaṭlu', 'an answer to take', 7),
        (verse_id_var, 8, 'చెప్పుము;', 'ceppumu;', 'give;', 8),
        (verse_id_var, 9, 'నిన్నుగూర్చి', 'ninnugūrci', 'about yourself', 9),
        (verse_id_var, 10, 'నీవేమి', 'nīvēmi', 'what do you', 10),
        (verse_id_var, 11, 'చెప్పుకొనుచున్నావని', 'ceppukonucunnāvani', 'say', 11),
        (verse_id_var, 12, 'అడిగిరి.', 'aḍigiri.', 'said.', 12);

    -- VERSE 23
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 23,
        'అందుకతడు—ప్రవక్తయైన యెషయా చెప్పినట్లు—ప్రభువు త్రోవను సరళము చేయుడని అరణ్యములో ఎలుగెత్తి పిలుచుచున్న ఒకని శబ్దము నేను అనెను.',
        'He said, "I am the voice of one crying in the wilderness, ''Make straight the way of the Lord,'' as Isaiah the prophet said."',
        'andukataḍu—pravaktayaina yeṣayā ceppinaṭlu—prabhuvu trōvanu saraḷamu cēyuḍani araṇyamulō elugetti pilucucunna okani śabdamu nēnu anenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అందుకతడు—', 'andukataḍu—', 'He said—', 1),
        (verse_id_var, 2, 'ప్రవక్తయైన', 'pravaktayaina', 'the prophet', 2),
        (verse_id_var, 3, 'యెషయా', 'yeṣayā', 'Isaiah', 3),
        (verse_id_var, 4, 'చెప్పినట్లు—', 'ceppinaṭlu—', 'as said—', 4),
        (verse_id_var, 5, 'ప్రభువు', 'prabhuvu', 'the Lord', 5),
        (verse_id_var, 6, 'త్రోవను', 'trōvanu', 'the way of', 6),
        (verse_id_var, 7, 'సరళము', 'saraḷamu', 'straight', 7),
        (verse_id_var, 8, 'చేయుడని', 'cēyuḍani', 'make', 8),
        (verse_id_var, 9, 'అరణ్యములో', 'araṇyamulō', 'in the wilderness', 9),
        (verse_id_var, 10, 'ఎలుగెత్తి', 'elugetti', 'crying', 10),
        (verse_id_var, 11, 'పిలుచుచున్న', 'pilucucunna', 'one', 11),
        (verse_id_var, 12, 'ఒకని', 'okani', 'of', 12),
        (verse_id_var, 13, 'శబ్దము', 'śabdamu', 'voice', 13),
        (verse_id_var, 14, 'నేను', 'nēnu', 'I am', 14),
        (verse_id_var, 15, 'అనెను.', 'anenu.', 'said.', 1);

    -- VERSE 24
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 24,
        'పంపబడినవారు పరిసయ్యుల తరఫువారు.',
        'The ones who had been sent were from the Pharisees.',
        'pampabaḍinavāru parisayyula taraphuvāru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'పంపబడినవారు', 'pampabaḍinavāru', 'The ones who had been sent', 1),
        (verse_id_var, 2, 'పరిసయ్యుల', 'parisayyula', 'the Pharisees', 2),
        (verse_id_var, 3, 'తరఫువారు.', 'taraphuvāru.', 'were from.', 3);

    -- VERSE 25
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 25,
        'వారు—నీవు క్రీస్తువైనను ఏలీయావైనను ఆ ప్రవక్తవైనను కానియెడల ఎందుకు బాప్తిస్మమిచ్చుచున్నావని అతని నడిగిరి.',
        'They asked him, "Why then do you baptize, if you are not the Christ, nor Elijah, nor the prophet?"',
        'vāru—nīvu krīstuvainanu ēlīyāvainanu ā pravaktavainanu kāniyeḍala enduku bāptismamiccucunnāvani atani naḍigiri.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'వారు—', 'vāru—', 'They—', 1),
        (verse_id_var, 2, 'నీవు', 'nīvu', 'you', 2),
        (verse_id_var, 3, 'క్రీస్తువైనను', 'krīstuvainanu', 'the Christ', 3),
        (verse_id_var, 4, 'ఏలీయావైనను', 'ēlīyāvainanu', 'nor Elijah', 4),
        (verse_id_var, 5, 'ఆ', 'ā', 'the', 5),
        (verse_id_var, 6, 'ప్రవక్తవైనను', 'pravaktavainanu', 'nor prophet', 6),
        (verse_id_var, 7, 'కానియెడల', 'kāniyeḍala', 'if are not', 7),
        (verse_id_var, 8, 'ఎందుకు', 'enduku', 'Why then', 8),
        (verse_id_var, 9, 'బాప్తిస్మమిచ్చుచున్నావని', 'bāptismamiccucunnāvani', 'do you baptize', 9),
        (verse_id_var, 10, 'అతని', 'atani', 'him', 10),
        (verse_id_var, 11, 'నడిగిరి.', 'naḍigiri.', 'asked.', 11);

    -- VERSE 26
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 26,
        'అందుకు యోహాను—నేను నీళ్లలో బాప్తిస్మమిచ్చుచున్నాను గాని మీరు ఎరుగని యొకడు మీ మధ్య నిలిచియున్నాడు;',
        'John answered them, "I baptize in water, but among you stands one whom you don''t know.',
        'anduku yōhānu—nēnu nīḷḷalō bāptismamiccucunnānu gāni mīru eruganī yokaḍu mī madhya nilīciyunnāḍu;')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అందుకు', 'anduku', 'answered', 1),
        (verse_id_var, 2, 'యోహాను—', 'yōhānu—', 'John—', 2),
        (verse_id_var, 3, 'నేను', 'nēnu', 'I', 3),
        (verse_id_var, 4, 'నీళ్లలో', 'nīḷḷalō', 'in water', 4),
        (verse_id_var, 5, 'బాప్తిస్మమిచ్చుచున్నాను', 'bāptismamiccucunnānu', 'baptize', 5),
        (verse_id_var, 6, 'గాని', 'gāni', 'but', 6),
        (verse_id_var, 7, 'మీరు', 'mīru', 'you', 7),
        (verse_id_var, 8, 'ఎరుగని', 'eruganī', 'don''t know', 8),
        (verse_id_var, 9, 'యొకడు', 'yokaḍu', 'one whom', 9),
        (verse_id_var, 10, 'మీ', 'mī', 'you', 7),
        (verse_id_var, 11, 'మధ్య', 'madhya', 'among', 10),
        (verse_id_var, 12, 'నిలిచియున్నాడు;', 'nilīciyunnāḍu;', 'stands;', 11);

    -- VERSE 27
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 27,
        'ఆయన నా వెనుక వచ్చువాడు; ఆయన చెప్పుల వారును విప్పుటకైనను నేను పాత్రుడను కాను అని వారికుత్తరమిచ్చెను.',
        'He is the one who comes after me, who is preferred before me, whose sandal strap I''m not worthy to loosen.',
        'āyana nā venuka vaccuvāḍu; āyana ceppula vāranu vippuṭakainanu nēnu pātruḍanu kānu ani vārikuttaramiccenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆయన', 'āyana', 'He', 1),
        (verse_id_var, 2, 'నా', 'nā', 'me', 2),
        (verse_id_var, 3, 'వెనుక', 'venuka', 'after', 3),
        (verse_id_var, 4, 'వచ్చువాడు;', 'vaccuvāḍu;', 'who comes;', 4),
        (verse_id_var, 5, 'ఆయన', 'āyana', 'whose', 1),
        (verse_id_var, 6, 'చెప్పుల', 'ceppula', 'sandal', 5),
        (verse_id_var, 7, 'వారును', 'vāranu', 'strap', 6),
        (verse_id_var, 8, 'విప్పుటకైనను', 'vippuṭakainanu', 'to loosen', 7),
        (verse_id_var, 9, 'నేను', 'nēnu', 'I', 8),
        (verse_id_var, 10, 'పాత్రుడను', 'pātruḍanu', 'worthy', 9),
        (verse_id_var, 11, 'కాను', 'kānu', 'am not', 10),
        (verse_id_var, 12, 'అని', 'ani', 'saying', 11),
        (verse_id_var, 13, 'వారికుత్తరమిచ్చెను.', 'vārikuttaramiccenu.', 'answered them.', 12);

    -- VERSE 28
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 28,
        'యోహాను బాప్తిస్మమిచ్చుచుండిన యొర్దానునదికి అవతలనున్న బేతనియలో ఈ సంగతులు జరిగెను.',
        'These things were done in Bethany beyond the Jordan, where John was baptizing.',
        'yōhānu bāptismamiccucuṇḍina yordānunadiki avatalanunna bētaniyalō ī saṅgatulu jarigenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యోహాను', 'yōhānu', 'John', 1),
        (verse_id_var, 2, 'బాప్తిస్మమిచ్చుచుండిన', 'bāptismamiccucuṇḍina', 'was baptizing', 2),
        (verse_id_var, 3, 'యొర్దానునదికి', 'yordānunadiki', 'the Jordan', 3),
        (verse_id_var, 4, 'అవతలనున్న', 'avatalanunna', 'beyond', 4),
        (verse_id_var, 5, 'బేతనియలో', 'bētaniyalō', 'in Bethany', 5),
        (verse_id_var, 6, 'ఈ', 'ī', 'These', 6),
        (verse_id_var, 7, 'సంగతులు', 'saṅgatulu', 'things', 7),
        (verse_id_var, 8, 'జరిగెను.', 'jarigenu.', 'were done.', 8);

    -- VERSE 29
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 29,
        'మరునాడు యోహాను యేసు తనయొద్దకు రాగా చూచి—ఇదిగో లోకపాపమును మోసికొనిపోవు దేవుని గొఱ్ఱెపిల్ల.',
        'The next day, he saw Jesus coming to him, and said, "Behold, the Lamb of God, who takes away the sin of the world!',
        'marunāḍu yōhānu yēsu tanayoddaku rāgā cūci—idigō lōkapāpamunu mōsikoniipōvu dēvuni gor̥r̥epilla.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మరునాడు', 'marunāḍu', 'The next day', 1),
        (verse_id_var, 2, 'యోహాను', 'yōhānu', 'he', 2),
        (verse_id_var, 3, 'యేసు', 'yēsu', 'Jesus', 3),
        (verse_id_var, 4, 'తనయొద్దకు', 'tanayoddaku', 'to him', 4),
        (verse_id_var, 5, 'రాగా', 'rāgā', 'coming', 5),
        (verse_id_var, 6, 'చూచి—', 'cūci—', 'saw and said—', 6),
        (verse_id_var, 7, 'ఇదిగో', 'idigō', 'Behold', 7),
        (verse_id_var, 8, 'లోకపాపమును', 'lōkapāpamunu', 'the sin of the world', 8),
        (verse_id_var, 9, 'మోసికొనిపోవు', 'mōsikoniipōvu', 'who takes away', 9),
        (verse_id_var, 10, 'దేవుని', 'dēvuni', 'of God', 10),
        (verse_id_var, 11, 'గొఱ్ఱెపిల్ల.', 'gor̥r̥epilla.', 'the Lamb.', 11);

    -- VERSE 30
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 30,
        'నా వెనుక ఒక పురుషుడు వచ్చుచున్నాడు; ఆయన నాకంటె ముందటివాడు గనుక నాకంటె ప్రముఖుడని నేను చెప్పినవాడు ఈయనే.',
        'This is he of whom I said, ''After me comes a man who is preferred before me, for he was before me.''',
        'nā venuka oka puruṣuḍu vaccucunnāḍu; āyana nākaṇṭe mundaṭivāḍu ganuka nākaṇṭe pramukhuḍani nēnu ceppinavāḍu īyanē.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నా', 'nā', 'me', 1),
        (verse_id_var, 2, 'వెనుక', 'venuka', 'After', 2),
        (verse_id_var, 3, 'ఒక', 'oka', 'a', 3),
        (verse_id_var, 4, 'పురుషుడు', 'puruṣuḍu', 'man', 4),
        (verse_id_var, 5, 'వచ్చుచున్నాడు;', 'vaccucunnāḍu;', 'comes;', 5),
        (verse_id_var, 6, 'ఆయన', 'āyana', 'he', 6),
        (verse_id_var, 7, 'నాకంటె', 'nākaṇṭe', 'before me', 7),
        (verse_id_var, 8, 'ముందటివాడు', 'mundaṭivāḍu', 'was', 8),
        (verse_id_var, 9, 'గనుక', 'ganuka', 'for', 9),
        (verse_id_var, 10, 'నాకంటె', 'nākaṇṭe', 'before me', 7),
        (verse_id_var, 11, 'ప్రముఖుడని', 'pramukhuḍani', 'preferred', 10),
        (verse_id_var, 12, 'నేను', 'nēnu', 'I', 11),
        (verse_id_var, 13, 'చెప్పినవాడు', 'ceppinavāḍu', 'said', 12),
        (verse_id_var, 14, 'ఈయనే.', 'īyanē.', 'This is he.', 13);

    -- VERSE 31
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 31,
        'నేను ఆయనను ఎరుగనైతిని గాని ఆయన ఇశ్రాయేలుకు ప్రత్యక్షము కావలెనని నేను నీళ్లలో బాప్తిస్మమిచ్చుచు వచ్చితిని.',
        'I didn''t know him, but for this reason I came baptizing in water: that he would be revealed to Israel.',
        'nēnu āyananu eruganaitini gāni āyana iśrāyēluku pratyakṣamu kāvalenani nēnu nīḷḷalō bāptismamiccucu vaccitini.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 2, 'ఆయనను', 'āyananu', 'him', 2),
        (verse_id_var, 3, 'ఎరుగనైతిని', 'eruganaitini', 'didn''t know', 3),
        (verse_id_var, 4, 'గాని', 'gāni', 'but', 4),
        (verse_id_var, 5, 'ఆయన', 'āyana', 'he', 2),
        (verse_id_var, 6, 'ఇశ్రాయేలుకు', 'iśrāyēluku', 'to Israel', 5),
        (verse_id_var, 7, 'ప్రత్యక్షము', 'pratyakṣamu', 'be revealed', 6),
        (verse_id_var, 8, 'కావలెనని', 'kāvalenani', 'that would', 7),
        (verse_id_var, 9, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 10, 'నీళ్లలో', 'nīḷḷalō', 'in water', 8),
        (verse_id_var, 11, 'బాప్తిస్మమిచ్చుచు', 'bāptismamiccucu', 'baptizing', 9),
        (verse_id_var, 12, 'వచ్చితిని.', 'vaccitini.', 'came.', 10);

    -- VERSE 32
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 32,
        'మరియు యోహాను—ఆత్మ పావురమువలె ఆకాశమునుండి దిగివచ్చుట చూచితిని; ఆ ఆత్మ ఆయనమీద నిలిచెను.',
        'John testified, saying, "I have seen the Spirit descending like a dove out of heaven, and it remained on him.',
        'mariyu yōhānu—ātma pāvuramuvale ākāśamunuṇḍi digivaccuṭa cūcitini; ā ātma āyanamīda nilīcenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మరియు', 'mariyu', 'testified', 1),
        (verse_id_var, 2, 'యోహాను—', 'yōhānu—', 'John—', 2),
        (verse_id_var, 3, 'ఆత్మ', 'ātma', 'the Spirit', 3),
        (verse_id_var, 4, 'పావురమువలె', 'pāvuramuvale', 'like a dove', 4),
        (verse_id_var, 5, 'ఆకాశమునుండి', 'ākāśamunuṇḍi', 'out of heaven', 5),
        (verse_id_var, 6, 'దిగివచ్చుట', 'digivaccuṭa', 'descending', 6),
        (verse_id_var, 7, 'చూచితిని;', 'cūcitini;', 'I have seen;', 7),
        (verse_id_var, 8, 'ఆ', 'ā', 'it', 8),
        (verse_id_var, 9, 'ఆత్మ', 'ātma', 'the Spirit', 3),
        (verse_id_var, 10, 'ఆయనమీద', 'āyanamīda', 'on him', 9),
        (verse_id_var, 11, 'నిలిచెను.', 'nilīcenu.', 'remained.', 10);

    -- VERSE 33
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 33,
        'నేను ఆయనను ఎరుగనైతిని గాని నీళ్లలో బాప్తిస్మమిచ్చుటకు నన్ను పంపినవాడు—నీవు ఎవనిమీద ఆత్మ దిగివచ్చి నిలుచుట చూచెదవో ఆయనే పరిశుద్ధాత్మలో బాప్తిస్మమిచ్చువాడని నాతో చెప్పెను.',
        'I didn''t recognize him, but he who sent me to baptize in water, he said to me, ''On whomever you will see the Spirit descending, and remaining on him, the same is he who baptizes in the Holy Spirit.''',
        'nēnu āyananu eruganaitini gāni nīḷḷalō bāptismamiccuṭaku nannu pampinavāḍu—nīvu evanimīda ātma digivacci nilucuṭa cūcedavō āyanē pariśuddhātmalō bāptismamiccuvāḍani nātō ceppenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 2, 'ఆయనను', 'āyananu', 'him', 2),
        (verse_id_var, 3, 'ఎరుగనైతిని', 'eruganaitini', 'didn''t recognize', 3),
        (verse_id_var, 4, 'గాని', 'gāni', 'but', 4),
        (verse_id_var, 5, 'నీళ్లలో', 'nīḷḷalō', 'in water', 5),
        (verse_id_var, 6, 'బాప్తిస్మమిచ్చుటకు', 'bāptismamiccuṭaku', 'to baptize', 6),
        (verse_id_var, 7, 'నన్ను', 'nannu', 'me', 1),
        (verse_id_var, 8, 'పంపినవాడు—', 'pampinavāḍu—', 'he who sent—', 7),
        (verse_id_var, 9, 'నీవు', 'nīvu', 'you', 8),
        (verse_id_var, 10, 'ఎవనిమీద', 'evanimīda', 'on whomever', 9),
        (verse_id_var, 11, 'ఆత్మ', 'ātma', 'the Spirit', 10),
        (verse_id_var, 12, 'దిగివచ్చి', 'digivacci', 'descending', 11),
        (verse_id_var, 13, 'నిలుచుట', 'nilucuṭa', 'and remaining', 12),
        (verse_id_var, 14, 'చూచెదవో', 'cūcedavō', 'will see', 13),
        (verse_id_var, 15, 'ఆయనే', 'āyanē', 'the same is he', 14),
        (verse_id_var, 16, 'పరిశుద్ధాత్మలో', 'pariśuddhātmalō', 'in the Holy Spirit', 15),
        (verse_id_var, 17, 'బాప్తిస్మమిచ్చువాడని', 'bāptismamiccuvāḍani', 'who baptizes', 16),
        (verse_id_var, 18, 'నాతో', 'nātō', 'to me', 1),
        (verse_id_var, 19, 'చెప్పెను.', 'ceppenu.', 'said.', 17);

    -- VERSE 34
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 34,
        'ఈయనే దేవుని కుమారుడని నేను తెలిసికొని సాక్ష్యమిచ్చియున్నాననెను.',
        'I have seen, and have testified that this is the Son of God.',
        'īyanē dēvuni kumāruḍani nēnu telisikoni sākṣyamicciyunnānanenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఈయనే', 'īyanē', 'this is', 1),
        (verse_id_var, 2, 'దేవుని', 'dēvuni', 'of God', 2),
        (verse_id_var, 3, 'కుమారుడని', 'kumāruḍani', 'the Son', 3),
        (verse_id_var, 4, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 5, 'తెలిసికొని', 'telisikoni', 'have seen', 5),
        (verse_id_var, 6, 'సాక్ష్యమిచ్చియున్నాననెను.', 'sākṣyamicciyunnānanenu.', 'and have testified.', 6);
END $$;