// ============================================================
// FROZEN after Session 1. Single Supabase client for the entire app.
// Import this — never create another client.
// ============================================================
import { createClient } from '@supabase/supabase-js';
import type { Well, WellFiDevice, PumpChange } from '../types';

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL as string;
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY as string;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  throw new Error('Missing Supabase environment variables. Check .env file.');
}

export type Database = {
  public: {
    Tables: {
      wells: { Row: Well; Insert: Omit<Well, 'id' | 'created_at' | 'updated_at' | 'wellfi_device' | 'active_pump_change'>; Update: Partial<Well>; };
      wellfi_devices: { Row: WellFiDevice; Insert: Omit<WellFiDevice, 'id' | 'created_at' | 'updated_at'>; Update: Partial<WellFiDevice>; };
      pump_changes: { Row: PumpChange; Insert: Omit<PumpChange, 'id' | 'created_at' | 'updated_at'>; Update: Partial<PumpChange>; };
    };
  };
};

export const supabase = createClient<Database>(SUPABASE_URL, SUPABASE_ANON_KEY);
