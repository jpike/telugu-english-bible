import { useState } from "react";
import { BibleVerse } from "../types/BibleTypes";
import { get_alignment_color } from "../lib/AlignmentPalette";

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
 * Props for the InterlinearVerse component.
 */
interface InterlinearVerseProps
{
    verse: BibleVerse;
    visibility: LineVisibility;
    font_scale: number;
}

/**
 * Renders a single verse as a flowing sequence of word "cells". Each cell
 * stacks three lines (Telugu, transliteration, English) that share the
 * same color, tying Telugu words to their English counterparts.
 */
export function InterlinearVerse(props: InterlinearVerseProps): JSX.Element
{
    const [active_group, set_active_group] = useState<number | null>(null);

    return (
        <div className="fade_in flex flex-wrap items-start gap-x-1 gap-y-4 py-5 border-b border-[var(--rule)] last:border-b-0">
            <span
                className="font-sans-ui select-none text-[11px] font-semibold tracking-wider text-[var(--ink-muted)] mt-2 mr-2 min-w-[1.75rem]"
                aria-label={`Verse ${props.verse.verse_number}`}
            >
                {props.verse.verse_number}
            </span>

            {props.verse.tokens.map((token, token_index) =>
            {
                const color = get_alignment_color(token.alignment_group);
                const is_active = active_group === token.alignment_group;

                return (
                    <div
                        key={`${token.position}-${token_index}`}
                        className={`flex flex-col items-center text-center px-2 py-1 rounded-md transition-colors duration-150 cursor-pointer ${is_active ? "group_active" : ""}`}
                        style={{
                            color: color.ink,
                            backgroundColor: is_active ? color.tint : "transparent",
                            minWidth: "2.5rem",
                        }}
                        onMouseEnter={() => set_active_group(token.alignment_group)}
                        onMouseLeave={() => set_active_group(null)}
                        onFocus={() => set_active_group(token.alignment_group)}
                        onBlur={() => set_active_group(null)}
                        tabIndex={0}
                        role="group"
                        aria-label={`${token.telugu_word}, ${token.transliteration_word}, ${token.english_word}`}
                    >
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

                        {props.visibility.show_english && (
                            <span
                                className="font-serif-eng leading-tight mt-1"
                                style={{ fontSize: `${1.0 * props.font_scale}rem`, lineHeight: 1.35 }}
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
