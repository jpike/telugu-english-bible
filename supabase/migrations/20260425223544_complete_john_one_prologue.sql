/*
  # Complete John 1 prologue (verses 6-18)

  1. Content additions
    - Adds 13 verses to John chapter 1 (verses 6 through 18), completing the prologue.
    - Each verse upserts Telugu (BSI-style), English (WEB public domain), and ISO-15919 transliteration text.
    - Each verse seeds aligned `verse_tokens` with per-verse alignment groups so word-level coloring works immediately.

  2. Strategy
    - Idempotent: verses are upserted by composite key (chapter_id, verse_number); existing tokens are deleted then re-inserted.
    - No schema changes; data only.

  3. Notes
    - Token alignment_group values are scoped per-verse and link Telugu words to their English meanings.
    - Hand-curated character alignments (`token_character_alignments`) are NOT seeded here; the runtime AksharaSegmenter will provide an approximate breakdown on click.
*/

DO $$
DECLARE
    chapter_id_var bigint;
    verse_id_var bigint;
BEGIN
    SELECT id INTO chapter_id_var FROM chapters WHERE book_id = 43 AND chapter_number = 1;

    -- VERSE 6
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 6,
        'దేవుని యొద్దనుండి పంపబడిన ఒక మనుష్యుడు ఉండెను; అతని పేరు యోహాను.',
        'There came a man, sent from God, whose name was John.',
        'dēvuni yoddanuṇḍi pampabaḍina oka manuṣyuḍu uṇḍenu; atani pēru yōhānu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'దేవుని', 'dēvuni', 'God', 1),
        (verse_id_var, 2, 'యొద్దనుండి', 'yoddanuṇḍi', 'from', 2),
        (verse_id_var, 3, 'పంపబడిన', 'pampabaḍina', 'sent', 3),
        (verse_id_var, 4, 'ఒక', 'oka', 'a', 4),
        (verse_id_var, 5, 'మనుష్యుడు', 'manuṣyuḍu', 'man', 5),
        (verse_id_var, 6, 'ఉండెను;', 'uṇḍenu;', 'came', 6),
        (verse_id_var, 7, 'అతని', 'atani', 'whose', 7),
        (verse_id_var, 8, 'పేరు', 'pēru', 'name', 8),
        (verse_id_var, 9, 'యోహాను.', 'yōhānu.', 'John.', 9);

    -- VERSE 7
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 7,
        'తన మూలముగా అందరు విశ్వసించునట్లు అతడు ఆ వెలుగును గూర్చి సాక్ష్యమిచ్చుటకు సాక్షిగా వచ్చెను.',
        'The same came as a witness, that he might testify about the light, that all might believe through him.',
        'tana mūlamugā andaru viśvasiñcunaṭlu ataḍu ā velugunu gūrci sākṣyamiccuṭaku sākṣigā vaccenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'తన', 'tana', 'him', 1),
        (verse_id_var, 2, 'మూలముగా', 'mūlamugā', 'through', 2),
        (verse_id_var, 3, 'అందరు', 'andaru', 'all', 3),
        (verse_id_var, 4, 'విశ్వసించునట్లు', 'viśvasiñcunaṭlu', 'might believe', 4),
        (verse_id_var, 5, 'అతడు', 'ataḍu', 'he', 5),
        (verse_id_var, 6, 'ఆ', 'ā', 'the', 6),
        (verse_id_var, 7, 'వెలుగును', 'velugunu', 'light', 7),
        (verse_id_var, 8, 'గూర్చి', 'gūrci', 'about', 8),
        (verse_id_var, 9, 'సాక్ష్యమిచ్చుటకు', 'sākṣyamiccuṭaku', 'testify', 9),
        (verse_id_var, 10, 'సాక్షిగా', 'sākṣigā', 'as a witness', 10),
        (verse_id_var, 11, 'వచ్చెను.', 'vaccenu.', 'came.', 11);

    -- VERSE 8
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 8,
        'అతడు ఆ వెలుగై యుండలేదు గాని ఆ వెలుగును గూర్చి సాక్ష్యమిచ్చుటకు అతడు వచ్చెను.',
        'He was not the light, but was sent that he might testify about the light.',
        'ataḍu ā velugai yuṇḍalēdu gāni ā velugunu gūrci sākṣyamiccuṭaku ataḍu vaccenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'అతడు', 'ataḍu', 'He', 1),
        (verse_id_var, 2, 'ఆ', 'ā', 'the', 2),
        (verse_id_var, 3, 'వెలుగై', 'velugai', 'light', 3),
        (verse_id_var, 4, 'యుండలేదు', 'yuṇḍalēdu', 'was not', 4),
        (verse_id_var, 5, 'గాని', 'gāni', 'but', 5),
        (verse_id_var, 6, 'ఆ', 'ā', 'the', 2),
        (verse_id_var, 7, 'వెలుగును', 'velugunu', 'light', 3),
        (verse_id_var, 8, 'గూర్చి', 'gūrci', 'about', 6),
        (verse_id_var, 9, 'సాక్ష్యమిచ్చుటకు', 'sākṣyamiccuṭaku', 'might testify', 7),
        (verse_id_var, 10, 'అతడు', 'ataḍu', 'he', 1),
        (verse_id_var, 11, 'వచ్చెను.', 'vaccenu.', 'was sent.', 8);

    -- VERSE 9
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 9,
        'నిజమైన వెలుగు ఉండెను; అది లోకములోనికి వచ్చుచు ప్రతి మనుష్యుని వెలిగించుచుండెను.',
        'The true light that enlightens everyone was coming into the world.',
        'nijamaina velugu uṇḍenu; adi lōkamulōniki vaccucu prati manuṣyuni veligiñcucuṇḍenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'నిజమైన', 'nijamaina', 'true', 1),
        (verse_id_var, 2, 'వెలుగు', 'velugu', 'light', 2),
        (verse_id_var, 3, 'ఉండెను;', 'uṇḍenu;', 'was', 3),
        (verse_id_var, 4, 'అది', 'adi', 'that', 4),
        (verse_id_var, 5, 'లోకములోనికి', 'lōkamulōniki', 'into the world', 5),
        (verse_id_var, 6, 'వచ్చుచు', 'vaccucu', 'coming', 6),
        (verse_id_var, 7, 'ప్రతి', 'prati', 'every', 7),
        (verse_id_var, 8, 'మనుష్యుని', 'manuṣyuni', 'man', 8),
        (verse_id_var, 9, 'వెలిగించుచుండెను.', 'veligiñcucuṇḍenu.', 'enlightens.', 9);

    -- VERSE 10
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 10,
        'ఆయన లోకములో ఉండెను, లోకము ఆయన మూలముగా కలిగెను గాని లోకము ఆయనను తెలిసికొనలేదు.',
        'He was in the world, and the world was made through him, and the world didn''t recognize him.',
        'āyana lōkamulō uṇḍenu, lōkamu āyana mūlamugā kaligenu gāni lōkamu āyananu telisikonalēdu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆయన', 'āyana', 'He', 1),
        (verse_id_var, 2, 'లోకములో', 'lōkamulō', 'in the world', 2),
        (verse_id_var, 3, 'ఉండెను,', 'uṇḍenu,', 'was,', 3),
        (verse_id_var, 4, 'లోకము', 'lōkamu', 'the world', 4),
        (verse_id_var, 5, 'ఆయన', 'āyana', 'him', 1),
        (verse_id_var, 6, 'మూలముగా', 'mūlamugā', 'through', 5),
        (verse_id_var, 7, 'కలిగెను', 'kaligenu', 'was made', 6),
        (verse_id_var, 8, 'గాని', 'gāni', 'and', 7),
        (verse_id_var, 9, 'లోకము', 'lōkamu', 'the world', 4),
        (verse_id_var, 10, 'ఆయనను', 'āyananu', 'him', 1),
        (verse_id_var, 11, 'తెలిసికొనలేదు.', 'telisikonalēdu.', 'didn''t recognize.', 8);

    -- VERSE 11
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 11,
        'ఆయన తన స్వకీయులయొద్దకు వచ్చెను; ఆయన స్వకీయులు ఆయనను అంగీకరింపలేదు.',
        'He came to his own, and those who were his own didn''t receive him.',
        'āyana tana svakīyulayoddaku vaccenu; āyana svakīyulu āyananu aṅgīkarimpalēdu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆయన', 'āyana', 'He', 1),
        (verse_id_var, 2, 'తన', 'tana', 'his', 2),
        (verse_id_var, 3, 'స్వకీయులయొద్దకు', 'svakīyulayoddaku', 'to own', 3),
        (verse_id_var, 4, 'వచ్చెను;', 'vaccenu;', 'came;', 4),
        (verse_id_var, 5, 'ఆయన', 'āyana', 'his', 2),
        (verse_id_var, 6, 'స్వకీయులు', 'svakīyulu', 'own', 3),
        (verse_id_var, 7, 'ఆయనను', 'āyananu', 'him', 1),
        (verse_id_var, 8, 'అంగీకరింపలేదు.', 'aṅgīkarimpalēdu.', 'didn''t receive.', 5);

    -- VERSE 12
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 12,
        'తన్ను ఎందరంగీకరించిరో వారికందరికి, అనగా తన నామమునందు విశ్వాసముంచిన వారికి, దేవుని పిల్లలగుటకు ఆయన అధికారము అనుగ్రహించెను.',
        'But as many as received him, to them he gave the right to become God''s children, to those who believe in his name.',
        'tannu endaraṅgīkariñcirō vārikandariki, anagā tana nāmamunandu viśvāsamuñcina vāriki, dēvuni pillalaguṭaku āyana adhikāramu anugrahiñcenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'తన్ను', 'tannu', 'him', 1),
        (verse_id_var, 2, 'ఎందరంగీకరించిరో', 'endaraṅgīkariñcirō', 'as many as received', 2),
        (verse_id_var, 3, 'వారికందరికి,', 'vārikandariki,', 'to them all,', 3),
        (verse_id_var, 4, 'అనగా', 'anagā', 'that is', 4),
        (verse_id_var, 5, 'తన', 'tana', 'his', 5),
        (verse_id_var, 6, 'నామమునందు', 'nāmamunandu', 'in name', 6),
        (verse_id_var, 7, 'విశ్వాసముంచిన', 'viśvāsamuñcina', 'who believe', 7),
        (verse_id_var, 8, 'వారికి,', 'vāriki,', 'to those,', 8),
        (verse_id_var, 9, 'దేవుని', 'dēvuni', 'God''s', 9),
        (verse_id_var, 10, 'పిల్లలగుటకు', 'pillalaguṭaku', 'to become children', 10),
        (verse_id_var, 11, 'ఆయన', 'āyana', 'he', 11),
        (verse_id_var, 12, 'అధికారము', 'adhikāramu', 'right', 12),
        (verse_id_var, 13, 'అనుగ్రహించెను.', 'anugrahiñcenu.', 'gave.', 13);

    -- VERSE 13
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 13,
        'వారు దేవునివలన పుట్టినవారే గాని, రక్తమువలననైనను శరీరేచ్ఛవలననైనను మానుషేచ్ఛవలననైనను పుట్టినవారు కారు.',
        'who were born not of blood, nor of the will of the flesh, nor of the will of man, but of God.',
        'vāru dēvunivalana puṭṭinavārē gāni, raktamuvalananainanu śarīrēcchavalananainanu mānuṣēcchavalananainanu puṭṭinavāru kāru.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'వారు', 'vāru', 'who', 1),
        (verse_id_var, 2, 'దేవునివలన', 'dēvunivalana', 'of God', 2),
        (verse_id_var, 3, 'పుట్టినవారే', 'puṭṭinavārē', 'were born', 3),
        (verse_id_var, 4, 'గాని,', 'gāni,', 'but,', 4),
        (verse_id_var, 5, 'రక్తమువలననైనను', 'raktamuvalananainanu', 'not of blood', 5),
        (verse_id_var, 6, 'శరీరేచ్ఛవలననైనను', 'śarīrēcchavalananainanu', 'nor of will of flesh', 6),
        (verse_id_var, 7, 'మానుషేచ్ఛవలననైనను', 'mānuṣēcchavalananainanu', 'nor of will of man', 7),
        (verse_id_var, 8, 'పుట్టినవారు', 'puṭṭinavāru', 'born', 3),
        (verse_id_var, 9, 'కారు.', 'kāru.', 'were not.', 8);

    -- VERSE 14
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 14,
        'ఆ వాక్యము శరీరధారియై, కృపాసత్యసంపూర్ణుడుగా మన మధ్య నివసించెను; తండ్రివలన కలిగిన అద్వితీయకుమారుని మహిమవలె మనము ఆయన మహిమను చూచితిమి.',
        'The Word became flesh, and lived among us. We saw his glory, such glory as of the one and only Son of the Father, full of grace and truth.',
        'ā vākyamu śarīradhāriyai, kr̥pāsatyasampūrṇuḍugā mana madhya nivasiñcenu; taṇḍrivalana kaligina advitīyakumāruni mahimavale manamu āyana mahimanu cūcitimi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆ', 'ā', 'The', 1),
        (verse_id_var, 2, 'వాక్యము', 'vākyamu', 'Word', 2),
        (verse_id_var, 3, 'శరీరధారియై,', 'śarīradhāriyai,', 'became flesh,', 3),
        (verse_id_var, 4, 'కృపాసత్యసంపూర్ణుడుగా', 'kr̥pāsatyasampūrṇuḍugā', 'full of grace and truth', 4),
        (verse_id_var, 5, 'మన', 'mana', 'us', 5),
        (verse_id_var, 6, 'మధ్య', 'madhya', 'among', 6),
        (verse_id_var, 7, 'నివసించెను;', 'nivasiñcenu;', 'lived;', 7),
        (verse_id_var, 8, 'తండ్రివలన', 'taṇḍrivalana', 'of the Father', 8),
        (verse_id_var, 9, 'కలిగిన', 'kaligina', 'as of', 9),
        (verse_id_var, 10, 'అద్వితీయకుమారుని', 'advitīyakumāruni', 'one and only Son', 10),
        (verse_id_var, 11, 'మహిమవలె', 'mahimavale', 'such glory', 11),
        (verse_id_var, 12, 'మనము', 'manamu', 'We', 12),
        (verse_id_var, 13, 'ఆయన', 'āyana', 'his', 13),
        (verse_id_var, 14, 'మహిమను', 'mahimanu', 'glory', 11),
        (verse_id_var, 15, 'చూచితిమి.', 'cūcitimi.', 'saw.', 14);

    -- VERSE 15
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 15,
        'యోహాను ఆయననుగూర్చి సాక్ష్యమిచ్చుచు—నా వెనుక వచ్చువాడు నాకంటె ప్రముఖుడు; ఆయన నాకన్న ముందటివాడు అని నేను చెప్పినవాడు ఈయనే అని ఎలుగెత్తి చాటెను.',
        'John testified about him. He cried out, saying, "This was he of whom I said, ''He who comes after me has surpassed me, for he was before me.''"',
        'yōhānu āyananugūrci sākṣyamiccucu—nā venuka vaccuvāḍu nākaṇṭe pramukhuḍu; āyana nākanna mundaṭivāḍu ani nēnu ceppinavāḍu īyanē ani elugetti cāṭenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'యోహాను', 'yōhānu', 'John', 1),
        (verse_id_var, 2, 'ఆయననుగూర్చి', 'āyananugūrci', 'about him', 2),
        (verse_id_var, 3, 'సాక్ష్యమిచ్చుచు—', 'sākṣyamiccucu—', 'testified—', 3),
        (verse_id_var, 4, 'నా', 'nā', 'me', 4),
        (verse_id_var, 5, 'వెనుక', 'venuka', 'after', 5),
        (verse_id_var, 6, 'వచ్చువాడు', 'vaccuvāḍu', 'who comes', 6),
        (verse_id_var, 7, 'నాకంటె', 'nākaṇṭe', 'than me', 7),
        (verse_id_var, 8, 'ప్రముఖుడు;', 'pramukhuḍu;', 'has surpassed;', 8),
        (verse_id_var, 9, 'ఆయన', 'āyana', 'he', 9),
        (verse_id_var, 10, 'నాకన్న', 'nākanna', 'before me', 10),
        (verse_id_var, 11, 'ముందటివాడు', 'mundaṭivāḍu', 'was', 11),
        (verse_id_var, 12, 'అని', 'ani', 'that', 12),
        (verse_id_var, 13, 'నేను', 'nēnu', 'I', 13),
        (verse_id_var, 14, 'చెప్పినవాడు', 'ceppinavāḍu', 'said', 14),
        (verse_id_var, 15, 'ఈయనే', 'īyanē', 'this is he', 15),
        (verse_id_var, 16, 'అని', 'ani', 'saying', 12),
        (verse_id_var, 17, 'ఎలుగెత్తి', 'elugetti', 'cried out', 16),
        (verse_id_var, 18, 'చాటెను.', 'cāṭenu.', 'proclaimed.', 17);

    -- VERSE 16
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 16,
        'ఆయన పరిపూర్ణతలోనుండి మనమందరము కృప వెంబడి కృపను పొందితిమి.',
        'From his fullness we all received grace upon grace.',
        'āyana paripūrṇatalōnuṇḍi manamandaramu kr̥pa veṃbaḍi kr̥panu pondītimi.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఆయన', 'āyana', 'his', 1),
        (verse_id_var, 2, 'పరిపూర్ణతలోనుండి', 'paripūrṇatalōnuṇḍi', 'From fullness', 2),
        (verse_id_var, 3, 'మనమందరము', 'manamandaramu', 'we all', 3),
        (verse_id_var, 4, 'కృప', 'kr̥pa', 'grace', 4),
        (verse_id_var, 5, 'వెంబడి', 'veṃbaḍi', 'upon', 5),
        (verse_id_var, 6, 'కృపను', 'kr̥panu', 'grace', 4),
        (verse_id_var, 7, 'పొందితిమి.', 'pondītimi.', 'received.', 6);

    -- VERSE 17
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 17,
        'ధర్మశాస్త్రము మోషేద్వారా అనుగ్రహింపబడెను; కృపయు సత్యమును యేసుక్రీస్తు ద్వారా కలిగెను.',
        'For the law was given through Moses. Grace and truth were realized through Jesus Christ.',
        'dharmaśāstramu mōṣēdvārā anugrahimpabaḍenu; kr̥payu satyamunu yēsukrīstu dvārā kaligenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ధర్మశాస్త్రము', 'dharmaśāstramu', 'the law', 1),
        (verse_id_var, 2, 'మోషేద్వారా', 'mōṣēdvārā', 'through Moses', 2),
        (verse_id_var, 3, 'అనుగ్రహింపబడెను;', 'anugrahimpabaḍenu;', 'was given;', 3),
        (verse_id_var, 4, 'కృపయు', 'kr̥payu', 'Grace', 4),
        (verse_id_var, 5, 'సత్యమును', 'satyamunu', 'and truth', 5),
        (verse_id_var, 6, 'యేసుక్రీస్తు', 'yēsukrīstu', 'Jesus Christ', 6),
        (verse_id_var, 7, 'ద్వారా', 'dvārā', 'through', 7),
        (verse_id_var, 8, 'కలిగెను.', 'kaligenu.', 'were realized.', 8);

    -- VERSE 18
    INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
    VALUES (chapter_id_var, 18,
        'ఎవడును ఎప్పుడైనను దేవుని చూడలేదు; తండ్రి రొమ్ముననున్న అద్వితీయ కుమారుడే ఆయనను బయలుపరచెను.',
        'No one has seen God at any time. The one and only Son, who is in the bosom of the Father, has declared him.',
        'evaḍunu eppuḍainanu dēvuni cūḍalēdu; taṇḍri rommunanunna advitīya kumāruḍē āyananu bayalupaṟacenu.')
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        telugu_text = EXCLUDED.telugu_text,
        english_text = EXCLUDED.english_text,
        transliteration_text = EXCLUDED.transliteration_text
    RETURNING id INTO verse_id_var;
    DELETE FROM verse_tokens WHERE verse_id = verse_id_var;
    INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
        (verse_id_var, 1, 'ఎవడును', 'evaḍunu', 'No one', 1),
        (verse_id_var, 2, 'ఎప్పుడైనను', 'eppuḍainanu', 'at any time', 2),
        (verse_id_var, 3, 'దేవుని', 'dēvuni', 'God', 3),
        (verse_id_var, 4, 'చూడలేదు;', 'cūḍalēdu;', 'has seen;', 4),
        (verse_id_var, 5, 'తండ్రి', 'taṇḍri', 'the Father', 5),
        (verse_id_var, 6, 'రొమ్ముననున్న', 'rommunanunna', 'in the bosom of', 6),
        (verse_id_var, 7, 'అద్వితీయ', 'advitīya', 'one and only', 7),
        (verse_id_var, 8, 'కుమారుడే', 'kumāruḍē', 'Son', 8),
        (verse_id_var, 9, 'ఆయనను', 'āyananu', 'him', 9),
        (verse_id_var, 10, 'బయలుపరచెను.', 'bayalupaṟacenu.', 'has declared.', 10);
END $$;