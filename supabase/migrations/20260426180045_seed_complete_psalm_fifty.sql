/*
  # Seed complete Psalm 50 (the Mighty One speaks)

  1. Content additions
    - Creates chapter row for Psalms 50 (book_id=19, chapter_number=50) if absent.
    - Seeds all 23 verses of Psalm 50 with BSI-style Telugu, WEB English, ISO-15919 transliteration.
    - Seeds aligned verse_tokens with per-verse alignment_group integers so words colour-link across languages.

  2. Strategy
    - Idempotent: chapter and verses upserted by natural keys; tokens cleared and re-inserted per verse.
    - No schema changes; data only.

  3. Notes
    - Asaph''s psalm: God as Judge calling heaven and earth, true worship vs. empty ritual.
*/

DO $$
DECLARE
    chapter_id_var bigint;
    verse_id_var bigint;
BEGIN
    INSERT INTO chapters (book_id, chapter_number)
    VALUES (19, 50)
    ON CONFLICT (book_id, chapter_number) DO UPDATE SET chapter_number = EXCLUDED.chapter_number
    RETURNING id INTO chapter_id_var;

    -- VERSE 1
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 1,
        'దేవాదిదేవుడైన యెహోవా మాటలాడుచున్నాడు; సూర్యోదయము మొదలుకొని సూర్యాస్తమయము వరకు ఆయన భూమిని పిలుచుచున్నాడు.',
        'The Mighty One, God, Yahweh, speaks, and calls the earth from sunrise to sunset.',
        'dēvādidēvuḍaina yehōvā māṭalāḍucunnāḍu; sūryōdayamu modalukoni sūryāstamayamu varaku āyana bhūmini pilucucunnāḍu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'దేవాదిదేవుడైన', 'dēvādidēvuḍaina', 'the Mighty One, God', 1),
        (verse_id_var, 2, 'యెహోవా', 'yehōvā', 'Yahweh', 2),
        (verse_id_var, 3, 'మాటలాడుచున్నాడు;', 'māṭalāḍucunnāḍu;', 'speaks;', 3),
        (verse_id_var, 4, 'సూర్యోదయము', 'sūryōdayamu', 'sunrise', 4),
        (verse_id_var, 5, 'మొదలుకొని', 'modalukoni', 'from', 5),
        (verse_id_var, 6, 'సూర్యాస్తమయము', 'sūryāstamayamu', 'sunset', 6),
        (verse_id_var, 7, 'వరకు', 'varaku', 'to', 7),
        (verse_id_var, 8, 'ఆయన', 'āyana', 'he', 8),
        (verse_id_var, 9, 'భూమిని', 'bhūmini', 'the earth', 9),
        (verse_id_var, 10, 'పిలుచుచున్నాడు.', 'pilucucunnāḍu.', 'calls.', 10);

    -- VERSE 2
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 2,
        'సౌందర్య పరిపూర్ణమైన సీయోనులోనుండి దేవుడు ప్రకాశించుచున్నాడు.',
        'Out of Zion, the perfection of beauty, God shines forth.',
        'sauṃdarya paripūrṇamaina sīyōnulōnuṃḍi dēvuḍu prakāśiñcucunnāḍu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'సౌందర్య', 'sauṃdarya', 'of beauty', 1),
        (verse_id_var, 2, 'పరిపూర్ణమైన', 'paripūrṇamaina', 'the perfection', 2),
        (verse_id_var, 3, 'సీయోనులోనుండి', 'sīyōnulōnuṃḍi', 'out of Zion', 3),
        (verse_id_var, 4, 'దేవుడు', 'dēvuḍu', 'God', 4),
        (verse_id_var, 5, 'ప్రకాశించుచున్నాడు.', 'prakāśiñcucunnāḍu.', 'shines forth.', 5);

    -- VERSE 3
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 3,
        'మన దేవుడు వేంచేయుచున్నాడు ఆయన మౌనముగా ఉండడు; ఆయన ముందర అగ్ని దహించుచున్నది; ఆయన చుట్టు ప్రచండమైన గాలి విసరుచున్నది.',
        'Our God comes, and does not keep silent. A fire devours before him. It is very stormy around him.',
        'mana dēvuḍu vēñcēyucunnāḍu āyana maunamugā uṃḍaḍu; āyana muṃdara agni dahiñcucunnadi; āyana cuṭṭu pracaṃḍamaina gāli visarucunnadi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'మన', 'mana', 'our', 1),
        (verse_id_var, 2, 'దేవుడు', 'dēvuḍu', 'God', 2),
        (verse_id_var, 3, 'వేంచేయుచున్నాడు', 'vēñcēyucunnāḍu', 'comes', 3),
        (verse_id_var, 4, 'ఆయన', 'āyana', 'he', 4),
        (verse_id_var, 5, 'మౌనముగా', 'maunamugā', 'silent', 5),
        (verse_id_var, 6, 'ఉండడు;', 'uṃḍaḍu;', 'does not keep;', 6),
        (verse_id_var, 7, 'ఆయన', 'āyana', 'him', 4),
        (verse_id_var, 8, 'ముందర', 'muṃdara', 'before', 7),
        (verse_id_var, 9, 'అగ్ని', 'agni', 'a fire', 8),
        (verse_id_var, 10, 'దహించుచున్నది;', 'dahiñcucunnadi;', 'devours;', 9),
        (verse_id_var, 11, 'ఆయన', 'āyana', 'him', 4),
        (verse_id_var, 12, 'చుట్టు', 'cuṭṭu', 'around', 10),
        (verse_id_var, 13, 'ప్రచండమైన', 'pracaṃḍamaina', 'very stormy', 11),
        (verse_id_var, 14, 'గాలి', 'gāli', 'wind', 12),
        (verse_id_var, 15, 'విసరుచున్నది.', 'visarucunnadi.', 'blows.', 13);

    -- VERSE 4
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 4,
        'తన ప్రజలకు తీర్పుతీర్చుటకై ఆయన పైనున్న ఆకాశమునకును భూమికిని ప్రకటనచేయుచున్నాడు.',
        'He calls to the heavens above, to the earth, that he may judge his people:',
        'tana prajalaku tīrputīrcuṭakai āyana painunna ākāśamunakunu bhūmikini prakaṭanacēyucunnāḍu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'తన', 'tana', 'his', 1),
        (verse_id_var, 2, 'ప్రజలకు', 'prajalaku', 'people', 2),
        (verse_id_var, 3, 'తీర్పుతీర్చుటకై', 'tīrputīrcuṭakai', 'that he may judge', 3),
        (verse_id_var, 4, 'ఆయన', 'āyana', 'he', 4),
        (verse_id_var, 5, 'పైనున్న', 'painunna', 'above', 5),
        (verse_id_var, 6, 'ఆకాశమునకును', 'ākāśamunakunu', 'to the heavens', 6),
        (verse_id_var, 7, 'భూమికిని', 'bhūmikini', 'to the earth', 7),
        (verse_id_var, 8, 'ప్రకటనచేయుచున్నాడు.', 'prakaṭanacēyucunnāḍu.', 'calls.', 8);

    -- VERSE 5
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 5,
        'బలి అర్పించుటవలన నాతో నిబంధనచేసికొనిన నా భక్తులను నాయొద్దకు సమకూర్చుడని ఆయన ఆజ్ఞ ఇచ్చుచున్నాడు.',
        '"Gather my saints together to me, those who have made a covenant with me by sacrifice."',
        'bali arpiñcuṭavalana nātō nibaṃdhanacēsikonina nā bhaktulanu nāyoddaku samakūrcuḍani āyana ājña iccucunnāḍu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'బలి', 'bali', 'sacrifice', 1),
        (verse_id_var, 2, 'అర్పించుటవలన', 'arpiñcuṭavalana', 'by', 2),
        (verse_id_var, 3, 'నాతో', 'nātō', 'with me', 3),
        (verse_id_var, 4, 'నిబంధనచేసికొనిన', 'nibaṃdhanacēsikonina', 'who have made a covenant', 4),
        (verse_id_var, 5, 'నా', 'nā', 'my', 5),
        (verse_id_var, 6, 'భక్తులను', 'bhaktulanu', 'saints', 6),
        (verse_id_var, 7, 'నాయొద్దకు', 'nāyoddaku', 'to me', 7),
        (verse_id_var, 8, 'సమకూర్చుడని', 'samakūrcuḍani', 'gather together', 8),
        (verse_id_var, 9, 'ఆయన', 'āyana', 'he', 9),
        (verse_id_var, 10, 'ఆజ్ఞ', 'ājña', 'command', 10),
        (verse_id_var, 11, 'ఇచ్చుచున్నాడు.', 'iccucunnāḍu.', 'gives.', 11);

    -- VERSE 6
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 6,
        'ఆకాశములు ఆయన నీతిని ప్రకటించుచున్నవి దేవుడే న్యాయాధిపతి. (సెలా)',
        'The heavens shall declare his righteousness, for God himself is judge. Selah.',
        'ākāśamulu āyana nītini prakaṭiñcucunnavi dēvuḍē nyāyādhipati. (selā)')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆకాశములు', 'ākāśamulu', 'the heavens', 1),
        (verse_id_var, 2, 'ఆయన', 'āyana', 'his', 2),
        (verse_id_var, 3, 'నీతిని', 'nītini', 'righteousness', 3),
        (verse_id_var, 4, 'ప్రకటించుచున్నవి', 'prakaṭiñcucunnavi', 'shall declare', 4),
        (verse_id_var, 5, 'దేవుడే', 'dēvuḍē', 'God himself', 5),
        (verse_id_var, 6, 'న్యాయాధిపతి.', 'nyāyādhipati.', 'is judge.', 6),
        (verse_id_var, 7, '(సెలా)', '(selā)', 'Selah.', 7);

    -- VERSE 7
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 7,
        'నా జనులారా, ఆలకించుడి నేను మాటలాడుచున్నాను; ఇశ్రాయేలూ, నేను నీమీద సాక్ష్యము చెప్పుచున్నాను; నేను దేవుడను నీ దేవుడను.',
        '"Hear, my people, and I will speak; Israel, I will testify against you. I am God, your God.',
        'nā janulārā, ālakiñcuḍi nēnu māṭalāḍucunnānu; iśrāyēlū, nēnu nīmīda sākṣyamu ceppucunnānu; nēnu dēvuḍanu nī dēvuḍanu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నా', 'nā', 'my', 1),
        (verse_id_var, 2, 'జనులారా,', 'janulārā,', 'people,', 2),
        (verse_id_var, 3, 'ఆలకించుడి', 'ālakiñcuḍi', 'hear', 3),
        (verse_id_var, 4, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 5, 'మాటలాడుచున్నాను;', 'māṭalāḍucunnānu;', 'will speak;', 5),
        (verse_id_var, 6, 'ఇశ్రాయేలూ,', 'iśrāyēlū,', 'Israel,', 6),
        (verse_id_var, 7, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 8, 'నీమీద', 'nīmīda', 'against you', 7),
        (verse_id_var, 9, 'సాక్ష్యము', 'sākṣyamu', 'testimony', 8),
        (verse_id_var, 10, 'చెప్పుచున్నాను;', 'ceppucunnānu;', 'will give;', 9),
        (verse_id_var, 11, 'నేను', 'nēnu', 'I am', 4),
        (verse_id_var, 12, 'దేవుడను', 'dēvuḍanu', 'God', 10),
        (verse_id_var, 13, 'నీ', 'nī', 'your', 11),
        (verse_id_var, 14, 'దేవుడను.', 'dēvuḍanu.', 'God.', 10);

    -- VERSE 8
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 8,
        'నీ బలులనుగూర్చి నేను నీతో వాదించుట లేదు నీ దహనబలులు ఎల్లప్పుడు నాయెదుట ఉన్నవి.',
        'I don''t rebuke you for your sacrifices. Your burnt offerings are continually before me.',
        'nī balulanugūrci nēnu nītō vādiñcuṭa lēdu nī dahanabalulu ellappuḍu nāyeduṭa unnavi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 2, 'బలులనుగూర్చి', 'balulanugūrci', 'for sacrifices', 2),
        (verse_id_var, 3, 'నేను', 'nēnu', 'I', 3),
        (verse_id_var, 4, 'నీతో', 'nītō', 'you', 4),
        (verse_id_var, 5, 'వాదించుట', 'vādiñcuṭa', 'rebuke', 5),
        (verse_id_var, 6, 'లేదు', 'lēdu', 'don''t', 6),
        (verse_id_var, 7, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 8, 'దహనబలులు', 'dahanabalulu', 'burnt offerings', 7),
        (verse_id_var, 9, 'ఎల్లప్పుడు', 'ellappuḍu', 'continually', 8),
        (verse_id_var, 10, 'నాయెదుట', 'nāyeduṭa', 'before me', 9),
        (verse_id_var, 11, 'ఉన్నవి.', 'unnavi.', 'are.', 10);

    -- VERSE 9
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 9,
        'నీ యింటిలోనుండి కోడెలను నీ దొడ్లలోనుండి మేకపోతులను నేను తీసికొనను.',
        'I have no need for a bull from your stall, nor male goats from your pens.',
        'nī yiṃṭilōnuṃḍi kōḍelanu nī doḍlalōnuṃḍi mēkapōtulanu nēnu tīsikonanu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 2, 'యింటిలోనుండి', 'yiṃṭilōnuṃḍi', 'from stall', 2),
        (verse_id_var, 3, 'కోడెలను', 'kōḍelanu', 'a bull', 3),
        (verse_id_var, 4, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 5, 'దొడ్లలోనుండి', 'doḍlalōnuṃḍi', 'from pens', 4),
        (verse_id_var, 6, 'మేకపోతులను', 'mēkapōtulanu', 'male goats', 5),
        (verse_id_var, 7, 'నేను', 'nēnu', 'I', 6),
        (verse_id_var, 8, 'తీసికొనను.', 'tīsikonanu.', 'have no need.', 7);

    -- VERSE 10
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 10,
        'అడవిలోని ప్రతి జంతువును వేయికొండలమీది పశువులును నావే.',
        'For every animal of the forest is mine, and the livestock on a thousand hills.',
        'aḍavilōni prati jaṃtuvunu vēyikoṃḍalamīdi paśuvulunu nāvē.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అడవిలోని', 'aḍavilōni', 'of the forest', 1),
        (verse_id_var, 2, 'ప్రతి', 'prati', 'every', 2),
        (verse_id_var, 3, 'జంతువును', 'jaṃtuvunu', 'animal', 3),
        (verse_id_var, 4, 'వేయికొండలమీది', 'vēyikoṃḍalamīdi', 'on a thousand hills', 4),
        (verse_id_var, 5, 'పశువులును', 'paśuvulunu', 'the livestock', 5),
        (verse_id_var, 6, 'నావే.', 'nāvē.', 'is mine.', 6);

    -- VERSE 11
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 11,
        'కొండపక్షులన్నియు నాకు తెలియును పొలములోని జంతువులు నావే.',
        'I know all the birds of the mountains. The wild animals of the field are mine.',
        'koṃḍapakṣulanniyu nāku teliyunu polamulōni jaṃtuvulu nāvē.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కొండపక్షులన్నియు', 'koṃḍapakṣulanniyu', 'all the birds of the mountains', 1),
        (verse_id_var, 2, 'నాకు', 'nāku', 'I', 2),
        (verse_id_var, 3, 'తెలియును', 'teliyunu', 'know', 3),
        (verse_id_var, 4, 'పొలములోని', 'polamulōni', 'of the field', 4),
        (verse_id_var, 5, 'జంతువులు', 'jaṃtuvulu', 'the wild animals', 5),
        (verse_id_var, 6, 'నావే.', 'nāvē.', 'are mine.', 6);

    -- VERSE 12
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 12,
        'నాకు ఆకలి వేసినయెడల నేను నీతో చెప్పను భూమియు దాని సమృద్ధియు నావే.',
        'If I were hungry, I would not tell you, for the world is mine, and all that is in it.',
        'nāku ākali vēsinayeḍala nēnu nītō ceppanu bhūmiyu dāni samr̥ddhiyu nāvē.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నాకు', 'nāku', 'I', 1),
        (verse_id_var, 2, 'ఆకలి', 'ākali', 'hungry', 2),
        (verse_id_var, 3, 'వేసినయెడల', 'vēsinayeḍala', 'if were', 3),
        (verse_id_var, 4, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 5, 'నీతో', 'nītō', 'you', 4),
        (verse_id_var, 6, 'చెప్పను', 'ceppanu', 'would not tell', 5),
        (verse_id_var, 7, 'భూమియు', 'bhūmiyu', 'the world', 6),
        (verse_id_var, 8, 'దాని', 'dāni', 'in it', 7),
        (verse_id_var, 9, 'సమృద్ధియు', 'samr̥ddhiyu', 'all that is', 8),
        (verse_id_var, 10, 'నావే.', 'nāvē.', 'is mine.', 9);

    -- VERSE 13
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 13,
        'నేను ఎద్దుల మాంసము భక్షించుదునా? మేకపోతుల రక్తము పానము చేయుదునా?',
        'Will I eat the flesh of bulls, or drink the blood of goats?',
        'nēnu eddula māṃsamu bhakṣiñcudunā? mēkapōtula raktamu pānamu cēyudunā?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నేను', 'nēnu', 'I', 1),
        (verse_id_var, 2, 'ఎద్దుల', 'eddula', 'of bulls', 2),
        (verse_id_var, 3, 'మాంసము', 'māṃsamu', 'the flesh', 3),
        (verse_id_var, 4, 'భక్షించుదునా?', 'bhakṣiñcudunā?', 'will eat?', 4),
        (verse_id_var, 5, 'మేకపోతుల', 'mēkapōtula', 'of goats', 5),
        (verse_id_var, 6, 'రక్తము', 'raktamu', 'the blood', 6),
        (verse_id_var, 7, 'పానము', 'pānamu', 'drink', 7),
        (verse_id_var, 8, 'చేయుదునా?', 'cēyudunā?', 'will?', 8);

    -- VERSE 14
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 14,
        'దేవునికి కృతజ్ఞతార్పణము చెల్లించుము సర్వోన్నతునికి నీ మ్రొక్కుబళ్లను చెల్లించుము.',
        'Offer to God the sacrifice of thanksgiving. Pay your vows to the Most High.',
        'dēvuniki kr̥tajñatārpaṇamu cellincumu sarvōnnatuniki nī mrokkubaḷḷanu cellincumu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'దేవునికి', 'dēvuniki', 'to God', 1),
        (verse_id_var, 2, 'కృతజ్ఞతార్పణము', 'kr̥tajñatārpaṇamu', 'the sacrifice of thanksgiving', 2),
        (verse_id_var, 3, 'చెల్లించుము', 'cellincumu', 'offer', 3),
        (verse_id_var, 4, 'సర్వోన్నతునికి', 'sarvōnnatuniki', 'to the Most High', 4),
        (verse_id_var, 5, 'నీ', 'nī', 'your', 5),
        (verse_id_var, 6, 'మ్రొక్కుబళ్లను', 'mrokkubaḷḷanu', 'vows', 6),
        (verse_id_var, 7, 'చెల్లించుము.', 'cellincumu.', 'pay.', 7);

    -- VERSE 15
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 15,
        'ఆపత్కాలమందు నన్ను ప్రార్థించుము నేను నిన్ను విడిపించెదను నీవు నన్ను మహిమపరచెదవు.',
        'Call on me in the day of trouble. I will deliver you, and you will honor me."',
        'āpatkālamaṃdu nannu prārthiñcumu nēnu ninnu viḍipiñcedanu nīvu nannu mahimaparacedavu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆపత్కాలమందు', 'āpatkālamaṃdu', 'in the day of trouble', 1),
        (verse_id_var, 2, 'నన్ను', 'nannu', 'on me', 2),
        (verse_id_var, 3, 'ప్రార్థించుము', 'prārthiñcumu', 'call', 3),
        (verse_id_var, 4, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 5, 'నిన్ను', 'ninnu', 'you', 5),
        (verse_id_var, 6, 'విడిపించెదను', 'viḍipiñcedanu', 'will deliver', 6),
        (verse_id_var, 7, 'నీవు', 'nīvu', 'you', 5),
        (verse_id_var, 8, 'నన్ను', 'nannu', 'me', 2),
        (verse_id_var, 9, 'మహిమపరచెదవు.', 'mahimaparacedavu.', 'will honor.', 7);

    -- VERSE 16
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 16,
        'భక్తిహీనులతో దేవుడిట్లనుచున్నాడు—నీవు నా కట్టడలను వివరించుట ఏల? నా నిబంధన నీవు నీ నోట ఉచ్చరించుట ఏల?',
        'But to the wicked God says, "What right do you have to declare my statutes, that you have taken my covenant on your lips,',
        'bhaktihīnulatō dēvuḍiṭlanucunnāḍu—nīvu nā kaṭṭaḍalanu vivariñcuṭa ēla? nā nibaṃdhana nīvu nī nōṭa uccariñcuṭa ēla?')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'భక్తిహీనులతో', 'bhaktihīnulatō', 'to the wicked', 1),
        (verse_id_var, 2, 'దేవుడిట్లనుచున్నాడు—', 'dēvuḍiṭlanucunnāḍu—', 'God says—', 2),
        (verse_id_var, 3, 'నీవు', 'nīvu', 'you', 3),
        (verse_id_var, 4, 'నా', 'nā', 'my', 4),
        (verse_id_var, 5, 'కట్టడలను', 'kaṭṭaḍalanu', 'statutes', 5),
        (verse_id_var, 6, 'వివరించుట', 'vivariñcuṭa', 'to declare', 6),
        (verse_id_var, 7, 'ఏల?', 'ēla?', 'what right?', 7),
        (verse_id_var, 8, 'నా', 'nā', 'my', 4),
        (verse_id_var, 9, 'నిబంధన', 'nibaṃdhana', 'covenant', 8),
        (verse_id_var, 10, 'నీవు', 'nīvu', 'you', 3),
        (verse_id_var, 11, 'నీ', 'nī', 'your', 9),
        (verse_id_var, 12, 'నోట', 'nōṭa', 'lips', 10),
        (verse_id_var, 13, 'ఉచ్చరించుట', 'uccariñcuṭa', 'have taken on', 11),
        (verse_id_var, 14, 'ఏల?', 'ēla?', 'why?', 7);

    -- VERSE 17
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 17,
        'శిక్షను అంగీకరింపక నా మాటలను నీ వెనుకకు నెట్టివేసితివి;',
        'since you hate instruction, and throw my words behind you?',
        'śikṣanu aṃgīkariṃpaka nā māṭalanu nī venukaku neṭṭivēsitivi;')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'శిక్షను', 'śikṣanu', 'instruction', 1),
        (verse_id_var, 2, 'అంగీకరింపక', 'aṃgīkariṃpaka', 'you hate', 2),
        (verse_id_var, 3, 'నా', 'nā', 'my', 3),
        (verse_id_var, 4, 'మాటలను', 'māṭalanu', 'words', 4),
        (verse_id_var, 5, 'నీ', 'nī', 'you', 5),
        (verse_id_var, 6, 'వెనుకకు', 'venukaku', 'behind', 6),
        (verse_id_var, 7, 'నెట్టివేసితివి;', 'neṭṭivēsitivi;', 'throw;', 7);

    -- VERSE 18
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 18,
        'దొంగను చూచినప్పుడు వానితో నీవు చెలిమిచేయుచున్నావు వ్యభిచారులలో నీవు పాలివాడవైతివి.',
        'When you saw a thief, you consented with him, and have participated with adulterers.',
        'doṃganu cūcinappuḍu vānitō nīvu celimicēyucunnāvu vyabhicārulalō nīvu pālivāḍavaitivi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'దొంగను', 'doṃganu', 'a thief', 1),
        (verse_id_var, 2, 'చూచినప్పుడు', 'cūcinappuḍu', 'when you saw', 2),
        (verse_id_var, 3, 'వానితో', 'vānitō', 'with him', 3),
        (verse_id_var, 4, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 5, 'చెలిమిచేయుచున్నావు', 'celimicēyucunnāvu', 'consented', 5),
        (verse_id_var, 6, 'వ్యభిచారులలో', 'vyabhicārulalō', 'with adulterers', 6),
        (verse_id_var, 7, 'నీవు', 'nīvu', 'you', 4),
        (verse_id_var, 8, 'పాలివాడవైతివి.', 'pālivāḍavaitivi.', 'have participated.', 7);

    -- VERSE 19
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 19,
        'నీవు చెడుతనమునకు నీ నోరు అప్పగించుచున్నావు నీ నాలుక కపటవార్తలు అల్లుచున్నది.',
        '"You give your mouth to evil. Your tongue frames deceit.',
        'nīvu ceḍutanamunaku nī nōru appagiñcucunnāvu nī nāluka kapaṭavārtalu allucunnadi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీవు', 'nīvu', 'you', 1),
        (verse_id_var, 2, 'చెడుతనమునకు', 'ceḍutanamunaku', 'to evil', 2),
        (verse_id_var, 3, 'నీ', 'nī', 'your', 3),
        (verse_id_var, 4, 'నోరు', 'nōru', 'mouth', 4),
        (verse_id_var, 5, 'అప్పగించుచున్నావు', 'appagiñcucunnāvu', 'give', 5),
        (verse_id_var, 6, 'నీ', 'nī', 'your', 3),
        (verse_id_var, 7, 'నాలుక', 'nāluka', 'tongue', 6),
        (verse_id_var, 8, 'కపటవార్తలు', 'kapaṭavārtalu', 'deceit', 7),
        (verse_id_var, 9, 'అల్లుచున్నది.', 'allucunnadi.', 'frames.', 8);

    -- VERSE 20
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 20,
        'నీ సహోదరునిమీద దురాలోచన చెప్పుదువు నీ తల్లి కుమారుని దూషింతువు.',
        'You sit and speak against your brother. You slander your own mother''s son.',
        'nī sahōdarunimīda durālōcana ceppuduvu nī talli kumāruni dūṣiṃtuvu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 2, 'సహోదరునిమీద', 'sahōdarunimīda', 'against brother', 2),
        (verse_id_var, 3, 'దురాలోచన', 'durālōcana', 'evil counsel', 3),
        (verse_id_var, 4, 'చెప్పుదువు', 'ceppuduvu', 'you speak', 4),
        (verse_id_var, 5, 'నీ', 'nī', 'your', 1),
        (verse_id_var, 6, 'తల్లి', 'talli', 'mother''s', 5),
        (verse_id_var, 7, 'కుమారుని', 'kumāruni', 'son', 6),
        (verse_id_var, 8, 'దూషింతువు.', 'dūṣiṃtuvu.', 'you slander.', 7);

    -- VERSE 21
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 21,
        'నీవు ఈలాగు చేయుచుండగా నేను మౌనినైతిని నేను నీ వంటివాడననుకొనుచుంటివి అయితే నేను నిన్ను గద్దించెదను నీ కన్నుల యెదుట వాటిని క్రమముగా ఉంచెదను.',
        'You have done these things, and I kept silent. You thought that I was just like you. I will rebuke you, and accuse you in front of your eyes.',
        'nīvu īlāgu cēyucuṃḍagā nēnu mauninaitini nēnu nī vaṃṭivāḍananukonucuṃṭivi ayitē nēnu ninnu gaddiñcedanu nī kannula yeduṭa vāṭini kramamugā uṃcedanu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నీవు', 'nīvu', 'you', 1),
        (verse_id_var, 2, 'ఈలాగు', 'īlāgu', 'these things', 2),
        (verse_id_var, 3, 'చేయుచుండగా', 'cēyucuṃḍagā', 'have done', 3),
        (verse_id_var, 4, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 5, 'మౌనినైతిని', 'mauninaitini', 'kept silent', 5),
        (verse_id_var, 6, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 7, 'నీ', 'nī', 'you', 1),
        (verse_id_var, 8, 'వంటివాడననుకొనుచుంటివి', 'vaṃṭivāḍananukonucuṃṭivi', 'thought just like', 6),
        (verse_id_var, 9, 'అయితే', 'ayitē', 'but', 7),
        (verse_id_var, 10, 'నేను', 'nēnu', 'I', 4),
        (verse_id_var, 11, 'నిన్ను', 'ninnu', 'you', 1),
        (verse_id_var, 12, 'గద్దించెదను', 'gaddiñcedanu', 'will rebuke', 8),
        (verse_id_var, 13, 'నీ', 'nī', 'your', 9),
        (verse_id_var, 14, 'కన్నుల', 'kannula', 'eyes', 10),
        (verse_id_var, 15, 'యెదుట', 'yeduṭa', 'in front of', 11),
        (verse_id_var, 16, 'వాటిని', 'vāṭini', 'them', 12),
        (verse_id_var, 17, 'క్రమముగా', 'kramamugā', 'in order', 13),
        (verse_id_var, 18, 'ఉంచెదను.', 'uṃcedanu.', 'will set.', 14);

    -- VERSE 22
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 22,
        'దేవుని మరచువారలారా, దీనిని ఆలోచించుడి లేనియెడల నేను మిమ్మును చీల్చివేసెదను విడిపించువాడెవడును ఉండడు.',
        '"Now consider this, you who forget God, lest I tear you into pieces, and there be none to deliver.',
        'dēvuni maracuvāralārā, dīnini ālōciñcuḍi lēniyeḍala nēnu mimmunu cīlcivēsedanu viḍipiñcuvāḍevaḍunu uṃḍaḍu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'దేవుని', 'dēvuni', 'God', 1),
        (verse_id_var, 2, 'మరచువారలారా,', 'maracuvāralārā,', 'you who forget,', 2),
        (verse_id_var, 3, 'దీనిని', 'dīnini', 'this', 3),
        (verse_id_var, 4, 'ఆలోచించుడి', 'ālōciñcuḍi', 'now consider', 4),
        (verse_id_var, 5, 'లేనియెడల', 'lēniyeḍala', 'lest', 5),
        (verse_id_var, 6, 'నేను', 'nēnu', 'I', 6),
        (verse_id_var, 7, 'మిమ్మును', 'mimmunu', 'you', 7),
        (verse_id_var, 8, 'చీల్చివేసెదను', 'cīlcivēsedanu', 'tear into pieces', 8),
        (verse_id_var, 9, 'విడిపించువాడెవడును', 'viḍipiñcuvāḍevaḍunu', 'none to deliver', 9),
        (verse_id_var, 10, 'ఉండడు.', 'uṃḍaḍu.', 'there be.', 10);

    -- VERSE 23
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 23,
        'కృతజ్ఞతార్పణము అర్పించువాడే నన్ను మహిమపరచును ప్రవర్తన చక్కబరచుకొనువానికి నేను దేవుని రక్షణ చూపించెదను.',
        'Whoever offers the sacrifice of thanksgiving glorifies me, and prepares his way so that I will show God''s salvation to him."',
        'kr̥tajñatārpaṇamu arpiñcuvāḍē nannu mahimaparacunu pravartana cakkabaracukonuvāniki nēnu dēvuni rakṣaṇa cūpiñcedanu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'కృతజ్ఞతార్పణము', 'kr̥tajñatārpaṇamu', 'the sacrifice of thanksgiving', 1),
        (verse_id_var, 2, 'అర్పించువాడే', 'arpiñcuvāḍē', 'whoever offers', 2),
        (verse_id_var, 3, 'నన్ను', 'nannu', 'me', 3),
        (verse_id_var, 4, 'మహిమపరచును', 'mahimaparacunu', 'glorifies', 4),
        (verse_id_var, 5, 'ప్రవర్తన', 'pravartana', 'way', 5),
        (verse_id_var, 6, 'చక్కబరచుకొనువానికి', 'cakkabaracukonuvāniki', 'prepares his', 6),
        (verse_id_var, 7, 'నేను', 'nēnu', 'I', 7),
        (verse_id_var, 8, 'దేవుని', 'dēvuni', 'God''s', 8),
        (verse_id_var, 9, 'రక్షణ', 'rakṣaṇa', 'salvation', 9),
        (verse_id_var, 10, 'చూపించెదను.', 'cūpiñcedanu.', 'will show.', 10);
END $$;
