/*
  # Expand Seed Corpus: Genesis 1 (verses 6-31) and Jude (1-25)

  ## Overview
  Adds two large blocks of interlinear content:

  1. Completes Genesis 1 by adding verses 6 through 31 (the existing seed
     covered only verses 1-5). This makes Genesis 1 the second fully
     ingested chapter alongside Psalm 23.
  2. Adds the complete book of Jude (single chapter, 25 verses), giving
     the reader its first fully completed Bible book in the New Testament.

  ## Affected Tables
  - chapters: ensures rows exist for Genesis 1 and Jude 1.
  - verses: inserts (or upserts) verse rows for Gen 1:6-31 and Jude 1:1-25.
  - verse_tokens: replaces tokens for each new verse so per-word
    color-coded alignment between Telugu, transliteration, and English
    is available everywhere.

  ## Security
  No RLS changes. Existing public read policies on these tables continue
  to apply; this migration only inserts/updates content rows.

  ## Notes
  1. Verse rows use ON CONFLICT (chapter_id, verse_number) DO UPDATE to
     refresh the Telugu, English, and transliteration text idempotently.
  2. Per-verse tokens are wiped and re-inserted to keep alignment groups
     consistent on re-runs without corrupting older rows.
  3. Telugu text follows BSI-style phrasing; transliteration follows
     approximate ISO-15919; English uses the World English Bible (public
     domain).
*/

DO $$
DECLARE
  chap_id bigint;
  vers_id bigint;
