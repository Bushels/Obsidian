// ============================================================
// FROZEN after Session 1. Do not modify without coordinator approval.
// All agents import from here. Never redefine these types.
// ============================================================

export type RiskLevel =
  | 'HIGH — DUE'
  | 'WATCH'
  | 'LOW'
  | 'RECENTLY CHANGED'
  | 'DOWN NOW'
  | 'NO DATA'
  | 'UNKNOWN';

export type WellStatus = 'Pumping' | 'Operating' | 'Suspended' | 'Abandoned';
export type Formation = 'Bluesky' | 'Clearwater';
export type PumpChangeStatus = 'warning' | 'scheduled' | 'in_progress' | 'completed' | 'cancelled';

export interface Well {
  id: string;
  well_id: string;
  formatted_id: string | null;
  name: string | null;
  lat: number;
  lon: number;
  formation: Formation | null;
  field: string | null;
  well_status: WellStatus | null;
  risk_level: RiskLevel | null;
  months_running: number | null;
  dec_rate_bbl_d: number | null;
  total_2025_bbl: number | null;
  cumulative_oil: number | null;
  on_production_date: string | null;
  last_production_date: string | null;
  annual_uptime_pct: number | null;
  total_downtime_days: number | null;
  monthly_hrs: number[] | null;
  monthly_oil: number[] | null;
  monthly_uptime: number[] | null;
  status_note: string | null;
  created_at: string;
  updated_at: string;
  wellfi_device?: WellFiDevice | null;
  active_pump_change?: PumpChange | null;
  // Downhole equipment depths
  pump_top_depth_m?: number | null;
  pump_bottom_depth_m?: number | null;
  slotted_tag_bar_top_depth_m?: number | null;
  slotted_tag_bar_bottom_depth_m?: number | null;
  wellfi_tool_top_depth_m?: number | null;
  wellfi_tool_bottom_depth_m?: number | null;
  no_turn_tool_top_depth_m?: number | null;
  no_turn_tool_bottom_depth_m?: number | null;
  collar_top_depth_m?: number | null;
  collar_bottom_depth_m?: number | null;
}

export interface WellFiDevice {
  id: string;
  well_id: string;
  serial_number: string | null;
  installed_at: string | null;
  installed_by: string;
  is_active: boolean;
  pump_speed_rpm: number | null;
  formation_pressure_kpa: number | null;
  pump_intake_pressure_kpa: number | null;
  target_surface_pressure_kpa: number | null;
  firmware_version: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface PumpChange {
  id: string;
  well_id: string;
  status: PumpChangeStatus;
  flagged_by: string;
  flagged_at: string;
  scheduled_date: string | null;
  notes: string | null;
  formation_pressure_kpa: number | null;
  pump_pressure_kpa: number | null;
  pump_speed_rpm: number | null;
  device_sourced: boolean;
  program_configured: boolean;
  installation_scheduled: boolean;
  actual_date: string | null;
  completed_by: string | null;
  wellfi_installed_after: boolean;
  notification_sent: boolean;
  created_at: string;
  updated_at: string;
}

export type MapColorMode = 'risk' | 'formation' | 'field';

export interface MapFilters {
  riskLevels: RiskLevel[];
  formations: Formation[];
  fields: string[];
  showWellFiOnly: boolean;
  showUpcomingOnly: boolean;
  minRateBblD: number;
}

export interface AppUser {
  name: string;
  email: string;
}
