/*
  # Seed Sample Interlinear Passages

  Inserts a curated set of well-known passages with full word-level
  alignment between Telugu (BSI-style), ISO-15919-like transliteration,
  and the World English Bible (WEB) English translation. These passages
  serve as the initial reading corpus for the app.

  ## Passages
  1. Genesis 1:1-5
  2. Psalm 23:1-6
  3. John 1:1-5
  4. John 3:16
  5. Matthew 6:9-13 (The Lord's Prayer)

  ## Notes
  Alignment groups link Telugu words with their English counterparts.
  The same group number ties a Telugu word cell to its English meaning
  and color in the UI. Groups are scoped per-verse.
*/

DO $$
DECLARE
  chap_id bigint;
  vers_id bigint;
BEGIN

  -- GENESIS 1
  INSERT INTO chapters (book_id, chapter_number) VALUES (1, 1)
  ON CONFLICT (book_id, chapter_number) DO NOTHING;
  SELECT id INTO chap_id FROM chapters WHERE book_id=1 AND chapter_number=1;

  -- Gen 1:1
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 1,
    'ఆదియందు దేవుడు భూమ్యాకాశములను సృజించెను.',
    'In the beginning God created the heavens and the earth.',
    'ādiyandu dēvuḍu bhūmyākāśamulanu sr̥jiñcenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ఆదియందు', 'ādiyandu', 'In the beginning', 1),
    (vers_id, 2, 'దేవుడు', 'dēvuḍu', 'God', 2),
    (vers_id, 3, 'భూమ్యాకాశములను', 'bhūmyākāśamulanu', 'the heavens and the earth', 3),
    (vers_id, 4, 'సృజించెను', 'sr̥jiñcenu', 'created', 4);

  -- Gen 1:2
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 2,
    'భూమి నిరాకారముగాను శూన్యముగాను ఉండెను; చీకటి అగాధ జలముపైన కమ్మియుండెను.',
    'The earth was formless and empty. Darkness was on the surface of the deep.',
    'bhūmi nirākāramugānu śūnyamugānu uṇḍenu; cīkaṭi agādha jalamupaina kammiyuṇḍenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'భూమి', 'bhūmi', 'The earth', 1),
    (vers_id, 2, 'నిరాకారముగాను', 'nirākāramugānu', 'formless', 2),
    (vers_id, 3, 'శూన్యముగాను', 'śūnyamugānu', 'and empty', 3),
    (vers_id, 4, 'ఉండెను', 'uṇḍenu', 'was', 4),
    (vers_id, 5, 'చీకటి', 'cīkaṭi', 'Darkness', 5),
    (vers_id, 6, 'అగాధ', 'agādha', 'of the deep', 6),
    (vers_id, 7, 'జలముపైన', 'jalamupaina', 'on the surface', 7),
    (vers_id, 8, 'కమ్మియుండెను', 'kammiyuṇḍenu', 'was covering', 8);

  -- Gen 1:3
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 3,
    'దేవుడు వెలుగు కమ్మని పలుకగా వెలుగు కలిగెను.',
    'God said, "Let there be light," and there was light.',
    'dēvuḍu velugu kammani palukagā velugu kaligenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'వెలుగు', 'velugu', 'light', 2),
    (vers_id, 3, 'కమ్మని', 'kammani', 'Let there be', 3),
    (vers_id, 4, 'పలుకగా', 'palukagā', 'said', 4),
    (vers_id, 5, 'వెలుగు', 'velugu', 'light', 2),
    (vers_id, 6, 'కలిగెను', 'kaligenu', 'there was', 5);

  -- Gen 1:4
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 4,
    'వెలుగు మంచిదైయున్నదని దేవుడు చూచెను; దేవుడు వెలుగును చీకటిని వేరుపరచెను.',
    'God saw the light, and saw that it was good. God divided the light from the darkness.',
    'velugu mañcidaiyunnadani dēvuḍu cūcenu; dēvuḍu velugunu cīkaṭini vēruparacenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'వెలుగు', 'velugu', 'the light', 1),
    (vers_id, 2, 'మంచిదైయున్నదని', 'mañcidaiyunnadani', 'was good', 2),
    (vers_id, 3, 'దేవుడు', 'dēvuḍu', 'God', 3),
    (vers_id, 4, 'చూచెను', 'cūcenu', 'saw', 4),
    (vers_id, 5, 'దేవుడు', 'dēvuḍu', 'God', 3),
    (vers_id, 6, 'వెలుగును', 'velugunu', 'the light', 1),
    (vers_id, 7, 'చీకటిని', 'cīkaṭini', 'the darkness', 5),
    (vers_id, 8, 'వేరుపరచెను', 'vēruparacenu', 'divided from', 6);

  -- Gen 1:5
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 5,
    'దేవుడు వెలుగునకు పగలనియు చీకటికి రాత్రి అనియు పేరుపెట్టెను. అస్తమయము ఉదయము కలుగగా ఒక దినమాయెను.',
    'God called the light "day", and the darkness he called "night". There was evening and there was morning, the first day.',
    'dēvuḍu velugunaku pagalaniyu cīkaṭiki rātri aniyu pēruPeṭṭenu. astamayamu udayamu kalugagā oka dinamāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'వెలుగునకు', 'velugunaku', 'the light', 2),
    (vers_id, 3, 'పగలనియు', 'pagalaniyu', 'day', 3),
    (vers_id, 4, 'చీకటికి', 'cīkaṭiki', 'the darkness', 4),
    (vers_id, 5, 'రాత్రి', 'rātri', 'night', 5),
    (vers_id, 6, 'అనియు', 'aniyu', 'and', 6),
    (vers_id, 7, 'పేరుపెట్టెను', 'pēruPeṭṭenu', 'called', 7),
    (vers_id, 8, 'అస్తమయము', 'astamayamu', 'evening', 8),
    (vers_id, 9, 'ఉదయము', 'udayamu', 'morning', 9),
    (vers_id, 10, 'కలుగగా', 'kalugagā', 'there was', 10),
    (vers_id, 11, 'ఒక', 'oka', 'the first', 11),
    (vers_id, 12, 'దినమాయెను', 'dinamāyenu', 'day', 12);

  -- PSALM 23
  INSERT INTO chapters (book_id, chapter_number) VALUES (19, 23)
  ON CONFLICT (book_id, chapter_number) DO NOTHING;
  SELECT id INTO chap_id FROM chapters WHERE book_id=19 AND chapter_number=23;

  -- Ps 23:1
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 1,
    'యెహోవా నా కాపరి; నాకు లేమి కలుగదు.',
    'Yahweh is my shepherd: I shall lack nothing.',
    'yehōvā nā kāpari; nāku lēmi kalugadu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'యెహోవా', 'yehōvā', 'Yahweh', 1),
    (vers_id, 2, 'నా', 'nā', 'my', 2),
    (vers_id, 3, 'కాపరి', 'kāpari', 'shepherd', 3),
    (vers_id, 4, 'నాకు', 'nāku', 'I shall', 4),
    (vers_id, 5, 'లేమి', 'lēmi', 'nothing', 5),
    (vers_id, 6, 'కలుగదు', 'kalugadu', 'lack', 6);

  -- Ps 23:2
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 2,
    'పచ్చికగల చోట్లను ఆయన నన్ను పరుండబెట్టును; శాంతికరమైన జలములయొద్దకు నన్ను నడిపించును.',
    'He makes me lie down in green pastures. He leads me beside still waters.',
    'paccikagala cōṭlanu āyana nannu paruṇḍabeṭṭunu; śāntikaramaina jalamulayoddaku nannu naḍipiñcunu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'పచ్చికగల', 'paccikagala', 'green', 1),
    (vers_id, 2, 'చోట్లను', 'cōṭlanu', 'pastures', 2),
    (vers_id, 3, 'ఆయన', 'āyana', 'He', 3),
    (vers_id, 4, 'నన్ను', 'nannu', 'me', 4),
    (vers_id, 5, 'పరుండబెట్టును', 'paruṇḍabeṭṭunu', 'makes lie down', 5),
    (vers_id, 6, 'శాంతికరమైన', 'śāntikaramaina', 'still', 6),
    (vers_id, 7, 'జలములయొద్దకు', 'jalamulayoddaku', 'beside waters', 7),
    (vers_id, 8, 'నన్ను', 'nannu', 'me', 4),
    (vers_id, 9, 'నడిపించును', 'naḍipiñcunu', 'leads', 8);

  -- Ps 23:3
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 3,
    'ఆయన నా ప్రాణమునకు సేదదీర్చును; తన నామమునుబట్టి నీతిమార్గములలో నన్ను నడిపించును.',
    'He restores my soul. He guides me in the paths of righteousness for his name''s sake.',
    'āyana nā prāṇamunaku sēdadīrcunu; tana nāmamunubaṭṭi nītimārgamulalō nannu naḍipiñcunu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ఆయన', 'āyana', 'He', 1),
    (vers_id, 2, 'నా', 'nā', 'my', 2),
    (vers_id, 3, 'ప్రాణమునకు', 'prāṇamunaku', 'soul', 3),
    (vers_id, 4, 'సేదదీర్చును', 'sēdadīrcunu', 'restores', 4),
    (vers_id, 5, 'తన', 'tana', 'his', 5),
    (vers_id, 6, 'నామమునుబట్టి', 'nāmamunubaṭṭi', 'name''s sake', 6),
    (vers_id, 7, 'నీతిమార్గములలో', 'nītimārgamulalō', 'paths of righteousness', 7),
    (vers_id, 8, 'నన్ను', 'nannu', 'me', 8),
    (vers_id, 9, 'నడిపించును', 'naḍipiñcunu', 'guides', 9);

  -- Ps 23:4
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 4,
    'గాఢాంధకారపు లోయలో నేను సంచరించినను ఏ అపాయమునకు భయపడను; నీవు నాకు తోడైయుందువు; నీ దుడ్డుకఱ్ఱయు నీ దండమును నన్ను ఆదరించును.',
    'Even though I walk through the valley of the shadow of death, I will fear no evil, for you are with me. Your rod and your staff, they comfort me.',
    'gāḍhāndhakārapu lōyalō nēnu sañcariñcinanu ē apāyamunaku bhayapaḍanu; nīvu nāku tōḍaiyunduvu; nī duḍḍukarrayu nī daṇḍamunu nannu ādariñcunu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'గాఢాంధకారపు', 'gāḍhāndhakārapu', 'shadow of death', 1),
    (vers_id, 2, 'లోయలో', 'lōyalō', 'valley', 2),
    (vers_id, 3, 'నేను', 'nēnu', 'I', 3),
    (vers_id, 4, 'సంచరించినను', 'sañcariñcinanu', 'walk through', 4),
    (vers_id, 5, 'ఏ', 'ē', 'no', 5),
    (vers_id, 6, 'అపాయమునకు', 'apāyamunaku', 'evil', 6),
    (vers_id, 7, 'భయపడను', 'bhayapaḍanu', 'fear', 7),
    (vers_id, 8, 'నీవు', 'nīvu', 'you', 8),
    (vers_id, 9, 'నాకు', 'nāku', 'with me', 9),
    (vers_id, 10, 'తోడైయుందువు', 'tōḍaiyunduvu', 'are', 10),
    (vers_id, 11, 'నీ', 'nī', 'your', 11),
    (vers_id, 12, 'దుడ్డుకఱ్ఱయు', 'duḍḍukarrayu', 'rod', 12),
    (vers_id, 13, 'నీ', 'nī', 'your', 11),
    (vers_id, 14, 'దండమును', 'daṇḍamunu', 'staff', 13),
    (vers_id, 15, 'నన్ను', 'nannu', 'me', 14),
    (vers_id, 16, 'ఆదరించును', 'ādariñcunu', 'comfort', 15);

  -- Ps 23:5
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 5,
    'నా శత్రువులయెదుట నీవు నాకు భోజనము సిద్ధపరచుదువు; నూనెతో నా తల అంటియున్నావు; నా గిన్నె నిండి పొర్లుచున్నది.',
    'You prepare a table before me in the presence of my enemies. You anoint my head with oil. My cup runs over.',
    'nā śatruvulayeduṭa nīvu nāku bhōjanamu siddhaparacuduvu; nūnetō nā tala aṇṭiyunnāvu; nā ginne niṇḍi porlucunnadi.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'నా', 'nā', 'my', 1),
    (vers_id, 2, 'శత్రువులయెదుట', 'śatruvulayeduṭa', 'before enemies', 2),
    (vers_id, 3, 'నీవు', 'nīvu', 'You', 3),
    (vers_id, 4, 'నాకు', 'nāku', 'for me', 4),
    (vers_id, 5, 'భోజనము', 'bhōjanamu', 'a table', 5),
    (vers_id, 6, 'సిద్ధపరచుదువు', 'siddhaparacuduvu', 'prepare', 6),
    (vers_id, 7, 'నూనెతో', 'nūnetō', 'with oil', 7),
    (vers_id, 8, 'నా', 'nā', 'my', 1),
    (vers_id, 9, 'తల', 'tala', 'head', 8),
    (vers_id, 10, 'అంటియున్నావు', 'aṇṭiyunnāvu', 'anoint', 9),
    (vers_id, 11, 'నా', 'nā', 'my', 1),
    (vers_id, 12, 'గిన్నె', 'ginne', 'cup', 10),
    (vers_id, 13, 'నిండి', 'niṇḍi', 'fully', 11),
    (vers_id, 14, 'పొర్లుచున్నది', 'porlucunnadi', 'runs over', 12);

  -- Ps 23:6
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 6,
    'నేను జీవించు దినములన్నియు కృపాక్షేమములే నాకు తోడైవచ్చును; చిరకాలము యెహోవా మందిరములో నేను నివసించెదను.',
    'Surely goodness and loving kindness shall follow me all the days of my life, and I will dwell in Yahweh''s house forever.',
    'nēnu jīviñcu dinamulanniyu kr̥pākṣēmamulē nāku tōḍaivaccunu; cirakālamu yehōvā mandiramulō nēnu nivasiñcedanu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'నేను', 'nēnu', 'I', 1),
    (vers_id, 2, 'జీవించు', 'jīviñcu', 'of life', 2),
    (vers_id, 3, 'దినములన్నియు', 'dinamulanniyu', 'all the days', 3),
    (vers_id, 4, 'కృపాక్షేమములే', 'kr̥pākṣēmamulē', 'goodness and loving kindness', 4),
    (vers_id, 5, 'నాకు', 'nāku', 'me', 5),
    (vers_id, 6, 'తోడైవచ్చును', 'tōḍaivaccunu', 'shall follow', 6),
    (vers_id, 7, 'చిరకాలము', 'cirakālamu', 'forever', 7),
    (vers_id, 8, 'యెహోవా', 'yehōvā', 'Yahweh''s', 8),
    (vers_id, 9, 'మందిరములో', 'mandiramulō', 'in house', 9),
    (vers_id, 10, 'నేను', 'nēnu', 'I', 1),
    (vers_id, 11, 'నివసించెదను', 'nivasiñcedanu', 'will dwell', 10);

  -- JOHN 1
  INSERT INTO chapters (book_id, chapter_number) VALUES (43, 1)
  ON CONFLICT (book_id, chapter_number) DO NOTHING;
  SELECT id INTO chap_id FROM chapters WHERE book_id=43 AND chapter_number=1;

  -- John 1:1
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 1,
    'ఆదియందు వాక్యముండెను; వాక్యము దేవునియొద్ద ఉండెను; వాక్యము దేవుడైయుండెను.',
    'In the beginning was the Word, and the Word was with God, and the Word was God.',
    'ādiyandu vākyamuṇḍenu; vākyamu dēvuniyodda uṇḍenu; vākyamu dēvuḍaiyuṇḍenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ఆదియందు', 'ādiyandu', 'In the beginning', 1),
    (vers_id, 2, 'వాక్యముండెను', 'vākyamuṇḍenu', 'was the Word', 2),
    (vers_id, 3, 'వాక్యము', 'vākyamu', 'the Word', 3),
    (vers_id, 4, 'దేవునియొద్ద', 'dēvuniyodda', 'with God', 4),
    (vers_id, 5, 'ఉండెను', 'uṇḍenu', 'was', 5),
    (vers_id, 6, 'వాక్యము', 'vākyamu', 'the Word', 3),
    (vers_id, 7, 'దేవుడైయుండెను', 'dēvuḍaiyuṇḍenu', 'was God', 6);

  -- John 1:2
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 2,
    'ఆయన ఆదియందు దేవునియొద్ద ఉండెను.',
    'The same was in the beginning with God.',
    'āyana ādiyandu dēvuniyodda uṇḍenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ఆయన', 'āyana', 'The same', 1),
    (vers_id, 2, 'ఆదియందు', 'ādiyandu', 'in the beginning', 2),
    (vers_id, 3, 'దేవునియొద్ద', 'dēvuniyodda', 'with God', 3),
    (vers_id, 4, 'ఉండెను', 'uṇḍenu', 'was', 4);

  -- John 1:3
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 3,
    'సమస్తమును ఆయన మూలముగా కలిగెను; కలిగియున్నదేదియు ఆయన లేకుండ కలుగలేదు.',
    'All things were made through him. Without him, nothing was made that has been made.',
    'samastamunu āyana mūlamugā kaligenu; kaligiyunnadēdiyu āyana lēkuṇḍa kalugalēdu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'సమస్తమును', 'samastamunu', 'All things', 1),
    (vers_id, 2, 'ఆయన', 'āyana', 'him', 2),
    (vers_id, 3, 'మూలముగా', 'mūlamugā', 'through', 3),
    (vers_id, 4, 'కలిగెను', 'kaligenu', 'were made', 4),
    (vers_id, 5, 'కలిగియున్నదేదియు', 'kaligiyunnadēdiyu', 'nothing that has been made', 5),
    (vers_id, 6, 'ఆయన', 'āyana', 'him', 2),
    (vers_id, 7, 'లేకుండ', 'lēkuṇḍa', 'without', 6),
    (vers_id, 8, 'కలుగలేదు', 'kalugalēdu', 'was made', 4);

  -- John 1:4
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 4,
    'ఆయనలో జీవముండెను; ఆ జీవము మనుష్యులకు వెలుగైయుండెను.',
    'In him was life, and the life was the light of men.',
    'āyanalō jīvamuṇḍenu; ā jīvamu manuṣyulaku velugaiyuṇḍenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ఆయనలో', 'āyanalō', 'In him', 1),
    (vers_id, 2, 'జీవముండెను', 'jīvamuṇḍenu', 'was life', 2),
    (vers_id, 3, 'ఆ', 'ā', 'the', 3),
    (vers_id, 4, 'జీవము', 'jīvamu', 'life', 4),
    (vers_id, 5, 'మనుష్యులకు', 'manuṣyulaku', 'of men', 5),
    (vers_id, 6, 'వెలుగైయుండెను', 'velugaiyuṇḍenu', 'was the light', 6);

  -- John 1:5
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 5,
    'ఆ వెలుగు చీకటిలో ప్రకాశించుచున్నది; చీకటి దాని గ్రహింపకుండెను.',
    'The light shines in the darkness, and the darkness hasn''t overcome it.',
    'ā velugu cīkaṭilō prakāśiñcucunnadi; cīkaṭi dāni grahimpakuṇḍenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ఆ', 'ā', 'The', 1),
    (vers_id, 2, 'వెలుగు', 'velugu', 'light', 2),
    (vers_id, 3, 'చీకటిలో', 'cīkaṭilō', 'in the darkness', 3),
    (vers_id, 4, 'ప్రకాశించుచున్నది', 'prakāśiñcucunnadi', 'shines', 4),
    (vers_id, 5, 'చీకటి', 'cīkaṭi', 'the darkness', 5),
    (vers_id, 6, 'దాని', 'dāni', 'it', 6),
    (vers_id, 7, 'గ్రహింపకుండెను', 'grahimpakuṇḍenu', 'hasn''t overcome', 7);

  -- JOHN 3
  INSERT INTO chapters (book_id, chapter_number) VALUES (43, 3)
  ON CONFLICT (book_id, chapter_number) DO NOTHING;
  SELECT id INTO chap_id FROM chapters WHERE book_id=43 AND chapter_number=3;

  -- John 3:16
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 16,
    'దేవుడు లోకమును ఎంతో ప్రేమించెను; కాగా ఆయన తన అద్వితీయకుమారునిగా పుట్టిన వానియందు విశ్వాసముంచు ప్రతివాడును నశింపక నిత్యజీవము పొందునట్లు ఆయనను అనుగ్రహించెను.',
    'For God so loved the world, that he gave his one and only Son, that whoever believes in him should not perish, but have eternal life.',
    'dēvuḍu lōkamunu entō prēmiñcenu; kāgā āyana tana advitīyakumārunigā puṭṭina vāniyandu viśvāsamuñcu prativāḍunu naśimpaka nityajīvamu pondunaṭlu āyananu anugrahiñcenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'లోకమును', 'lōkamunu', 'the world', 2),
    (vers_id, 3, 'ఎంతో', 'entō', 'so', 3),
    (vers_id, 4, 'ప్రేమించెను', 'prēmiñcenu', 'loved', 4),
    (vers_id, 5, 'కాగా', 'kāgā', 'that', 5),
    (vers_id, 6, 'ఆయన', 'āyana', 'he', 6),
    (vers_id, 7, 'తన', 'tana', 'his', 7),
    (vers_id, 8, 'అద్వితీయకుమారునిగా', 'advitīyakumārunigā', 'one and only Son', 8),
    (vers_id, 9, 'పుట్టిన', 'puṭṭina', 'begotten', 9),
    (vers_id, 10, 'వానియందు', 'vāniyandu', 'in him', 10),
    (vers_id, 11, 'విశ్వాసముంచు', 'viśvāsamuñcu', 'believes', 11),
    (vers_id, 12, 'ప్రతివాడును', 'prativāḍunu', 'whoever', 12),
    (vers_id, 13, 'నశింపక', 'naśimpaka', 'should not perish', 13),
    (vers_id, 14, 'నిత్యజీవము', 'nityajīvamu', 'eternal life', 14),
    (vers_id, 15, 'పొందునట్లు', 'pondunaṭlu', 'but have', 15),
    (vers_id, 16, 'ఆయనను', 'āyananu', 'him', 6),
    (vers_id, 17, 'అనుగ్రహించెను', 'anugrahiñcenu', 'gave', 16);

  -- MATTHEW 6 (Lord's Prayer)
  INSERT INTO chapters (book_id, chapter_number) VALUES (40, 6)
  ON CONFLICT (book_id, chapter_number) DO NOTHING;
  SELECT id INTO chap_id FROM chapters WHERE book_id=40 AND chapter_number=6;

  -- Matt 6:9
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 9,
    'కాబట్టి మీరు ఈలాగు ప్రార్థనచేయుడి: పరలోకమందున్న మా తండ్రీ, నీ నామము పరిశుద్ధపరచబడుగాక;',
    'Pray like this: Our Father in heaven, may your name be kept holy.',
    'kābaṭṭi mīru īlāgu prārthanacēyuḍi: paralōkamandunna mā taṇḍrī, nī nāmamu pariśuddhaparacabaḍugāka;')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'కాబట్టి', 'kābaṭṭi', 'Therefore', 1),
    (vers_id, 2, 'మీరు', 'mīru', 'you', 2),
    (vers_id, 3, 'ఈలాగు', 'īlāgu', 'like this', 3),
    (vers_id, 4, 'ప్రార్థనచేయుడి', 'prārthanacēyuḍi', 'pray', 4),
    (vers_id, 5, 'పరలోకమందున్న', 'paralōkamandunna', 'in heaven', 5),
    (vers_id, 6, 'మా', 'mā', 'Our', 6),
    (vers_id, 7, 'తండ్రీ', 'taṇḍrī', 'Father', 7),
    (vers_id, 8, 'నీ', 'nī', 'your', 8),
    (vers_id, 9, 'నామము', 'nāmamu', 'name', 9),
    (vers_id, 10, 'పరిశుద్ధపరచబడుగాక', 'pariśuddhaparacabaḍugāka', 'be kept holy', 10);

  -- Matt 6:10
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 10,
    'నీ రాజ్యము వచ్చుగాక; నీ చిత్తము పరలోకమందు నెరవేరుచున్నట్లు భూమియందును నెరవేరుగాక;',
    'Let your Kingdom come. Let your will be done on earth, as it is in heaven.',
    'nī rājyamu vaccugāka; nī cittamu paralōkamandu neravērucunnaṭlu bhūmiyandunu neravērugāka;')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'నీ', 'nī', 'your', 1),
    (vers_id, 2, 'రాజ్యము', 'rājyamu', 'Kingdom', 2),
    (vers_id, 3, 'వచ్చుగాక', 'vaccugāka', 'Let come', 3),
    (vers_id, 4, 'నీ', 'nī', 'your', 1),
    (vers_id, 5, 'చిత్తము', 'cittamu', 'will', 4),
    (vers_id, 6, 'పరలోకమందు', 'paralōkamandu', 'in heaven', 5),
    (vers_id, 7, 'నెరవేరుచున్నట్లు', 'neravērucunnaṭlu', 'as it is done', 6),
    (vers_id, 8, 'భూమియందును', 'bhūmiyandunu', 'on earth', 7),
    (vers_id, 9, 'నెరవేరుగాక', 'neravērugāka', 'be done', 8);

  -- Matt 6:11
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 11,
    'మా అనుదినాహారము నేడు మాకు దయచేయుము.',
    'Give us today our daily bread.',
    'mā anudināhāramu nēḍu māku dayacēyumu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'మా', 'mā', 'our', 1),
    (vers_id, 2, 'అనుదినాహారము', 'anudināhāramu', 'daily bread', 2),
    (vers_id, 3, 'నేడు', 'nēḍu', 'today', 3),
    (vers_id, 4, 'మాకు', 'māku', 'us', 4),
    (vers_id, 5, 'దయచేయుము', 'dayacēyumu', 'Give', 5);

  -- Matt 6:12
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 12,
    'మా ఋణస్థులను మేము క్షమించియున్న ప్రకారము మా ఋణములు క్షమించుము.',
    'Forgive us our debts, as we also forgive our debtors.',
    'mā r̥ṇasthulanu mēmu kṣamiñciyunna prakāramu mā r̥ṇamulu kṣamiñcumu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'మా', 'mā', 'our', 1),
    (vers_id, 2, 'ఋణస్థులను', 'r̥ṇasthulanu', 'debtors', 2),
    (vers_id, 3, 'మేము', 'mēmu', 'we', 3),
    (vers_id, 4, 'క్షమించియున్న', 'kṣamiñciyunna', 'also forgive', 4),
    (vers_id, 5, 'ప్రకారము', 'prakāramu', 'as', 5),
    (vers_id, 6, 'మా', 'mā', 'our', 1),
    (vers_id, 7, 'ఋణములు', 'r̥ṇamulu', 'debts', 6),
    (vers_id, 8, 'క్షమించుము', 'kṣamiñcumu', 'Forgive us', 7);

  -- Matt 6:13
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 13,
    'మమ్మును శోధనలోకి తేక దుష్టునినుండి మమ్మును తప్పించుము; రాజ్యమును బలమును మహిమయు యుగయుగములు నీవే గనుక నీకు చెందును. ఆమేన్.',
    'Bring us not into temptation, but deliver us from the evil one. For yours is the Kingdom, the power, and the glory forever. Amen.',
    'mammunu śōdhanalōki tēka duṣṭuninuṇḍi mammunu tappiñcumu; rājyamunu balamunu mahimayu yugayugamulu nīvē ganuka nīku cendunu. āmēn.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'మమ్మును', 'mammunu', 'us', 1),
    (vers_id, 2, 'శోధనలోకి', 'śōdhanalōki', 'into temptation', 2),
    (vers_id, 3, 'తేక', 'tēka', 'Bring not', 3),
    (vers_id, 4, 'దుష్టునినుండి', 'duṣṭuninuṇḍi', 'from the evil one', 4),
    (vers_id, 5, 'మమ్మును', 'mammunu', 'us', 1),
    (vers_id, 6, 'తప్పించుము', 'tappiñcumu', 'deliver', 5),
    (vers_id, 7, 'రాజ్యమును', 'rājyamunu', 'the Kingdom', 6),
    (vers_id, 8, 'బలమును', 'balamunu', 'the power', 7),
    (vers_id, 9, 'మహిమయు', 'mahimayu', 'the glory', 8),
    (vers_id, 10, 'యుగయుగములు', 'yugayugamulu', 'forever', 9),
    (vers_id, 11, 'నీవే', 'nīvē', 'yours', 10),
    (vers_id, 12, 'గనుక', 'ganuka', 'for', 11),
    (vers_id, 13, 'నీకు', 'nīku', 'to you', 12),
    (vers_id, 14, 'చెందును', 'cendunu', 'belong', 13),
    (vers_id, 15, 'ఆమేన్', 'āmēn', 'Amen', 14);

END $$;
