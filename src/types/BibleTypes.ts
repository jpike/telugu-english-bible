/**
 * Core domain types representing Bible content as stored in Supabase.
 * Keeping these in a single file makes it easy to reason about what
 * the reader needs to render a chapter.
 */

/**
 * A Bible book and its catalog metadata.
 */
export interface BibleBook
{
    /** Stable numeric id matching canonical order (1..66). */
    id: number;
    /** English display name. */
    name_english: string;
    /** Telugu display name. */
    name_telugu: string;
    /** 'old' or 'new' testament classification. */
    testament: "old" | "new";
    /** Canonical ordering (1..66). */
    book_order: number;
    /** Total chapters in this book. */
    chapter_count: number;
}

/**
 * A single word-level token within a verse, including alignment info
 * used to color-code matching Telugu and English words.
 */
export interface VerseToken
{
    /** Stable database id used to look up character-level alignments. */
    id: number;
    /** Position within the verse, starting at 1. */
    position: number;
    /** Telugu script word. */
    telugu_word: string;
    /** ISO-15919-like transliteration of the Telugu word. */
    transliteration_word: string;
    /** English gloss for this token. */
    english_word: string;
    /**
     * Verse-scoped group id linking Telugu tokens to English meanings.
     * Tokens that share a group share the same display color.
     */
    alignment_group: number;
}

/**
 * A verse with both full text and per-word alignment tokens.
 */
export interface BibleVerse
{
    /** Verse number within the chapter. */
    verse_number: number;
    /** Full Telugu (BSI) verse text. */
    telugu_text: string;
    /** Full English (WEB) verse text. */
    english_text: string;
    /** Full verse transliteration. */
    transliteration_text: string;
    /** Word-aligned tokens in Telugu order. */
    tokens: VerseToken[];
}
