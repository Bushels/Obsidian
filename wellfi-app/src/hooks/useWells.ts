import { useEffect } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import { useAuth } from '@/lib/auth-context';
import type { Well, WellFiDevice, PumpChange } from '@/types';
import type { OperationalStatus, WellEnriched } from '@/types/operationalStatus';
import type { DeviceInventoryItem } from '@/types/deviceInventory';
import type {
  ToolInventoryItem,
  WellEvent,
  WellEventFulfillment,
} from '@/types/wellEvents';

const PAGE_SIZE = 1000;

async function fetchAllPages<T>(
  fetchPage: (from: number, to: number) => Promise<{ data: T[] | null; error: unknown }>,
): Promise<T[]> {
  const rows: T[] = [];

  for (let from = 0; ; from += PAGE_SIZE) {
    const to = from + PAGE_SIZE - 1;
    const { data, error } = await fetchPage(from, to);

    if (error) {
      throw error;
    }

    const batch = data ?? [];
    rows.push(...batch);

    if (batch.length < PAGE_SIZE) {
      break;
    }
  }

  return rows;
}

async function fetchRowsForIds<T>(
  ids: string[],
  fetchChunk: (chunkIds: string[]) => Promise<{ data: T[] | null; error: unknown }>,
  chunkSize = 100,
): Promise<T[]> {
  const rows: T[] = [];

  for (let index = 0; index < ids.length; index += chunkSize) {
    const chunkIds = ids.slice(index, index + chunkSize);
    const { data, error } = await fetchChunk(chunkIds);

    if (error) {
      throw error;
    }

    rows.push(...(data ?? []));
  }

  return rows;
}

function compareMonthsRunning(left: Well, right: Well): number {
  const leftMonths = left.months_running ?? Number.NEGATIVE_INFINITY;
  const rightMonths = right.months_running ?? Number.NEGATIVE_INFINITY;

  if (rightMonths !== leftMonths) {
    return rightMonths - leftMonths;
  }

  return (left.well_id ?? '').localeCompare(right.well_id ?? '');
}

function mapWellEventToOperationalStatus(event: WellEvent): OperationalStatus {
  return {
    id: event.id,
    well_id: event.well_id,
    status: event.state === 'down' ? 'well_down' : event.state,
    set_by: event.updated_by_name ?? event.created_by_name,
    set_by_user_id: event.updated_by_user_id ?? event.created_by_user_id,
    notes: event.notes,
    pump_change_start: event.expected_start_date ?? event.expected_down_date,
    pump_change_end: event.expected_end_date,
    is_active: event.is_active,
    created_at: event.created_at,
    updated_at: event.updated_at,
  };
}

function buildFirstSeenMap<K, V>(
  rows: V[],
  getKey: (row: V) => K,
): Map<K, V> {
  const map = new Map<K, V>();

  for (const row of rows) {
    const key = getKey(row);
    if (!map.has(key)) {
      map.set(key, row);
    }
  }

  return map;
}

