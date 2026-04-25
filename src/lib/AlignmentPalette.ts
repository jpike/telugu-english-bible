/**
 * Color palette used to visually tie Telugu words to their English glosses.
 *
 * The palette is intentionally warm and earthy to complement the book-like
 * reading surface. Colors were chosen for good legibility on a cream
 * background and to avoid purple/indigo tones per design guidance.
 */

/**
 * A single alignment color with both a dark ink tone (for text) and
 * a soft tint (for subtle background highlighting).
 */
export interface AlignmentColor
{
    /** Text color used for the three stacked lines of a group. */
    ink: string;
    /** Soft tinted background, used on hover / active state. */
    tint: string;
}

/**
 * A curated, colorblind-friendly rotation of colors. Chosen to read well
 * against the warm cream page background and to distinguish neighboring
 * word cells even when colors repeat within a long verse.
 */
const ALIGNMENT_PALETTE: AlignmentColor[] = [
    { ink: "#b45309", tint: "#fde8c9" },
    { ink: "#0f766e", tint: "#ccfbf1" },
    { ink: "#9d174d", tint: "#fce7f3" },
    { ink: "#1d4ed8", tint: "#dbeafe" },
    { ink: "#15803d", tint: "#dcfce7" },
    { ink: "#b91c1c", tint: "#fee2e2" },
    { ink: "#ca8a04", tint: "#fef9c3" },
    { ink: "#0369a1", tint: "#e0f2fe" },
    { ink: "#a16207", tint: "#fef3c7" },
    { ink: "#be185d", tint: "#fce7f3" },
    { ink: "#047857", tint: "#d1fae5" },
    { ink: "#c2410c", tint: "#ffedd5" },
    { ink: "#1e40af", tint: "#dbeafe" },
    { ink: "#166534", tint: "#dcfce7" },
    { ink: "#9f1239", tint: "#ffe4e6" },
    { ink: "#115e59", tint: "#ccfbf1" },
];

/**
 * Resolves the color for a given alignment group index using a stable
 * rotation so the same group maps to the same color across the three lines.
 */
export function get_alignment_color(alignment_group: number): AlignmentColor
{
    const palette_size = ALIGNMENT_PALETTE.length;
    const safe_index = ((alignment_group - 1) % palette_size + palette_size) % palette_size;
    return ALIGNMENT_PALETTE[safe_index];
}
