/**
 * wellEvents.ts
 *
 * Well Event workflow and timeline types introduced in Phase 1/2.
 * Kept separate from frozen types.ts.
 */

export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export type WellEventState = 'watch' | 'warning' | 'down';
export type WellEventSourceChannel = 'app' | 'slack' | 'telegram' | 'admin';

export type WellEventFulfillmentStatus =
  | 'unassigned'
  | 'tool_reserved'
  | 'scheduled'
  | 'dispatched'
  | 'on_site'
  | 'completed'
  | 'cancelled';

export type ToolInventoryStatus =
  | 'in_stock'
  | 'reserved'
  | 'deployed'
  | 'service'
  | 'retired';

export interface FulfillmentStatusConfig {
  label: string;
  color: string;
  description: string;
}

export interface ToolInventoryStatusConfig {
  label: string;
  color: string;
}

export const WELL_EVENT_FULFILLMENT_STATUS_CONFIG: Record<WellEventFulfillmentStatus, FulfillmentStatusConfig> = {
  unassigned: {
    label: 'Unassigned',
    color: '#94A3B8',
    description: 'No tool or crew has been assigned yet.',
  },
  tool_reserved: {
    label: 'Tool Reserved',
    color: '#22C55E',
    description: 'A tool is reserved for this event.',
  },
  scheduled: {
    label: 'Scheduled',
    color: '#0EA5E9',
    description: 'Service has been scheduled.',
  },
  dispatched: {
    label: 'Dispatched',
    color: '#8B5CF6',
    description: 'Crew or tool is on the way.',
  },
  on_site: {
    label: 'On Site',
    color: '#F97316',
    description: 'Crew is on location.',
  },
  completed: {
    label: 'Completed',
    color: '#14B8A6',
    description: 'Fulfillment is complete.',
  },
  cancelled: {
    label: 'Cancelled',
    color: '#64748B',
    description: 'Fulfillment was cancelled.',
  },
};

export const TOOL_INVENTORY_STATUS_CONFIG: Record<ToolInventoryStatus, ToolInventoryStatusConfig> = {
  in_stock: {
    label: 'In Stock',
    color: '#22C55E',
  },
  reserved: {
    label: 'Reserved',
    color: '#0EA5E9',
  },
  deployed: {
    label: 'Deployed',
    color: '#F97316',
  },
  service: {
    label: 'Service',
    color: '#EAB308',
  },
  retired: {
    label: 'Retired',
    color: '#64748B',
  },
};

export interface WellEvent {
  id: string;
  well_id: string;
  operator_id: string;
  state: WellEventState;
  is_active: boolean;
  is_abrupt: boolean;
  support_requested: boolean;
  expected_down_date: string | null;
  expected_start_date: string | null;
  expected_end_date: string | null;
  requested_tool_type: string | null;
  notes: string | null;
  created_by_user_id: string | null;
  created_by_name: string;
  updated_by_user_id: string | null;
  updated_by_name: string | null;
  source_channel: WellEventSourceChannel;
  created_at: string;
  updated_at: string;
  cleared_at: string | null;
  cleared_by_user_id: string | null;
  cleared_by_name: string | null;
}

export interface WellEventFulfillment {
  id: string;
  well_event_id: string;
  status: WellEventFulfillmentStatus;
  assigned_tool_id: string | null;
  assigned_tech_user_id: string | null;
  assigned_tech_name: string | null;
  planned_service_date: string | null;
  expected_downtime_hours: number | null;
  estimated_production_loss_bbl: number | null;
  internal_notes: string | null;
  last_updated_by_user_id: string | null;
  last_updated_by_name: string | null;
  created_at: string;
  updated_at: string;
  completed_at: string | null;
}

export interface ToolInventoryItem {
  id: string;
  serial_number: string;
  tool_type: string;
  model: string | null;
  status: ToolInventoryStatus;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface WellEventAuditLogEntry {
  id: string;
  well_event_id: string | null;
  well_id: string;
  actor_user_id: string | null;
  actor_name: string;
  actor_role: string;
  action: string;
  from_state: string | null;
  to_state: string | null;
  source_channel: WellEventSourceChannel;
  payload: Json;
  created_at: string;
}

export interface WellActivityLogEntry {
  id: string;
  well_id: string;
  operator_id: string;
  activity_type: string;
  source_table: string;
  source_record_id: string | null;
  actor_user_id: string | null;
  actor_name: string | null;
  occurred_at: string;
  payload: Json;
  created_at: string;
}

export interface SetWellEventParams {
  wellId: string;
  state: WellEventState;
  isAbrupt?: boolean | null;
  supportRequested?: boolean | null;
  expectedDownDate?: string | null;
  expectedStartDate?: string | null;
  expectedEndDate?: string | null;
  requestedToolType?: string | null;
  notes?: string | null;
  sourceChannel?: WellEventSourceChannel;
}
