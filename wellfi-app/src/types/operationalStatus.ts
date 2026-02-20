/**
 * operationalStatus.ts — Session 8 types
 *
 * Operational status types for engineer-assigned well states.
 * Separate from frozen types.ts to respect the freeze contract.
 */

import type { Well } from '@/types';
import type { DeviceInventoryItem } from '@/types/deviceInventory';

// ─── Core Types ──────────────────────────────────────────────

export type OperationalStatusType = 'watch' | 'warning' | 'well_down';

export interface OperationalStatus {
  id: string;
  well_id: string;
  status: OperationalStatusType;
  set_by: string;
  set_by_user_id: string | null;
  notes: string | null;
  pump_change_start: string | null;
  pump_change_end: string | null;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

/**
 * Extended well type that includes operational status.
 * The frozen Well interface is extended at runtime by useWells —
 * this type captures that shape for downstream consumers.
 */
export type WellEnriched = Well & {
  operational_status?: OperationalStatus | null;
  assigned_device?: DeviceInventoryItem | null;
};

// ─── Config & Colors ──────────────────────────────────────────

export interface OpStatusConfig {
  label: string;
  color: string;
  bgClass: string;
  mapFill: string;
  mapStroke: string;
  mapGlow: string;
  mapFillHover: string;
  mapStrokeHover: string;
}

export const OP_STATUS_CONFIG: Record<OperationalStatusType, OpStatusConfig> = {
  watch: {
    label: 'Watch',
    color: '#3B82F6',
    bgClass: 'bg-blue-500',
    mapFill: 'rgba(59, 130, 246, 0.12)',
    mapStroke: 'rgba(59, 130, 246, 0.45)',
    mapGlow: 'rgba(59, 130, 246, 0.18)',
    mapFillHover: 'rgba(59, 130, 246, 0.22)',
    mapStrokeHover: 'rgba(59, 130, 246, 0.70)',
  },
  warning: {
    label: 'Warning',
    color: '#EAB308',
    bgClass: 'bg-yellow-500',
    mapFill: 'rgba(234, 179, 8, 0.12)',
    mapStroke: 'rgba(234, 179, 8, 0.45)',
    mapGlow: 'rgba(234, 179, 8, 0.18)',
    mapFillHover: 'rgba(234, 179, 8, 0.22)',
    mapStrokeHover: 'rgba(234, 179, 8, 0.70)',
  },
  well_down: {
    label: 'Well Down',
    color: '#EF4444',
    bgClass: 'bg-red-500',
    mapFill: 'rgba(239, 68, 68, 0.15)',
    mapStroke: 'rgba(239, 68, 68, 0.50)',
    mapGlow: 'rgba(239, 68, 68, 0.22)',
    mapFillHover: 'rgba(239, 68, 68, 0.28)',
    mapStrokeHover: 'rgba(239, 68, 68, 0.80)',
  },
};

/**
 * Numeric level for map feature-state (mirrors health_level pattern).
 * 0 = none, 1 = watch, 2 = warning, 3 = well_down
 */
export const OP_STATUS_LEVEL: Record<OperationalStatusType, number> = {
  watch: 1,
  warning: 2,
  well_down: 3,
};

// ─── Status options for UI rendering ──────────────────────────

export const OP_STATUS_OPTIONS: {
  value: OperationalStatusType;
  label: string;
  color: string;
  description: string;
}[] = [
  {
    value: 'watch',
    label: 'Watch',
    color: '#3B82F6',
    description: 'Monitor closely — potential issue detected',
  },
  {
    value: 'warning',
    label: 'Warning',
    color: '#EAB308',
    description: 'Action needed soon — performance degrading',
  },
  {
    value: 'well_down',
    label: 'Well Down',
    color: '#EF4444',
    description: 'Well is down — requires immediate attention',
  },
];
