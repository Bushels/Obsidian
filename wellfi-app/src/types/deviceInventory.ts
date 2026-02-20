/**
 * deviceInventory.ts — Session 9 types
 *
 * Device inventory lifecycle types for WellFi device tracking.
 * Separate from frozen types.ts to respect the freeze contract.
 * Lifecycle: incoming → in_stock → assigned → installed
 */

// ─── Core Types ──────────────────────────────────────────────

export type DeviceStatus = 'in_stock' | 'incoming' | 'assigned' | 'installed';

export interface DeviceInventoryItem {
  id: string;
  serial_number: string;
  status: DeviceStatus;
  assigned_well_id: string | null;
  assigned_by: string | null;
  assigned_by_user_id: string | null;
  assigned_at: string | null;
  installed_by: string | null;
  installed_by_user_id: string | null;
  installed_at: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface InventoryCounts {
  in_stock: number;
  incoming: number;
  assigned: number;
  installed: number;
  total: number;
}

// ─── Config & Display ────────────────────────────────────────

export interface DeviceStatusConfig {
  label: string;
  color: string;
  bgClass: string;
  description: string;
}

export const DEVICE_STATUS_CONFIG: Record<DeviceStatus, DeviceStatusConfig> = {
  incoming: {
    label: 'Incoming',
    color: '#A855F7',
    bgClass: 'bg-purple-500',
    description: 'Being manufactured or assembled',
  },
  in_stock: {
    label: 'In Stock',
    color: '#22C55E',
    bgClass: 'bg-green-500',
    description: 'In inventory, available for assignment',
  },
  assigned: {
    label: 'Assigned',
    color: '#EAB308',
    bgClass: 'bg-yellow-500',
    description: 'Assigned to a well, awaiting installation',
  },
  installed: {
    label: 'Installed',
    color: '#00D4FF',
    bgClass: 'bg-wellfi-cyan',
    description: 'Physically installed on a well',
  },
};
