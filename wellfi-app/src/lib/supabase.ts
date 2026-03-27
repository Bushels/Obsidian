// ============================================================
// FROZEN after Session 1. Single Supabase client for the entire app.
// Import this — never create another client.
// ============================================================
import { createClient } from '@supabase/supabase-js';
import type { Well, WellFiDevice, PumpChange } from '../types';
import type { DeviceInventoryItem } from '../types/deviceInventory';
import type { OperationalStatus } from '../types/operationalStatus';
import type {
  ToolInventoryItem,
  WellActivityLogEntry,
  WellEvent,
  WellEventAuditLogEntry,
  WellEventFulfillment,
  WellEventSourceChannel,
  WellEventState,
} from '../types/wellEvents';

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL as string;
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY as string;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  throw new Error('Missing Supabase environment variables. Check .env file.');
}

type TableDefinition<Row, Insert, Update> = {
  Row: Row;
  Insert: Insert;
  Update: Update;
  Relationships: [];
};

export type Database = {
  public: {
    Tables: {
      wells: TableDefinition<Well, Omit<Well, 'id' | 'created_at' | 'updated_at' | 'wellfi_device' | 'active_pump_change'>, Partial<Well>>;
      wellfi_devices: TableDefinition<WellFiDevice, Omit<WellFiDevice, 'id' | 'created_at' | 'updated_at'>, Partial<WellFiDevice>>;
      pump_changes: TableDefinition<PumpChange, Omit<PumpChange, 'id' | 'created_at' | 'updated_at'>, Partial<PumpChange>>;
      operational_statuses: TableDefinition<OperationalStatus, Omit<OperationalStatus, 'id' | 'created_at' | 'updated_at'>, Partial<OperationalStatus>>;
      device_inventory: TableDefinition<DeviceInventoryItem, Omit<DeviceInventoryItem, 'id' | 'created_at' | 'updated_at'>, Partial<DeviceInventoryItem>>;
      well_events: TableDefinition<WellEvent, Omit<WellEvent, 'id' | 'created_at' | 'updated_at' | 'cleared_at' | 'cleared_by_user_id' | 'cleared_by_name'>, Partial<WellEvent>>;
      tool_inventory: TableDefinition<ToolInventoryItem, Omit<ToolInventoryItem, 'id' | 'created_at' | 'updated_at'>, Partial<ToolInventoryItem>>;
      well_event_fulfillment: TableDefinition<WellEventFulfillment, Omit<WellEventFulfillment, 'id' | 'created_at' | 'updated_at' | 'completed_at'>, Partial<WellEventFulfillment>>;
      well_event_audit_log: TableDefinition<WellEventAuditLogEntry, Omit<WellEventAuditLogEntry, 'id' | 'created_at'>, Partial<WellEventAuditLogEntry>>;
      well_activity_log: TableDefinition<WellActivityLogEntry, Omit<WellActivityLogEntry, 'id' | 'created_at'>, Partial<WellActivityLogEntry>>;
    };
    Views: Record<string, never>;
    Functions: {
      set_well_event: {
        Args: {
          p_well_id: string;
          p_state: WellEventState;
          p_is_abrupt?: boolean | null;
          p_support_requested?: boolean | null;
          p_expected_down_date?: string | null;
          p_expected_start_date?: string | null;
          p_expected_end_date?: string | null;
          p_requested_tool_type?: string | null;
          p_notes?: string | null;
          p_source_channel?: WellEventSourceChannel;
        };
        Returns: WellEvent;
      };
      clear_well_event: {
        Args: {
          p_well_id: string;
          p_source_channel?: WellEventSourceChannel;
        };
        Returns: WellEvent;
      };
    };
  };
};

export const supabase = createClient<Database>(SUPABASE_URL, SUPABASE_ANON_KEY);
