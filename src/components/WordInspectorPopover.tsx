import { useEffect, useRef } from "react";
import { X } from "lucide-react";
import { VerseToken } from "../types/BibleTypes";
import { CharacterAlignment } from "../types/CharacterAlignmentTypes";
import { WordCharacterBreakdown } from "./WordCharacterBreakdown";

/**
 * Props for the WordInspectorPopover component.
 */
interface WordInspectorPopoverProps
{
    /** Token whose character breakdown is being inspected. */
    token: VerseToken;
    /** Curated character alignments for the token (may be empty). */
    character_alignments: CharacterAlignment[];
    /** Bounding rectangle of the clicked word cell in viewport coordinates. */
    anchor_rect: DOMRect;
    /** Font scale multiplier inherited from the reader's settings. */
    font_scale: number;
    /** Whether curated character alignments were available for this token. */
    has_curated_alignments: boolean;
    /** Closes the popover. */
    on_close: () => void;
}

/**
 * Floating popover that appears next to a clicked word and shows the
 * akshara-by-akshara character breakdown for that single word. Uses the
 * shared WordCharacterBreakdown component to render the colored chips.
 */
export function WordInspectorPopover(props: WordInspectorPopoverProps): JSX.Element
{
    const popover_ref = useRef<HTMLDivElement | null>(null);

    useEffect(() =>
    {
        function handle_outside_click(event: MouseEvent): void
        {
            if (popover_ref.current && !popover_ref.current.contains(event.target as Node))
            {
                props.on_close();
            }
        }

        function handle_escape_key(event: KeyboardEvent): void
        {
            if (event.key === "Escape")
            {
                props.on_close();
            }
        }

        // DELAY ATTACHING THE OUTSIDE-CLICK HANDLER SO THE TRIGGERING CLICK ITSELF DOES NOT CLOSE US.
        const attachment_timeout = window.setTimeout(() =>
        {
            window.addEventListener("mousedown", handle_outside_click);
        }, 0);
        window.addEventListener("keydown", handle_escape_key);

        return () =>
        {
            window.clearTimeout(attachment_timeout);
            window.removeEventListener("mousedown", handle_outside_click);
            window.removeEventListener("keydown", handle_escape_key);
        };
    }, [props]);

    // POSITION THE POPOVER BELOW THE ANCHOR, CLAMPED TO THE VIEWPORT EDGES.
    const POPOVER_WIDTH_PX = 320;
    const POPOVER_VERTICAL_GAP_PX = 8;
    const VIEWPORT_PADDING_PX = 12;
    const ideal_left_px = props.anchor_rect.left + props.anchor_rect.width / 2 - POPOVER_WIDTH_PX / 2;
    const max_left_px = window.innerWidth - POPOVER_WIDTH_PX - VIEWPORT_PADDING_PX;
    const clamped_left_px = Math.max(VIEWPORT_PADDING_PX, Math.min(ideal_left_px, max_left_px));
    const top_px = props.anchor_rect.bottom + window.scrollY + POPOVER_VERTICAL_GAP_PX;

    return (
        <div
            ref={popover_ref}
            role="dialog"
            aria-label={`Character breakdown for ${props.token.telugu_word}`}
            className="absolute z-40 fade_in"
            style={{
                top: `${top_px}px`,
                left: `${clamped_left_px + window.scrollX}px`,
                width: `${POPOVER_WIDTH_PX}px`,
            }}
        >
            <div className="rounded-xl bg-white border border-[var(--rule)] shadow-xl p-4">
                <div className="flex items-start justify-between gap-3 mb-2">
                    <div className="min-w-0">
                        <div className="font-sans-ui text-[10px] uppercase tracking-widest text-[var(--ink-muted)]">
                            Character breakdown
                        </div>
                        <div className="font-serif-eng text-base font-semibold text-[var(--ink-primary)] truncate">
                            {props.token.english_word}
                        </div>
                    </div>
                    <button
                        type="button"
                        onClick={props.on_close}
                        className="p-1 rounded-full text-[var(--ink-muted)] hover:bg-[var(--accent-soft)] hover:text-[var(--ink-primary)] transition"
                        aria-label="Close character breakdown"
                    >
                        <X size={14} />
                    </button>
                </div>

                <WordCharacterBreakdown
                    telugu_word={props.token.telugu_word}
                    character_alignments={props.character_alignments}
                    show_telugu={true}
                    show_transliteration={true}
                    font_scale={props.font_scale}
                    density="comfortable"
                />

                <div className="mt-3 pt-3 border-t border-[var(--rule)] font-sans-ui text-[11px] text-[var(--ink-muted)] leading-relaxed">
                    Full word: <span className="italic">{props.token.transliteration_word}</span>
                    {!props.has_curated_alignments && (
                        <div className="mt-1 text-[10px] uppercase tracking-wider text-[var(--ink-muted)]">
                            Auto-generated breakdown
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
}
