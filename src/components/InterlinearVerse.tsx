import { useState } from "react";
import { BibleVerse, VerseToken } from "../types/BibleTypes";
import { CharacterAlignment } from "../types/CharacterAlignmentTypes";
import { get_alignment_color } from "../lib/AlignmentPalette";
import { WordCharacterBreakdown } from "./WordCharacterBreakdown";

/**
 * Configuration for which of the three interlinear lines should be visible.
 * Lets learners hide lines to self-test comprehension.
 */
export interface LineVisibility
{
    show_telugu: boolean;
    show_transliteration: boolean;
    show_english: boolean;
}

/**
 * Callback invoked when a learner clicks a word cell to inspect its
 * character breakdown. Receives the token and the bounding rect of the
 * clicked cell so a popover can be anchored next to it.
 */
export type OnWordClick = (token: VerseToken, anchor_rect: DOMRect) => void;

/**
 * Props for the InterlinearVerse component.
 */
interface InterlinearVerseProps
{
    verse: BibleVerse;
    visibility: LineVisibility;
    font_scale: number;
    /** When true, render each word as a per-akshara color-coded breakdown instead of word-level coloring. */
    letter_mode: boolean;
    /** Curated character alignments keyed by token id; empty entries fall back to runtime segmentation. */
    character_alignments_by_token_id: Map<number, CharacterAlignment[]>;
    /** Invoked when a word cell is clicked; opens an inspector popover for the token. */
    on_word_click: OnWordClick;
}

/**
 * Renders a single verse as a flowing sequence of word "cells". Each cell
 * stacks three lines (Telugu, transliteration, English) that share the
 * same color, tying Telugu words to their English counterparts. In
 * letter mode, each cell is replaced by a per-akshara color-coded
 * breakdown.
 */
export function InterlinearVerse(props: InterlinearVerseProps): JSX.Element
{
    const [active_group, set_active_group] = useState<number | null>(null);

    function handle_word_click(event: React.MouseEvent<HTMLDivElement>, token: VerseToken): void
    {
        const cell_element = event.currentTarget;
        const anchor_rect = cell_element.getBoundingClientRect();
        props.on_word_click(token, anchor_rect);
    }

    function handle_word_keydown(event: React.KeyboardEvent<HTMLDivElement>, token: VerseToken): void
    {
        if (event.key === "Enter" || event.key === " ")
        {
            event.preventDefault();
            const cell_element = event.currentTarget;
            const anchor_rect = cell_element.getBoundingClientRect();
            props.on_word_click(token, anchor_rect);
        }
    }

    return (
        <div className="fade_in flex flex-wrap items-start gap-x-2 gap-y-4 py-5 border-b border-[var(--rule)] last:border-b-0">
            <span
                className="font-sans-ui select-none text-[11px] font-semibold tracking-wider text-[var(--ink-muted)] mt-2 mr-2 min-w-[1.75rem]"
                aria-label={`Verse ${props.verse.verse_number}`}
            >
                {props.verse.verse_number}
            </span>

            {props.verse.tokens.map((token, token_index) =>
            {
                const word_color = get_alignment_color(token.alignment_group);
                const is_word_group_active = active_group === token.alignment_group && !props.letter_mode;
                const character_alignments = props.character_alignments_by_token_id.get(token.id) ?? [];

                return (
                    <div
                        key={`${token.id}-${token_index}`}
                        className={`flex flex-col items-center text-center px-2 py-1 rounded-md transition-colors duration-150 cursor-pointer ${is_word_group_active ? "group_active" : ""}`}
                        style={{
                            color: props.letter_mode ? "var(--ink-primary)" : word_color.ink,
                            backgroundColor: is_word_group_active ? word_color.tint : "transparent",
                            minWidth: "2.5rem",
                        }}
                        onMouseEnter={() => set_active_group(token.alignment_group)}
                        onMouseLeave={() => set_active_group(null)}
                        onFocus={() => set_active_group(token.alignment_group)}
                        onBlur={() => set_active_group(null)}
                        onClick={(event) => handle_word_click(event, token)}
                        onKeyDown={(event) => handle_word_keydown(event, token)}
                        tabIndex={0}
                        role="button"
                        aria-label={`${token.telugu_word}, ${token.transliteration_word}, ${token.english_word}. Click to inspect character breakdown.`}
                    >
                        {props.letter_mode ? (
                            <WordCharacterBreakdown
                                telugu_word={token.telugu_word}
                                character_alignments={character_alignments}
                                show_telugu={props.visibility.show_telugu}
                                show_transliteration={props.visibility.show_transliteration}
                                font_scale={props.font_scale}
                                density="compact"
                            />
                        ) : (
                            <>
                                {props.visibility.show_telugu && (
                                    <span
                                        lang="te"
                                        className="font-telugu font-semibold leading-tight"
                                        style={{ fontSize: `${1.35 * props.font_scale}rem`, lineHeight: 1.5 }}
                                    >
                                        {token.telugu_word}
                                    </span>
                                )}

                                {props.visibility.show_transliteration && (
                                    <span
                                        className="font-sans-ui italic font-medium leading-tight mt-1"
                                        style={{ fontSize: `${0.82 * props.font_scale}rem`, opacity: 0.9 }}
                                    >
                                        {token.transliteration_word}
                                    </span>
                                )}
                            </>
                        )}

                        {props.visibility.show_english && (
                            <span
                                className="font-serif-eng leading-tight mt-1"
                                style={{
                                    fontSize: `${1.0 * props.font_scale}rem`,
                                    lineHeight: 1.35,
                                    color: props.letter_mode ? "var(--ink-secondary)" : undefined,
                                }}
                            >
                                {token.english_word}
                            </span>
                        )}
                    </div>
                );
            })}
        </div>
    );
}
