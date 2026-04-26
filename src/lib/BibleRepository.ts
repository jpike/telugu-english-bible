import { supabase_client } from "./SupabaseClient";
import { BibleBook, BibleVerse, VerseToken } from "../types/BibleTypes";
import { CharacterAlignment } from "../types/CharacterAlignmentTypes";

/**
 * Data-access helpers for Bible content. Keeping Supabase calls in one
 * place makes it easy to add caching and to swap back-ends later.
 */

/**
 * Map keyed by `verse_token.id` whose value is the akshara-by-akshara
 * alignment between the Telugu word and its transliteration. Empty
 * entries are valid and signal "no curated data; fall back to runtime
 * segmentation".
 */
export type CharacterAlignmentsByTokenId = Map<number, CharacterAlignment[]>;

/**
 * Fetches the full catalog of Bible books sorted by canonical order.
 */
export async function fetch_all_books(): Promise<BibleBook[]>
{
    const { data, error } = await supabase_client
        .from("books")
        .select("id, name_english, name_telugu, testament, book_order, chapter_count")
        .order("book_order", { ascending: true });

    if (error)
    {
        throw error;
    }

    return (data ?? []) as BibleBook[];
}

/**
 * Returns the set of chapter numbers for which seeded verse data exists,
 * restricted to a given book. Used to badge "available" chapters in the UI.
 */
export async function fetch_available_chapters(book_id: number): Promise<Set<number>>
{
    const { data, error } = await supabase_client
        .from("chapters")
        .select("chapter_number, verses(id)")
        .eq("book_id", book_id);

    if (error)
    {
        throw error;
    }

    const available_chapter_numbers = new Set<number>();

    for (const row of (data ?? []) as Array<{ chapter_number: number; verses: Array<{ id: number }> }>)
    {
        if (row.verses && row.verses.length > 0)
        {
            available_chapter_numbers.add(row.chapter_number);
        }
    }

    return available_chapter_numbers;
}

/**
 * Aggregate result for a single chapter, including the per-verse text
 * plus a lookup of curated character alignments keyed by token id.
 */
export interface ChapterContent
{
    /** All verses in the chapter, in order. */
    verses: BibleVerse[];
    /** Curated character alignments per verse_token id (may be empty for tokens without curated data). */
    character_alignments_by_token_id: CharacterAlignmentsByTokenId;
}

/**
 * Loads a chapter's verses, alignment tokens, and curated character
 * alignments in one round-trip-friendly bundle.
 */
export async function fetch_chapter_content(book_id: number, chapter_number: number): Promise<ChapterContent>
{
    // LOOK UP THE CHAPTER ID BY COMPOSITE KEY.
    const { data: chapter_row, error: chapter_error } = await supabase_client
        .from("chapters")
        .select("id")
        .eq("book_id", book_id)
        .eq("chapter_number", chapter_number)
        .maybeSingle();

    if (chapter_error)
    {
        throw chapter_error;
    }

    if (!chapter_row)
    {
        return { verses: [], character_alignments_by_token_id: new Map() };
    }

    // FETCH ALL VERSES IN THE CHAPTER ORDERED BY VERSE NUMBER.
    const { data: verse_rows, error: verse_error } = await supabase_client
        .from("verses")
        .select("id, verse_number, telugu_text, english_text, transliteration_text")
        .eq("chapter_id", chapter_row.id)
        .order("verse_number", { ascending: true });

    if (verse_error)
    {
        throw verse_error;
    }

    const verses = (verse_rows ?? []) as Array<{
        id: number;
        verse_number: number;
        telugu_text: string;
        english_text: string;
        transliteration_text: string;
    }>;

    if (verses.length === 0)
    {
        return { verses: [], character_alignments_by_token_id: new Map() };
    }

    // FETCH ALL TOKENS FOR THE VERSES IN A SINGLE QUERY.
    const verse_ids = verses.map((verse_row) => verse_row.id);
    const { data: token_rows, error: token_error } = await supabase_client
        .from("verse_tokens")
        .select("id, verse_id, position, telugu_word, transliteration_word, english_word, alignment_group")
        .in("verse_id", verse_ids)
        .order("position", { ascending: true });

    if (token_error)
    {
        throw token_error;
    }

    const tokens = (token_rows ?? []) as Array<VerseToken & { verse_id: number }>;

    // FETCH ANY CURATED CHARACTER ALIGNMENTS FOR THE TOKENS WE JUST LOADED.
    const character_alignments_by_token_id: CharacterAlignmentsByTokenId = new Map();
    if (tokens.length > 0)
    {
        const token_ids = tokens.map((token_row) => token_row.id);
        const { data: alignment_rows, error: alignment_error } = await supabase_client
            .from("token_character_alignments")
            .select("verse_token_id, position, telugu_grapheme, transliteration_chars, char_group")
            .in("verse_token_id", token_ids)
            .order("position", { ascending: true });

        if (alignment_error)
        {
            throw alignment_error;
        }

        for (const alignment_row of (alignment_rows ?? []) as Array<{
            verse_token_id: number;
            position: number;
            telugu_grapheme: string;
            transliteration_chars: string;
            char_group: number;
        }>)
        {
            const bucket = character_alignments_by_token_id.get(alignment_row.verse_token_id) ?? [];
            bucket.push({
                position: alignment_row.position,
                telugu_grapheme: alignment_row.telugu_grapheme,
                transliteration_chars: alignment_row.transliteration_chars,
                char_group: alignment_row.char_group,
            });
            character_alignments_by_token_id.set(alignment_row.verse_token_id, bucket);
        }
    }

    // BUCKET TOKENS BY VERSE ID FOR EASY ASSEMBLY BELOW.
    const tokens_by_verse_id = new Map<number, VerseToken[]>();
    for (const token_row of tokens)
    {
        const bucket = tokens_by_verse_id.get(token_row.verse_id) ?? [];
        bucket.push({
            id: token_row.id,
            position: token_row.position,
            telugu_word: token_row.telugu_word,
            transliteration_word: token_row.transliteration_word,
            english_word: token_row.english_word,
            alignment_group: token_row.alignment_group,
        });
        tokens_by_verse_id.set(token_row.verse_id, bucket);
    }

    const assembled_verses: BibleVerse[] = verses.map((verse_row) => ({
        verse_number: verse_row.verse_number,
        telugu_text: verse_row.telugu_text,
        english_text: verse_row.english_text,
        transliteration_text: verse_row.transliteration_text,
        tokens: tokens_by_verse_id.get(verse_row.id) ?? [],
    }));

    return { verses: assembled_verses, character_alignments_by_token_id };
}