export function useWells() {
  const queryClient = useQueryClient();
  const { user, isAdmin } = useAuth();

  const query = useQuery({
    queryKey: ['wells', user?.id ?? 'anonymous', user?.operatorSlug ?? 'global', isAdmin ? 'admin' : 'scoped'],
    enabled: !!user,
    queryFn: async (): Promise<WellEnriched[]> => {
      // Fetch all rows with pagination. Supabase caps plain selects at 1000 rows.
      const wells = await fetchAllPages<Well>(async (from, to) => {
        const response = await supabase
          .from('wells')
          .select('*')
          .neq('well_status', 'Abandoned')
          .order('well_id', { ascending: true })
          .range(from, to);

        return {
          data: (response.data ?? null) as Well[] | null,
          error: response.error,
        };
      });

      const devices = await fetchAllPages<WellFiDevice>(async (from, to) => {
        const response = await supabase
          .from('wellfi_devices')
          .select('*')
          .eq('is_active', true)
          .order('id', { ascending: true })
          .range(from, to);

        return {
          data: (response.data ?? null) as WellFiDevice[] | null,
          error: response.error,
        };
      });

      const pumpChanges = await fetchAllPages<PumpChange>(async (from, to) => {
        const response = await supabase
          .from('pump_changes')
          .select('*')
          .in('status', ['warning', 'scheduled', 'in_progress'])
          .order('id', { ascending: true })
          .range(from, to);

        return {
          data: (response.data ?? null) as PumpChange[] | null,
          error: response.error,
        };
      });

      const opStatuses = await fetchAllPages<OperationalStatus>(async (from, to) => {
        const response = await supabase
          .from('operational_statuses' as never)
          .select('*')
          .eq('is_active', true)
          .order('id', { ascending: true })
          .range(from, to);

        return {
          data: (response.data ?? null) as OperationalStatus[] | null,
          error: response.error,
        };
      });

      const inventoryDevices = await fetchAllPages<DeviceInventoryItem>(async (from, to) => {
        const response = await supabase
          .from('device_inventory' as never)
          .select('*')
          .in('status', ['assigned', 'installed'])
          .order('id', { ascending: true })
          .range(from, to);

        return {
          data: (response.data ?? null) as DeviceInventoryItem[] | null,
          error: response.error,
        };
      });

      const wellEvents = await fetchAllPages<WellEvent>(async (from, to) => {
        const response = await supabase
          .from('well_events')
          .select('*')
          .eq('is_active', true)
          .order('updated_at', { ascending: false })
          .range(from, to);

        return {
          data: (response.data ?? null) as WellEvent[] | null,
          error: response.error,
        };
      });

      const activeEventIds = wellEvents.map((event) => event.id);
      const activeEventIdSet = new Set(activeEventIds);

      const fulfillmentRows = activeEventIds.length > 0
        ? await fetchRowsForIds<WellEventFulfillment>(
          activeEventIds,
          async (chunkIds) => {
            const response = await supabase
              .from('well_event_fulfillment')
              .select('*')
              .in('well_event_id', chunkIds)
              .order('updated_at', { ascending: false });

            return {
              data: (response.data ?? null) as WellEventFulfillment[] | null,
              error: response.error,
            };
          },
        ).then((rows) => rows.filter((row) => activeEventIdSet.has(row.well_event_id)))
        : [];

      const assignedToolIds = [...new Set(
        fulfillmentRows
          .map((row) => row.assigned_tool_id)
          .filter((toolId): toolId is string => !!toolId),
      )];

      const toolRows = assignedToolIds.length > 0
        ? await fetchRowsForIds<ToolInventoryItem>(
          assignedToolIds,
          async (chunkIds) => {
            const response = await supabase
              .from('tool_inventory')
              .select('*')
              .in('id', chunkIds)
              .order('serial_number', { ascending: true });

            return {
              data: (response.data ?? null) as ToolInventoryItem[] | null,
              error: response.error,
            };
          },
        )
        : [];

      // Join in memory. Relation rows key off wells.id (UUID), not wells.well_id.
      const wellRows = [...wells].sort(compareMonthsRunning);
      const deviceRows = devices;
      const changeRows = pumpChanges;
      const statusRows = opStatuses;
      const inventoryRows = inventoryDevices;
      const eventRows = wellEvents;

      const deviceMap = new Map(deviceRows.map((device) => [device.well_id, device]));
      const changeMap = new Map(changeRows.map((change) => [change.well_id, change]));
      const statusMap = new Map(statusRows.map((status) => [status.well_id, status]));
      const inventoryMap = new Map(inventoryRows.map((device) => [device.assigned_well_id, device]));
      const eventMap = buildFirstSeenMap(eventRows, (event) => event.well_id);
      const fulfillmentMap = buildFirstSeenMap(fulfillmentRows, (row) => row.well_event_id);
      const toolMap = new Map(toolRows.map((tool) => [tool.id, tool]));

      return wellRows.map((well) => {
        const activeWellEvent = eventMap.get(well.id) ?? null;
        const fulfillment = activeWellEvent
          ? (fulfillmentMap.get(activeWellEvent.id) ?? null)
          : null;
        const assignedTool = fulfillment?.assigned_tool_id
          ? (toolMap.get(fulfillment.assigned_tool_id) ?? null)
          : null;

        return {
          ...well,
          wellfi_device: deviceMap.get(well.id) ?? null,
          active_pump_change: changeMap.get(well.id) ?? null,
          operational_status: activeWellEvent
            ? mapWellEventToOperationalStatus(activeWellEvent)
            : (statusMap.get(well.id) ?? null),
          active_well_event: activeWellEvent,
          well_event_fulfillment: fulfillment,
          assigned_tool: assignedTool,
          assigned_device: inventoryMap.get(well.id) ?? null,
        };
      });
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
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'well_events' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['wells'] });
        },
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'well_event_fulfillment' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['wells'] });
        },
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'tool_inventory' },
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
