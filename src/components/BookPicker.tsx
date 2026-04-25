import { useMemo, useState } from "react";
import { BibleBook } from "../types/BibleTypes";
import { ChevronRight, Search, X } from "lucide-react";

/**
 * Props for the BookPicker slide-over.
 */
interface BookPickerProps
{
    /** Whether the picker is visible on screen. */
    is_open: boolean;
    /** Complete book catalog (all 66 books). */
    books: BibleBook[];
    /** Currently selected book id, used to highlight the row. */
    current_book_id: number;
    /** Callback when a book + chapter is selected. */
    on_select: (book_id: number, chapter_number: number) => void;
    /** Callback to close the picker without selecting. */
    on_close: () => void;
}

/**
 * A two-pane slide-over that lets the user browse all 66 Bible books
 * and pick a chapter. The left column lists books grouped by testament;
 * the right column shows a chapter grid for the selected book.
 */
export function BookPicker(props: BookPickerProps): JSX.Element
{
    const [selected_book_id, set_selected_book_id] = useState<number>(props.current_book_id);
    const [search_query, set_search_query] = useState<string>("");

    const filtered_books = useMemo(() =>
    {
        const needle = search_query.trim().toLowerCase();
        if (needle.length === 0)
        {
            return props.books;
        }
        return props.books.filter((book) =>
            book.name_english.toLowerCase().includes(needle) ||
            book.name_telugu.includes(search_query.trim())
        );
    }, [props.books, search_query]);

    const old_testament_books = filtered_books.filter((book) => book.testament === "old");
    const new_testament_books = filtered_books.filter((book) => book.testament === "new");
    const active_book = props.books.find((book) => book.id === selected_book_id);

    if (!props.is_open)
    {
        return <></>;
    }

    return (
        <div className="fixed inset-0 z-40 flex">
            <button
                type="button"
                onClick={props.on_close}
                aria-label="Close book picker"
                className="absolute inset-0 bg-black/40 backdrop-blur-sm"
            />

            <div className="relative ml-auto h-full w-full max-w-3xl bg-[var(--bg-panel)] shadow-2xl flex flex-col animate-[fade_up_240ms_ease-out]">
                <div className="flex items-center justify-between px-6 py-4 border-b border-[var(--rule)]">
                    <h2 className="font-serif-eng text-2xl font-semibold">Browse the Bible</h2>
                    <button
                        type="button"
                        onClick={props.on_close}
                        className="p-2 rounded-full hover:bg-[var(--accent-soft)] transition"
                        aria-label="Close"
                    >
                        <X size={18} />
                    </button>
                </div>

                <div className="px-6 pt-4">
                    <div className="flex items-center gap-2 bg-[var(--bg-page)] border border-[var(--rule)] rounded-lg px-3 py-2">
                        <Search size={16} className="text-[var(--ink-muted)]" />
                        <input
                            value={search_query}
                            onChange={(change_event) => set_search_query(change_event.target.value)}
                            placeholder="Search books (English or Telugu)"
                            className="font-sans-ui bg-transparent outline-none w-full text-sm"
                        />
                    </div>
                </div>

                <div className="flex-1 overflow-hidden grid grid-cols-1 md:grid-cols-[minmax(220px,280px)_1fr] gap-0">
                    <div className="border-r border-[var(--rule)] overflow-y-auto py-3">
                        <BookGroup
                            label="Old Testament"
                            books={old_testament_books}
                            selected_book_id={selected_book_id}
                            on_select={set_selected_book_id}
                        />
                        <BookGroup
                            label="New Testament"
                            books={new_testament_books}
                            selected_book_id={selected_book_id}
                            on_select={set_selected_book_id}
                        />
                    </div>

                    <div className="overflow-y-auto p-6">
                        {active_book && (
                            <div>
                                <div className="mb-4">
                                    <div className="font-sans-ui text-xs uppercase tracking-widest text-[var(--ink-muted)]">Chapter</div>
                                    <h3 className="font-serif-eng text-3xl font-semibold">{active_book.name_english}</h3>
                                    <div lang="te" className="font-telugu text-lg text-[var(--ink-secondary)] mt-1">{active_book.name_telugu}</div>
                                </div>

                                <div className="grid grid-cols-6 sm:grid-cols-8 md:grid-cols-10 gap-2">
                                    {Array.from({ length: active_book.chapter_count }, (_, chapter_index) => chapter_index + 1).map((chapter_number) => (
                                        <button
                                            key={chapter_number}
                                            type="button"
                                            onClick={() => props.on_select(active_book.id, chapter_number)}
                                            className="aspect-square rounded-md border border-[var(--rule)] font-sans-ui text-sm hover:bg-[var(--accent-soft)] hover:border-[var(--accent)] transition"
                                        >
                                            {chapter_number}
                                        </button>
                                    ))}
                                </div>
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
}

/**
 * Small presentational helper rendering a labeled list of books.
 */
function BookGroup(props: { label: string; books: BibleBook[]; selected_book_id: number; on_select: (book_id: number) => void }): JSX.Element
{
    return (
        <div className="px-3 mb-4">
            <div className="font-sans-ui text-[10px] uppercase tracking-widest text-[var(--ink-muted)] px-2 py-2">{props.label}</div>
            <ul>
                {props.books.map((book) => (
                    <li key={book.id}>
                        <button
                            type="button"
                            onClick={() => props.on_select(book.id)}
                            className={`w-full flex items-center justify-between px-2 py-1.5 rounded-md text-left transition ${props.selected_book_id === book.id ? "bg-[var(--accent-soft)] text-[var(--accent)]" : "hover:bg-[var(--bg-page)]"}`}
                        >
                            <div>
                                <div className="font-serif-eng text-[15px] font-medium leading-tight">{book.name_english}</div>
                                <div lang="te" className="font-telugu text-xs text-[var(--ink-muted)] leading-tight">{book.name_telugu}</div>
                            </div>
                            <ChevronRight size={14} className="opacity-60" />
                        </button>
                    </li>
                ))}
            </ul>
        </div>
    );
}
