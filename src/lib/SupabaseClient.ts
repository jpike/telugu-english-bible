import { createClient } from "@supabase/supabase-js";

/**
 * Singleton Supabase client used by the Telugu Bible reader.
 * The anon key provides read-only access to the public Bible content
 * as enforced by RLS on the database.
 */
const supabase_url = import.meta.env.VITE_SUPABASE_URL as string;
const supabase_anon_key = import.meta.env.VITE_SUPABASE_ANON_KEY as string;

export const supabase_client = createClient(supabase_url, supabase_anon_key, {
    auth: {
        persistSession: false,
        autoRefreshToken: false,
    },
});
