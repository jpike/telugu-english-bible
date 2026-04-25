import { supabase_client } from "./SupabaseClient";
import { BibleBook, BibleVerse, VerseToken } from "../types/BibleTypes";

/**
 * Data-access helpers for Bible content. Keeping Supabase calls in one
 * place makes it easy to add caching and to swap back-ends later.
 */

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
 * Loads all verses with their alignment tokens for a specific chapter.
 * Returns an empty array when the chapter has not yet been ingested.
 */
export async function fetch_chapter_verses(book_id: number, chapter_number: number): Promise<BibleVerse[]>
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
        return [];
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
        return [];
    }

    // FETCH ALL TOKENS FOR THE VERSES IN A SINGLE QUERY.
    const verse_ids = verses.map((verse_row) => verse_row.id);
    const { data: token_rows, error: token_error } = await supabase_client
        .from("verse_tokens")
        .select("verse_id, position, telugu_word, transliteration_word, english_word, alignment_group")
        .in("verse_id", verse_ids)
        .order("position", { ascending: true });

    if (token_error)
    {
        throw token_error;
    }

    // BUCKET TOKENS BY VERSE ID FOR EASY ASSEMBLY BELOW.
    const tokens_by_verse_id = new Map<number, VerseToken[]>();
    for (const token_row of (token_rows ?? []) as Array<VerseToken & { verse_id: number }>)
    {
        const bucket = tokens_by_verse_id.get(token_row.verse_id) ?? [];
        bucket.push({
            position: token_row.position,
            telugu_word: token_row.telugu_word,
            transliteration_word: token_row.transliteration_word,
            english_word: token_row.english_word,
            alignment_group: token_row.alignment_group,
        });
        tokens_by_verse_id.set(token_row.verse_id, bucket);
    }

    return verses.map((verse_row) => ({
        verse_number: verse_row.verse_number,
        telugu_text: verse_row.telugu_text,
        english_text: verse_row.english_text,
        transliteration_text: verse_row.transliteration_text,
        tokens: tokens_by_verse_id.get(verse_row.id) ?? [],
    }));
}
