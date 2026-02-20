import { useEffect } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { Well, WellFiDevice, PumpChange } from '@/types';
import type { OperationalStatus, WellEnriched } from '@/types/operationalStatus';
import type { DeviceInventoryItem } from '@/types/deviceInventory';

export function useWells() {
  const queryClient = useQueryClient();

  const query = useQuery({
    queryKey: ['wells'],
    queryFn: async (): Promise<WellEnriched[]> => {
      // 1. Fetch all wells
      const { data: wells, error } = await supabase
        .from('wells')
        .select('*')
        .neq('well_status', 'Abandoned')
        .order('months_running', { ascending: false, nullsFirst: false });
      if (error) throw error;

      // 2. Fetch active WellFi devices
      const { data: devices } = await supabase
        .from('wellfi_devices')
        .select('*')
        .eq('is_active', true);

      // 3. Fetch active pump changes (warning, scheduled, in_progress only)
      const { data: pumpChanges } = await supabase
        .from('pump_changes')
        .select('*')
        .in('status', ['warning', 'scheduled', 'in_progress']);

      // 4. Fetch active operational statuses
      const { data: opStatuses } = await supabase
        .from('operational_statuses' as never)
        .select('*')
        .eq('is_active', true);

      // 5. Fetch active device inventory assignments (assigned or installed)
      const { data: inventoryDevices } = await supabase
        .from('device_inventory' as never)
        .select('*')
        .in('status', ['assigned', 'installed']);

      // 6. Join in memory — Map by wells.id (UUID), NOT wells.well_id
      const wellRows = (wells ?? []) as unknown as Well[];
      const deviceRows = (devices ?? []) as unknown as WellFiDevice[];
      const changeRows = (pumpChanges ?? []) as unknown as PumpChange[];
      const statusRows = (opStatuses ?? []) as unknown as OperationalStatus[];
      const inventoryRows = (inventoryDevices ?? []) as unknown as DeviceInventoryItem[];

      const deviceMap = new Map(deviceRows.map(d => [d.well_id, d]));
      const changeMap = new Map(changeRows.map(p => [p.well_id, p]));
      const statusMap = new Map(statusRows.map(s => [s.well_id, s]));
      const inventoryMap = new Map(inventoryRows.map(d => [d.assigned_well_id, d]));

      return wellRows.map(w => ({
        ...w,
        wellfi_device: deviceMap.get(w.id) ?? null,
        active_pump_change: changeMap.get(w.id) ?? null,
        operational_status: statusMap.get(w.id) ?? null,
        assigned_device: inventoryMap.get(w.id) ?? null,
      }));
    },
    staleTime: 30_000,
  });

  // Real-time: invalidate on any change to wells, devices, pump_changes, or operational_statuses
  useEffect(() => {
    const channel = supabase
      .channel('wells-realtime')
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'wells' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['wells'] });
        },
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'wellfi_devices' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['wells'] });
        },
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'pump_changes' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['wells'] });
        },
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'operational_statuses' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['wells'] });
        },
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'device_inventory' },
        () => {
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
