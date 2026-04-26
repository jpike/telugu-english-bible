import { useEffect, useState } from "react";
import { BibleBook, BibleVerse } from "../types/BibleTypes";
import { fetch_chapter_verses } from "../lib/BibleRepository";
import { InterlinearVerse, LineVisibility } from "./InterlinearVerse";
import { BookOpen, ChevronLeft, ChevronRight } from "lucide-react";

/**
 * Props for the ChapterReader, the main reading surface.
 */
interface ChapterReaderProps
{
    book: BibleBook;
    chapter_number: number;
    visibility: LineVisibility;
    font_scale: number;
    on_navigate_chapter: (book_id: number, chapter_number: number) => void;
}

/**
 * Loads and displays a chapter of interlinear verses. Handles loading,
 * empty-chapter (not yet seeded), and ready states, and provides
 * previous/next chapter navigation at the foot of the chapter.
 */
export function ChapterReader(props: ChapterReaderProps): JSX.Element
{
    const [verses, set_verses] = useState<BibleVerse[]>([]);
    const [is_loading, set_is_loading] = useState<boolean>(true);

    useEffect(() =>
    {
        let was_cancelled = false;
        set_is_loading(true);

        fetch_chapter_verses(props.book.id, props.chapter_number)
            .then((loaded_verses) =>
            {
                if (!was_cancelled)
                {
                    set_verses(loaded_verses);
                    set_is_loading(false);
                }
            })
            .catch(() =>
            {
                if (!was_cancelled)
                {
                    set_verses([]);
                    set_is_loading(false);
                }
            });

        return () =>
        {
            was_cancelled = true;
        };
    }, [props.book.id, props.chapter_number]);

    const can_go_previous = props.chapter_number > 1;
    const can_go_next = props.chapter_number < props.book.chapter_count;

    return (
        <article className="max-w-4xl mx-auto px-6 py-12">
            <header className="mb-8 text-center">
                <div className="font-sans-ui text-[11px] uppercase tracking-[0.2em] text-[var(--ink-muted)] mb-2">
                    {props.book.testament === "old" ? "Old Testament" : "New Testament"}
                </div>
                <h1 className="font-serif-eng text-5xl font-semibold tracking-tight">
                    {props.book.name_english}{" "}
                    <span className="text-[var(--accent)]">{props.chapter_number}</span>
                </h1>
                <div lang="te" className="font-telugu text-xl text-[var(--ink-secondary)] mt-2">
                    {props.book.name_telugu}
                </div>
                <div className="mx-auto mt-6 w-16 h-px bg-[var(--rule)]" />
            </header>

            {is_loading && (
                <div className="py-16 text-center text-[var(--ink-muted)] font-sans-ui text-sm">Loading verses...</div>
            )}

            {!is_loading && verses.length === 0 && (
                <EmptyChapter book={props.book} chapter_number={props.chapter_number} />
            )}

            {!is_loading && verses.length > 0 && (
                <div className="rounded-lg">
                    {verses.map((verse) => (
                        <InterlinearVerse
                            key={verse.verse_number}
                            verse={verse}
                            visibility={props.visibility}
                            font_scale={props.font_scale}
                        />
                    ))}
                </div>
            )}

            <nav className="mt-12 flex items-center justify-between gap-4 font-sans-ui text-sm">
                <button
                    type="button"
                    disabled={!can_go_previous}
                    onClick={() => props.on_navigate_chapter(props.book.id, props.chapter_number - 1)}
                    className="inline-flex items-center gap-2 px-4 py-2 rounded-full border border-[var(--rule)] disabled:opacity-40 disabled:cursor-not-allowed hover:bg-[var(--accent-soft)] hover:border-[var(--accent)] transition"
                >
                    <ChevronLeft size={16} /> Previous chapter
                </button>

                <div className="text-[var(--ink-muted)]">
                    {props.book.name_english} {props.chapter_number} / {props.book.chapter_count}
                </div>

                <button
                    type="button"
                    disabled={!can_go_next}
                    onClick={() => props.on_navigate_chapter(props.book.id, props.chapter_number + 1)}
                    className="inline-flex items-center gap-2 px-4 py-2 rounded-full border border-[var(--rule)] disabled:opacity-40 disabled:cursor-not-allowed hover:bg-[var(--accent-soft)] hover:border-[var(--accent)] transition"
                >
                    Next chapter <ChevronRight size={16} />
                </button>
            </nav>
        </article>
    );
}

/**
 * Friendly placeholder shown for chapters that haven't yet been ingested
 * with interlinear alignment data.
 */
function EmptyChapter(props: { book: BibleBook; chapter_number: number }): JSX.Element
{
    const SUGGESTED_PASSAGES: Array<{ label: string; hint: string }> = [
        { label: "Genesis 1", hint: "The beginning" },
        { label: "Psalm 23", hint: "The LORD is my shepherd" },
        { label: "John 1", hint: "In the beginning was the Word" },
        { label: "John 3:16", hint: "For God so loved the world" },
        { label: "Matthew 6", hint: "The Lord's Prayer" },
    ];

    return (
        <div className="mx-auto max-w-xl text-center py-16 px-6 border border-dashed border-[var(--rule)] rounded-xl bg-white/60">
            <BookOpen size={28} className="mx-auto text-[var(--accent)]" />
            <h2 className="font-serif-eng text-2xl font-semibold mt-3">
                {props.book.name_english} {props.chapter_number} is coming soon
            </h2>
            <p className="font-sans-ui text-sm text-[var(--ink-secondary)] mt-2 leading-relaxed">
                Interlinear alignment for this chapter has not been added yet. In the meantime, try one of these curated passages:
            </p>
            <ul className="mt-4 grid grid-cols-1 sm:grid-cols-2 gap-2 text-left">
                {SUGGESTED_PASSAGES.map((passage) => (
                    <li
                        key={passage.label}
                        className="font-sans-ui text-sm px-3 py-2 rounded-md bg-[var(--bg-page)] border border-[var(--rule)]"
                    >
                        <div className="font-semibold text-[var(--accent)]">{passage.label}</div>
                        <div className="text-[var(--ink-muted)] text-xs">{passage.hint}</div>
                    </li>
                ))}
            </ul>
        </div>
    );
}
