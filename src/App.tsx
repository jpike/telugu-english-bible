import { useEffect, useMemo, useState } from "react";
import { BibleBook } from "./types/BibleTypes";
import { fetch_all_books } from "./lib/BibleRepository";
import { BookPicker } from "./components/BookPicker";
import { ChapterReader } from "./components/ChapterReader";
import { SettingsPanel } from "./components/SettingsPanel";
import { LineVisibility } from "./components/InterlinearVerse";
import { BookOpen, Library } from "lucide-react";

/**
 * Root of the Telugu interlinear Bible reader. Orchestrates:
 *   - Loading the book catalog from Supabase
 *   - Tracking the current book / chapter
 *   - Persisting user display preferences to localStorage
 *   - Rendering the header, book picker, and reading surface
 */
function App(): JSX.Element
{
    const [books, set_books] = useState<BibleBook[]>([]);
    const [current_book_id, set_current_book_id] = useState<number>(43);
    const [current_chapter, set_current_chapter] = useState<number>(1);
    const [is_picker_open, set_is_picker_open] = useState<boolean>(false);
    const [visibility, set_visibility] = useState<LineVisibility>(() => load_saved_visibility());
    const [font_scale, set_font_scale] = useState<number>(() => load_saved_font_scale());
    const [letter_mode, set_letter_mode] = useState<boolean>(() => load_saved_letter_mode());

    useEffect(() =>
    {
        fetch_all_books()
            .then((loaded_books) => set_books(loaded_books))
            .catch(() => set_books([]));
    }, []);

    useEffect(() =>
    {
        localStorage.setItem("telugu_bible_visibility", JSON.stringify(visibility));
    }, [visibility]);

    useEffect(() =>
    {
        localStorage.setItem("telugu_bible_font_scale", String(font_scale));
    }, [font_scale]);

    useEffect(() =>
    {
        localStorage.setItem("telugu_bible_letter_mode", letter_mode ? "1" : "0");
    }, [letter_mode]);

    const current_book = useMemo(
        () => books.find((book) => book.id === current_book_id) ?? null,
        [books, current_book_id],
    );

    function handle_select_chapter(book_id: number, chapter_number: number): void
    {
        set_current_book_id(book_id);
        set_current_chapter(chapter_number);
        set_is_picker_open(false);
        window.scrollTo({ top: 0, behavior: "smooth" });
    }

    return (
        <div className="min-h-screen flex flex-col">
            <header className="sticky top-0 z-30 bg-[var(--bg-page)]/85 backdrop-blur-md border-b border-[var(--rule)]">
                <div className="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between gap-4">
                    <div className="flex items-center gap-2">
                        <div className="w-8 h-8 rounded-lg bg-[var(--accent)] text-white flex items-center justify-center">
                            <BookOpen size={16} />
                        </div>
                        <div className="leading-tight">
                            <div className="font-serif-eng text-[17px] font-semibold">Paraloka Bible</div>
                            <div className="font-sans-ui text-[10px] uppercase tracking-widest text-[var(--ink-muted)]">
                                Telugu Interlinear Reader
                            </div>
                        </div>
                    </div>

                    <button
                        type="button"
                        onClick={() => set_is_picker_open(true)}
                        className="hidden sm:inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white border border-[var(--rule)] font-sans-ui text-sm hover:border-[var(--accent)] hover:bg-[var(--accent-soft)] transition"
                    >
                        <Library size={14} />
                        {current_book ? (
                            <>
                                <span className="font-semibold">{current_book.name_english}</span>
                                <span className="text-[var(--accent)]">{current_chapter}</span>
                            </>
                        ) : (
                            <span>Browse books</span>
                        )}
                    </button>

                    <SettingsPanel
                        visibility={visibility}
                        font_scale={font_scale}
                        letter_mode={letter_mode}
                        on_visibility_change={set_visibility}
                        on_font_scale_change={set_font_scale}
                        on_letter_mode_change={set_letter_mode}
                    />
                </div>

                <div className="sm:hidden px-6 pb-3">
                    <button
                        type="button"
                        onClick={() => set_is_picker_open(true)}
                        className="w-full inline-flex items-center justify-center gap-2 px-4 py-2 rounded-full bg-white border border-[var(--rule)] font-sans-ui text-sm"
                    >
                        <Library size={14} />
                        {current_book ? `${current_book.name_english} ${current_chapter}` : "Browse books"}
                    </button>
                </div>
            </header>

            <main className="flex-1">
                {current_book ? (
                    <ChapterReader
                        book={current_book}
                        chapter_number={current_chapter}
                        visibility={visibility}
                        font_scale={font_scale}
                        letter_mode={letter_mode}
                        on_navigate_chapter={handle_select_chapter}
                    />
                ) : (
                    <div className="py-24 text-center text-[var(--ink-muted)] font-sans-ui text-sm">Loading library...</div>
                )}
            </main>

            <footer className="border-t border-[var(--rule)] py-6 text-center font-sans-ui text-[11px] text-[var(--ink-muted)]">
                Telugu text based on BSI &middot; English text from World English Bible (public domain) &middot; Built for learners
            </footer>

            <BookPicker
                is_open={is_picker_open}
                books={books}
                current_book_id={current_book_id}
                on_select={handle_select_chapter}
                on_close={() => set_is_picker_open(false)}
            />
        </div>
    );
}

/**
 * Loads saved line-visibility preferences from localStorage with safe defaults.
 */
function load_saved_visibility(): LineVisibility
{
    const DEFAULT_VISIBILITY: LineVisibility = {
        show_telugu: true,
        show_transliteration: true,
        show_english: true,
    };

    try
    {
        const raw = localStorage.getItem("telugu_bible_visibility");
        if (!raw)
        {
            return DEFAULT_VISIBILITY;
        }
        const parsed = JSON.parse(raw) as Partial<LineVisibility>;
        return {
            show_telugu: parsed.show_telugu ?? true,
            show_transliteration: parsed.show_transliteration ?? true,
            show_english: parsed.show_english ?? true,
        };
    }
    catch
    {
        return DEFAULT_VISIBILITY;
    }
}

/**
 * Loads the persisted font scale preference from localStorage.
 */
function load_saved_font_scale(): number
{
    const DEFAULT_FONT_SCALE = 1.0;
    try
    {
        const raw = localStorage.getItem("telugu_bible_font_scale");
        if (!raw)
        {
            return DEFAULT_FONT_SCALE;
        }
        const parsed = Number(raw);
        if (Number.isFinite(parsed) && parsed >= 0.8 && parsed <= 1.6)
        {
            return parsed;
        }
        return DEFAULT_FONT_SCALE;
    }
    catch
    {
        return DEFAULT_FONT_SCALE;
    }
}

/**
 * Loads the persisted letter-mode preference from localStorage.
 * Letter mode swaps word-level coloring for per-akshara coloring inline.
 */
function load_saved_letter_mode(): boolean
{
    try
    {
        const raw = localStorage.getItem("telugu_bible_letter_mode");
        return raw === "1";
    }
    catch
    {
        return false;
    }
}

export default App;
