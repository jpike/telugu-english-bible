/**
 * Types describing the character (akshara) level alignment between a
 * Telugu word and its transliteration. Used by the letter-mode inline
 * view and by the click-to-inspect popover.
 */

/**
 * One akshara of a Telugu word paired with the Latin letters it produces.
 * Several of these pairs make up a full word breakdown.
 */
export interface CharacterAlignment
{
    /** Order of the akshara within its parent token, starting at 1. */
    position: number;
    /** A single Telugu akshara as a complete grapheme cluster (may span codepoints). */
    telugu_grapheme: string;
    /** Latin transliteration letters that correspond to this akshara. */
    transliteration_chars: string;
    /** Per-token color group; shared between the akshara and its Latin chunk. */
    char_group: number;
}