BEGIN

  -- ============================================================
  -- GENESIS 1 (verses 6-31)
  -- ============================================================
  INSERT INTO chapters (book_id, chapter_number) VALUES (1, 1)
  ON CONFLICT (book_id, chapter_number) DO NOTHING;
  SELECT id INTO chap_id FROM chapters WHERE book_id=1 AND chapter_number=1;

  -- Gen 1:6
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 6,
    'జలముల మధ్య విశాలము కలిగి ఆ జలములను ఈ జలములనుండి వేరుపరచును గాకని దేవుడు పలికెను.',
    'God said, "Let there be an expanse in the middle of the waters, and let it divide the waters from the waters."',
    'jalamula madhya viśālamu kaligi ā jalamulanu ī jalamulanuṇḍi vēruparacunu gākani dēvuḍu palikenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'జలముల', 'jalamula', 'of the waters', 1),
    (vers_id, 2, 'మధ్య', 'madhya', 'in the middle', 2),
    (vers_id, 3, 'విశాలము', 'viśālamu', 'an expanse', 3),
    (vers_id, 4, 'కలిగి', 'kaligi', 'let there be', 4),
    (vers_id, 5, 'ఆ', 'ā', 'the', 5),
    (vers_id, 6, 'జలములను', 'jalamulanu', 'the waters', 1),
    (vers_id, 7, 'ఈ', 'ī', 'these', 5),
    (vers_id, 8, 'జలములనుండి', 'jalamulanuṇḍi', 'from the waters', 1),
    (vers_id, 9, 'వేరుపరచును', 'vēruparacunu', 'divide', 6),
    (vers_id, 10, 'గాకని', 'gākani', 'let it', 7),
    (vers_id, 11, 'దేవుడు', 'dēvuḍu', 'God', 8),
    (vers_id, 12, 'పలికెను', 'palikenu', 'said', 9);

  -- Gen 1:7
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 7,
    'దేవుడు ఆ విశాలమును చేసి విశాలము క్రిందనున్న జలములను విశాలము పైనున్న జలములనుండి వేరుపరచెను; ఆ ప్రకారమాయెను.',
    'God made the expanse, and divided the waters which were under the expanse from the waters which were above the expanse; and it was so.',
    'dēvuḍu ā viśālamunu cēsi viśālamu krindanunna jalamulanu viśālamu painunna jalamulanuṇḍi vēruparacenu; ā prakāramāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'ఆ', 'ā', 'the', 2),
    (vers_id, 3, 'విశాలమును', 'viśālamunu', 'expanse', 3),
    (vers_id, 4, 'చేసి', 'cēsi', 'made', 4),
    (vers_id, 5, 'విశాలము', 'viśālamu', 'the expanse', 3),
    (vers_id, 6, 'క్రిందనున్న', 'krindanunna', 'which were under', 5),
    (vers_id, 7, 'జలములను', 'jalamulanu', 'the waters', 6),
    (vers_id, 8, 'విశాలము', 'viśālamu', 'the expanse', 3),
    (vers_id, 9, 'పైనున్న', 'painunna', 'which were above', 7),
    (vers_id, 10, 'జలములనుండి', 'jalamulanuṇḍi', 'from the waters', 6),
    (vers_id, 11, 'వేరుపరచెను', 'vēruparacenu', 'divided', 8),
    (vers_id, 12, 'ఆ', 'ā', 'and', 9),
    (vers_id, 13, 'ప్రకారమాయెను', 'prakāramāyenu', 'it was so', 10);

  -- Gen 1:8
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 8,
    'దేవుడు ఆ విశాలమునకు ఆకాశమని పేరు పెట్టెను. అస్తమయము ఉదయము కలుగగా రెండవ దినమాయెను.',
    'God called the expanse "sky." There was evening and there was morning, a second day.',
    'dēvuḍu ā viśālamunaku ākāśamani pēru peṭṭenu. astamayamu udayamu kalugagā reṇḍava dinamāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'ఆ', 'ā', 'the', 2),
    (vers_id, 3, 'విశాలమునకు', 'viśālamunaku', 'expanse', 3),
    (vers_id, 4, 'ఆకాశమని', 'ākāśamani', 'sky', 4),
    (vers_id, 5, 'పేరు', 'pēru', 'name', 5),
    (vers_id, 6, 'పెట్టెను', 'peṭṭenu', 'called', 6),
    (vers_id, 7, 'అస్తమయము', 'astamayamu', 'evening', 7),
    (vers_id, 8, 'ఉదయము', 'udayamu', 'morning', 8),
    (vers_id, 9, 'కలుగగా', 'kalugagā', 'there was', 9),
    (vers_id, 10, 'రెండవ', 'reṇḍava', 'a second', 10),
    (vers_id, 11, 'దినమాయెను', 'dinamāyenu', 'day', 11);

  -- Gen 1:9
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 9,
    'దేవుడు ఆకాశము క్రిందనున్న జలములు ఒక చోటికి చేరి యెండిన నేల కనబడును గాకని పలుకగా ఆ ప్రకారమాయెను.',
    'God said, "Let the waters under the sky be gathered together to one place, and let the dry land appear;" and it was so.',
    'dēvuḍu ākāśamu krindanunna jalamulu oka cōṭiki cēri yeṇḍina nēla kanabaḍunu gākani palukagā ā prakāramāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'ఆకాశము', 'ākāśamu', 'the sky', 2),
    (vers_id, 3, 'క్రిందనున్న', 'krindanunna', 'under', 3),
    (vers_id, 4, 'జలములు', 'jalamulu', 'the waters', 4),
    (vers_id, 5, 'ఒక', 'oka', 'one', 5),
    (vers_id, 6, 'చోటికి', 'cōṭiki', 'to place', 6),
    (vers_id, 7, 'చేరి', 'cēri', 'be gathered together', 7),
    (vers_id, 8, 'యెండిన', 'yeṇḍina', 'the dry', 8),
    (vers_id, 9, 'నేల', 'nēla', 'land', 9),
    (vers_id, 10, 'కనబడును', 'kanabaḍunu', 'appear', 10),
    (vers_id, 11, 'గాకని', 'gākani', 'let', 11),
    (vers_id, 12, 'పలుకగా', 'palukagā', 'said', 12),
    (vers_id, 13, 'ఆ', 'ā', 'and', 13),
    (vers_id, 14, 'ప్రకారమాయెను', 'prakāramāyenu', 'it was so', 14);

  -- Gen 1:10
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 10,
    'దేవుడు ఆ యెండిన నేలకు భూమి అని పేరుపెట్టెను; జలముల సముదాయమునకు సముద్రములని పేరుపెట్టెను; అది మంచిదని దేవుడు చూచెను.',
    'God called the dry land "earth," and the gathering together of the waters he called "seas." God saw that it was good.',
    'dēvuḍu ā yeṇḍina nēlaku bhūmi ani pēruPeṭṭenu; jalamula samudāyamunaku samudramulani pēruPeṭṭenu; adi mañcidani dēvuḍu cūcenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'ఆ', 'ā', 'the', 2),
    (vers_id, 3, 'యెండిన', 'yeṇḍina', 'dry', 3),
    (vers_id, 4, 'నేలకు', 'nēlaku', 'land', 4),
    (vers_id, 5, 'భూమి', 'bhūmi', 'earth', 5),
    (vers_id, 6, 'అని', 'ani', 'as', 6),
    (vers_id, 7, 'పేరుపెట్టెను', 'pēruPeṭṭenu', 'called', 7),
    (vers_id, 8, 'జలముల', 'jalamula', 'of the waters', 8),
    (vers_id, 9, 'సముదాయమునకు', 'samudāyamunaku', 'gathering together', 9),
    (vers_id, 10, 'సముద్రములని', 'samudramulani', 'seas', 10),
    (vers_id, 11, 'పేరుపెట్టెను', 'pēruPeṭṭenu', 'he called', 7),
    (vers_id, 12, 'అది', 'adi', 'it', 11),
    (vers_id, 13, 'మంచిదని', 'mañcidani', 'was good', 12),
    (vers_id, 14, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 15, 'చూచెను', 'cūcenu', 'saw', 13);

  -- Gen 1:11
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 11,
    'దేవుడు భూమి గడ్డిని విత్తనములిచ్చు చెట్లను భూమిమీద తమ తమ జాతుల ప్రకారము ఫలించు ఫలవృక్షములను పుట్టించును గాకని పలికెను; ఆ ప్రకారమాయెను.',
    'God said, "Let the earth yield grass, herbs yielding seeds, and fruit trees bearing fruit after their kind, with their seeds in it, on the earth;" and it was so.',
    'dēvuḍu bhūmi gaḍḍini vittanamuliccu ceṭlanu bhūmimīda tama tama jātula prakāramu phaliñcu phalavr̥kṣamulanu puṭṭiñcunu gākani palikenu; ā prakāramāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'భూమి', 'bhūmi', 'the earth', 2),
    (vers_id, 3, 'గడ్డిని', 'gaḍḍini', 'grass', 3),
    (vers_id, 4, 'విత్తనములిచ్చు', 'vittanamuliccu', 'yielding seeds', 4),
    (vers_id, 5, 'చెట్లను', 'ceṭlanu', 'herbs', 5),
    (vers_id, 6, 'భూమిమీద', 'bhūmimīda', 'on the earth', 6),
    (vers_id, 7, 'తమ', 'tama', 'their', 7),
    (vers_id, 8, 'తమ', 'tama', 'own', 7),
    (vers_id, 9, 'జాతుల', 'jātula', 'kinds', 8),
    (vers_id, 10, 'ప్రకారము', 'prakāramu', 'after', 9),
    (vers_id, 11, 'ఫలించు', 'phaliñcu', 'bearing', 10),
    (vers_id, 12, 'ఫలవృక్షములను', 'phalavr̥kṣamulanu', 'fruit trees', 11),
    (vers_id, 13, 'పుట్టించును', 'puṭṭiñcunu', 'yield', 12),
    (vers_id, 14, 'గాకని', 'gākani', 'let', 13),
    (vers_id, 15, 'పలికెను', 'palikenu', 'said', 14),
    (vers_id, 16, 'ఆ', 'ā', 'and', 15),
    (vers_id, 17, 'ప్రకారమాయెను', 'prakāramāyenu', 'it was so', 16);

  -- Gen 1:12
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 12,
    'భూమి గడ్డిని తమ తమ జాతుల ప్రకారము విత్తనములిచ్చు చెట్లను తమలో విత్తనములుగల ఫలములిచ్చు వృక్షములను పుట్టించెను; అది మంచిదని దేవుడు చూచెను.',
    'The earth yielded grass, herbs yielding seed after their kind, and trees bearing fruit, with their seeds in it, after their kind; and God saw that it was good.',
    'bhūmi gaḍḍini tama tama jātula prakāramu vittanamuliccu ceṭlanu tamalō vittanamulugala phalamuliccu vr̥kṣamulanu puṭṭiñcenu; adi mañcidani dēvuḍu cūcenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'భూమి', 'bhūmi', 'The earth', 1),
    (vers_id, 2, 'గడ్డిని', 'gaḍḍini', 'grass', 2),
    (vers_id, 3, 'తమ', 'tama', 'their', 3),
    (vers_id, 4, 'తమ', 'tama', 'own', 3),
    (vers_id, 5, 'జాతుల', 'jātula', 'kinds', 4),
    (vers_id, 6, 'ప్రకారము', 'prakāramu', 'after', 5),
    (vers_id, 7, 'విత్తనములిచ్చు', 'vittanamuliccu', 'yielding seed', 6),
    (vers_id, 8, 'చెట్లను', 'ceṭlanu', 'herbs', 7),
    (vers_id, 9, 'తమలో', 'tamalō', 'in it', 8),
    (vers_id, 10, 'విత్తనములుగల', 'vittanamulugala', 'with seeds', 9),
    (vers_id, 11, 'ఫలములిచ్చు', 'phalamuliccu', 'bearing fruit', 10),
    (vers_id, 12, 'వృక్షములను', 'vr̥kṣamulanu', 'trees', 11),
    (vers_id, 13, 'పుట్టించెను', 'puṭṭiñcenu', 'yielded', 12),
    (vers_id, 14, 'అది', 'adi', 'it', 13),
    (vers_id, 15, 'మంచిదని', 'mañcidani', 'was good', 14),
    (vers_id, 16, 'దేవుడు', 'dēvuḍu', 'God', 15),
    (vers_id, 17, 'చూచెను', 'cūcenu', 'saw', 16);

  -- Gen 1:13
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 13,
    'అస్తమయము ఉదయము కలుగగా మూడవ దినమాయెను.',
    'There was evening and there was morning, a third day.',
    'astamayamu udayamu kalugagā mūḍava dinamāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'అస్తమయము', 'astamayamu', 'evening', 1),
    (vers_id, 2, 'ఉదయము', 'udayamu', 'morning', 2),
    (vers_id, 3, 'కలుగగా', 'kalugagā', 'there was', 3),
    (vers_id, 4, 'మూడవ', 'mūḍava', 'a third', 4),
    (vers_id, 5, 'దినమాయెను', 'dinamāyenu', 'day', 5);

  -- Gen 1:14
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 14,
    'దేవుడు పగటిని రాత్రిని వేరుపరచుటకు ఆకాశ విశాలములో జ్యోతులు కలుగును గాకని పలికెను; అవి సూచనలుగాను కాలములను దినములను సంవత్సరములను గుర్తుపరచుటకు ఉండును గాక;',
    'God said, "Let there be lights in the expanse of sky to divide the day from the night; and let them be for signs to mark seasons, days, and years;"',
    'dēvuḍu pagaṭini rātrini vēruparacuṭaku ākāśa viśālamulō jyōtulu kalugunu gākani palikenu; avi sūcanalugānu kālamulanu dinamulanu saṁvatsaramulanu gurtuparacuṭaku uṇḍunu gāka;')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'పగటిని', 'pagaṭini', 'the day', 2),
    (vers_id, 3, 'రాత్రిని', 'rātrini', 'the night', 3),
    (vers_id, 4, 'వేరుపరచుటకు', 'vēruparacuṭaku', 'to divide', 4),
    (vers_id, 5, 'ఆకాశ', 'ākāśa', 'of sky', 5),
    (vers_id, 6, 'విశాలములో', 'viśālamulō', 'in the expanse', 6),
    (vers_id, 7, 'జ్యోతులు', 'jyōtulu', 'lights', 7),
    (vers_id, 8, 'కలుగును', 'kalugunu', 'let there be', 8),
    (vers_id, 9, 'గాకని', 'gākani', 'let', 9),
    (vers_id, 10, 'పలికెను', 'palikenu', 'said', 10),
    (vers_id, 11, 'అవి', 'avi', 'them', 11),
    (vers_id, 12, 'సూచనలుగాను', 'sūcanalugānu', 'for signs', 12),
    (vers_id, 13, 'కాలములను', 'kālamulanu', 'seasons', 13),
    (vers_id, 14, 'దినములను', 'dinamulanu', 'days', 14),
    (vers_id, 15, 'సంవత్సరములను', 'saṁvatsaramulanu', 'and years', 15),
    (vers_id, 16, 'గుర్తుపరచుటకు', 'gurtuparacuṭaku', 'to mark', 16),
    (vers_id, 17, 'ఉండును', 'uṇḍunu', 'be', 17),
    (vers_id, 18, 'గాక', 'gāka', 'let', 9);

  -- Gen 1:15
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 15,
    'మరియు అవి భూమిమీద వెలుగిచ్చుటకు ఆకాశ విశాలములో జ్యోతులుగా ఉండును గాక; ఆ ప్రకారమాయెను.',
    'and let them be for lights in the expanse of sky to give light on the earth; and it was so.',
    'mariyu avi bhūmimīda velugiccuṭaku ākāśa viśālamulō jyōtulugā uṇḍunu gāka; ā prakāramāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'మరియు', 'mariyu', 'and', 1),
    (vers_id, 2, 'అవి', 'avi', 'them', 2),
    (vers_id, 3, 'భూమిమీద', 'bhūmimīda', 'on the earth', 3),
    (vers_id, 4, 'వెలుగిచ్చుటకు', 'velugiccuṭaku', 'to give light', 4),
    (vers_id, 5, 'ఆకాశ', 'ākāśa', 'of sky', 5),
    (vers_id, 6, 'విశాలములో', 'viśālamulō', 'in the expanse', 6),
    (vers_id, 7, 'జ్యోతులుగా', 'jyōtulugā', 'for lights', 7),
    (vers_id, 8, 'ఉండును', 'uṇḍunu', 'be', 8),
    (vers_id, 9, 'గాక', 'gāka', 'let', 9),
    (vers_id, 10, 'ఆ', 'ā', 'and', 10),
    (vers_id, 11, 'ప్రకారమాయెను', 'prakāramāyenu', 'it was so', 11);

  -- Gen 1:16
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 16,
    'దేవుడు రెండు గొప్ప జ్యోతులను చేసెను; పగటిని ఏలుటకు పెద్ద జ్యోతిని, రాత్రిని ఏలుటకు చిన్న జ్యోతిని చేసెను; నక్షత్రములనుకూడ చేసెను.',
    'God made the two great lights: the greater light to rule the day, and the lesser light to rule the night. He also made the stars.',
    'dēvuḍu reṇḍu goppa jyōtulanu cēsenu; pagaṭini ēluṭaku pedda jyōtini, rātrini ēluṭaku cinna jyōtini cēsenu; nakṣatramulanukūḍa cēsenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'రెండు', 'reṇḍu', 'two', 2),
    (vers_id, 3, 'గొప్ప', 'goppa', 'great', 3),
    (vers_id, 4, 'జ్యోతులను', 'jyōtulanu', 'lights', 4),
    (vers_id, 5, 'చేసెను', 'cēsenu', 'made', 5),
    (vers_id, 6, 'పగటిని', 'pagaṭini', 'the day', 6),
    (vers_id, 7, 'ఏలుటకు', 'ēluṭaku', 'to rule', 7),
    (vers_id, 8, 'పెద్ద', 'pedda', 'the greater', 8),
    (vers_id, 9, 'జ్యోతిని', 'jyōtini', 'light', 9),
    (vers_id, 10, 'రాత్రిని', 'rātrini', 'the night', 10),
    (vers_id, 11, 'ఏలుటకు', 'ēluṭaku', 'to rule', 7),
    (vers_id, 12, 'చిన్న', 'cinna', 'the lesser', 11),
    (vers_id, 13, 'జ్యోతిని', 'jyōtini', 'light', 9),
    (vers_id, 14, 'చేసెను', 'cēsenu', 'made', 5),
    (vers_id, 15, 'నక్షత్రములనుకూడ', 'nakṣatramulanukūḍa', 'also the stars', 12),
    (vers_id, 16, 'చేసెను', 'cēsenu', 'He made', 5);

  -- Gen 1:17
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 17,
    'భూమిమీద వెలుగిచ్చుటకు దేవుడు ఆకాశ విశాలములో వాటిని ఉంచెను.',
    'God set them in the expanse of sky to give light to the earth,',
    'bhūmimīda velugiccuṭaku dēvuḍu ākāśa viśālamulō vāṭini uñcenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'భూమిమీద', 'bhūmimīda', 'to the earth', 1),
    (vers_id, 2, 'వెలుగిచ్చుటకు', 'velugiccuṭaku', 'to give light', 2),
    (vers_id, 3, 'దేవుడు', 'dēvuḍu', 'God', 3),
    (vers_id, 4, 'ఆకాశ', 'ākāśa', 'of sky', 4),
    (vers_id, 5, 'విశాలములో', 'viśālamulō', 'in the expanse', 5),
    (vers_id, 6, 'వాటిని', 'vāṭini', 'them', 6),
    (vers_id, 7, 'ఉంచెను', 'uñcenu', 'set', 7);

  -- Gen 1:18
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 18,
    'పగటిని రాత్రిని ఏలుటకును వెలుగును చీకటిని వేరుపరచుటకును వాటిని ఉంచెను; అది మంచిదని దేవుడు చూచెను.',
    'and to rule over the day and over the night, and to divide the light from the darkness. God saw that it was good.',
    'pagaṭini rātrini ēluṭakunu velugunu cīkaṭini vēruparacuṭakunu vāṭini uñcenu; adi mañcidani dēvuḍu cūcenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'పగటిని', 'pagaṭini', 'over the day', 1),
    (vers_id, 2, 'రాత్రిని', 'rātrini', 'over the night', 2),
    (vers_id, 3, 'ఏలుటకును', 'ēluṭakunu', 'to rule', 3),
    (vers_id, 4, 'వెలుగును', 'velugunu', 'the light', 4),
    (vers_id, 5, 'చీకటిని', 'cīkaṭini', 'from the darkness', 5),
    (vers_id, 6, 'వేరుపరచుటకును', 'vēruparacuṭakunu', 'to divide', 6),
    (vers_id, 7, 'వాటిని', 'vāṭini', 'them', 7),
    (vers_id, 8, 'ఉంచెను', 'uñcenu', 'set', 8),
    (vers_id, 9, 'అది', 'adi', 'it', 9),
    (vers_id, 10, 'మంచిదని', 'mañcidani', 'was good', 10),
    (vers_id, 11, 'దేవుడు', 'dēvuḍu', 'God', 11),
    (vers_id, 12, 'చూచెను', 'cūcenu', 'saw', 12);

  -- Gen 1:19
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 19,
    'అస్తమయము ఉదయము కలుగగా నాలుగవ దినమాయెను.',
    'There was evening and there was morning, a fourth day.',
    'astamayamu udayamu kalugagā nālugava dinamāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'అస్తమయము', 'astamayamu', 'evening', 1),
    (vers_id, 2, 'ఉదయము', 'udayamu', 'morning', 2),
    (vers_id, 3, 'కలుగగా', 'kalugagā', 'there was', 3),
    (vers_id, 4, 'నాలుగవ', 'nālugava', 'a fourth', 4),
    (vers_id, 5, 'దినమాయెను', 'dinamāyenu', 'day', 5);

  -- Gen 1:20
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 20,
    'దేవుడు జలములు జీవముగల జంతువులను సమృద్ధిగా పుట్టించును గాక; భూమిపైన ఆకాశ విశాలములో పక్షులు ఎగురును గాకని పలికెను.',
    'God said, "Let the waters abound with living creatures, and let birds fly above the earth in the open expanse of sky."',
    'dēvuḍu jalamulu jīvamugala jantuvulanu samr̥ddhigā puṭṭiñcunu gāka; bhūmipaina ākāśa viśālamulō pakṣulu egurunu gākani palikenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'జలములు', 'jalamulu', 'the waters', 2),
    (vers_id, 3, 'జీవముగల', 'jīvamugala', 'living', 3),
    (vers_id, 4, 'జంతువులను', 'jantuvulanu', 'creatures', 4),
    (vers_id, 5, 'సమృద్ధిగా', 'samr̥ddhigā', 'abound', 5),
    (vers_id, 6, 'పుట్టించును', 'puṭṭiñcunu', 'with', 6),
    (vers_id, 7, 'గాక', 'gāka', 'let', 7),
    (vers_id, 8, 'భూమిపైన', 'bhūmipaina', 'above the earth', 8),
    (vers_id, 9, 'ఆకాశ', 'ākāśa', 'of sky', 9),
    (vers_id, 10, 'విశాలములో', 'viśālamulō', 'in the open expanse', 10),
    (vers_id, 11, 'పక్షులు', 'pakṣulu', 'birds', 11),
    (vers_id, 12, 'ఎగురును', 'egurunu', 'fly', 12),
    (vers_id, 13, 'గాకని', 'gākani', 'and let', 7),
    (vers_id, 14, 'పలికెను', 'palikenu', 'said', 13);

  -- Gen 1:21
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 21,
    'దేవుడు మహా మత్స్యములను జలములు తమ తమ జాతుల ప్రకారము సమృద్ధిగా పుట్టించిన జీవముగల ప్రతి జంతువును రెక్కలుగల ప్రతి పక్షిని తమ తమ జాతుల ప్రకారము సృజించెను; అది మంచిదని దేవుడు చూచెను.',
    'God created the large sea creatures, and every living creature that moves, with which the waters swarmed, after their kind, and every winged bird after its kind. God saw that it was good.',
    'dēvuḍu mahā matsyamulanu jalamulu tama tama jātula prakāramu samr̥ddhigā puṭṭiñcina jīvamugala prati jantuvunu rekkalugala prati pakṣini tama tama jātula prakāramu sr̥jiñcenu; adi mañcidani dēvuḍu cūcenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'మహా', 'mahā', 'large', 2),
    (vers_id, 3, 'మత్స్యములను', 'matsyamulanu', 'sea creatures', 3),
    (vers_id, 4, 'జలములు', 'jalamulu', 'the waters', 4),
    (vers_id, 5, 'తమ', 'tama', 'their', 5),
    (vers_id, 6, 'తమ', 'tama', 'own', 5),
    (vers_id, 7, 'జాతుల', 'jātula', 'kind', 6),
    (vers_id, 8, 'ప్రకారము', 'prakāramu', 'after', 7),
    (vers_id, 9, 'సమృద్ధిగా', 'samr̥ddhigā', 'swarmed', 8),
    (vers_id, 10, 'పుట్టించిన', 'puṭṭiñcina', 'with which', 9),
    (vers_id, 11, 'జీవముగల', 'jīvamugala', 'living', 10),
    (vers_id, 12, 'ప్రతి', 'prati', 'every', 11),
    (vers_id, 13, 'జంతువును', 'jantuvunu', 'creature that moves', 12),
    (vers_id, 14, 'రెక్కలుగల', 'rekkalugala', 'winged', 13),
    (vers_id, 15, 'ప్రతి', 'prati', 'every', 11),
    (vers_id, 16, 'పక్షిని', 'pakṣini', 'bird', 14),
    (vers_id, 17, 'తమ', 'tama', 'its', 5),
    (vers_id, 18, 'తమ', 'tama', 'own', 5),
    (vers_id, 19, 'జాతుల', 'jātula', 'kind', 6),
    (vers_id, 20, 'ప్రకారము', 'prakāramu', 'after', 7),
    (vers_id, 21, 'సృజించెను', 'sr̥jiñcenu', 'created', 15),
    (vers_id, 22, 'అది', 'adi', 'it', 16),
    (vers_id, 23, 'మంచిదని', 'mañcidani', 'was good', 17),
    (vers_id, 24, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 25, 'చూచెను', 'cūcenu', 'saw', 18);

  -- Gen 1:22
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 22,
    'దేవుడు వాటిని ఆశీర్వదించి—మీరు ఫలించి సమృద్ధిగా అభివృద్ధిపొంది సముద్ర జలములలో నిండియుండుడని, పక్షులు భూమిమీద విస్తారముగా అభివృద్ధి పొందుగాకని చెప్పెను.',
    'God blessed them, saying, "Be fruitful, and multiply, and fill the waters in the seas, and let birds multiply on the earth."',
    'dēvuḍu vāṭini āśīrvadiñci—mīru phaliñci samr̥ddhigā abhivr̥ddhipondi samudra jalamulalō niṇḍiyuṇḍuḍani, pakṣulu bhūmimīda vistāramugā abhivr̥ddhi pondugākani ceppenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'వాటిని', 'vāṭini', 'them', 2),
    (vers_id, 3, 'ఆశీర్వదించి', 'āśīrvadiñci', 'blessed', 3),
    (vers_id, 4, 'మీరు', 'mīru', 'you', 4),
    (vers_id, 5, 'ఫలించి', 'phaliñci', 'be fruitful', 5),
    (vers_id, 6, 'సమృద్ధిగా', 'samr̥ddhigā', 'abundantly', 6),
    (vers_id, 7, 'అభివృద్ధిపొంది', 'abhivr̥ddhipondi', 'multiply', 7),
    (vers_id, 8, 'సముద్ర', 'samudra', 'in the seas', 8),
    (vers_id, 9, 'జలములలో', 'jalamulalō', 'the waters', 9),
    (vers_id, 10, 'నిండియుండుడని', 'niṇḍiyuṇḍuḍani', 'fill', 10),
    (vers_id, 11, 'పక్షులు', 'pakṣulu', 'birds', 11),
    (vers_id, 12, 'భూమిమీద', 'bhūmimīda', 'on the earth', 12),
    (vers_id, 13, 'విస్తారముగా', 'vistāramugā', 'greatly', 13),
    (vers_id, 14, 'అభివృద్ధి', 'abhivr̥ddhi', 'multiply', 7),
    (vers_id, 15, 'పొందుగాకని', 'pondugākani', 'let', 14),
    (vers_id, 16, 'చెప్పెను', 'ceppenu', 'saying', 15);

  -- Gen 1:23
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 23,
    'అస్తమయము ఉదయము కలుగగా అయిదవ దినమాయెను.',
    'There was evening and there was morning, a fifth day.',
    'astamayamu udayamu kalugagā ayidava dinamāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'అస్తమయము', 'astamayamu', 'evening', 1),
    (vers_id, 2, 'ఉదయము', 'udayamu', 'morning', 2),
    (vers_id, 3, 'కలుగగా', 'kalugagā', 'there was', 3),
    (vers_id, 4, 'అయిదవ', 'ayidava', 'a fifth', 4),
    (vers_id, 5, 'దినమాయెను', 'dinamāyenu', 'day', 5);

  -- Gen 1:24
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 24,
    'దేవుడు భూమి జీవముగల జంతువులను తమ తమ జాతుల ప్రకారము పశువులను పురుగులను అడవి జంతువులను తమ తమ జాతుల ప్రకారము పుట్టించును గాకని పలికెను; ఆ ప్రకారమాయెను.',
    'God said, "Let the earth produce living creatures after their kind, livestock, creeping things, and animals of the earth after their kind;" and it was so.',
    'dēvuḍu bhūmi jīvamugala jantuvulanu tama tama jātula prakāramu paśuvulanu purugulanu aḍavi jantuvulanu tama tama jātula prakāramu puṭṭiñcunu gākani palikenu; ā prakāramāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'భూమి', 'bhūmi', 'the earth', 2),
    (vers_id, 3, 'జీవముగల', 'jīvamugala', 'living', 3),
    (vers_id, 4, 'జంతువులను', 'jantuvulanu', 'creatures', 4),
    (vers_id, 5, 'తమ', 'tama', 'their', 5),
    (vers_id, 6, 'తమ', 'tama', 'own', 5),
    (vers_id, 7, 'జాతుల', 'jātula', 'kind', 6),
    (vers_id, 8, 'ప్రకారము', 'prakāramu', 'after', 7),
    (vers_id, 9, 'పశువులను', 'paśuvulanu', 'livestock', 8),
    (vers_id, 10, 'పురుగులను', 'purugulanu', 'creeping things', 9),
    (vers_id, 11, 'అడవి', 'aḍavi', 'wild', 10),
    (vers_id, 12, 'జంతువులను', 'jantuvulanu', 'animals of the earth', 11),
    (vers_id, 13, 'తమ', 'tama', 'their', 5),
    (vers_id, 14, 'తమ', 'tama', 'own', 5),
    (vers_id, 15, 'జాతుల', 'jātula', 'kind', 6),
    (vers_id, 16, 'ప్రకారము', 'prakāramu', 'after', 7),
    (vers_id, 17, 'పుట్టించును', 'puṭṭiñcunu', 'produce', 12),
    (vers_id, 18, 'గాకని', 'gākani', 'let', 13),
    (vers_id, 19, 'పలికెను', 'palikenu', 'said', 14),
    (vers_id, 20, 'ఆ', 'ā', 'and', 15),
    (vers_id, 21, 'ప్రకారమాయెను', 'prakāramāyenu', 'it was so', 16);

  -- Gen 1:25
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 25,
    'దేవుడు భూ జంతువులను తమ తమ జాతుల ప్రకారము పశువులను తమ తమ జాతుల ప్రకారము నేలను ప్రాకు ప్రతి పురుగును దాని జాతి ప్రకారము చేసెను; అది మంచిదని దేవుడు చూచెను.',
    'God made the animals of the earth after their kind, and the livestock after their kind, and everything that creeps on the ground after its kind. God saw that it was good.',
    'dēvuḍu bhū jantuvulanu tama tama jātula prakāramu paśuvulanu tama tama jātula prakāramu nēlanu prāku prati purugunu dāni jāti prakāramu cēsenu; adi mañcidani dēvuḍu cūcenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'భూ', 'bhū', 'of the earth', 2),
    (vers_id, 3, 'జంతువులను', 'jantuvulanu', 'animals', 3),
    (vers_id, 4, 'తమ', 'tama', 'their', 4),
    (vers_id, 5, 'తమ', 'tama', 'own', 4),
    (vers_id, 6, 'జాతుల', 'jātula', 'kind', 5),
    (vers_id, 7, 'ప్రకారము', 'prakāramu', 'after', 6),
    (vers_id, 8, 'పశువులను', 'paśuvulanu', 'the livestock', 7),
    (vers_id, 9, 'తమ', 'tama', 'their', 4),
    (vers_id, 10, 'తమ', 'tama', 'own', 4),
    (vers_id, 11, 'జాతుల', 'jātula', 'kind', 5),
    (vers_id, 12, 'ప్రకారము', 'prakāramu', 'after', 6),
    (vers_id, 13, 'నేలను', 'nēlanu', 'on the ground', 8),
    (vers_id, 14, 'ప్రాకు', 'prāku', 'creeps', 9),
    (vers_id, 15, 'ప్రతి', 'prati', 'every', 10),
    (vers_id, 16, 'పురుగును', 'purugunu', 'thing', 11),
    (vers_id, 17, 'దాని', 'dāni', 'its', 12),
    (vers_id, 18, 'జాతి', 'jāti', 'kind', 5),
    (vers_id, 19, 'ప్రకారము', 'prakāramu', 'after', 6),
    (vers_id, 20, 'చేసెను', 'cēsenu', 'made', 13),
    (vers_id, 21, 'అది', 'adi', 'it', 14),
    (vers_id, 22, 'మంచిదని', 'mañcidani', 'was good', 15),
    (vers_id, 23, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 24, 'చూచెను', 'cūcenu', 'saw', 16);

  -- Gen 1:26
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 26,
    'దేవుడు—మన స్వరూపమందు మన పోలికెచొప్పున నరులను చేయుదము; వారు సముద్రపు చేపలను ఆకాశ పక్షులను పశువులను సమస్త భూమిని భూమిమీద ప్రాకు ప్రతి పురుగును ఏలుదురుగాకని పలికెను.',
    'God said, "Let us make man in our image, after our likeness. Let them have dominion over the fish of the sea, and over the birds of the sky, and over the livestock, and over all the earth, and over every creeping thing that creeps on the earth."',
    'dēvuḍu—mana svarūpamandu mana pōlikecoppuna narulanu cēyudamu; vāru samudrapu cēpalanu ākāśa pakṣulanu paśuvulanu samasta bhūmini bhūmimīda prāku prati purugunu ēlugurugākani palikenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'మన', 'mana', 'our', 2),
    (vers_id, 3, 'స్వరూపమందు', 'svarūpamandu', 'in image', 3),
    (vers_id, 4, 'మన', 'mana', 'our', 2),
    (vers_id, 5, 'పోలికెచొప్పున', 'pōlikecoppuna', 'after likeness', 4),
    (vers_id, 6, 'నరులను', 'narulanu', 'man', 5),
    (vers_id, 7, 'చేయుదము', 'cēyudamu', 'let us make', 6),
    (vers_id, 8, 'వారు', 'vāru', 'them', 7),
    (vers_id, 9, 'సముద్రపు', 'samudrapu', 'of the sea', 8),
    (vers_id, 10, 'చేపలను', 'cēpalanu', 'the fish', 9),
    (vers_id, 11, 'ఆకాశ', 'ākāśa', 'of the sky', 10),
    (vers_id, 12, 'పక్షులను', 'pakṣulanu', 'the birds', 11),
    (vers_id, 13, 'పశువులను', 'paśuvulanu', 'the livestock', 12),
    (vers_id, 14, 'సమస్త', 'samasta', 'all', 13),
    (vers_id, 15, 'భూమిని', 'bhūmini', 'the earth', 14),
    (vers_id, 16, 'భూమిమీద', 'bhūmimīda', 'on the earth', 15),
    (vers_id, 17, 'ప్రాకు', 'prāku', 'that creeps', 16),
    (vers_id, 18, 'ప్రతి', 'prati', 'every', 17),
    (vers_id, 19, 'పురుగును', 'purugunu', 'creeping thing', 18),
    (vers_id, 20, 'ఏలుదురుగాకని', 'ēlugurugākani', 'have dominion', 19),
    (vers_id, 21, 'పలికెను', 'palikenu', 'said', 20);

  -- Gen 1:27
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 27,
    'దేవుడు తన స్వరూపమందు నరుని సృజించెను; దేవుని స్వరూపమందు అతడిని సృజించెను; స్త్రీగాను పురుషునిగాను వారిని సృజించెను.',
    'God created man in his own image. In God''s own image he created him; male and female he created them.',
    'dēvuḍu tana svarūpamandu naruni sr̥jiñcenu; dēvuni svarūpamandu ataḍini sr̥jiñcenu; strīgānu puruṣunigānu vārini sr̥jiñcenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'తన', 'tana', 'his own', 2),
    (vers_id, 3, 'స్వరూపమందు', 'svarūpamandu', 'in image', 3),
    (vers_id, 4, 'నరుని', 'naruni', 'man', 4),
    (vers_id, 5, 'సృజించెను', 'sr̥jiñcenu', 'created', 5),
    (vers_id, 6, 'దేవుని', 'dēvuni', 'God''s', 6),
    (vers_id, 7, 'స్వరూపమందు', 'svarūpamandu', 'in own image', 3),
    (vers_id, 8, 'అతడిని', 'ataḍini', 'him', 7),
    (vers_id, 9, 'సృజించెను', 'sr̥jiñcenu', 'he created', 5),
    (vers_id, 10, 'స్త్రీగాను', 'strīgānu', 'female', 8),
    (vers_id, 11, 'పురుషునిగాను', 'puruṣunigānu', 'and male', 9),
    (vers_id, 12, 'వారిని', 'vārini', 'them', 10),
    (vers_id, 13, 'సృజించెను', 'sr̥jiñcenu', 'he created', 5);

  -- Gen 1:28
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 28,
    'దేవుడు వారిని ఆశీర్వదించెను; ఎట్లనగా—మీరు ఫలించి అభివృద్ధిపొంది భూమిని నింపి దాని లోబరచుకొనుడి; సముద్రపు చేపలను ఆకాశ పక్షులను భూమిమీద ప్రాకు ప్రతి జీవిని ఏలుడని వారితో చెప్పెను.',
    'God blessed them. God said to them, "Be fruitful, multiply, fill the earth, and subdue it. Have dominion over the fish of the sea, over the birds of the sky, and over every living thing that moves on the earth."',
    'dēvuḍu vārini āśīrvadiñcenu; eṭlanagā—mīru phaliñci abhivr̥ddhipondi bhūmini niṁpi dāni lōbaracukonuḍi; samudrapu cēpalanu ākāśa pakṣulanu bhūmimīda prāku prati jīvini ēluḍani vāritō ceppenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'వారిని', 'vārini', 'them', 2),
    (vers_id, 3, 'ఆశీర్వదించెను', 'āśīrvadiñcenu', 'blessed', 3),
    (vers_id, 4, 'ఎట్లనగా', 'eṭlanagā', 'said to', 4),
    (vers_id, 5, 'మీరు', 'mīru', 'you', 5),
    (vers_id, 6, 'ఫలించి', 'phaliñci', 'be fruitful', 6),
    (vers_id, 7, 'అభివృద్ధిపొంది', 'abhivr̥ddhipondi', 'multiply', 7),
    (vers_id, 8, 'భూమిని', 'bhūmini', 'the earth', 8),
    (vers_id, 9, 'నింపి', 'niṁpi', 'fill', 9),
    (vers_id, 10, 'దాని', 'dāni', 'it', 10),
    (vers_id, 11, 'లోబరచుకొనుడి', 'lōbaracukonuḍi', 'and subdue', 11),
    (vers_id, 12, 'సముద్రపు', 'samudrapu', 'of the sea', 12),
    (vers_id, 13, 'చేపలను', 'cēpalanu', 'the fish', 13),
    (vers_id, 14, 'ఆకాశ', 'ākāśa', 'of the sky', 14),
    (vers_id, 15, 'పక్షులను', 'pakṣulanu', 'the birds', 15),
    (vers_id, 16, 'భూమిమీద', 'bhūmimīda', 'on the earth', 16),
    (vers_id, 17, 'ప్రాకు', 'prāku', 'that moves', 17),
    (vers_id, 18, 'ప్రతి', 'prati', 'every', 18),
    (vers_id, 19, 'జీవిని', 'jīvini', 'living thing', 19),
    (vers_id, 20, 'ఏలుడని', 'ēluḍani', 'have dominion', 20),
    (vers_id, 21, 'వారితో', 'vāritō', 'to them', 2),
    (vers_id, 22, 'చెప్పెను', 'ceppenu', 'said', 21);

  -- Gen 1:29
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 29,
    'దేవుడు—ఇదిగో నేను సర్వ భూమిమీద ఉన్న విత్తనములిచ్చు ప్రతి చెట్టును, తమలో విత్తనమిచ్చు వృక్షఫలముగల ప్రతి వృక్షమును మీకు ఇచ్చియున్నాను; అవి మీకు ఆహారమగును.',
    'God said, "Behold, I have given you every herb yielding seed, which is on the surface of all the earth, and every tree, which bears fruit yielding seed. It shall be your food."',
    'dēvuḍu—idigō nēnu sarva bhūmimīda unna vittanamuliccu prati ceṭṭunu, tamalō vittanamiccu vr̥kṣaphalamugala prati vr̥kṣamunu mīku icciyunnānu; avi mīku āhāramagunu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God said', 1),
    (vers_id, 2, 'ఇదిగో', 'idigō', 'Behold', 2),
    (vers_id, 3, 'నేను', 'nēnu', 'I', 3),
    (vers_id, 4, 'సర్వ', 'sarva', 'all', 4),
    (vers_id, 5, 'భూమిమీద', 'bhūmimīda', 'of the earth', 5),
    (vers_id, 6, 'ఉన్న', 'unna', 'on the surface', 6),
    (vers_id, 7, 'విత్తనములిచ్చు', 'vittanamuliccu', 'yielding seed', 7),
    (vers_id, 8, 'ప్రతి', 'prati', 'every', 8),
    (vers_id, 9, 'చెట్టును', 'ceṭṭunu', 'herb', 9),
    (vers_id, 10, 'తమలో', 'tamalō', 'in itself', 10),
    (vers_id, 11, 'విత్తనమిచ్చు', 'vittanamiccu', 'yielding seed', 7),
    (vers_id, 12, 'వృక్షఫలముగల', 'vr̥kṣaphalamugala', 'bearing fruit', 11),
    (vers_id, 13, 'ప్రతి', 'prati', 'every', 8),
    (vers_id, 14, 'వృక్షమును', 'vr̥kṣamunu', 'tree', 12),
    (vers_id, 15, 'మీకు', 'mīku', 'to you', 13),
    (vers_id, 16, 'ఇచ్చియున్నాను', 'icciyunnānu', 'have given', 14),
    (vers_id, 17, 'అవి', 'avi', 'it', 15),
    (vers_id, 18, 'మీకు', 'mīku', 'your', 13),
    (vers_id, 19, 'ఆహారమగును', 'āhāramagunu', 'shall be food', 16);

  -- Gen 1:30
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 30,
    'భూమిపై జీవముగల ప్రతి జంతువునకును ఆకాశ పక్షులన్నిటికిని నేలను ప్రాకుచుండు ప్రతి జీవికిని ఆహారమునకై పచ్చని ప్రతి మొక్కను ఇచ్చియున్నాను; ఆ ప్రకారమాయెను.',
    'To every animal of the earth, and to every bird of the sky, and to everything that creeps on the earth, in which there is life, I have given every green herb for food; and it was so.',
    'bhūmipai jīvamugala prati jantuvunakunu ākāśa pakṣulanniṭikini nēlanu prākucuṇḍu prati jīvikini āhāramunakai paccani prati mokkanu icciyunnānu; ā prakāramāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'భూమిపై', 'bhūmipai', 'of the earth', 1),
    (vers_id, 2, 'జీవముగల', 'jīvamugala', 'in which there is life', 2),
    (vers_id, 3, 'ప్రతి', 'prati', 'every', 3),
    (vers_id, 4, 'జంతువునకును', 'jantuvunakunu', 'animal', 4),
    (vers_id, 5, 'ఆకాశ', 'ākāśa', 'of the sky', 5),
    (vers_id, 6, 'పక్షులన్నిటికిని', 'pakṣulanniṭikini', 'every bird', 6),
    (vers_id, 7, 'నేలను', 'nēlanu', 'on the earth', 7),
    (vers_id, 8, 'ప్రాకుచుండు', 'prākucuṇḍu', 'that creeps', 8),
    (vers_id, 9, 'ప్రతి', 'prati', 'everything', 3),
    (vers_id, 10, 'జీవికిని', 'jīvikini', 'living', 9),
    (vers_id, 11, 'ఆహారమునకై', 'āhāramunakai', 'for food', 10),
    (vers_id, 12, 'పచ్చని', 'paccani', 'green', 11),
    (vers_id, 13, 'ప్రతి', 'prati', 'every', 3),
    (vers_id, 14, 'మొక్కను', 'mokkanu', 'herb', 12),
    (vers_id, 15, 'ఇచ్చియున్నాను', 'icciyunnānu', 'I have given', 13),
    (vers_id, 16, 'ఆ', 'ā', 'and', 14),
    (vers_id, 17, 'ప్రకారమాయెను', 'prakāramāyenu', 'it was so', 15);

  -- Gen 1:31
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 31,
    'దేవుడు తాను చేసిన సమస్తమును చూచినప్పుడు అది బహు మంచిదిగా ఉండెను; అస్తమయము ఉదయము కలుగగా ఆరవ దినమాయెను.',
    'God saw everything that he had made, and behold, it was very good. There was evening and there was morning, a sixth day.',
    'dēvuḍu tānu cēsina samastamunu cūcinappuḍu adi bahu mañcidigā uṇḍenu; astamayamu udayamu kalugagā ārava dinamāyenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'దేవుడు', 'dēvuḍu', 'God', 1),
    (vers_id, 2, 'తాను', 'tānu', 'he', 2),
    (vers_id, 3, 'చేసిన', 'cēsina', 'had made', 3),
    (vers_id, 4, 'సమస్తమును', 'samastamunu', 'everything that', 4),
    (vers_id, 5, 'చూచినప్పుడు', 'cūcinappuḍu', 'saw', 5),
    (vers_id, 6, 'అది', 'adi', 'it', 6),
    (vers_id, 7, 'బహు', 'bahu', 'very', 7),
    (vers_id, 8, 'మంచిదిగా', 'mañcidigā', 'good', 8),
    (vers_id, 9, 'ఉండెను', 'uṇḍenu', 'was', 9),
    (vers_id, 10, 'అస్తమయము', 'astamayamu', 'evening', 10),
    (vers_id, 11, 'ఉదయము', 'udayamu', 'morning', 11),
    (vers_id, 12, 'కలుగగా', 'kalugagā', 'there was', 12),
    (vers_id, 13, 'ఆరవ', 'ārava', 'a sixth', 13),
    (vers_id, 14, 'దినమాయెను', 'dinamāyenu', 'day', 14);

  -- ============================================================
  -- JUDE (chapter 1, verses 1-25)
  -- ============================================================
  INSERT INTO chapters (book_id, chapter_number) VALUES (65, 1)
  ON CONFLICT (book_id, chapter_number) DO NOTHING;
  SELECT id INTO chap_id FROM chapters WHERE book_id=65 AND chapter_number=1;

  -- Jude 1:1
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 1,
    'యేసుక్రీస్తు దాసుడును యాకోబు సహోదరుడునైన యూదా, తండ్రియైన దేవునిచేత ప్రేమింపబడి యేసుక్రీస్తునందు భద్రముగా కాపాడబడిన పిలువబడినవారికి శుభాకాంక్షలు.',
    'Jude, a servant of Jesus Christ, and brother of James, to those who are called, sanctified by God the Father, and kept for Jesus Christ:',
    'yēsukrīstu dāsuḍunu yākōbu sahōdaruḍunaina yūdā, taṇḍriyaina dēvunicēta prēmiṁpabaḍi yēsukrīstunandu bhadramugā kāpāḍabaḍina piluvabaḍinavāriki śubhākāṅkṣalu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'యేసుక్రీస్తు', 'yēsukrīstu', 'of Jesus Christ', 1),
    (vers_id, 2, 'దాసుడును', 'dāsuḍunu', 'a servant', 2),
    (vers_id, 3, 'యాకోబు', 'yākōbu', 'of James', 3),
    (vers_id, 4, 'సహోదరుడునైన', 'sahōdaruḍunaina', 'and brother', 4),
    (vers_id, 5, 'యూదా', 'yūdā', 'Jude', 5),
    (vers_id, 6, 'తండ్రియైన', 'taṇḍriyaina', 'the Father', 6),
    (vers_id, 7, 'దేవునిచేత', 'dēvunicēta', 'by God', 7),
    (vers_id, 8, 'ప్రేమింపబడి', 'prēmiṁpabaḍi', 'sanctified', 8),
    (vers_id, 9, 'యేసుక్రీస్తునందు', 'yēsukrīstunandu', 'for Jesus Christ', 1),
    (vers_id, 10, 'భద్రముగా', 'bhadramugā', 'safely', 9),
    (vers_id, 11, 'కాపాడబడిన', 'kāpāḍabaḍina', 'kept', 10),
    (vers_id, 12, 'పిలువబడినవారికి', 'piluvabaḍinavāriki', 'to those who are called', 11),
    (vers_id, 13, 'శుభాకాంక్షలు', 'śubhākāṅkṣalu', 'greetings', 12);

  -- Jude 1:2
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 2,
    'కనికరమును సమాధానమును ప్రేమయు మీకు విస్తరించును గాక.',
    'Mercy to you and peace and love be multiplied.',
    'kanikaramunu samādhānamunu prēmayu mīku vistariñcunu gāka.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'కనికరమును', 'kanikaramunu', 'mercy', 1),
    (vers_id, 2, 'సమాధానమును', 'samādhānamunu', 'and peace', 2),
    (vers_id, 3, 'ప్రేమయు', 'prēmayu', 'and love', 3),
    (vers_id, 4, 'మీకు', 'mīku', 'to you', 4),
    (vers_id, 5, 'విస్తరించును', 'vistariñcunu', 'be multiplied', 5),
    (vers_id, 6, 'గాక', 'gāka', 'may', 6);

  -- Jude 1:3
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 3,
    'ప్రియులారా, మన అందరి రక్షణవిషయమై మీకు వ్రాయవలెనని నేను అత్యావశ్యకతతో పూనుకొని, పరిశుద్ధులకు ఒక్కసారే అప్పగింపబడిన విశ్వాసముకొరకు మీరు పోరాడవలెనని ప్రబోధించుచు మీకు వ్రాయుచున్నాను.',
    'Beloved, while I was very eager to write to you about our common salvation, I was constrained to write to you exhorting you to contend earnestly for the faith which was once for all delivered to the saints.',
    'priyulārā, mana andari rakṣaṇaviṣayamai mīku vrāyavalenani nēnu atyāvaśyakatatō pūnukoni, pariśuddhulaku okkasārē appagiṁpabaḍina viśvāsamukoraku mīru pōrāḍavalenani prabōdhiñcucu mīku vrāyucunnānu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ప్రియులారా', 'priyulārā', 'Beloved', 1),
    (vers_id, 2, 'మన', 'mana', 'our', 2),
    (vers_id, 3, 'అందరి', 'andari', 'common', 3),
    (vers_id, 4, 'రక్షణవిషయమై', 'rakṣaṇaviṣayamai', 'about salvation', 4),
    (vers_id, 5, 'మీకు', 'mīku', 'to you', 5),
    (vers_id, 6, 'వ్రాయవలెనని', 'vrāyavalenani', 'to write', 6),
    (vers_id, 7, 'నేను', 'nēnu', 'I', 7),
    (vers_id, 8, 'అత్యావశ్యకతతో', 'atyāvaśyakatatō', 'very eager', 8),
    (vers_id, 9, 'పూనుకొని', 'pūnukoni', 'was', 9),
    (vers_id, 10, 'పరిశుద్ధులకు', 'pariśuddhulaku', 'to the saints', 10),
    (vers_id, 11, 'ఒక్కసారే', 'okkasārē', 'once for all', 11),
    (vers_id, 12, 'అప్పగింపబడిన', 'appagiṁpabaḍina', 'delivered', 12),
    (vers_id, 13, 'విశ్వాసముకొరకు', 'viśvāsamukoraku', 'for the faith', 13),
    (vers_id, 14, 'మీరు', 'mīru', 'you', 14),
    (vers_id, 15, 'పోరాడవలెనని', 'pōrāḍavalenani', 'to contend earnestly', 15),
    (vers_id, 16, 'ప్రబోధించుచు', 'prabōdhiñcucu', 'exhorting', 16),
    (vers_id, 17, 'మీకు', 'mīku', 'to you', 5),
    (vers_id, 18, 'వ్రాయుచున్నాను', 'vrāyucunnānu', 'I write', 6);

  -- Jude 1:4
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 4,
    'ఏలయనగా కొందరు మనుష్యులు రహస్యముగా చొరబడియున్నారు; వారు భక్తిహీనులై మన దేవుని కృపను కామాతురత్వమునకు మార్చి, మన అద్వితీయ నాధుడును ప్రభువునైన యేసుక్రీస్తును విసర్జించుచున్నారు; వారికి ఈ తీర్పు పూర్వము నుండి వ్రాయబడియున్నది.',
    'For there are certain men who crept in secretly, even those who were long ago written about for this condemnation: ungodly men, turning the grace of our God into indecency, and denying our only Master, God, and Lord, Jesus Christ.',
    'ēlayanagā kondaru manuṣyulu rahasyamugā corabaḍiyunnāru; vāru bhaktihīnulai mana dēvuni kr̥panu kāmāturatvamunaku mārci, mana advitīya nādhuḍunu prabhuvunaina yēsukrīstunu visarjiñcucunnāru; vāriki ī tīrpu pūrvamu nuṇḍi vrāyabaḍiyunnadi.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ఏలయనగా', 'ēlayanagā', 'for', 1),
    (vers_id, 2, 'కొందరు', 'kondaru', 'certain', 2),
    (vers_id, 3, 'మనుష్యులు', 'manuṣyulu', 'men', 3),
    (vers_id, 4, 'రహస్యముగా', 'rahasyamugā', 'secretly', 4),
    (vers_id, 5, 'చొరబడియున్నారు', 'corabaḍiyunnāru', 'crept in', 5),
    (vers_id, 6, 'వారు', 'vāru', 'who', 6),
    (vers_id, 7, 'భక్తిహీనులై', 'bhaktihīnulai', 'ungodly', 7),
    (vers_id, 8, 'మన', 'mana', 'our', 8),
    (vers_id, 9, 'దేవుని', 'dēvuni', 'God''s', 9),
    (vers_id, 10, 'కృపను', 'kr̥panu', 'grace', 10),
    (vers_id, 11, 'కామాతురత్వమునకు', 'kāmāturatvamunaku', 'into indecency', 11),
    (vers_id, 12, 'మార్చి', 'mārci', 'turning', 12),
    (vers_id, 13, 'మన', 'mana', 'our', 8),
    (vers_id, 14, 'అద్వితీయ', 'advitīya', 'only', 13),
    (vers_id, 15, 'నాధుడును', 'nādhuḍunu', 'Master', 14),
    (vers_id, 16, 'ప్రభువునైన', 'prabhuvunaina', 'and Lord', 15),
    (vers_id, 17, 'యేసుక్రీస్తును', 'yēsukrīstunu', 'Jesus Christ', 16),
    (vers_id, 18, 'విసర్జించుచున్నారు', 'visarjiñcucunnāru', 'denying', 17),
    (vers_id, 19, 'వారికి', 'vāriki', 'about whom', 18),
    (vers_id, 20, 'ఈ', 'ī', 'this', 19),
    (vers_id, 21, 'తీర్పు', 'tīrpu', 'condemnation', 20),
    (vers_id, 22, 'పూర్వము', 'pūrvamu', 'long ago', 21),
    (vers_id, 23, 'నుండి', 'nuṇḍi', 'from', 22),
    (vers_id, 24, 'వ్రాయబడియున్నది', 'vrāyabaḍiyunnadi', 'were written', 23);

  -- Jude 1:5
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 5,
    'మీరు ఈ సంగతులన్నియు ఎరిగియున్నను మీకు జ్ఞాపకము చేయగోరుచున్నాను; ప్రభువు ఐగుప్తు దేశములోనుండి జనులను విడిపించి, వెనుక విశ్వసింపనివారిని నాశనము చేసెను.',
    'Now I desire to remind you, though you already know this, that the Lord, having saved a people out of the land of Egypt, afterward destroyed those who didn''t believe.',
    'mīru ī saṅgatulanniyu erigiyunnanu mīku jñāpakamu cēyagōrucunnānu; prabhuvu aiguptu dēśamulōnuṇḍi janulanu viḍipiñci, venuka viśvasiṁpanivārini nāśanamu cēsenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'మీరు', 'mīru', 'you', 1),
    (vers_id, 2, 'ఈ', 'ī', 'this', 2),
    (vers_id, 3, 'సంగతులన్నియు', 'saṅgatulanniyu', 'all things', 3),
    (vers_id, 4, 'ఎరిగియున్నను', 'erigiyunnanu', 'though already know', 4),
    (vers_id, 5, 'మీకు', 'mīku', 'you', 1),
    (vers_id, 6, 'జ్ఞాపకము', 'jñāpakamu', 'remembrance', 5),
    (vers_id, 7, 'చేయగోరుచున్నాను', 'cēyagōrucunnānu', 'I desire to bring', 6),
    (vers_id, 8, 'ప్రభువు', 'prabhuvu', 'the Lord', 7),
    (vers_id, 9, 'ఐగుప్తు', 'aiguptu', 'of Egypt', 8),
    (vers_id, 10, 'దేశములోనుండి', 'dēśamulōnuṇḍi', 'out of the land', 9),
    (vers_id, 11, 'జనులను', 'janulanu', 'a people', 10),
    (vers_id, 12, 'విడిపించి', 'viḍipiñci', 'having saved', 11),
    (vers_id, 13, 'వెనుక', 'venuka', 'afterward', 12),
    (vers_id, 14, 'విశ్వసింపనివారిని', 'viśvasiṁpanivārini', 'those who did not believe', 13),
    (vers_id, 15, 'నాశనము', 'nāśanamu', 'destruction', 14),
    (vers_id, 16, 'చేసెను', 'cēsenu', 'brought', 15);

  -- Jude 1:6
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 6,
    'మరియు తమ ప్రధానత్వమును నిలుపుకొనక తమ నివాసస్థలమును విడిచిపెట్టిన దేవదూతలను మహా దినపు తీర్పు వరకు, నిత్యబంధకములతో అంధకారములో ఉంచియున్నాడు.',
    'Angels who didn''t keep their first domain, but deserted their own dwelling place, he has kept in everlasting bonds under darkness for the judgment of the great day.',
    'mariyu tama pradhānatvamunu nilupukonaka tama nivāsasthalamunu viḍicipeṭṭina dēvadūtalanu mahā dinapu tīrpu varaku, nityabandhakamulatō andhakāramulō uñciyunnāḍu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'మరియు', 'mariyu', 'and', 1),
    (vers_id, 2, 'తమ', 'tama', 'their', 2),
    (vers_id, 3, 'ప్రధానత్వమును', 'pradhānatvamunu', 'first domain', 3),
    (vers_id, 4, 'నిలుపుకొనక', 'nilupukonaka', 'did not keep', 4),
    (vers_id, 5, 'తమ', 'tama', 'their own', 2),
    (vers_id, 6, 'నివాసస్థలమును', 'nivāsasthalamunu', 'dwelling place', 5),
    (vers_id, 7, 'విడిచిపెట్టిన', 'viḍicipeṭṭina', 'deserted', 6),
    (vers_id, 8, 'దేవదూతలను', 'dēvadūtalanu', 'angels', 7),
    (vers_id, 9, 'మహా', 'mahā', 'great', 8),
    (vers_id, 10, 'దినపు', 'dinapu', 'of the day', 9),
    (vers_id, 11, 'తీర్పు', 'tīrpu', 'judgment', 10),
    (vers_id, 12, 'వరకు', 'varaku', 'for the', 11),
    (vers_id, 13, 'నిత్యబంధకములతో', 'nityabandhakamulatō', 'in everlasting bonds', 12),
    (vers_id, 14, 'అంధకారములో', 'andhakāramulō', 'under darkness', 13),
    (vers_id, 15, 'ఉంచియున్నాడు', 'uñciyunnāḍu', 'he has kept', 14);

  -- Jude 1:7
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 7,
    'అటువలెనే సొదొమ గొమొర్రాలును వాటిచుట్టునున్న పట్టణములును వీరివలెనే వ్యభిచారానుసారముగా నడచి, పరదేహాలను కామించి, నిత్యాగ్నిదండనను అనుభవించుచు దృష్టాంతముగా ఉంచబడెను.',
    'Even as Sodom and Gomorrah, and the cities around them, having, in the same way as these, given themselves over to sexual immorality and gone after strange flesh, are set forth as an example, suffering the punishment of eternal fire.',
    'aṭuvalenē sodoma gomorrālunu vāṭicuṭṭununna paṭṭaṇamulunu vīrivalenē vyabhicārānusāramugā naḍaci, paradēhālanu kāmiñci, nityāgnidaṇḍananu anubhaviñcucu dr̥ṣṭāntamugā uñcabaḍenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'అటువలెనే', 'aṭuvalenē', 'even as', 1),
    (vers_id, 2, 'సొదొమ', 'sodoma', 'Sodom', 2),
    (vers_id, 3, 'గొమొర్రాలును', 'gomorrālunu', 'and Gomorrah', 3),
    (vers_id, 4, 'వాటిచుట్టునున్న', 'vāṭicuṭṭununna', 'around them', 4),
    (vers_id, 5, 'పట్టణములును', 'paṭṭaṇamulunu', 'the cities', 5),
    (vers_id, 6, 'వీరివలెనే', 'vīrivalenē', 'in the same way as these', 6),
    (vers_id, 7, 'వ్యభిచారానుసారముగా', 'vyabhicārānusāramugā', 'to sexual immorality', 7),
    (vers_id, 8, 'నడచి', 'naḍaci', 'given themselves over', 8),
    (vers_id, 9, 'పరదేహాలను', 'paradēhālanu', 'after strange flesh', 9),
    (vers_id, 10, 'కామించి', 'kāmiñci', 'gone', 10),
    (vers_id, 11, 'నిత్యాగ్నిదండనను', 'nityāgnidaṇḍananu', 'punishment of eternal fire', 11),
    (vers_id, 12, 'అనుభవించుచు', 'anubhaviñcucu', 'suffering', 12),
    (vers_id, 13, 'దృష్టాంతముగా', 'dr̥ṣṭāntamugā', 'as an example', 13),
    (vers_id, 14, 'ఉంచబడెను', 'uñcabaḍenu', 'are set forth', 14);

  -- Jude 1:8
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 8,
    'అదేరీతిగా వీరుకూడ కలలు కనుచు తమ శరీరములను అపవిత్రపరచుకొనుచున్నారు, ప్రభుత్వమును తృణీకరించుచున్నారు, మహాత్ముల మీద దూషణలు పలుకుచున్నారు.',
    'Yet in like manner these also in their dreaming defile the flesh, despise authority, and slander celestial beings.',
    'adērītigā vīrukūḍa kalalu kanucu tama śarīramulanu apavitraparacukonucunnāru, prabhutvamunu tr̥ṇīkariñcucunnāru, mahātmula mīda dūṣaṇalu palukucunnāru.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'అదేరీతిగా', 'adērītigā', 'yet in like manner', 1),
    (vers_id, 2, 'వీరుకూడ', 'vīrukūḍa', 'these also', 2),
    (vers_id, 3, 'కలలు', 'kalalu', 'dreams', 3),
    (vers_id, 4, 'కనుచు', 'kanucu', 'in dreaming', 4),
    (vers_id, 5, 'తమ', 'tama', 'their', 5),
    (vers_id, 6, 'శరీరములను', 'śarīramulanu', 'the flesh', 6),
    (vers_id, 7, 'అపవిత్రపరచుకొనుచున్నారు', 'apavitraparacukonucunnāru', 'defile', 7),
    (vers_id, 8, 'ప్రభుత్వమును', 'prabhutvamunu', 'authority', 8),
    (vers_id, 9, 'తృణీకరించుచున్నారు', 'tr̥ṇīkariñcucunnāru', 'despise', 9),
    (vers_id, 10, 'మహాత్ముల', 'mahātmula', 'celestial beings', 10),
    (vers_id, 11, 'మీద', 'mīda', 'against', 11),
    (vers_id, 12, 'దూషణలు', 'dūṣaṇalu', 'slanders', 12),
    (vers_id, 13, 'పలుకుచున్నారు', 'palukucunnāru', 'speak', 13);

  -- Jude 1:9
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 9,
    'అయితే ప్రధానదూతయైన మిఖాయేలు మోషే శరీరమును గూర్చి అపవాదితో వాదించుచు, దూషణతీర్పు అతనిమీద ఉచ్చరించుటకు సాహసింపక—ప్రభువు నిన్ను గద్దించునుగాక అని పలికెను.',
    'But Michael, the archangel, when contending with the devil and arguing about the body of Moses, dared not bring against him a railing judgment, but said, "May the Lord rebuke you!"',
    'ayitē pradhānadūtayaina mikhāyēlu mōṣē śarīramunu gūrci apavāditō vādiñcucu, dūṣaṇatīrpu atanimīda uccariñcuṭaku sāhasiṁpaka—prabhuvu ninnu gaddiñcunugāka ani palikenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'అయితే', 'ayitē', 'but', 1),
    (vers_id, 2, 'ప్రధానదూతయైన', 'pradhānadūtayaina', 'the archangel', 2),
    (vers_id, 3, 'మిఖాయేలు', 'mikhāyēlu', 'Michael', 3),
    (vers_id, 4, 'మోషే', 'mōṣē', 'of Moses', 4),
    (vers_id, 5, 'శరీరమును', 'śarīramunu', 'the body', 5),
    (vers_id, 6, 'గూర్చి', 'gūrci', 'about', 6),
    (vers_id, 7, 'అపవాదితో', 'apavāditō', 'with the devil', 7),
    (vers_id, 8, 'వాదించుచు', 'vādiñcucu', 'when contending', 8),
    (vers_id, 9, 'దూషణతీర్పు', 'dūṣaṇatīrpu', 'a railing judgment', 9),
    (vers_id, 10, 'అతనిమీద', 'atanimīda', 'against him', 10),
    (vers_id, 11, 'ఉచ్చరించుటకు', 'uccariñcuṭaku', 'to bring', 11),
    (vers_id, 12, 'సాహసింపక', 'sāhasiṁpaka', 'dared not', 12),
    (vers_id, 13, 'ప్రభువు', 'prabhuvu', 'the Lord', 13),
    (vers_id, 14, 'నిన్ను', 'ninnu', 'you', 14),
    (vers_id, 15, 'గద్దించునుగాక', 'gaddiñcunugāka', 'rebuke', 15),
    (vers_id, 16, 'అని', 'ani', 'said', 16),
    (vers_id, 17, 'పలికెను', 'palikenu', 'spoke', 16);

  -- Jude 1:10
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 10,
    'వీరైతే తాము ఎరుగని విషయములనుబట్టి దూషించుచున్నారు; మరియు వివేకములేని జంతువులవలె స్వభావికముగా తెలిసికొనువాటిని బట్టి తమ్మును తాము నశింపజేసికొనుచున్నారు.',
    'But these speak evil of whatever things they don''t know. What they understand naturally, like the creatures without reason, they are destroyed in these things.',
    'vīraitē tāmu erugani viṣayamulanubaṭṭi dūṣiñcucunnāru; mariyu vivēkamulēni jantuvulavale svabhāvikamugā telisikonuvāṭini baṭṭi tammunu tāmu naśiṁpajēsikonucunnāru.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'వీరైతే', 'vīraitē', 'but these', 1),
    (vers_id, 2, 'తాము', 'tāmu', 'they', 2),
    (vers_id, 3, 'ఎరుగని', 'erugani', 'do not know', 3),
    (vers_id, 4, 'విషయములనుబట్టి', 'viṣayamulanubaṭṭi', 'whatever things', 4),
    (vers_id, 5, 'దూషించుచున్నారు', 'dūṣiñcucunnāru', 'speak evil of', 5),
    (vers_id, 6, 'మరియు', 'mariyu', 'and', 6),
    (vers_id, 7, 'వివేకములేని', 'vivēkamulēni', 'without reason', 7),
    (vers_id, 8, 'జంతువులవలె', 'jantuvulavale', 'like creatures', 8),
    (vers_id, 9, 'స్వభావికముగా', 'svabhāvikamugā', 'naturally', 9),
    (vers_id, 10, 'తెలిసికొనువాటిని', 'telisikonuvāṭini', 'what they understand', 10),
    (vers_id, 11, 'బట్టి', 'baṭṭi', 'in', 11),
    (vers_id, 12, 'తమ్మును', 'tammunu', 'themselves', 12),
    (vers_id, 13, 'తాము', 'tāmu', 'they', 2),
    (vers_id, 14, 'నశింపజేసికొనుచున్నారు', 'naśiṁpajēsikonucunnāru', 'are destroyed', 13);

  -- Jude 1:11
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 11,
    'వారికి అయ్యో; వారు కయీను మార్గమున నడిచి, లాభమునుబట్టి బిలాము పొరపాటులో పడిరి, కోరహు తిరుగుబాటుచేత నశించిరి.',
    'Woe to them! For they went in the way of Cain, and ran riotously in the error of Balaam for hire, and perished in Korah''s rebellion.',
    'vāriki ayyō; vāru kayīnu mārgamuna naḍici, lābhamunubaṭṭi bilāmu porapāṭulō paḍiri, kōrahu tirugubāṭucēta naśiñciri.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'వారికి', 'vāriki', 'to them', 1),
    (vers_id, 2, 'అయ్యో', 'ayyō', 'woe', 2),
    (vers_id, 3, 'వారు', 'vāru', 'they', 3),
    (vers_id, 4, 'కయీను', 'kayīnu', 'of Cain', 4),
    (vers_id, 5, 'మార్గమున', 'mārgamuna', 'in the way', 5),
    (vers_id, 6, 'నడిచి', 'naḍici', 'went', 6),
    (vers_id, 7, 'లాభమునుబట్టి', 'lābhamunubaṭṭi', 'for hire', 7),
    (vers_id, 8, 'బిలాము', 'bilāmu', 'of Balaam', 8),
    (vers_id, 9, 'పొరపాటులో', 'porapāṭulō', 'in the error', 9),
    (vers_id, 10, 'పడిరి', 'paḍiri', 'ran riotously', 10),
    (vers_id, 11, 'కోరహు', 'kōrahu', 'Korah''s', 11),
    (vers_id, 12, 'తిరుగుబాటుచేత', 'tirugubāṭucēta', 'in rebellion', 12),
    (vers_id, 13, 'నశించిరి', 'naśiñciri', 'perished', 13);

  -- Jude 1:12
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 12,
    'వీరు మీ ప్రేమ విందులలో మీతో కూడ భోజనము చేయుచు, నిర్భయముగా తమ్మును తాము పోషించుకొనుచు, మీకు గ్రహించరాని కడ్డి, వాయువులచేత కొట్టుకొని పోవు నీరులేని మేఘములు, ఫలములు లేక యెండిపోయి, రెండు మారులు మృతిబొంది వేళ్లతోకూడ పెరికివేయబడిన చెట్లు,',
    'These are hidden rocky reefs in your love feasts when they feast with you, shepherds who without fear feed themselves; clouds without water, carried along by winds; autumn leaves without fruit, twice dead, plucked up by the roots;',
    'vīru mī prēma vindulalō mītō kūḍa bhōjanamu cēyucu, nirbhayamugā tammunu tāmu pōṣiñcukonucu, mīku grahiñcarāni kaḍḍi, vāyuvulacēta koṭṭukoni pōvu nīrulēni mēghamulu, phalamulu lēka yeṇḍipōyi, reṇḍu mārulu mr̥tibondi vēḷlatōkūḍa perikivēyabaḍina ceṭlu,')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'వీరు', 'vīru', 'these', 1),
    (vers_id, 2, 'మీ', 'mī', 'your', 2),
    (vers_id, 3, 'ప్రేమ', 'prēma', 'love', 3),
    (vers_id, 4, 'విందులలో', 'vindulalō', 'in feasts', 4),
    (vers_id, 5, 'మీతో', 'mītō', 'with you', 5),
    (vers_id, 6, 'కూడ', 'kūḍa', 'together', 6),
    (vers_id, 7, 'భోజనము', 'bhōjanamu', 'feast', 7),
    (vers_id, 8, 'చేయుచు', 'cēyucu', 'when they', 8),
    (vers_id, 9, 'నిర్భయముగా', 'nirbhayamugā', 'without fear', 9),
    (vers_id, 10, 'తమ్మును', 'tammunu', 'themselves', 10),
    (vers_id, 11, 'తాము', 'tāmu', 'they', 11),
    (vers_id, 12, 'పోషించుకొనుచు', 'pōṣiñcukonucu', 'feed', 12),
    (vers_id, 13, 'మీకు', 'mīku', 'to you', 2),
    (vers_id, 14, 'గ్రహించరాని', 'grahiñcarāni', 'hidden', 13),
    (vers_id, 15, 'కడ్డి', 'kaḍḍi', 'rocky reefs', 14),
    (vers_id, 16, 'వాయువులచేత', 'vāyuvulacēta', 'by winds', 15),
    (vers_id, 17, 'కొట్టుకొని', 'koṭṭukoni', 'carried along', 16),
    (vers_id, 18, 'పోవు', 'pōvu', 'going', 17),
    (vers_id, 19, 'నీరులేని', 'nīrulēni', 'without water', 18),
    (vers_id, 20, 'మేఘములు', 'mēghamulu', 'clouds', 19),
    (vers_id, 21, 'ఫలములు', 'phalamulu', 'fruit', 20),
    (vers_id, 22, 'లేక', 'lēka', 'without', 21),
    (vers_id, 23, 'యెండిపోయి', 'yeṇḍipōyi', 'autumn', 22),
    (vers_id, 24, 'రెండు', 'reṇḍu', 'twice', 23),
    (vers_id, 25, 'మారులు', 'mārulu', 'times', 24),
    (vers_id, 26, 'మృతిబొంది', 'mr̥tibondi', 'dead', 25),
    (vers_id, 27, 'వేళ్లతోకూడ', 'vēḷlatōkūḍa', 'by the roots', 26),
    (vers_id, 28, 'పెరికివేయబడిన', 'perikivēyabaḍina', 'plucked up', 27),
    (vers_id, 29, 'చెట్లు', 'ceṭlu', 'trees', 28);

  -- Jude 1:13
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 13,
    'తమ సిగ్గును నురుగువలె వెళ్లగ్రక్కు సముద్రపు ఉరికెపతంగములు, త్రోవ తప్పిన నక్షత్రములు; వీరికొరకు కటిక చీకటి నిత్యము ఉంచబడియున్నది.',
    'wild waves of the sea, foaming out their own shame; wandering stars, for whom the blackness of darkness has been reserved forever.',
    'tama siggunu nuruguvale veḷlagrakku samudrapu urikepataṅgamulu, trōva tappina nakṣatramulu; vīrikoraku kaṭika cīkaṭi nityamu uñcabaḍiyunnadi.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'తమ', 'tama', 'their own', 1),
    (vers_id, 2, 'సిగ్గును', 'siggunu', 'shame', 2),
    (vers_id, 3, 'నురుగువలె', 'nuruguvale', 'as foam', 3),
    (vers_id, 4, 'వెళ్లగ్రక్కు', 'veḷlagrakku', 'foaming out', 4),
    (vers_id, 5, 'సముద్రపు', 'samudrapu', 'of the sea', 5),
    (vers_id, 6, 'ఉరికెపతంగములు', 'urikepataṅgamulu', 'wild waves', 6),
    (vers_id, 7, 'త్రోవ', 'trōva', 'the way', 7),
    (vers_id, 8, 'తప్పిన', 'tappina', 'wandering from', 8),
    (vers_id, 9, 'నక్షత్రములు', 'nakṣatramulu', 'stars', 9),
    (vers_id, 10, 'వీరికొరకు', 'vīrikoraku', 'for whom', 10),
    (vers_id, 11, 'కటిక', 'kaṭika', 'thick', 11),
    (vers_id, 12, 'చీకటి', 'cīkaṭi', 'darkness', 12),
    (vers_id, 13, 'నిత్యము', 'nityamu', 'forever', 13),
    (vers_id, 14, 'ఉంచబడియున్నది', 'uñcabaḍiyunnadi', 'has been reserved', 14);

  -- Jude 1:14
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 14,
    'ఆదాము నుండి ఏడవవాడైన హనోకుకూడ వీరిగూర్చి ప్రవచించుచు ఇట్లనెను— ఇదిగో సమస్తమైనవారికి తీర్పు తీర్చుటకును,',
    'About these also Enoch, the seventh from Adam, prophesied, saying, "Behold, the Lord came with ten thousands of his holy ones,',
    'ādāmu nuṇḍi ēḍavavāḍaina hanōkukūḍa vīrigūrci pravacañcucu iṭlanenu— idigō samastamainavāriki tīrpu tīrcuṭakunu,')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ఆదాము', 'ādāmu', 'from Adam', 1),
    (vers_id, 2, 'నుండి', 'nuṇḍi', 'from', 2),
    (vers_id, 3, 'ఏడవవాడైన', 'ēḍavavāḍaina', 'the seventh', 3),
    (vers_id, 4, 'హనోకుకూడ', 'hanōkukūḍa', 'Enoch also', 4),
    (vers_id, 5, 'వీరిగూర్చి', 'vīrigūrci', 'about these', 5),
    (vers_id, 6, 'ప్రవచించుచు', 'pravacañcucu', 'prophesied', 6),
    (vers_id, 7, 'ఇట్లనెను', 'iṭlanenu', 'saying', 7),
    (vers_id, 8, 'ఇదిగో', 'idigō', 'behold', 8),
    (vers_id, 9, 'సమస్తమైనవారికి', 'samastamainavāriki', 'all', 9),
    (vers_id, 10, 'తీర్పు', 'tīrpu', 'judgment', 10),
    (vers_id, 11, 'తీర్చుటకును', 'tīrcuṭakunu', 'to execute', 11);

  -- Jude 1:15
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 15,
    'భక్తిహీనులందరు భక్తివిరోధముగా చేసిన భక్తిహీనమైన క్రియలన్నిటిని గూర్చియు, భక్తిహీనులైన పాపులు తనకు విరోధముగా పలికిన కఠినమాటలన్నిటిని గూర్చియు, వారిని ఒప్పించుటకును ప్రభువు తన పరిశుద్ధ లక్షల యోధులతో వచ్చెను.',
    'to execute judgment on all, and to convict all the ungodly of all their works of ungodliness which they have done in an ungodly way, and of all the hard things which ungodly sinners have spoken against him."',
    'bhaktihīnulandaru bhaktivirōdhamugā cēsina bhaktihīnamaina kriyalanniṭini gūrciyu, bhaktihīnulaina pāpulu tanaku virōdhamugā palikina kaṭhinamāṭalanniṭini gūrciyu, vārini oppiñcuṭakunu prabhuvu tana pariśuddha lakṣala yōdhulatō vaccenu.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'భక్తిహీనులందరు', 'bhaktihīnulandaru', 'all the ungodly', 1),
    (vers_id, 2, 'భక్తివిరోధముగా', 'bhaktivirōdhamugā', 'in an ungodly way', 2),
    (vers_id, 3, 'చేసిన', 'cēsina', 'have done', 3),
    (vers_id, 4, 'భక్తిహీనమైన', 'bhaktihīnamaina', 'of ungodliness', 4),
    (vers_id, 5, 'క్రియలన్నిటిని', 'kriyalanniṭini', 'all works', 5),
    (vers_id, 6, 'గూర్చియు', 'gūrciyu', 'concerning', 6),
    (vers_id, 7, 'భక్తిహీనులైన', 'bhaktihīnulaina', 'ungodly', 1),
    (vers_id, 8, 'పాపులు', 'pāpulu', 'sinners', 7),
    (vers_id, 9, 'తనకు', 'tanaku', 'against him', 8),
    (vers_id, 10, 'విరోధముగా', 'virōdhamugā', 'against', 9),
    (vers_id, 11, 'పలికిన', 'palikina', 'have spoken', 10),
    (vers_id, 12, 'కఠినమాటలన్నిటిని', 'kaṭhinamāṭalanniṭini', 'all hard things', 11),
    (vers_id, 13, 'గూర్చియు', 'gūrciyu', 'concerning', 6),
    (vers_id, 14, 'వారిని', 'vārini', 'them', 12),
    (vers_id, 15, 'ఒప్పించుటకును', 'oppiñcuṭakunu', 'to convict', 13),
    (vers_id, 16, 'ప్రభువు', 'prabhuvu', 'the Lord', 14),
    (vers_id, 17, 'తన', 'tana', 'his', 15),
    (vers_id, 18, 'పరిశుద్ధ', 'pariśuddha', 'holy', 16),
    (vers_id, 19, 'లక్షల', 'lakṣala', 'ten thousands', 17),
    (vers_id, 20, 'యోధులతో', 'yōdhulatō', 'with ones', 18),
    (vers_id, 21, 'వచ్చెను', 'vaccenu', 'came', 19);

  -- Jude 1:16
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 16,
    'వీరు సణుగువారును, తమ గతిని గూర్చి అసంతృప్తిపడువారును, తమ దురాశలచొప్పున నడుచుకొనువారును, ఆడంబరమైన మాటలాడువారును, లాభముకొరకు మొగమాటము చూపువారునై యున్నారు.',
    'These are murmurers and complainers, walking after their lusts (and their mouth speaks proud things), showing respect of persons to gain advantage.',
    'vīru saṇuguvārunu, tama gatini gūrci asaṁtr̥ptipaḍuvārunu, tama durāśalacoppuna naḍucukonuvārunu, āḍambaramaina māṭalāḍuvārunu, lābhamukoraku mogamāṭamu cūpuvārunai yunnāru.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'వీరు', 'vīru', 'these', 1),
    (vers_id, 2, 'సణుగువారును', 'saṇuguvārunu', 'are murmurers', 2),
    (vers_id, 3, 'తమ', 'tama', 'their', 3),
    (vers_id, 4, 'గతిని', 'gatini', 'lot', 4),
    (vers_id, 5, 'గూర్చి', 'gūrci', 'about', 5),
    (vers_id, 6, 'అసంతృప్తిపడువారును', 'asaṁtr̥ptipaḍuvārunu', 'and complainers', 6),
    (vers_id, 7, 'తమ', 'tama', 'their', 3),
    (vers_id, 8, 'దురాశలచొప్పున', 'durāśalacoppuna', 'after lusts', 7),
    (vers_id, 9, 'నడుచుకొనువారును', 'naḍucukonuvārunu', 'walking', 8),
    (vers_id, 10, 'ఆడంబరమైన', 'āḍambaramaina', 'proud', 9),
    (vers_id, 11, 'మాటలాడువారును', 'māṭalāḍuvārunu', 'speakers of', 10),
    (vers_id, 12, 'లాభముకొరకు', 'lābhamukoraku', 'to gain advantage', 11),
    (vers_id, 13, 'మొగమాటము', 'mogamāṭamu', 'respect of persons', 12),
    (vers_id, 14, 'చూపువారునై', 'cūpuvārunai', 'showing', 13),
    (vers_id, 15, 'యున్నారు', 'yunnāru', 'are', 14);

  -- Jude 1:17
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 17,
    'ప్రియులారా, మన ప్రభువైన యేసుక్రీస్తు అపొస్తలులు పూర్వము పలికిన మాటలను జ్ఞాపకము చేసికొనుడి.',
    'But you, beloved, remember the words which have been spoken before by the apostles of our Lord Jesus Christ.',
    'priyulārā, mana prabhuvaina yēsukrīstu apostalulu pūrvamu palikina māṭalanu jñāpakamu cēsikonuḍi.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ప్రియులారా', 'priyulārā', 'beloved', 1),
    (vers_id, 2, 'మన', 'mana', 'our', 2),
    (vers_id, 3, 'ప్రభువైన', 'prabhuvaina', 'Lord', 3),
    (vers_id, 4, 'యేసుక్రీస్తు', 'yēsukrīstu', 'Jesus Christ', 4),
    (vers_id, 5, 'అపొస్తలులు', 'apostalulu', 'the apostles', 5),
    (vers_id, 6, 'పూర్వము', 'pūrvamu', 'before', 6),
    (vers_id, 7, 'పలికిన', 'palikina', 'have spoken', 7),
    (vers_id, 8, 'మాటలను', 'māṭalanu', 'the words', 8),
    (vers_id, 9, 'జ్ఞాపకము', 'jñāpakamu', 'remember', 9),
    (vers_id, 10, 'చేసికొనుడి', 'cēsikonuḍi', 'do', 10);

  -- Jude 1:18
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 18,
    'వారు—అంత్యకాలమునందు తమ భక్తిహీనమైన దురాశలచొప్పున నడుచుకొను అపహాసకులుందురని మీతో చెప్పిరి.',
    'They said to you, "In the last time there will be mockers, walking after their own ungodly lusts."',
    'vāru—antyakālamunandu tama bhaktihīnamaina durāśalacoppuna naḍucukonu apahāsakulunduran̲i mītō ceppiri.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'వారు', 'vāru', 'they', 1),
    (vers_id, 2, 'అంత్యకాలమునందు', 'antyakālamunandu', 'in the last time', 2),
    (vers_id, 3, 'తమ', 'tama', 'their own', 3),
    (vers_id, 4, 'భక్తిహీనమైన', 'bhaktihīnamaina', 'ungodly', 4),
    (vers_id, 5, 'దురాశలచొప్పున', 'durāśalacoppuna', 'after lusts', 5),
    (vers_id, 6, 'నడుచుకొను', 'naḍucukonu', 'walking', 6),
    (vers_id, 7, 'అపహాసకులుందురని', 'apahāsakulunduran̲i', 'there will be mockers', 7),
    (vers_id, 8, 'మీతో', 'mītō', 'to you', 8),
    (vers_id, 9, 'చెప్పిరి', 'ceppiri', 'said', 9);

  -- Jude 1:19
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 19,
    'వీరు భేదములు కలుగజేయువారును ప్రకృతిసంబంధులును ఆత్మలేనివారునైయున్నారు.',
    'These are they who cause divisions and are sensual, not having the Spirit.',
    'vīru bhēdamulu kalugajēyuvārunu prakr̥tisaṁbandhulunu ātmalēnivārunaiyunnāru.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'వీరు', 'vīru', 'these', 1),
    (vers_id, 2, 'భేదములు', 'bhēdamulu', 'divisions', 2),
    (vers_id, 3, 'కలుగజేయువారును', 'kalugajēyuvārunu', 'who cause', 3),
    (vers_id, 4, 'ప్రకృతిసంబంధులును', 'prakr̥tisaṁbandhulunu', 'are sensual', 4),
    (vers_id, 5, 'ఆత్మలేనివారునైయున్నారు', 'ātmalēnivārunaiyunnāru', 'not having the Spirit', 5);

  -- Jude 1:20
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 20,
    'ప్రియులారా, మీరు అతిపరిశుద్ధమైన మీ విశ్వాసవిషయమై మిమ్మును క్షేమాభివృద్ధి చేసికొనుచు, పరిశుద్ధాత్మలో ప్రార్థనచేయుచు,',
    'But you, beloved, keep building up yourselves on your most holy faith, praying in the Holy Spirit.',
    'priyulārā, mīru atipariśuddhamaina mī viśvāsaviṣayamai mimmunu kṣēmābhivr̥ddhi cēsikonucu, pariśuddhātmalō prārthanacēyucu,')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'ప్రియులారా', 'priyulārā', 'beloved', 1),
    (vers_id, 2, 'మీరు', 'mīru', 'you', 2),
    (vers_id, 3, 'అతిపరిశుద్ధమైన', 'atipariśuddhamaina', 'most holy', 3),
    (vers_id, 4, 'మీ', 'mī', 'your', 4),
    (vers_id, 5, 'విశ్వాసవిషయమై', 'viśvāsaviṣayamai', 'on faith', 5),
    (vers_id, 6, 'మిమ్మును', 'mimmunu', 'yourselves', 6),
    (vers_id, 7, 'క్షేమాభివృద్ధి', 'kṣēmābhivr̥ddhi', 'building up', 7),
    (vers_id, 8, 'చేసికొనుచు', 'cēsikonucu', 'keep', 8),
    (vers_id, 9, 'పరిశుద్ధాత్మలో', 'pariśuddhātmalō', 'in the Holy Spirit', 9),
    (vers_id, 10, 'ప్రార్థనచేయుచు', 'prārthanacēyucu', 'praying', 10);

  -- Jude 1:21
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 21,
    'నిత్యజీవార్థమైన మన ప్రభువగు యేసుక్రీస్తు కనికరము కొరకు ఎదురుచూచుచు, దేవుని ప్రేమలో నిలుచునట్లు మిమ్మును మీరు కాపాడుకొనుడి.',
    'Keep yourselves in the love of God, looking for the mercy of our Lord Jesus Christ to eternal life.',
    'nityajīvārthamaina mana prabhuvagu yēsukrīstu kanikaramu koraku eduruçucucu, dēvuni prēmalō nilucunaṭlu mimmunu mīru kāpāḍukonuḍi.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'నిత్యజీవార్థమైన', 'nityajīvārthamaina', 'to eternal life', 1),
    (vers_id, 2, 'మన', 'mana', 'our', 2),
    (vers_id, 3, 'ప్రభువగు', 'prabhuvagu', 'Lord', 3),
    (vers_id, 4, 'యేసుక్రీస్తు', 'yēsukrīstu', 'Jesus Christ', 4),
    (vers_id, 5, 'కనికరము', 'kanikaramu', 'mercy', 5),
    (vers_id, 6, 'కొరకు', 'koraku', 'for', 6),
    (vers_id, 7, 'ఎదురుచూచుచు', 'eduruçucucu', 'looking', 7),
    (vers_id, 8, 'దేవుని', 'dēvuni', 'of God', 8),
    (vers_id, 9, 'ప్రేమలో', 'prēmalō', 'in the love', 9),
    (vers_id, 10, 'నిలుచునట్లు', 'nilucunaṭlu', 'so as to abide', 10),
    (vers_id, 11, 'మిమ్మును', 'mimmunu', 'yourselves', 11),
    (vers_id, 12, 'మీరు', 'mīru', 'you', 12),
    (vers_id, 13, 'కాపాడుకొనుడి', 'kāpāḍukonuḍi', 'keep', 13);

  -- Jude 1:22
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 22,
    'మరియు సందేహపడువారిని కనికరించుడి;',
    'On some have compassion, making a distinction,',
    'mariyu sandēhapaḍuvārini kanikariñcuḍi;')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'మరియు', 'mariyu', 'and', 1),
    (vers_id, 2, 'సందేహపడువారిని', 'sandēhapaḍuvārini', 'on those who doubt', 2),
    (vers_id, 3, 'కనికరించుడి', 'kanikariñcuḍi', 'have compassion', 3);

  -- Jude 1:23
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 23,
    'కొందరిని అగ్నిలోనుండి లాగివేసి రక్షించుడి; శరీర సంబంధమైన అపవిత్రవస్త్రమునుకూడ అసహ్యించుకొనుచు, భయముతో కనికరించుడి.',
    'and some save, snatching them out of the fire with fear, hating even the clothing stained by the flesh.',
    'kondarini agnilōnuṇḍi lāgivēsi rakṣiñcuḍi; śarīra saṁbandhamaina apavitravastramunukūḍa asahyiñcukonucu, bhayamutō kanikariñcuḍi.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'కొందరిని', 'kondarini', 'and some', 1),
    (vers_id, 2, 'అగ్నిలోనుండి', 'agnilōnuṇḍi', 'out of the fire', 2),
    (vers_id, 3, 'లాగివేసి', 'lāgivēsi', 'snatching', 3),
    (vers_id, 4, 'రక్షించుడి', 'rakṣiñcuḍi', 'save', 4),
    (vers_id, 5, 'శరీర', 'śarīra', 'flesh', 5),
    (vers_id, 6, 'సంబంధమైన', 'saṁbandhamaina', 'by the', 6),
    (vers_id, 7, 'అపవిత్రవస్త్రమునుకూడ', 'apavitravastramunukūḍa', 'even the stained clothing', 7),
    (vers_id, 8, 'అసహ్యించుకొనుచు', 'asahyiñcukonucu', 'hating', 8),
    (vers_id, 9, 'భయముతో', 'bhayamutō', 'with fear', 9),
    (vers_id, 10, 'కనికరించుడి', 'kanikariñcuḍi', 'have compassion', 10);

  -- Jude 1:24
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 24,
    'తొట్రుపడకుండ మిమ్మును కాపాడుటకును, తన మహిమ యెదుట ఆనందముతో నిర్దోషులనుగా నిలువబెట్టుటకును శక్తిగల',
    'Now to him who is able to keep them from stumbling, and to present you faultless before the presence of his glory in great joy,',
    'toṭrupaḍakuṇḍa mimmunu kāpāḍuṭakunu, tana mahima yeduṭa ānandamutō nirdōṣulanugā niluvabeṭṭuṭakunu śaktigala')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'తొట్రుపడకుండ', 'toṭrupaḍakuṇḍa', 'from stumbling', 1),
    (vers_id, 2, 'మిమ్మును', 'mimmunu', 'you', 2),
    (vers_id, 3, 'కాపాడుటకును', 'kāpāḍuṭakunu', 'to keep', 3),
    (vers_id, 4, 'తన', 'tana', 'his', 4),
    (vers_id, 5, 'మహిమ', 'mahima', 'glory', 5),
    (vers_id, 6, 'యెదుట', 'yeduṭa', 'before', 6),
    (vers_id, 7, 'ఆనందముతో', 'ānandamutō', 'in great joy', 7),
    (vers_id, 8, 'నిర్దోషులనుగా', 'nirdōṣulanugā', 'faultless', 8),
    (vers_id, 9, 'నిలువబెట్టుటకును', 'niluvabeṭṭuṭakunu', 'to present', 9),
    (vers_id, 10, 'శక్తిగల', 'śaktigala', 'who is able', 10);

  -- Jude 1:25
  INSERT INTO verses (chapter_id, verse_number, telugu_text, english_text, transliteration_text)
  VALUES (chap_id, 25,
    'మన రక్షకుడునైన అద్వితీయ దేవునికి, మన ప్రభువైన యేసుక్రీస్తుద్వారా, యుగములన్నిటికి పూర్వము ఇప్పుడును ఎల్లకాలము మహిమయు మహాత్మ్యమును ఆధిపత్యమును అధికారమును కలుగును గాక. ఆమేన్.',
    'to God our Savior, who alone is wise, be glory and majesty, dominion and power, both now and forever. Amen.',
    'mana rakṣakuḍunaina advitīya dēvuniki, mana prabhuvaina yēsukrīstudvārā, yugamulanniṭiki pūrvamu ippuḍunu ellakālamu mahimayu mahātmyamunu ādhipatyamunu adhikāramunu kalugunu gāka. āmēn.')
  ON CONFLICT (chapter_id, verse_number) DO UPDATE SET telugu_text=EXCLUDED.telugu_text, english_text=EXCLUDED.english_text, transliteration_text=EXCLUDED.transliteration_text RETURNING id INTO vers_id;
  DELETE FROM verse_tokens WHERE verse_id=vers_id;
  INSERT INTO verse_tokens (verse_id, position, telugu_word, transliteration_word, english_word, alignment_group) VALUES
    (vers_id, 1, 'మన', 'mana', 'our', 1),
    (vers_id, 2, 'రక్షకుడునైన', 'rakṣakuḍunaina', 'Savior', 2),
    (vers_id, 3, 'అద్వితీయ', 'advitīya', 'who alone is', 3),
    (vers_id, 4, 'దేవునికి', 'dēvuniki', 'to God', 4),
    (vers_id, 5, 'మన', 'mana', 'our', 1),
    (vers_id, 6, 'ప్రభువైన', 'prabhuvaina', 'Lord', 5),
    (vers_id, 7, 'యేసుక్రీస్తుద్వారా', 'yēsukrīstudvārā', 'through Jesus Christ', 6),
    (vers_id, 8, 'యుగములన్నిటికి', 'yugamulanniṭiki', 'all ages', 7),
    (vers_id, 9, 'పూర్వము', 'pūrvamu', 'before', 8),
    (vers_id, 10, 'ఇప్పుడును', 'ippuḍunu', 'and now', 9),
    (vers_id, 11, 'ఎల్లకాలము', 'ellakālamu', 'forever', 10),
    (vers_id, 12, 'మహిమయు', 'mahimayu', 'glory', 11),
    (vers_id, 13, 'మహాత్మ్యమును', 'mahātmyamunu', 'and majesty', 12),
    (vers_id, 14, 'ఆధిపత్యమును', 'ādhipatyamunu', 'dominion', 13),
    (vers_id, 15, 'అధికారమును', 'adhikāramunu', 'and power', 14),
    (vers_id, 16, 'కలుగును', 'kalugunu', 'be', 15),
    (vers_id, 17, 'గాక', 'gāka', 'may', 16),
    (vers_id, 18, 'ఆమేన్', 'āmēn', 'Amen', 17);

END $$;
