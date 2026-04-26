/*
  # Seed complete Matthew 6 (Sermon on the Mount continued)

  1. Content additions
    - Creates chapter row for Matthew 6 (book_id=40, chapter_number=6) if absent.
    - Seeds all 34 verses with BSI-style Telugu, WEB English, ISO-15919 transliteration.
    - Seeds aligned verse_tokens with per-verse alignment_group integers so words colour-link.

  2. Strategy
    - Idempotent: chapter and verses upserted by natural keys; tokens cleared and re-inserted per verse.
    - No schema changes; data only.

  3. Notes
    - Contains the Lord''s Prayer, teaching on giving, fasting, treasures in heaven, do not worry.
*/

DO $$
DECLARE
    chapter_id_var bigint;
    verse_id_var bigint;
BEGIN
    INSERT INTO chapters (book_id, chapter_number)
    VALUES (40, 6)
    ON CONFLICT (book_id, chapter_number) DO UPDATE SET chapter_number = EXCLUDED.chapter_number
    RETURNING id INTO chapter_id_var;

    -- VERSE 1
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 1,
        'మనుష్యులకు కనబడవలెనని వారియెదుట మీ నీతికార్యము చేయకుండ జాగ్రత్తపడుడి; లేనియెడల పరలోకమందున్న మీ తండ్రియొద్ద మీకు ఫలము దొరకదు.',
        '"Be careful that you don''t do your charitable giving before men, to be seen by them, or else you have no reward from your Father who is in heaven.',
        'manuṣyulaku kanabaḍavalenani vāriyeduṭa mī nītikāryamu cēyakuṃḍa jāgrattapaḍuḍi; lēniyeḍala paralōkamaṃdunna mī taṃḍriyodda mīku phalamu dorakadu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మనుష్యులకు', 'manuṣyulaku', 'by men', 1),
        (verse_id_var, 2, 'కనబడవలెనని', 'kanabaḍavalenani', 'to be seen', 2),
        (verse_id_var, 3, 'వారియెదుట', 'vāriyeduṭa', 'before them', 3),
        (verse_id_var, 4, 'మీ', 'mī', 'your', 4),
        (verse_id_var, 5, 'నీతికార్యము', 'nītikāryamu', 'charitable giving', 5),
        (verse_id_var, 6, 'చేయకుండ', 'cēyakuṃḍa', 'don''t do', 6),
        (verse_id_var, 7, 'జాగ్రత్తపడుడి;', 'jāgrattapaḍuḍi;', 'be careful;', 7),
        (verse_id_var, 8, 'లేనియెడల', 'lēniyeḍala', 'or else', 8),
        (verse_id_var, 9, 'పరలోకమందున్న', 'paralōkamaṃdunna', 'who is in heaven', 9),
        (verse_id_var, 10, 'మీ', 'mī', 'your', 4),
        (verse_id_var, 11, 'తండ్రియొద్ద', 'taṃḍriyodda', 'from Father', 10),
        (verse_id_var, 12, 'మీకు', 'mīku', 'you', 11),
        (verse_id_var, 13, 'ఫలము', 'phalamu', 'reward', 12),
        (verse_id_var, 14, 'దొరకదు.', 'dorakadu.', 'have no.', 13);

    -- VERSE 2
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 2,
        'కావున నీవు ధర్మము చేయునప్పుడు, మనుష్యులవలన ఘనత నొందవలెనని, వేషధారులు సమాజమందిరములలోను వీధులలోను చేయునట్లు, నీ ముందర బూర ఊదింపవద్దు; వారు తమ ఫలము పొంది యున్నారని మీతో నిశ్చయముగా చెప్పుచున్నాను.',
        'Therefore when you do merciful deeds, don''t sound a trumpet before yourself, as the hypocrites do in the synagogues and in the streets, that they may get glory from men. Most certainly I tell you, they have received their reward.',
        'kāvuna nīvu dharmamu cēyunappuḍu, manuṣyulavalana ghanata noṃdavalenani, vēṣadhārulu samājamaṃdiramulalōnu vīdhulalōnu cēyunaṭlu, nī muṃdara būra ūdiṃpavaddu; vāru tama phalamu poṃdi yunnārani mītō niścayamugā ceppucunnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కావున', 'kāvuna', 'therefore', 1),
        (verse_id_var, 2, 'నీవు', 'nīvu', 'you', 2),
        (verse_id_var, 3, 'ధర్మము', 'dharmamu', 'merciful deeds', 3),
        (verse_id_var, 4, 'చేయునప్పుడు,', 'cēyunappuḍu,', 'when do,', 4),
        (verse_id_var, 5, 'మనుష్యులవలన', 'manuṣyulavalana', 'from men', 5),
        (verse_id_var, 6, 'ఘనత', 'ghanata', 'glory', 6),
        (verse_id_var, 7, 'నొందవలెనని,', 'noṃdavalenani,', 'they may get,', 7),
        (verse_id_var, 8, 'వేషధారులు', 'vēṣadhārulu', 'the hypocrites', 8),
        (verse_id_var, 9, 'సమాజమందిరములలోను', 'samājamaṃdiramulalōnu', 'in the synagogues', 9),
        (verse_id_var, 10, 'వీధులలోను', 'vīdhulalōnu', 'in the streets', 10),
        (verse_id_var, 11, 'చేయునట్లు,', 'cēyunaṭlu,', 'as do,', 11),
        (verse_id_var, 12, 'నీ', 'nī', 'yourself', 12),
        (verse_id_var, 13, 'ముందర', 'muṃdara', 'before', 13),
        (verse_id_var, 14, 'బూర', 'būra', 'a trumpet', 14),
        (verse_id_var, 15, 'ఊదింపవద్దు;', 'ūdiṃpavaddu;', 'don''t sound;', 15),
        (verse_id_var, 16, 'వారు', 'vāru', 'they', 16),
        (verse_id_var, 17, 'తమ', 'tama', 'their', 17),
        (verse_id_var, 18, 'ఫలము', 'phalamu', 'reward', 18),
        (verse_id_var, 19, 'పొంది', 'poṃdi', 'have received', 19),
        (verse_id_var, 20, 'యున్నారని', 'yunnārani', 'are', 20),
        (verse_id_var, 21, 'మీతో', 'mītō', 'you', 21),
        (verse_id_var, 22, 'నిశ్చయముగా', 'niścayamugā', 'most certainly', 22),
        (verse_id_var, 23, 'చెప్పుచున్నాను.', 'ceppucunnānu.', 'I tell.', 23);

    -- VERSE 3
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 3,
        'నీవు ధర్మము చేయునప్పుడు, నీ ధర్మము రహస్యముగా ఉండు నిమిత్తము నీ కుడిచెయ్యి చేయునది నీ యెడమచేతికి తెలియకయుండవలెను.',
        'But when you do merciful deeds, don''t let your left hand know what your right hand does,',
        'nīvu dharmamu cēyunappuḍu, nī dharmamu rahasyamugā uṃḍu nimittamu nī kuḍiceyyi cēyunadi nī yeḍamacētiki teliyakayuṃḍavalenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీవు', 'nīvu', 'you', 1),
        (verse_id_var, 2, 'ధర్మము', 'dharmamu', 'merciful deeds', 2),
        (verse_id_var, 3, 'చేయునప్పుడు,', 'cēyunappuḍu,', 'when do,', 3),
        (verse_id_var, 4, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 5, 'ధర్మము', 'dharmamu', 'giving', 2),
        (verse_id_var, 6, 'రహస్యముగా', 'rahasyamugā', 'in secret', 5),
        (verse_id_var, 7, 'ఉండు', 'uṃḍu', 'be', 6),
        (verse_id_var, 8, 'నిమిత్తము', 'nimittamu', 'so that', 7),
        (verse_id_var, 9, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 10, 'కుడిచెయ్యి', 'kuḍiceyyi', 'right hand', 8),
        (verse_id_var, 11, 'చేయునది', 'cēyunadi', 'does', 9),
        (verse_id_var, 12, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 13, 'యెడమచేతికి', 'yeḍamacētiki', 'left hand', 10),
        (verse_id_var, 14, 'తెలియకయుండవలెను.', 'teliyakayuṃḍavalenu.', 'don''t let know.', 11);

    -- VERSE 4
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 4,
        'అట్లు నీ ధర్మము రహస్యముగా ఉండును; అప్పుడు రహస్యమందు చూచు నీ తండ్రి నీకు ప్రతిఫలమిచ్చును.',
        'so that your merciful deeds may be in secret, then your Father who sees in secret will reward you openly.',
        'aṭlu nī dharmamu rahasyamugā uṃḍunu; appuḍu rahasyamaṃdu cūcu nī taṃḍri nīku pratiphalamiccunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అట్లు', 'aṭlu', 'so that', 1),
        (verse_id_var, 2, 'నీ', 'nī', 'your', 2),
        (verse_id_var, 3, 'ధర్మము', 'dharmamu', 'merciful deeds', 3),
        (verse_id_var, 4, 'రహస్యముగా', 'rahasyamugā', 'in secret', 4),
        (verse_id_var, 5, 'ఉండును;', 'uṃḍunu;', 'may be;', 5),
        (verse_id_var, 6, 'అప్పుడు', 'appuḍu', 'then', 6),
        (verse_id_var, 7, 'రహస్యమందు', 'rahasyamaṃdu', 'in secret', 4),
        (verse_id_var, 8, 'చూచు', 'cūcu', 'who sees', 7),
        (verse_id_var, 9, 'నీ', 'nī', 'your', 2),
        (verse_id_var, 10, 'తండ్రి', 'taṃḍri', 'Father', 8),
        (verse_id_var, 11, 'నీకు', 'nīku', 'you', 9),
        (verse_id_var, 12, 'ప్రతిఫలమిచ్చును.', 'pratiphalamiccunu.', 'will reward.', 10);

    -- VERSE 5
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 5,
        'మీరు ప్రార్థన చేయునప్పుడు వేషధారులవలె ఉండకుడి; మనుష్యులకు కనబడవలెనని సమాజమందిరములలోను వీధుల మూలలలోను నిలిచి ప్రార్థన చేయుట వారికిష్టము; వారు తమ ఫలము పొంది యున్నారని మీతో నిశ్చయముగా చెప్పుచున్నాను.',
        '"When you pray, you shall not be as the hypocrites, for they love to stand and pray in the synagogues and in the corners of the streets, that they may be seen by men. Most certainly, I tell you, they have received their reward.',
        'mīru prārthana cēyunappuḍu vēṣadhārulavale uṃḍakuḍi; manuṣyulaku kanabaḍavalenani samājamaṃdiramulalōnu vīdhula mūlalalōnu nilici prārthana cēyuṭa vārikiṣṭamu; vāru tama phalamu poṃdi yunnārani mītō niścayamugā ceppucunnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మీరు', 'mīru', 'you', 1),
        (verse_id_var, 2, 'ప్రార్థన', 'prārthana', 'pray', 2),
        (verse_id_var, 3, 'చేయునప్పుడు', 'cēyunappuḍu', 'when', 3),
        (verse_id_var, 4, 'వేషధారులవలె', 'vēṣadhārulavale', 'as the hypocrites', 4),
        (verse_id_var, 5, 'ఉండకుడి;', 'uṃḍakuḍi;', 'shall not be;', 5),
        (verse_id_var, 6, 'మనుష్యులకు', 'manuṣyulaku', 'by men', 6),
        (verse_id_var, 7, 'కనబడవలెనని', 'kanabaḍavalenani', 'may be seen', 7),
        (verse_id_var, 8, 'సమాజమందిరములలోను', 'samājamaṃdiramulalōnu', 'in the synagogues', 8),
        (verse_id_var, 9, 'వీధుల', 'vīdhula', 'of the streets', 9),
        (verse_id_var, 10, 'మూలలలోను', 'mūlalalōnu', 'in the corners', 10),
        (verse_id_var, 11, 'నిలిచి', 'nilici', 'to stand', 11),
        (verse_id_var, 12, 'ప్రార్థన', 'prārthana', 'pray', 2),
        (verse_id_var, 13, 'చేయుట', 'cēyuṭa', 'and', 12),
        (verse_id_var, 14, 'వారికిష్టము;', 'vārikiṣṭamu;', 'they love;', 13),
        (verse_id_var, 15, 'వారు', 'vāru', 'they', 14),
        (verse_id_var, 16, 'తమ', 'tama', 'their', 15),
        (verse_id_var, 17, 'ఫలము', 'phalamu', 'reward', 16),
        (verse_id_var, 18, 'పొంది', 'poṃdi', 'have received', 17),
        (verse_id_var, 19, 'యున్నారని', 'yunnārani', 'are', 18),
        (verse_id_var, 20, 'మీతో', 'mītō', 'you', 1),
        (verse_id_var, 21, 'నిశ్చయముగా', 'niścayamugā', 'most certainly', 19),
        (verse_id_var, 22, 'చెప్పుచున్నాను.', 'ceppucunnānu.', 'I tell.', 20);

    -- VERSE 6
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 6,
        'నీవు ప్రార్థన చేయునప్పుడు, నీ గదిలోనికి వెళ్లి తలుపువేసి, రహస్యమందున్న నీ తండ్రికి ప్రార్థన చేయుము; అప్పుడు రహస్యమందు చూచు నీ తండ్రి నీకు ప్రతిఫలమిచ్చును.',
        'But you, when you pray, enter into your inner room, and having shut your door, pray to your Father who is in secret, and your Father who sees in secret will reward you openly.',
        'nīvu prārthana cēyunappuḍu, nī gadilōniki veḷli talupuvēsi, rahasyamaṃdunna nī taṃḍriki prārthana cēyumu; appuḍu rahasyamaṃdu cūcu nī taṃḍri nīku pratiphalamiccunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీవు', 'nīvu', 'you', 1),
        (verse_id_var, 2, 'ప్రార్థన', 'prārthana', 'pray', 2),
        (verse_id_var, 3, 'చేయునప్పుడు,', 'cēyunappuḍu,', 'when,', 3),
        (verse_id_var, 4, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 5, 'గదిలోనికి', 'gadilōniki', 'into inner room', 5),
        (verse_id_var, 6, 'వెళ్లి', 'veḷli', 'enter', 6),
        (verse_id_var, 7, 'తలుపువేసి,', 'talupuvēsi,', 'having shut door,', 7),
        (verse_id_var, 8, 'రహస్యమందున్న', 'rahasyamaṃdunna', 'who is in secret', 8),
        (verse_id_var, 9, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 10, 'తండ్రికి', 'taṃḍriki', 'to Father', 9),
        (verse_id_var, 11, 'ప్రార్థన', 'prārthana', 'pray', 2),
        (verse_id_var, 12, 'చేయుము;', 'cēyumu;', 'do;', 10),
        (verse_id_var, 13, 'అప్పుడు', 'appuḍu', 'and', 11),
        (verse_id_var, 14, 'రహస్యమందు', 'rahasyamaṃdu', 'in secret', 12),
        (verse_id_var, 15, 'చూచు', 'cūcu', 'who sees', 13),
        (verse_id_var, 16, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 17, 'తండ్రి', 'taṃḍri', 'Father', 14),
        (verse_id_var, 18, 'నీకు', 'nīku', 'you', 1),
        (verse_id_var, 19, 'ప్రతిఫలమిచ్చును.', 'pratiphalamiccunu.', 'will reward.', 15);

    -- VERSE 7
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 7,
        'మరియు మీరు ప్రార్థన చేయునప్పుడు అన్యజనులవలె వ్యర్థమైన మాటలు వచింపకుడి; విస్తరించి మాటలాడుటవలన తమ మనవి అంగీకరింపబడునని వారు తలంచుచున్నారు.',
        'In praying, don''t use vain repetitions, as the Gentiles do; for they think that they will be heard for their much speaking.',
        'mariyu mīru prārthana cēyunappuḍu anyajanulavale vyarthamaina māṭalu vaciṃpakuḍi; vistariñci māṭalāḍuṭavalana tama manavi aṃgīkariṃpabaḍunani vāru talaṃcucunnāru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మరియు', 'mariyu', 'and', 1),
        (verse_id_var, 2, 'మీరు', 'mīru', 'you', 2),
        (verse_id_var, 3, 'ప్రార్థన', 'prārthana', 'praying', 3),
        (verse_id_var, 4, 'చేయునప్పుడు', 'cēyunappuḍu', 'in', 4),
        (verse_id_var, 5, 'అన్యజనులవలె', 'anyajanulavale', 'as the Gentiles', 5),
        (verse_id_var, 6, 'వ్యర్థమైన', 'vyarthamaina', 'vain', 6),
        (verse_id_var, 7, 'మాటలు', 'māṭalu', 'repetitions', 7),
        (verse_id_var, 8, 'వచింపకుడి;', 'vaciṃpakuḍi;', 'don''t use;', 8),
        (verse_id_var, 9, 'విస్తరించి', 'vistariñci', 'much', 9),
        (verse_id_var, 10, 'మాటలాడుటవలన', 'māṭalāḍuṭavalana', 'for speaking', 10),
        (verse_id_var, 11, 'తమ', 'tama', 'their', 11),
        (verse_id_var, 12, 'మనవి', 'manavi', 'request', 12),
        (verse_id_var, 13, 'అంగీకరింపబడునని', 'aṃgīkariṃpabaḍunani', 'will be heard', 13),
        (verse_id_var, 14, 'వారు', 'vāru', 'they', 14),
        (verse_id_var, 15, 'తలంచుచున్నారు.', 'talaṃcucunnāru.', 'think.', 15);

    -- VERSE 8
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 8,
        'మీరు వారివలె ఉండకుడి. మీరు మీ తండ్రిని అడుగక మునుపే మీకు అక్కరగా నున్నవేవో ఆయనకు తెలియును.',
        'Therefore don''t be like them, for your Father knows what things you need, before you ask him.',
        'mīru vārivale uṃḍakuḍi. mīru mī taṃḍrini aḍugaka munupē mīku akkaragā nunnavēvō āyanaku teliyunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మీరు', 'mīru', 'you', 1),
        (verse_id_var, 2, 'వారివలె', 'vārivale', 'like them', 2),
        (verse_id_var, 3, 'ఉండకుడి.', 'uṃḍakuḍi.', 'don''t be.', 3),
        (verse_id_var, 4, 'మీరు', 'mīru', 'you', 1),
        (verse_id_var, 5, 'మీ', 'mī', 'your', 4),
        (verse_id_var, 6, 'తండ్రిని', 'taṃḍrini', 'Father', 5),
        (verse_id_var, 7, 'అడుగక', 'aḍugaka', 'ask', 6),
        (verse_id_var, 8, 'మునుపే', 'munupē', 'before', 7),
        (verse_id_var, 9, 'మీకు', 'mīku', 'you', 1),
        (verse_id_var, 10, 'అక్కరగా', 'akkaragā', 'need', 8),
        (verse_id_var, 11, 'నున్నవేవో', 'nunnavēvō', 'what things', 9),
        (verse_id_var, 12, 'ఆయనకు', 'āyanaku', 'he', 10),
        (verse_id_var, 13, 'తెలియును.', 'teliyunu.', 'knows.', 11);

    -- VERSE 9
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 9,
        'కాబట్టి మీరీలాగు ప్రార్థన చేయుడి—పరలోకమందున్న మా తండ్రీ, నీ నామము పరిశుద్ధపరచబడుగాక,',
        'Pray like this: ''Our Father in heaven, may your name be kept holy.',
        'kābaṭṭi mīrīlāgu prārthana cēyuḍi—paralōkamaṃdunna mā taṃḍrī, nī nāmamu pariśuddhaparacabaḍugāka,')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కాబట్టి', 'kābaṭṭi', 'therefore', 1),
        (verse_id_var, 2, 'మీరీలాగు', 'mīrīlāgu', 'like this', 2),
        (verse_id_var, 3, 'ప్రార్థన', 'prārthana', 'pray', 3),
        (verse_id_var, 4, 'చేయుడి—', 'cēyuḍi—', 'do—', 4),
        (verse_id_var, 5, 'పరలోకమందున్న', 'paralōkamaṃdunna', 'in heaven', 5),
        (verse_id_var, 6, 'మా', 'mā', 'our', 6),
        (verse_id_var, 7, 'తండ్రీ,', 'taṃḍrī,', 'Father,', 7),
        (verse_id_var, 8, 'నీ', 'nī', 'your', 8),
        (verse_id_var, 9, 'నామము', 'nāmamu', 'name', 9),
        (verse_id_var, 10, 'పరిశుద్ధపరచబడుగాక,', 'pariśuddhaparacabaḍugāka,', 'may be kept holy,', 10);

    -- VERSE 10
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 10,
        'నీ రాజ్యము వచ్చుగాక, నీ చిత్తము పరలోకమందు నెరవేరుచున్నట్లు భూమియందును నెరవేరును గాక,',
        'Let your Kingdom come. Let your will be done, on earth as it is in heaven.',
        'nī rājyamu vaccugāka, nī cittamu paralōkamaṃdu neravērucunnaṭlu bhūmiyaṃdunu neravērunu gāka,')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 2, 'రాజ్యము', 'rājyamu', 'Kingdom', 2),
        (verse_id_var, 3, 'వచ్చుగాక,', 'vaccugāka,', 'let come,', 3),
        (verse_id_var, 4, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 5, 'చిత్తము', 'cittamu', 'will', 4),
        (verse_id_var, 6, 'పరలోకమందు', 'paralōkamaṃdu', 'in heaven', 5),
        (verse_id_var, 7, 'నెరవేరుచున్నట్లు', 'neravērucunnaṭlu', 'as it is done', 6),
        (verse_id_var, 8, 'భూమియందును', 'bhūmiyaṃdunu', 'on earth', 7),
        (verse_id_var, 9, 'నెరవేరును', 'neravērunu', 'be done', 6),
        (verse_id_var, 10, 'గాక,', 'gāka,', 'let,', 8);

    -- VERSE 11
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 11,
        'మా అనుదినాహారము నేడు మాకు దయచేయుము.',
        'Give us today our daily bread.',
        'mā anudināhāramu nēḍu māku dayacēyumu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మా', 'mā', 'our', 1),
        (verse_id_var, 2, 'అనుదినాహారము', 'anudināhāramu', 'daily bread', 2),
        (verse_id_var, 3, 'నేడు', 'nēḍu', 'today', 3),
        (verse_id_var, 4, 'మాకు', 'māku', 'us', 4),
        (verse_id_var, 5, 'దయచేయుము.', 'dayacēyumu.', 'give.', 5);

    -- VERSE 12
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 12,
        'మా ఋణస్థులను మేము క్షమించియున్న ప్రకారము మా ఋణములు క్షమించుము.',
        'Forgive us our debts, as we also forgive our debtors.',
        'mā r̥ṇasthulanu mēmu kṣamiñciyunna prakāramu mā r̥ṇamulu kṣamiñcumu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మా', 'mā', 'our', 1),
        (verse_id_var, 2, 'ఋణస్థులను', 'r̥ṇasthulanu', 'debtors', 2),
        (verse_id_var, 3, 'మేము', 'mēmu', 'we', 3),
        (verse_id_var, 4, 'క్షమించియున్న', 'kṣamiñciyunna', 'forgive', 4),
        (verse_id_var, 5, 'ప్రకారము', 'prakāramu', 'as also', 5),
        (verse_id_var, 6, 'మా', 'mā', 'our', 1),
        (verse_id_var, 7, 'ఋణములు', 'r̥ṇamulu', 'debts', 6),
        (verse_id_var, 8, 'క్షమించుము.', 'kṣamiñcumu.', 'forgive us.', 7);

    -- VERSE 13
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 13,
        'మమ్మును శోధనలోకి తేక దుష్టునినుండి మమ్మును తప్పించుము. (రాజ్యమును బలమును మహిమయు నిరంతరము నీవే.) ఆమేన్.',
        'Bring us not into temptation, but deliver us from the evil one. For yours is the Kingdom, the power, and the glory forever. Amen.',
        'mammunu śōdhanalōki tēka duṣṭuninuṃḍi mammunu tappiñcumu. (rājyamunu balamunu mahimayu niraṃtaramu nīvē.) āmēn.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మమ్మును', 'mammunu', 'us', 1),
        (verse_id_var, 2, 'శోధనలోకి', 'śōdhanalōki', 'into temptation', 2),
        (verse_id_var, 3, 'తేక', 'tēka', 'bring not', 3),
        (verse_id_var, 4, 'దుష్టునినుండి', 'duṣṭuninuṃḍi', 'from the evil one', 4),
        (verse_id_var, 5, 'మమ్మును', 'mammunu', 'us', 1),
        (verse_id_var, 6, 'తప్పించుము.', 'tappiñcumu.', 'deliver.', 5),
        (verse_id_var, 7, '(రాజ్యమును', '(rājyamunu', '(the Kingdom', 6),
        (verse_id_var, 8, 'బలమును', 'balamunu', 'the power', 7),
        (verse_id_var, 9, 'మహిమయు', 'mahimayu', 'and the glory', 8),
        (verse_id_var, 10, 'నిరంతరము', 'niraṃtaramu', 'forever', 9),
        (verse_id_var, 11, 'నీవే.)', 'nīvē.)', 'yours is.)', 10),
        (verse_id_var, 12, 'ఆమేన్.', 'āmēn.', 'Amen.', 11);

    -- VERSE 14
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 14,
        'మనుష్యుల అపరాధములను మీరు క్షమించినయెడల, మీ పరలోకపు తండ్రియు మీ అపరాధములను క్షమించును.',
        'For if you forgive men their trespasses, your heavenly Father will also forgive you.',
        'manuṣyula aparādhamulanu mīru kṣamiñcinayeḍala, mī paralōkapu taṃḍriyu mī aparādhamulanu kṣamiñcunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మనుష్యుల', 'manuṣyula', 'men', 1),
        (verse_id_var, 2, 'అపరాధములను', 'aparādhamulanu', 'their trespasses', 2),
        (verse_id_var, 3, 'మీరు', 'mīru', 'you', 3),
        (verse_id_var, 4, 'క్షమించినయెడల,', 'kṣamiñcinayeḍala,', 'if forgive,', 4),
        (verse_id_var, 5, 'మీ', 'mī', 'your', 5),
        (verse_id_var, 6, 'పరలోకపు', 'paralōkapu', 'heavenly', 6),
        (verse_id_var, 7, 'తండ్రియు', 'taṃḍriyu', 'Father', 7),
        (verse_id_var, 8, 'మీ', 'mī', 'you', 3),
        (verse_id_var, 9, 'అపరాధములను', 'aparādhamulanu', 'also', 8),
        (verse_id_var, 10, 'క్షమించును.', 'kṣamiñcunu.', 'will forgive.', 9);

    -- VERSE 15
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 15,
        'మీరు మనుష్యుల అపరాధములను క్షమింపక పోయినయెడల మీ తండ్రియు మీ అపరాధములను క్షమింపడు.',
        'But if you don''t forgive men their trespasses, neither will your Father forgive your trespasses.',
        'mīru manuṣyula aparādhamulanu kṣamiṃpaka pōyinayeḍala mī taṃḍriyu mī aparādhamulanu kṣamiṃpaḍu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మీరు', 'mīru', 'you', 1),
        (verse_id_var, 2, 'మనుష్యుల', 'manuṣyula', 'men', 2),
        (verse_id_var, 3, 'అపరాధములను', 'aparādhamulanu', 'their trespasses', 3),
        (verse_id_var, 4, 'క్షమింపక', 'kṣamiṃpaka', 'don''t forgive', 4),
        (verse_id_var, 5, 'పోయినయెడల', 'pōyinayeḍala', 'but if', 5),
        (verse_id_var, 6, 'మీ', 'mī', 'your', 6),
        (verse_id_var, 7, 'తండ్రియు', 'taṃḍriyu', 'Father', 7),
        (verse_id_var, 8, 'మీ', 'mī', 'your', 6),
        (verse_id_var, 9, 'అపరాధములను', 'aparādhamulanu', 'trespasses', 3),
        (verse_id_var, 10, 'క్షమింపడు.', 'kṣamiṃpaḍu.', 'neither will forgive.', 8);

    -- VERSE 16
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 16,
        'మీరు ఉపవాసము చేయునప్పుడు వేషధారులవలె ముఖము వాడబెట్టుకొనకుడి; తాము ఉపవాసము చేయుచున్నట్టు మనుష్యులకు కనబడవలెనని వారు తమ ముఖము వికారము చేసికొందురు; వారు తమ ఫలము పొంది యున్నారని మీతో నిశ్చయముగా చెప్పుచున్నాను.',
        '"Moreover when you fast, don''t be like the hypocrites, with sad faces. For they disfigure their faces, that they may be seen by men to be fasting. Most certainly I tell you, they have received their reward.',
        'mīru upavāsamu cēyunappuḍu vēṣadhārulavale mukhamu vāḍabeṭṭukonakuḍi; tāmu upavāsamu cēyucunnaṭṭu manuṣyulaku kanabaḍavalenani vāru tama mukhamu vikāramu cēsikoṃduru; vāru tama phalamu poṃdi yunnārani mītō niścayamugā ceppucunnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మీరు', 'mīru', 'you', 1),
        (verse_id_var, 2, 'ఉపవాసము', 'upavāsamu', 'fast', 2),
        (verse_id_var, 3, 'చేయునప్పుడు', 'cēyunappuḍu', 'when', 3),
        (verse_id_var, 4, 'వేషధారులవలె', 'vēṣadhārulavale', 'like the hypocrites', 4),
        (verse_id_var, 5, 'ముఖము', 'mukhamu', 'faces', 5),
        (verse_id_var, 6, 'వాడబెట్టుకొనకుడి;', 'vāḍabeṭṭukonakuḍi;', 'don''t be sad;', 6),
        (verse_id_var, 7, 'తాము', 'tāmu', 'they', 7),
        (verse_id_var, 8, 'ఉపవాసము', 'upavāsamu', 'fasting', 2),
        (verse_id_var, 9, 'చేయుచున్నట్టు', 'cēyucunnaṭṭu', 'to be', 8),
        (verse_id_var, 10, 'మనుష్యులకు', 'manuṣyulaku', 'by men', 9),
        (verse_id_var, 11, 'కనబడవలెనని', 'kanabaḍavalenani', 'may be seen', 10),
        (verse_id_var, 12, 'వారు', 'vāru', 'they', 7),
        (verse_id_var, 13, 'తమ', 'tama', 'their', 11),
        (verse_id_var, 14, 'ముఖము', 'mukhamu', 'faces', 5),
        (verse_id_var, 15, 'వికారము', 'vikāramu', 'disfigure', 12),
        (verse_id_var, 16, 'చేసికొందురు;', 'cēsikoṃduru;', 'do;', 13),
        (verse_id_var, 17, 'వారు', 'vāru', 'they', 7),
        (verse_id_var, 18, 'తమ', 'tama', 'their', 11),
        (verse_id_var, 19, 'ఫలము', 'phalamu', 'reward', 14),
        (verse_id_var, 20, 'పొంది', 'poṃdi', 'have received', 15),
        (verse_id_var, 21, 'యున్నారని', 'yunnārani', 'are', 16),
        (verse_id_var, 22, 'మీతో', 'mītō', 'you', 1),
        (verse_id_var, 23, 'నిశ్చయముగా', 'niścayamugā', 'most certainly', 17),
        (verse_id_var, 24, 'చెప్పుచున్నాను.', 'ceppucunnānu.', 'I tell.', 18);

    -- VERSE 17
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 17,
        'ఉపవాసము చేయునప్పుడు నీవు మనుష్యులకు ఉపవాసము చేయుచున్నట్టు కనబడక, రహస్యమందున్న నీ తండ్రికే కనబడవలెనని నీ తల అంటుకొని, నీ ముఖము కడుగుకొనుము;',
        'But you, when you fast, anoint your head, and wash your face;',
        'upavāsamu cēyunappuḍu nīvu manuṣyulaku upavāsamu cēyucunnaṭṭu kanabaḍaka, rahasyamaṃdunna nī taṃḍrikē kanabaḍavalenani nī tala aṃṭukoni, nī mukhamu kaḍugukonumu;')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఉపవాసము', 'upavāsamu', 'fast', 1),
        (verse_id_var, 2, 'చేయునప్పుడు', 'cēyunappuḍu', 'when', 2),
        (verse_id_var, 3, 'నీవు', 'nīvu', 'you', 3),
        (verse_id_var, 4, 'మనుష్యులకు', 'manuṣyulaku', 'to men', 4),
        (verse_id_var, 5, 'ఉపవాసము', 'upavāsamu', 'fasting', 1),
        (verse_id_var, 6, 'చేయుచున్నట్టు', 'cēyucunnaṭṭu', 'as', 5),
        (verse_id_var, 7, 'కనబడక,', 'kanabaḍaka,', 'don''t appear,', 6),
        (verse_id_var, 8, 'రహస్యమందున్న', 'rahasyamaṃdunna', 'who is in secret', 7),
        (verse_id_var, 9, 'నీ', 'nī', 'your', 8),
        (verse_id_var, 10, 'తండ్రికే', 'taṃḍrikē', 'to Father', 9),
        (verse_id_var, 11, 'కనబడవలెనని', 'kanabaḍavalenani', 'may appear', 10),
        (verse_id_var, 12, 'నీ', 'nī', 'your', 8),
        (verse_id_var, 13, 'తల', 'tala', 'head', 11),
        (verse_id_var, 14, 'అంటుకొని,', 'aṃṭukoni,', 'anoint,', 12),
        (verse_id_var, 15, 'నీ', 'nī', 'your', 8),
        (verse_id_var, 16, 'ముఖము', 'mukhamu', 'face', 13),
        (verse_id_var, 17, 'కడుగుకొనుము;', 'kaḍugukonumu;', 'wash;', 14);

    -- VERSE 18
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 18,
        'అప్పుడు రహస్యమందు చూచు నీ తండ్రి నీకు ప్రతిఫలమిచ్చును.',
        'so that you are not seen by men to be fasting, but by your Father who is in secret, and your Father, who sees in secret, will reward you.',
        'appuḍu rahasyamaṃdu cūcu nī taṃḍri nīku pratiphalamiccunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అప్పుడు', 'appuḍu', 'so that', 1),
        (verse_id_var, 2, 'రహస్యమందు', 'rahasyamaṃdu', 'in secret', 2),
        (verse_id_var, 3, 'చూచు', 'cūcu', 'who sees', 3),
        (verse_id_var, 4, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 5, 'తండ్రి', 'taṃḍri', 'Father', 5),
        (verse_id_var, 6, 'నీకు', 'nīku', 'you', 6),
        (verse_id_var, 7, 'ప్రతిఫలమిచ్చును.', 'pratiphalamiccunu.', 'will reward.', 7);

    -- VERSE 19
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 19,
        'భూమిమీద మీకొరకు ధనమును సమకూర్చుకొనవద్దు; ఇక్కడ చిమ్మెటయు, తుప్పును వాటిని తినివేయును, దొంగలు కన్నమువేసి దొంగిలెదరు.',
        '"Don''t lay up treasures for yourselves on the earth, where moth and rust consume, and where thieves break through and steal;',
        'bhūmimīda mīkoraku dhanamunu samakūrcukonavaddu; ikkaḍa cimmeṭayu, tuppunu vāṭini tinivēyunu, doṃgalu kannamuvēsi doṃgiledaru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'భూమిమీద', 'bhūmimīda', 'on the earth', 1),
        (verse_id_var, 2, 'మీకొరకు', 'mīkoraku', 'for yourselves', 2),
        (verse_id_var, 3, 'ధనమును', 'dhanamunu', 'treasures', 3),
        (verse_id_var, 4, 'సమకూర్చుకొనవద్దు;', 'samakūrcukonavaddu;', 'don''t lay up;', 4),
        (verse_id_var, 5, 'ఇక్కడ', 'ikkaḍa', 'where', 5),
        (verse_id_var, 6, 'చిమ్మెటయు,', 'cimmeṭayu,', 'moth,', 6),
        (verse_id_var, 7, 'తుప్పును', 'tuppunu', 'and rust', 7),
        (verse_id_var, 8, 'వాటిని', 'vāṭini', 'them', 8),
        (verse_id_var, 9, 'తినివేయును,', 'tinivēyunu,', 'consume,', 9),
        (verse_id_var, 10, 'దొంగలు', 'doṃgalu', 'thieves', 10),
        (verse_id_var, 11, 'కన్నమువేసి', 'kannamuvēsi', 'break through', 11),
        (verse_id_var, 12, 'దొంగిలెదరు.', 'doṃgiledaru.', 'and steal.', 12);

    -- VERSE 20
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 20,
        'పరలోకమందు మీకొరకు ధనమును సమకూర్చుకొనుడి; అచ్చట చిమ్మెటయైనను, తుప్పైనను దానిని తినివేయదు, దొంగలు కన్నమువేసి దొంగిలరు.',
        'but lay up for yourselves treasures in heaven, where neither moth nor rust consume, and where thieves don''t break through and steal;',
        'paralōkamaṃdu mīkoraku dhanamunu samakūrcukonuḍi; accaṭa cimmeṭayainanu, tuppainanu dānini tinivēyadu, doṃgalu kannamuvēsi doṃgilaru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'పరలోకమందు', 'paralōkamaṃdu', 'in heaven', 1),
        (verse_id_var, 2, 'మీకొరకు', 'mīkoraku', 'for yourselves', 2),
        (verse_id_var, 3, 'ధనమును', 'dhanamunu', 'treasures', 3),
        (verse_id_var, 4, 'సమకూర్చుకొనుడి;', 'samakūrcukonuḍi;', 'lay up;', 4),
        (verse_id_var, 5, 'అచ్చట', 'accaṭa', 'where', 5),
        (verse_id_var, 6, 'చిమ్మెటయైనను,', 'cimmeṭayainanu,', 'neither moth,', 6),
        (verse_id_var, 7, 'తుప్పైనను', 'tuppainanu', 'nor rust', 7),
        (verse_id_var, 8, 'దానిని', 'dānini', 'them', 8),
        (verse_id_var, 9, 'తినివేయదు,', 'tinivēyadu,', 'consume,', 9),
        (verse_id_var, 10, 'దొంగలు', 'doṃgalu', 'thieves', 10),
        (verse_id_var, 11, 'కన్నమువేసి', 'kannamuvēsi', 'break through', 11),
        (verse_id_var, 12, 'దొంగిలరు.', 'doṃgilaru.', 'don''t and steal.', 12);

    -- VERSE 21
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 21,
        'నీ ధనమెక్కడ నుండునో అక్కడనే నీ హృదయము ఉండును.',
        'for where your treasure is, there your heart will be also.',
        'nī dhanamekkaḍa nuṃḍunō akkaḍanē nī hr̥dayamu uṃḍunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 2, 'ధనమెక్కడ', 'dhanamekkaḍa', 'where treasure', 2),
        (verse_id_var, 3, 'నుండునో', 'nuṃḍunō', 'is', 3),
        (verse_id_var, 4, 'అక్కడనే', 'akkaḍanē', 'there', 4),
        (verse_id_var, 5, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 6, 'హృదయము', 'hr̥dayamu', 'heart', 5),
        (verse_id_var, 7, 'ఉండును.', 'uṃḍunu.', 'will be also.', 6);

    -- VERSE 22
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 22,
        'దేహమునకు దీపము కన్నే. నీ కన్ను తేటగా ఉంటే నీ దేహమంతయు వెలుగుమయమై యుండును;',
        '"The lamp of the body is the eye. If therefore your eye is sound, your whole body will be full of light.',
        'dēhamunaku dīpamu kannē. nī kannu tēṭagā uṃṭē nī dēhamaṃtayu velugumayamai yuṃḍunu;')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'దేహమునకు', 'dēhamunaku', 'of the body', 1),
        (verse_id_var, 2, 'దీపము', 'dīpamu', 'the lamp', 2),
        (verse_id_var, 3, 'కన్నే.', 'kannē.', 'is the eye.', 3),
        (verse_id_var, 4, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 5, 'కన్ను', 'kannu', 'eye', 5),
        (verse_id_var, 6, 'తేటగా', 'tēṭagā', 'sound', 6),
        (verse_id_var, 7, 'ఉంటే', 'uṃṭē', 'is if', 7),
        (verse_id_var, 8, 'నీ', 'nī', 'your', 4),
        (verse_id_var, 9, 'దేహమంతయు', 'dēhamaṃtayu', 'whole body', 8),
        (verse_id_var, 10, 'వెలుగుమయమై', 'velugumayamai', 'full of light', 9),
        (verse_id_var, 11, 'యుండును;', 'yuṃḍunu;', 'will be;', 10);

    -- VERSE 23
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 23,
        'నీ కన్ను చెడినదైతే నీ దేహమంతయు చీకటిమయమై యుండును; నీలోనున్న వెలుగు చీకటియై యుండిన యెడల ఆ చీకటి యెంత గొప్పదైయుండును!',
        'But if your eye is evil, your whole body will be full of darkness. If therefore the light that is in you is darkness, how great is the darkness!',
        'nī kannu ceḍinadaitē nī dēhamaṃtayu cīkaṭimayamai yuṃḍunu; nīlōnunna velugu cīkaṭiyai yuṃḍina yeḍala ā cīkaṭi yeṃta goppadaiyuṃḍunu!')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 2, 'కన్ను', 'kannu', 'eye', 2),
        (verse_id_var, 3, 'చెడినదైతే', 'ceḍinadaitē', 'is evil if', 3),
        (verse_id_var, 4, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 5, 'దేహమంతయు', 'dēhamaṃtayu', 'whole body', 4),
        (verse_id_var, 6, 'చీకటిమయమై', 'cīkaṭimayamai', 'full of darkness', 5),
        (verse_id_var, 7, 'యుండును;', 'yuṃḍunu;', 'will be;', 6),
        (verse_id_var, 8, 'నీలోనున్న', 'nīlōnunna', 'is in you', 7),
        (verse_id_var, 9, 'వెలుగు', 'velugu', 'the light', 8),
        (verse_id_var, 10, 'చీకటియై', 'cīkaṭiyai', 'is darkness', 9),
        (verse_id_var, 11, 'యుండిన', 'yuṃḍina', 'that', 10),
        (verse_id_var, 12, 'యెడల', 'yeḍala', 'if', 11),
        (verse_id_var, 13, 'ఆ', 'ā', 'the', 12),
        (verse_id_var, 14, 'చీకటి', 'cīkaṭi', 'darkness', 13),
        (verse_id_var, 15, 'యెంత', 'yeṃta', 'how', 14),
        (verse_id_var, 16, 'గొప్పదైయుండును!', 'goppadaiyuṃḍunu!', 'great is!', 15);

    -- VERSE 24
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 24,
        'ఏ సేవకుడును ఇద్దరు యజమానులకు దాసుడుగా ఉండనేరడు; వాడు ఒకని ద్వేషించి యొకని ప్రేమించును, లేదా యొకని హత్తుకొని యొకని తృణీకరించును. మీరు దేవునికిని సిరికిని దాసులుగా ఉండనేరరు.',
        '"No one can serve two masters, for either he will hate the one and love the other; or else he will be devoted to one and despise the other. You can''t serve both God and Mammon.',
        'ē sēvakuḍunu iddaru yajamānulaku dāsuḍugā uṃḍanēraḍu; vāḍu okani dvēṣiñci yokani prēmiñcunu, lēdā yokani hattukoni yokani tr̥ṇīkariñcunu. mīru dēvunikini sirikini dāsulugā uṃḍanēraru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఏ', 'ē', 'no', 1),
        (verse_id_var, 2, 'సేవకుడును', 'sēvakuḍunu', 'one', 2),
        (verse_id_var, 3, 'ఇద్దరు', 'iddaru', 'two', 3),
        (verse_id_var, 4, 'యజమానులకు', 'yajamānulaku', 'masters', 4),
        (verse_id_var, 5, 'దాసుడుగా', 'dāsuḍugā', 'serve as slave', 5),
        (verse_id_var, 6, 'ఉండనేరడు;', 'uṃḍanēraḍu;', 'can;', 6),
        (verse_id_var, 7, 'వాడు', 'vāḍu', 'he', 7),
        (verse_id_var, 8, 'ఒకని', 'okani', 'the one', 8),
        (verse_id_var, 9, 'ద్వేషించి', 'dvēṣiñci', 'will hate', 9),
        (verse_id_var, 10, 'యొకని', 'yokani', 'the other', 10),
        (verse_id_var, 11, 'ప్రేమించును,', 'prēmiñcunu,', 'and love,', 11),
        (verse_id_var, 12, 'లేదా', 'lēdā', 'or else', 12),
        (verse_id_var, 13, 'యొకని', 'yokani', 'one', 8),
        (verse_id_var, 14, 'హత్తుకొని', 'hattukoni', 'will be devoted', 13),
        (verse_id_var, 15, 'యొకని', 'yokani', 'the other', 10),
        (verse_id_var, 16, 'తృణీకరించును.', 'tr̥ṇīkariñcunu.', 'and despise.', 14),
        (verse_id_var, 17, 'మీరు', 'mīru', 'you', 15),
        (verse_id_var, 18, 'దేవునికిని', 'dēvunikini', 'God', 16),
        (verse_id_var, 19, 'సిరికిని', 'sirikini', 'and Mammon', 17),
        (verse_id_var, 20, 'దాసులుగా', 'dāsulugā', 'serve both', 5),
        (verse_id_var, 21, 'ఉండనేరరు.', 'uṃḍanēraru.', 'can''t.', 18);

    -- VERSE 25
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 25,
        'అందువలన—ఏమి తిందుమో ఏమి త్రాగుదుమో అని మీ ప్రాణమునుగూర్చియైనను, ఏమి ధరించుకొందుమో అని మీ దేహమునుగూర్చియైనను చింతింపకుడని మీతో చెప్పుచున్నాను. ఆహారముకంటె ప్రాణమును, వస్త్రముకంటె దేహమును గొప్పవి కావా?',
        'Therefore I tell you, don''t be anxious for your life: what you will eat, or what you will drink; nor yet for your body, what you will wear. Isn''t life more than food, and the body more than clothing?',
        'aṃduvalana—ēmi tiṃdumō ēmi trāgudumō ani mī prāṇamunugūrciyainanu, ēmi dhariñcukoṃdumō ani mī dēhamunugūrciyainanu ciṃtiṃpakuḍani mītō ceppucunnānu. āhāramukaṃṭe prāṇamunu, vastramukaṃṭe dēhamunu goppavi kāvā?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అందువలన—', 'aṃduvalana—', 'therefore—', 1),
        (verse_id_var, 2, 'ఏమి', 'ēmi', 'what', 2),
        (verse_id_var, 3, 'తిందుమో', 'tiṃdumō', 'will eat', 3),
        (verse_id_var, 4, 'ఏమి', 'ēmi', 'what', 2),
        (verse_id_var, 5, 'త్రాగుదుమో', 'trāgudumō', 'will drink', 4),
        (verse_id_var, 6, 'అని', 'ani', 'or', 5),
        (verse_id_var, 7, 'మీ', 'mī', 'your', 6),
        (verse_id_var, 8, 'ప్రాణమునుగూర్చియైనను,', 'prāṇamunugūrciyainanu,', 'for life,', 7),
        (verse_id_var, 9, 'ఏమి', 'ēmi', 'what', 2),
        (verse_id_var, 10, 'ధరించుకొందుమో', 'dhariñcukoṃdumō', 'will wear', 8),
        (verse_id_var, 11, 'అని', 'ani', 'nor yet', 9),
        (verse_id_var, 12, 'మీ', 'mī', 'your', 6),
        (verse_id_var, 13, 'దేహమునుగూర్చియైనను', 'dēhamunugūrciyainanu', 'for body', 10),
        (verse_id_var, 14, 'చింతింపకుడని', 'ciṃtiṃpakuḍani', 'don''t be anxious', 11),
        (verse_id_var, 15, 'మీతో', 'mītō', 'you', 12),
        (verse_id_var, 16, 'చెప్పుచున్నాను.', 'ceppucunnānu.', 'I tell.', 13),
        (verse_id_var, 17, 'ఆహారముకంటె', 'āhāramukaṃṭe', 'than food', 14),
        (verse_id_var, 18, 'ప్రాణమును,', 'prāṇamunu,', 'life,', 7),
        (verse_id_var, 19, 'వస్త్రముకంటె', 'vastramukaṃṭe', 'than clothing', 15),
        (verse_id_var, 20, 'దేహమును', 'dēhamunu', 'the body', 10),
        (verse_id_var, 21, 'గొప్పవి', 'goppavi', 'more', 16),
        (verse_id_var, 22, 'కావా?', 'kāvā?', 'isn''t?', 17);

    -- VERSE 26
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 26,
        'ఆకాశ పక్షులను చూడుడి; అవి విత్తవు, కోయవు, కొట్లలో కూర్చుకొనవు; అయినను మీ పరలోకపు తండ్రి వాటిని పోషించుచున్నాడు; మీరు వాటికంటె బహు శ్రేష్ఠులు కారా?',
        'See the birds of the sky, that they don''t sow, neither do they reap, nor gather into barns. Your heavenly Father feeds them. Aren''t you of much more value than they?',
        'ākāśa pakṣulanu cūḍuḍi; avi vittavu, kōyavu, koṭlalō kūrcukonavu; ayinanu mī paralōkapu taṃḍri vāṭini pōṣiñcucunnāḍu; mīru vāṭikaṃṭe bahu śrēṣṭhulu kārā?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆకాశ', 'ākāśa', 'of the sky', 1),
        (verse_id_var, 2, 'పక్షులను', 'pakṣulanu', 'the birds', 2),
        (verse_id_var, 3, 'చూడుడి;', 'cūḍuḍi;', 'see;', 3),
        (verse_id_var, 4, 'అవి', 'avi', 'they', 4),
        (verse_id_var, 5, 'విత్తవు,', 'vittavu,', 'don''t sow,', 5),
        (verse_id_var, 6, 'కోయవు,', 'kōyavu,', 'neither reap,', 6),
        (verse_id_var, 7, 'కొట్లలో', 'koṭlalō', 'into barns', 7),
        (verse_id_var, 8, 'కూర్చుకొనవు;', 'kūrcukonavu;', 'nor gather;', 8),
        (verse_id_var, 9, 'అయినను', 'ayinanu', 'yet', 9),
        (verse_id_var, 10, 'మీ', 'mī', 'your', 10),
        (verse_id_var, 11, 'పరలోకపు', 'paralōkapu', 'heavenly', 11),
        (verse_id_var, 12, 'తండ్రి', 'taṃḍri', 'Father', 12),
        (verse_id_var, 13, 'వాటిని', 'vāṭini', 'them', 13),
        (verse_id_var, 14, 'పోషించుచున్నాడు;', 'pōṣiñcucunnāḍu;', 'feeds;', 14),
        (verse_id_var, 15, 'మీరు', 'mīru', 'you', 15),
        (verse_id_var, 16, 'వాటికంటె', 'vāṭikaṃṭe', 'than they', 16),
        (verse_id_var, 17, 'బహు', 'bahu', 'much more', 17),
        (verse_id_var, 18, 'శ్రేష్ఠులు', 'śrēṣṭhulu', 'of value', 18),
        (verse_id_var, 19, 'కారా?', 'kārā?', 'aren''t?', 19);

    -- VERSE 27
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 27,
        'మీలో ఎవడు చింతించుటవలన తన యెత్తు మూరెడు ఎక్కువ చేసికొనగలడు?',
        '"Which of you, by being anxious, can add one moment to his lifespan?',
        'mīlō evaḍu ciṃtiñcuṭavalana tana yettu mūreḍu ekkuva cēsikonagalaḍu?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మీలో', 'mīlō', 'of you', 1),
        (verse_id_var, 2, 'ఎవడు', 'evaḍu', 'which', 2),
        (verse_id_var, 3, 'చింతించుటవలన', 'ciṃtiñcuṭavalana', 'by being anxious', 3),
        (verse_id_var, 4, 'తన', 'tana', 'his', 4),
        (verse_id_var, 5, 'యెత్తు', 'yettu', 'lifespan', 5),
        (verse_id_var, 6, 'మూరెడు', 'mūreḍu', 'one moment', 6),
        (verse_id_var, 7, 'ఎక్కువ', 'ekkuva', 'add', 7),
        (verse_id_var, 8, 'చేసికొనగలడు?', 'cēsikonagalaḍu?', 'can to?', 8);

    -- VERSE 28
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 28,
        'వస్త్రములనుగూర్చి మీరు చింతింప నేల? అడవిపువ్వులు ఏలాగు ఎదుగుచున్నవో ఆలోచించుడి. అవి కష్టపడవు, ఒడకవు;',
        'Why are you anxious about clothing? Consider the lilies of the field, how they grow. They don''t toil, neither do they spin,',
        'vastramulanugūrci mīru ciṃtiṃpa nēla? aḍavipuvvulu ēlāgu eḍugucunnavō ālōciñcuḍi. avi kaṣṭapaḍavu, oḍakavu;')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'వస్త్రములనుగూర్చి', 'vastramulanugūrci', 'about clothing', 1),
        (verse_id_var, 2, 'మీరు', 'mīru', 'you', 2),
        (verse_id_var, 3, 'చింతింప', 'ciṃtiṃpa', 'are anxious', 3),
        (verse_id_var, 4, 'నేల?', 'nēla?', 'why?', 4),
        (verse_id_var, 5, 'అడవిపువ్వులు', 'aḍavipuvvulu', 'the lilies of the field', 5),
        (verse_id_var, 6, 'ఏలాగు', 'ēlāgu', 'how', 6),
        (verse_id_var, 7, 'ఎదుగుచున్నవో', 'eḍugucunnavō', 'they grow', 7),
        (verse_id_var, 8, 'ఆలోచించుడి.', 'ālōciñcuḍi.', 'consider.', 8),
        (verse_id_var, 9, 'అవి', 'avi', 'they', 9),
        (verse_id_var, 10, 'కష్టపడవు,', 'kaṣṭapaḍavu,', 'don''t toil,', 10),
        (verse_id_var, 11, 'ఒడకవు;', 'oḍakavu;', 'neither spin;', 11);

    -- VERSE 29
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 29,
        'అయినను తన సమస్త వైభవముతో కూడిన సొలొమోను సహితము వీటిలో నొకదానివలెనైనను అలంకరింపబడలేదని మీతో చెప్పుచున్నాను.',
        'yet I tell you that even Solomon in all his glory was not dressed like one of these.',
        'ayinanu tana samasta vaibhavamutō kūḍina solomōnu sahitamu vīṭilō nokadānivalenainanu alaṃkariṃpabaḍalēdani mītō ceppucunnānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అయినను', 'ayinanu', 'yet', 1),
        (verse_id_var, 2, 'తన', 'tana', 'his', 2),
        (verse_id_var, 3, 'సమస్త', 'samasta', 'all', 3),
        (verse_id_var, 4, 'వైభవముతో', 'vaibhavamutō', 'glory', 4),
        (verse_id_var, 5, 'కూడిన', 'kūḍina', 'in', 5),
        (verse_id_var, 6, 'సొలొమోను', 'solomōnu', 'Solomon', 6),
        (verse_id_var, 7, 'సహితము', 'sahitamu', 'even', 7),
        (verse_id_var, 8, 'వీటిలో', 'vīṭilō', 'of these', 8),
        (verse_id_var, 9, 'నొకదానివలెనైనను', 'nokadānivalenainanu', 'like one', 9),
        (verse_id_var, 10, 'అలంకరింపబడలేదని', 'alaṃkariṃpabaḍalēdani', 'was not dressed', 10),
        (verse_id_var, 11, 'మీతో', 'mītō', 'you', 11),
        (verse_id_var, 12, 'చెప్పుచున్నాను.', 'ceppucunnānu.', 'I tell.', 12);

    -- VERSE 30
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 30,
        'నేడుండి, రేపు పొయిలో వేయబడు అడవి గడ్డిని దేవుడీలాగు అలంకరించినయెడల, అల్పవిశ్వాసులారా, మీకు మరి నిశ్చయముగా వస్త్రములు ధరింపజేయడా?',
        'But if God so clothes the grass of the field, which today exists, and tomorrow is thrown into the oven, won''t he much more clothe you, you of little faith?',
        'nēḍuṃḍi, rēpu poyilō vēyabaḍu aḍavi gaḍḍini dēvuḍīlāgu alaṃkariñcinayeḍala, alpaviśvāsulārā, mīku mari niścayamugā vastramulu dhariṃpajēyaḍā?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నేడుండి,', 'nēḍuṃḍi,', 'today exists,', 1),
        (verse_id_var, 2, 'రేపు', 'rēpu', 'tomorrow', 2),
        (verse_id_var, 3, 'పొయిలో', 'poyilō', 'into the oven', 3),
        (verse_id_var, 4, 'వేయబడు', 'vēyabaḍu', 'is thrown', 4),
        (verse_id_var, 5, 'అడవి', 'aḍavi', 'of the field', 5),
        (verse_id_var, 6, 'గడ్డిని', 'gaḍḍini', 'the grass', 6),
        (verse_id_var, 7, 'దేవుడీలాగు', 'dēvuḍīlāgu', 'God so', 7),
        (verse_id_var, 8, 'అలంకరించినయెడల,', 'alaṃkariñcinayeḍala,', 'if clothes,', 8),
        (verse_id_var, 9, 'అల్పవిశ్వాసులారా,', 'alpaviśvāsulārā,', 'you of little faith,', 9),
        (verse_id_var, 10, 'మీకు', 'mīku', 'you', 10),
        (verse_id_var, 11, 'మరి', 'mari', 'much more', 11),
        (verse_id_var, 12, 'నిశ్చయముగా', 'niścayamugā', 'won''t he', 12),
        (verse_id_var, 13, 'వస్త్రములు', 'vastramulu', 'clothing', 13),
        (verse_id_var, 14, 'ధరింపజేయడా?', 'dhariṃpajēyaḍā?', 'clothe?', 14);

    -- VERSE 31
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 31,
        'కాబట్టి—ఏమి తిందుమో ఏమి త్రాగుదుమో ఏమి ధరించుకొందుమో అని చింతింపకుడి;',
        '"Therefore don''t be anxious, saying, ''What will we eat?'', ''What will we drink?'' or, ''With what will we be clothed?''',
        'kābaṭṭi—ēmi tiṃdumō ēmi trāgudumō ēmi dhariñcukoṃdumō ani ciṃtiṃpakuḍi;')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కాబట్టి—', 'kābaṭṭi—', 'therefore—', 1),
        (verse_id_var, 2, 'ఏమి', 'ēmi', 'what', 2),
        (verse_id_var, 3, 'తిందుమో', 'tiṃdumō', 'will we eat', 3),
        (verse_id_var, 4, 'ఏమి', 'ēmi', 'what', 2),
        (verse_id_var, 5, 'త్రాగుదుమో', 'trāgudumō', 'will we drink', 4),
        (verse_id_var, 6, 'ఏమి', 'ēmi', 'with what', 5),
        (verse_id_var, 7, 'ధరించుకొందుమో', 'dhariñcukoṃdumō', 'will we be clothed', 6),
        (verse_id_var, 8, 'అని', 'ani', 'saying', 7),
        (verse_id_var, 9, 'చింతింపకుడి;', 'ciṃtiṃpakuḍi;', 'don''t be anxious;', 8);

    -- VERSE 32
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 32,
        'అన్యజనులు వీటన్నిటి విషయమై విచారింతురు. ఇవన్నియు మీకు కావలెనని మీ పరలోకపు తండ్రికి తెలియును.',
        'For the Gentiles seek after all these things, for your heavenly Father knows that you need all these things.',
        'anyajanulu vīṭanniṭi viṣayamai vicāriṃturu. ivanniyu mīku kāvalenani mī paralōkapu taṃḍriki teliyunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అన్యజనులు', 'anyajanulu', 'the Gentiles', 1),
        (verse_id_var, 2, 'వీటన్నిటి', 'vīṭanniṭi', 'all these things', 2),
        (verse_id_var, 3, 'విషయమై', 'viṣayamai', 'after', 3),
        (verse_id_var, 4, 'విచారింతురు.', 'vicāriṃturu.', 'seek.', 4),
        (verse_id_var, 5, 'ఇవన్నియు', 'ivanniyu', 'all these things', 2),
        (verse_id_var, 6, 'మీకు', 'mīku', 'you', 5),
        (verse_id_var, 7, 'కావలెనని', 'kāvalenani', 'need', 6),
        (verse_id_var, 8, 'మీ', 'mī', 'your', 7),
        (verse_id_var, 9, 'పరలోకపు', 'paralōkapu', 'heavenly', 8),
        (verse_id_var, 10, 'తండ్రికి', 'taṃḍriki', 'Father', 9),
        (verse_id_var, 11, 'తెలియును.', 'teliyunu.', 'knows.', 10);

    -- VERSE 33
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 33,
        'కాబట్టి మీరు ఆయన రాజ్యమును నీతిని మొదట వెదకుడి; అప్పుడవన్నియు మీకనుగ్రహింపబడును.',
        'But seek first God''s Kingdom, and his righteousness; and all these things will be given to you as well.',
        'kābaṭṭi mīru āyana rājyamunu nītini modaṭa vedakuḍi; appuḍavanniyu mīkanugrahiṃpabaḍunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కాబట్టి', 'kābaṭṭi', 'but', 1),
        (verse_id_var, 2, 'మీరు', 'mīru', 'you', 2),
        (verse_id_var, 3, 'ఆయన', 'āyana', 'God''s', 3),
        (verse_id_var, 4, 'రాజ్యమును', 'rājyamunu', 'Kingdom', 4),
        (verse_id_var, 5, 'నీతిని', 'nītini', 'righteousness', 5),
        (verse_id_var, 6, 'మొదట', 'modaṭa', 'first', 6),
        (verse_id_var, 7, 'వెదకుడి;', 'vedakuḍi;', 'seek;', 7),
        (verse_id_var, 8, 'అప్పుడవన్నియు', 'appuḍavanniyu', 'and all these things', 8),
        (verse_id_var, 9, 'మీకనుగ్రహింపబడును.', 'mīkanugrahiṃpabaḍunu.', 'will be given to you.', 9);

    -- VERSE 34
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 34,
        'రేపటినిగూర్చి చింతింపకుడి; రేపటి దినము దాని సంగతులనుగూర్చి చింతించును; ఏ దినపు కీడు ఆ దినమునకు చాలును.',
        'Therefore don''t be anxious for tomorrow, for tomorrow will be anxious for itself. Each day''s own evil is sufficient.',
        'rēpaṭinigūrci ciṃtiṃpakuḍi; rēpaṭi dinamu dāni saṃgatulanugūrci ciṃtiñcunu; ē dinapu kīḍu ā dinamunaku cālunu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'రేపటినిగూర్చి', 'rēpaṭinigūrci', 'for tomorrow', 1),
        (verse_id_var, 2, 'చింతింపకుడి;', 'ciṃtiṃpakuḍi;', 'don''t be anxious;', 2),
        (verse_id_var, 3, 'రేపటి', 'rēpaṭi', 'tomorrow', 1),
        (verse_id_var, 4, 'దినము', 'dinamu', 'will', 3),
        (verse_id_var, 5, 'దాని', 'dāni', 'for itself', 4),
        (verse_id_var, 6, 'సంగతులనుగూర్చి', 'saṃgatulanugūrci', 'about its things', 5),
        (verse_id_var, 7, 'చింతించును;', 'ciṃtiñcunu;', 'be anxious;', 2),
        (verse_id_var, 8, 'ఏ', 'ē', 'each', 6),
        (verse_id_var, 9, 'దినపు', 'dinapu', 'day''s', 7),
        (verse_id_var, 10, 'కీడు', 'kīḍu', 'own evil', 8),
        (verse_id_var, 11, 'ఆ', 'ā', 'is', 9),
        (verse_id_var, 12, 'దినమునకు', 'dinamunaku', 'for the day', 10),
        (verse_id_var, 13, 'చాలును.', 'cālunu.', 'sufficient.', 11);
END $$;
