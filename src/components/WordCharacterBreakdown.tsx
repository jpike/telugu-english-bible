import { CharacterAlignment } from "../types/CharacterAlignmentTypes";
import { get_alignment_color } from "../lib/AlignmentPalette";
import { segment_word_into_alignments } from "../lib/AksharaSegmenter";

/**
 * Props for the WordCharacterBreakdown component.
 */
interface WordCharacterBreakdownProps
{
    /** Telugu source word, used as a fallback when no curated alignments are provided. */
    telugu_word: string;
    /** Curated akshara-by-akshara alignments for this word. Empty falls back to the runtime segmenter. */
    character_alignments: CharacterAlignment[];
    /** Whether to render the Telugu line. */
    show_telugu: boolean;
    /** Whether to render the transliteration line. */
    show_transliteration: boolean;
    /** Font scale multiplier inherited from the reader's settings. */
    font_scale: number;
    /** Tightness of layout - "compact" suits inline reading, "comfortable" suits the popover. */
    density: "compact" | "comfortable";
}

/**
 * Renders a single Telugu word as a row of color-coded aksharas paired
 * with the corresponding chunks of its Latin transliteration. Each
 * akshara and its Latin chunk share a color so learners can see the
 * character-level mapping at a glance.
 */
export function WordCharacterBreakdown(props: WordCharacterBreakdownProps): JSX.Element
{
    // PREFER CURATED CHARACTER ALIGNMENTS; FALL BACK TO THE RUNTIME SEGMENTER FOR UNCURATED TOKENS.
    const alignments = props.character_alignments.length > 0
        ? props.character_alignments
        : segment_word_into_alignments(props.telugu_word);

    const telugu_font_size_rem = (props.density === "compact" ? 1.25 : 1.6) * props.font_scale;
    const transliteration_font_size_rem = (props.density === "compact" ? 0.78 : 0.9) * props.font_scale;
    const chunk_horizontal_padding = props.density === "compact" ? "px-1" : "px-1.5";

    return (
        <div className="flex flex-wrap items-start gap-x-0.5">
            {alignments.map((alignment) =>
            {
                const color = get_alignment_color(alignment.char_group);

                return (
                    <div
                        key={`${alignment.position}-${alignment.telugu_grapheme}`}
                        className={`flex flex-col items-center text-center ${chunk_horizontal_padding} rounded`}
                        style={{
                            color: color.ink,
                            backgroundColor: color.tint,
                        }}
                    >
                        {props.show_telugu && (
                            <span
                                lang="te"
                                className="font-telugu font-semibold leading-tight"
                                style={{ fontSize: `${telugu_font_size_rem}rem`, lineHeight: 1.4 }}
                            >
                                {alignment.telugu_grapheme}
                            </span>
                        )}

                        {props.show_transliteration && (
                            <span
                                className="font-sans-ui italic font-medium leading-tight mt-0.5"
                                style={{ fontSize: `${transliteration_font_size_rem}rem` }}
                            >
                                {alignment.transliteration_chars}
                            </span>
                        )}
                    </div>
                );
            })}
        </div>
    );
}
