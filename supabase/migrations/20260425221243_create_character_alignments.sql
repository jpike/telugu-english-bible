/*
  # Per-Akshara Character Alignment Table

  ## Overview
  Adds a table that records the akshara-level alignment between a single
  Telugu word (verse_tokens row) and the Latin letters of its
  transliteration. This powers the "letter mode" inline view and the
  click-to-inspect popover so learners can see exactly which Telugu
  character maps to which English letter(s).

  ## New Tables

  ### token_character_alignments
  - id (bigserial, PK)
  - verse_token_id (bigint, FK -> verse_tokens.id, cascade delete)
  - position (int) - order of the akshara within the token (1-based)
  - telugu_grapheme (text) - one Telugu akshara (e.g. క or క్ష) as a single
    grapheme cluster which may span multiple codepoints
  - transliteration_chars (text) - the Latin letters produced by this
    akshara (e.g. "ka" or "kṣa")
  - char_group (int) - per-token color group, used by the UI to share a
    color between the akshara and its matching transliteration chunk

  A unique constraint on (verse_token_id, position) keeps the ordering
  unambiguous and guards against duplicate rows during seeding.

  ## Security
  RLS is enabled. SELECT is allowed for both anon and authenticated roles
  because Bible content is public. No insert/update/delete policies are
  declared, which keeps the table read-only from the client.

  ## Notes
  1. The application falls back to a runtime akshara segmenter when no
     rows exist for a given token, so the table can be backfilled
     incrementally without breaking the UI.
*/

CREATE TABLE IF NOT EXISTS token_character_alignments (
  id bigserial PRIMARY KEY,
  verse_token_id bigint NOT NULL REFERENCES verse_tokens(id) ON DELETE CASCADE,
  position int NOT NULL,
  telugu_grapheme text NOT NULL DEFAULT '',
  transliteration_chars text NOT NULL DEFAULT '',
  char_group int NOT NULL DEFAULT 0,
  UNIQUE (verse_token_id, position)
);

CREATE INDEX IF NOT EXISTS idx_char_alignments_token
  ON token_character_alignments(verse_token_id, position);

ALTER TABLE token_character_alignments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read char alignments anon"
  ON token_character_alignments
  FOR SELECT
  TO anon
  USING (true);

CREATE POLICY "Public read char alignments auth"
  ON token_character_alignments
  FOR SELECT
  TO authenticated
  USING (true);
