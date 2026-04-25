/*
  # Telugu Interlinear Bible Schema

  ## Overview
  Creates the core data model for a Telugu/English interlinear Bible reader.
  Stores books, chapters, verses, and per-word alignment tokens used for
  color-coded interlinear rendering.

  ## New Tables

  ### books
  - id (int, PK) - stable book identifier (1..66)
  - name_english (text) - English book name
  - name_telugu (text) - Telugu book name
  - testament (text) - 'old' or 'new'
  - book_order (int) - canonical ordering
  - chapter_count (int) - total chapters in the book

  ### chapters
  - id (bigserial, PK)
  - book_id (int, FK)
  - chapter_number (int)

  ### verses
  - id (bigserial, PK)
  - chapter_id (bigint, FK)
  - verse_number (int)
  - telugu_text (text) - full BSI verse text
  - english_text (text) - full WEB verse text
  - transliteration_text (text) - ISO-15919-like transliteration

  ### verse_tokens
  - id (bigserial, PK)
  - verse_id (bigint, FK)
  - position (int) - order within the verse
  - telugu_word (text)
  - transliteration_word (text)
  - english_word (text)
  - alignment_group (int) - shared id that ties Telugu/English words together
    for color-coding across the three stacked lines.

  ## Security
  All tables enable RLS and expose read-only SELECT access to anon and
  authenticated roles since Bible content is public. No insert/update/delete
  policies are created, preventing any client writes.
*/

CREATE TABLE IF NOT EXISTS books (
  id int PRIMARY KEY,
  name_english text NOT NULL,
  name_telugu text NOT NULL DEFAULT '',
  testament text NOT NULL DEFAULT 'old',
  book_order int NOT NULL DEFAULT 0,
  chapter_count int NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS chapters (
  id bigserial PRIMARY KEY,
  book_id int NOT NULL REFERENCES books(id) ON DELETE CASCADE,
  chapter_number int NOT NULL,
  UNIQUE (book_id, chapter_number)
);

CREATE TABLE IF NOT EXISTS verses (
  id bigserial PRIMARY KEY,
  chapter_id bigint NOT NULL REFERENCES chapters(id) ON DELETE CASCADE,
  verse_number int NOT NULL,
  telugu_text text NOT NULL DEFAULT '',
  english_text text NOT NULL DEFAULT '',
  transliteration_text text NOT NULL DEFAULT '',
  UNIQUE (chapter_id, verse_number)
);

CREATE TABLE IF NOT EXISTS verse_tokens (
  id bigserial PRIMARY KEY,
  verse_id bigint NOT NULL REFERENCES verses(id) ON DELETE CASCADE,
  position int NOT NULL,
  telugu_word text NOT NULL DEFAULT '',
  transliteration_word text NOT NULL DEFAULT '',
  english_word text NOT NULL DEFAULT '',
  alignment_group int NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_chapters_book ON chapters(book_id, chapter_number);
CREATE INDEX IF NOT EXISTS idx_verses_chapter ON verses(chapter_id, verse_number);
CREATE INDEX IF NOT EXISTS idx_tokens_verse ON verse_tokens(verse_id, position);

ALTER TABLE books ENABLE ROW LEVEL SECURITY;
ALTER TABLE chapters ENABLE ROW LEVEL SECURITY;
ALTER TABLE verses ENABLE ROW LEVEL SECURITY;
ALTER TABLE verse_tokens ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read books anon" ON books FOR SELECT TO anon USING (true);
CREATE POLICY "Public read books auth" ON books FOR SELECT TO authenticated USING (true);

CREATE POLICY "Public read chapters anon" ON chapters FOR SELECT TO anon USING (true);
CREATE POLICY "Public read chapters auth" ON chapters FOR SELECT TO authenticated USING (true);

CREATE POLICY "Public read verses anon" ON verses FOR SELECT TO anon USING (true);
CREATE POLICY "Public read verses auth" ON verses FOR SELECT TO authenticated USING (true);

CREATE POLICY "Public read tokens anon" ON verse_tokens FOR SELECT TO anon USING (true);
CREATE POLICY "Public read tokens auth" ON verse_tokens FOR SELECT TO authenticated USING (true);
