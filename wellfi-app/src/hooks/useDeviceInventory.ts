/**
 * useDeviceInventory — Session 9
 *
 * CRUD hooks for device inventory lifecycle.
 * Lifecycle: incoming → in_stock → assigned → installed
 */

import { useEffect, useMemo } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { DeviceInventoryItem, DeviceStatus, InventoryCounts } from '@/types/deviceInventory';
import { toast } from 'sonner';

// ─── Query: Fetch all inventory items ────────────────────────

export function useDeviceInventory() {
  const queryClient = useQueryClient();

  const query = useQuery({
    queryKey: ['device_inventory'],
    queryFn: async (): Promise<DeviceInventoryItem[]> => {
      const { data, error } = await supabase
        .from('device_inventory' as never)
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;
      return (data ?? []) as unknown as DeviceInventoryItem[];
    },
    staleTime: 30_000,
  });

  // Realtime invalidation
  useEffect(() => {
    const channel = supabase
      .channel('device-inventory-realtime')
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'device_inventory' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['device_inventory'] });
          queryClient.invalidateQueries({ queryKey: ['wells'] });
        },
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [queryClient]);

  return query;
}

// ─── Derived: Inventory counts ───────────────────────────────

export function useInventoryCounts(): InventoryCounts {
  const { data: items = [] } = useDeviceInventory();

  return useMemo(() => {
    const counts: InventoryCounts = {
      in_stock: 0,
      incoming: 0,
      assigned: 0,
      installed: 0,
      total: 0,
    };

    for (const item of items) {
      const key = item.status as keyof Omit<InventoryCounts, 'total'>;
      if (key in counts) {
        counts[key]++;
      }
      counts.total++;
    }

    return counts;
  }, [items]);
}

// ─── Mutation: Add device (as in_stock or incoming) ──────────

interface AddDeviceParams {
  serial_number: string;
  status?: 'in_stock' | 'incoming';
  notes?: string | null;
}

export function useAddDevice() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (params: AddDeviceParams) => {
      const { data, error } = await supabase
        .from('device_inventory' as never)
        .insert({
          serial_number: params.serial_number,
          status: params.status ?? 'in_stock',
          notes: params.notes ?? null,
        } as never)
        .select()
        .single();

      if (error) throw error;
      return data as unknown as DeviceInventoryItem;
    },
    onSuccess: (_data, params) => {
      queryClient.invalidateQueries({ queryKey: ['device_inventory'] });
      const label = params.status === 'incoming' ? 'incoming' : 'stock';
      toast.success(`Device added to ${label}`);
    },
    onError: (err: Error) => {
      if (err.message.includes('unique') || err.message.includes('duplicate')) {
        toast.error('A device with that serial number already exists');
      } else {
        toast.error(`Failed to add device: ${err.message}`);
      }
    },
  });
}

// ─── Mutation: Mark incoming device as in stock ──────────────

export function useMarkInStock() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (deviceId: string) => {
      const { data, error } = await supabase
        .from('device_inventory' as never)
        .update({
          status: 'in_stock',
        } as never)
        .eq('id', deviceId)
        .eq('status', 'incoming')
        .select()
        .single();

      if (error) throw error;
      return data as unknown as DeviceInventoryItem;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['device_inventory'] });
      toast.success('Device moved to stock');
    },
    onError: (err: Error) => {
      toast.error(`Failed to update device: ${err.message}`);
    },
  });
}

// ─── Mutation: Assign device to well ─────────────────────────

interface AssignDeviceParams {
  deviceId: string;
  wellId: string;
  assignedBy: string;
  assignedByUserId: string;
}

export function useAssignDevice() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (params: AssignDeviceParams) => {
      const { data, error } = await supabase
        .from('device_inventory' as never)
        .update({
          status: 'assigned',
          assigned_well_id: params.wellId,
          assigned_by: params.assignedBy,
          assigned_by_user_id: params.assignedByUserId,
          assigned_at: new Date().toISOString(),
        } as never)
        .eq('id', params.deviceId)
        .eq('status', 'in_stock')
        .select()
        .single();

      if (error) throw error;
      return data as unknown as DeviceInventoryItem;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['device_inventory'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
      toast.success('Device assigned to well');
    },
    onError: (err: Error) => {
      toast.error(`Failed to assign device: ${err.message}`);
    },
  });
}

// ─── Mutation: Mark device as installed ──────────────────────

interface MarkInstalledParams {
  deviceId: string;
  installedBy: string;
  installedByUserId: string;
}

export function useMarkInstalled() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (params: MarkInstalledParams) => {
      const { data, error } = await supabase
        .from('device_inventory' as never)
        .update({
          status: 'installed',
          installed_by: params.installedBy,
          installed_by_user_id: params.installedByUserId,
          installed_at: new Date().toISOString(),
        } as never)
        .eq('id', params.deviceId)
        .eq('status', 'assigned')
        .select()
        .single();

      if (error) throw error;
      return data as unknown as DeviceInventoryItem;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['device_inventory'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
      toast.success('Device marked as installed');
    },
    onError: (err: Error) => {
      toast.error(`Failed to mark installed: ${err.message}`);
    },
  });
}

// ─── Mutation: Unassign device (return to stock) ─────────────

export function useUnassignDevice() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (deviceId: string) => {
      const { data, error } = await supabase
        .from('device_inventory' as never)
        .update({
          status: 'in_stock',
          assigned_well_id: null,
          assigned_by: null,
          assigned_by_user_id: null,
          assigned_at: null,
          installed_by: null,
          installed_by_user_id: null,
          installed_at: null,
        } as never)
        .eq('id', deviceId)
        .select()
        .single();

      if (error) throw error;
      return data as unknown as DeviceInventoryItem;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['device_inventory'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
      toast.success('Device returned to stock');
    },
    onError: (err: Error) => {
      toast.error(`Failed to unassign device: ${err.message}`);
    },
  });
}
