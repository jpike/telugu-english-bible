import { Minus, Plus, Type } from "lucide-react";
import { LineVisibility } from "./InterlinearVerse";

/**
 * Props for the SettingsPanel allowing the reader to toggle lines,
 * adjust font size, and switch into per-character "letter mode".
 */
interface SettingsPanelProps
{
    visibility: LineVisibility;
    font_scale: number;
    letter_mode: boolean;
    on_visibility_change: (next: LineVisibility) => void;
    on_font_scale_change: (next: number) => void;
    on_letter_mode_change: (next: boolean) => void;
}

/**
 * Compact, in-header settings controls for the interlinear reader.
 */
export function SettingsPanel(props: SettingsPanelProps): JSX.Element
{
    function toggle_line(line_key: keyof LineVisibility): void
    {
        props.on_visibility_change({
            ...props.visibility,
            [line_key]: !props.visibility[line_key],
        });
    }

    function adjust_font(delta: number): void
    {
        const MIN_SCALE = 0.8;
        const MAX_SCALE = 1.6;
        const next_scale = Math.min(MAX_SCALE, Math.max(MIN_SCALE, Number((props.font_scale + delta).toFixed(2))));
        props.on_font_scale_change(next_scale);
    }

    return (
        <div className="flex items-center gap-3 font-sans-ui text-xs">
            <div className="flex items-center gap-1 bg-[var(--bg-page)] border border-[var(--rule)] rounded-full p-1">
                <LineToggle label="తె" is_active={props.visibility.show_telugu} on_click={() => toggle_line("show_telugu")} />
                <LineToggle label="Aa" is_active={props.visibility.show_transliteration} on_click={() => toggle_line("show_transliteration")} italic />
                <LineToggle label="En" is_active={props.visibility.show_english} on_click={() => toggle_line("show_english")} />
            </div>

            <button
                type="button"
                onClick={() => props.on_letter_mode_change(!props.letter_mode)}
                aria-pressed={props.letter_mode}
                title="Letter mode: color-code each Telugu character with its English letters"
                className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full border transition text-[11px] font-semibold ${props.letter_mode
                    ? "bg-[var(--accent)] text-white border-[var(--accent)]"
                    : "bg-[var(--bg-page)] text-[var(--ink-secondary)] border-[var(--rule)] hover:bg-[var(--accent-soft)]"}`}
            >
                <Type size={12} />
                <span>Letters</span>
            </button>

            <div className="flex items-center gap-1 bg-[var(--bg-page)] border border-[var(--rule)] rounded-full p-1">
                <button
                    type="button"
                    onClick={() => adjust_font(-0.1)}
                    className="p-1.5 rounded-full hover:bg-[var(--accent-soft)] transition"
                    aria-label="Decrease font size"
                >
                    <Minus size={12} />
                </button>
                <div className="px-2 text-[11px] tabular-nums text-[var(--ink-secondary)]">{Math.round(props.font_scale * 100)}%</div>
                <button
                    type="button"
                    onClick={() => adjust_font(0.1)}
                    className="p-1.5 rounded-full hover:bg-[var(--accent-soft)] transition"
                    aria-label="Increase font size"
                >
                    <Plus size={12} />
                </button>
            </div>
        </div>
    );
}

/**
 * Small round chip button used in the line-visibility toggle group.
 */
function LineToggle(props: { label: string; is_active: boolean; on_click: () => void; italic?: boolean }): JSX.Element
{
    return (
        <button
            type="button"
            onClick={props.on_click}
            className={`px-2.5 py-1 rounded-full transition text-[11px] font-semibold ${props.is_active ? "bg-[var(--accent)] text-white" : "text-[var(--ink-secondary)] hover:bg-[var(--accent-soft)]"} ${props.italic ? "italic" : ""}`}
            aria-pressed={props.is_active}
        >
            {props.label}
        </button>
    );
}
