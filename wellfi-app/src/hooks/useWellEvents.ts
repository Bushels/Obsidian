import { useEffect, useMemo } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { Database } from '@/lib/supabase';
import { useAuth } from '@/lib/auth-context';
import type {
  SetWellEventParams,
  ToolInventoryItem,
  WellEvent,
  WellEventFulfillment,
  WellEventFulfillmentStatus,
} from '@/types/wellEvents';
import { toast } from 'sonner';

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

type WellEventFulfillmentUpdate = Database['public']['Tables']['well_event_fulfillment']['Update'];

interface UseWellEventsOptions {
  wellId?: string;
  activeOnly?: boolean;
}

interface UpdateWellEventFulfillmentParams {
  id: string;
  updates: WellEventFulfillmentUpdate;
}

interface AssignToolToEventParams {
  fulfillmentId: string;
  toolId: string;
  status?: Extract<WellEventFulfillmentStatus, 'tool_reserved' | 'scheduled' | 'dispatched' | 'on_site'>;
  plannedServiceDate?: string | null;
  expectedDowntimeHours?: number | null;
  estimatedProductionLossBbl?: number | null;
  internalNotes?: string | null;
}

interface AddToolInventoryItemParams {
  serialNumber: string;
  toolType: string;
  model?: string | null;
  status?: Extract<ToolInventoryItem['status'], 'in_stock' | 'service' | 'retired'>;
  notes?: string | null;
}

interface UpdateToolInventoryItemParams {
  id: string;
  updates: Database['public']['Tables']['tool_inventory']['Update'];
}

function withActorMetadata(
  updates: WellEventFulfillmentUpdate,
  actorId: string | null,
  actorName: string | null,
): WellEventFulfillmentUpdate {
  const nextUpdates: WellEventFulfillmentUpdate = {
    ...updates,
    last_updated_by_user_id: actorId,
    last_updated_by_name: actorName,
  };

  if (updates.status === 'completed' && updates.completed_at === undefined) {
    nextUpdates.completed_at = new Date().toISOString();
  }

  if (updates.status && updates.status !== 'completed' && updates.completed_at === undefined) {
    nextUpdates.completed_at = null;
  }

  return nextUpdates;
}

function buildFulfillmentToolAssignmentUpdates(
  params: AssignToolToEventParams,
): WellEventFulfillmentUpdate {
  const updates: WellEventFulfillmentUpdate = {
    assigned_tool_id: params.toolId,
    status: params.status ?? 'tool_reserved',
  };

  if (params.plannedServiceDate !== undefined) {
    updates.planned_service_date = params.plannedServiceDate;
  }

  if (params.expectedDowntimeHours !== undefined) {
    updates.expected_downtime_hours = params.expectedDowntimeHours;
  }

  if (params.estimatedProductionLossBbl !== undefined) {
    updates.estimated_production_loss_bbl = params.estimatedProductionLossBbl;
  }

  if (params.internalNotes !== undefined) {
    updates.internal_notes = params.internalNotes;
  }

  return updates;
}

export function useWellEvents(options: UseWellEventsOptions = {}) {
  const queryClient = useQueryClient();
  const { user } = useAuth();
  const { wellId, activeOnly = false } = options;

  const query = useQuery({
    queryKey: [
      'well_events',
      user?.id ?? 'anonymous',
      user?.operatorSlug ?? 'global',
      wellId ?? 'all',
      activeOnly ? 'active' : 'all',
    ],
    enabled: !!user,
    queryFn: async (): Promise<WellEvent[]> => fetchAllPages<WellEvent>(async (from, to) => {
      let request = supabase
        .from('well_events')
        .select('*')
        .order('updated_at', { ascending: false })
        .range(from, to);

      if (wellId) {
        request = request.eq('well_id', wellId);
      }

      if (activeOnly) {
        request = request.eq('is_active', true);
      }

      const { data, error } = await request;
      return {
        data: (data ?? null) as WellEvent[] | null,
        error,
      };
    }),
    staleTime: 30_000,
  });

  useEffect(() => {
    const channel = supabase.channel(`well-events-realtime-${wellId ?? 'all'}-${activeOnly ? 'active' : 'all'}`);
    const handleChange = () => {
      queryClient.invalidateQueries({ queryKey: ['well_events'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    };

    if (wellId) {
      channel.on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'well_events', filter: `well_id=eq.${wellId}` },
        handleChange,
      );
    } else {
      channel.on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'well_events' },
        handleChange,
      );
    }

    channel.subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [activeOnly, queryClient, wellId]);

  return query;
}

export function useSetWellEvent() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (params: SetWellEventParams): Promise<WellEvent> => {
      const { data, error } = await supabase.rpc('set_well_event' as never, {
        p_well_id: params.wellId,
        p_state: params.state,
        p_is_abrupt: params.isAbrupt ?? null,
        p_support_requested: params.supportRequested ?? null,
        p_expected_down_date: params.expectedDownDate ?? null,
        p_expected_start_date: params.expectedStartDate ?? null,
        p_expected_end_date: params.expectedEndDate ?? null,
        p_requested_tool_type: params.requestedToolType ?? null,
        p_notes: params.notes ?? null,
        p_source_channel: params.sourceChannel ?? 'app',
      } as never);

      if (error) {
        throw error;
      }

      return (Array.isArray(data) ? data[0] : data) as WellEvent;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['well_events'] });
      queryClient.invalidateQueries({ queryKey: ['well_event_fulfillment'] });
      queryClient.invalidateQueries({ queryKey: ['well_activity_log'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    },
    onError: (err: Error) => {
      toast.error(`Failed to set well event: ${err.message}`);
    },
  });
}

export function useClearWellEvent() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (wellId: string): Promise<WellEvent> => {
      const { data, error } = await supabase.rpc('clear_well_event' as never, {
        p_well_id: wellId,
        p_source_channel: 'app',
      } as never);

      if (error) {
        throw error;
      }

      return (Array.isArray(data) ? data[0] : data) as WellEvent;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['well_events'] });
      queryClient.invalidateQueries({ queryKey: ['well_event_fulfillment'] });
      queryClient.invalidateQueries({ queryKey: ['well_activity_log'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    },
    onError: (err: Error) => {
      toast.error(`Failed to clear well event: ${err.message}`);
    },
  });
}

export function useWellEventFulfillment(wellEventId?: string) {
  const queryClient = useQueryClient();
  const { user } = useAuth();

  const query = useQuery({
    queryKey: [
      'well_event_fulfillment',
      user?.id ?? 'anonymous',
      user?.operatorSlug ?? 'global',
      wellEventId ?? 'all',
    ],
    enabled: !!user,
    queryFn: async (): Promise<WellEventFulfillment[]> => fetchAllPages<WellEventFulfillment>(async (from, to) => {
      let request = supabase
        .from('well_event_fulfillment')
        .select('*')
        .order('updated_at', { ascending: false })
        .range(from, to);

      if (wellEventId) {
        request = request.eq('well_event_id', wellEventId);
      }

      const { data, error } = await request;
      return {
        data: (data ?? null) as WellEventFulfillment[] | null,
        error,
      };
    }),
    staleTime: 30_000,
  });

  useEffect(() => {
    const channel = supabase
      .channel(`well-event-fulfillment-realtime-${wellEventId ?? 'all'}`)
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'well_event_fulfillment' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['well_event_fulfillment'] });
          queryClient.invalidateQueries({ queryKey: ['wells'] });
        },
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [queryClient, wellEventId]);

  return query;
}

export function useUpdateWellEventFulfillment() {
  const queryClient = useQueryClient();
  const { user, isAdmin } = useAuth();

  return useMutation({
    mutationFn: async ({ id, updates }: UpdateWellEventFulfillmentParams): Promise<WellEventFulfillment> => {
      if (!isAdmin) {
        throw new Error('Admin access required to update well event fulfillment');
      }

      const { data, error } = await supabase
        .from('well_event_fulfillment')
        .update(
          withActorMetadata(
            updates,
            user?.id ?? null,
            user?.displayName ?? user?.username ?? null,
          ) as never,
        )
        .eq('id', id)
        .select()
        .single();

      if (error) {
        throw error;
      }

      return data as WellEventFulfillment;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['well_event_fulfillment'] });
      queryClient.invalidateQueries({ queryKey: ['tool_inventory'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    },
    onError: (err: Error) => {
      toast.error(`Failed to update fulfillment: ${err.message}`);
    },
  });
}

export function useToolInventory() {
  const queryClient = useQueryClient();
  const { user, isAdmin } = useAuth();

  const query = useQuery({
    queryKey: [
      'tool_inventory',
      user?.id ?? 'anonymous',
      user?.operatorSlug ?? 'global',
      isAdmin ? 'admin' : 'blocked',
    ],
    enabled: !!user && isAdmin,
    queryFn: async (): Promise<ToolInventoryItem[]> => fetchAllPages<ToolInventoryItem>(async (from, to) => {
      const { data, error } = await supabase
        .from('tool_inventory')
        .select('*')
        .order('serial_number', { ascending: true })
        .range(from, to);

      return {
        data: (data ?? null) as ToolInventoryItem[] | null,
        error,
      };
    }),
    staleTime: 30_000,
  });

  useEffect(() => {
    const channel = supabase
      .channel('tool-inventory-realtime')
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'tool_inventory' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['tool_inventory'] });
          queryClient.invalidateQueries({ queryKey: ['well_event_fulfillment'] });
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

export function useToolInventoryCounts() {
  const { data: items = [] } = useToolInventory();

  return useMemo(() => {
    const counts = {
      in_stock: 0,
      reserved: 0,
      deployed: 0,
      service: 0,
      retired: 0,
      total: 0,
    };

    for (const item of items) {
      counts[item.status]++;
      counts.total++;
    }

    return counts;
  }, [items]);
}

export function useAddToolInventoryItem() {
  const queryClient = useQueryClient();
  const { isAdmin } = useAuth();

  return useMutation({
    mutationFn: async (params: AddToolInventoryItemParams): Promise<ToolInventoryItem> => {
      if (!isAdmin) {
        throw new Error('Admin access required to add tool inventory');
      }

      const { data, error } = await supabase
        .from('tool_inventory')
        .insert({
          serial_number: params.serialNumber.trim(),
          tool_type: params.toolType.trim(),
          model: params.model?.trim() || null,
          status: params.status ?? 'in_stock',
          notes: params.notes?.trim() || null,
        } as never)
        .select()
        .single();

      if (error) {
        throw error;
      }

      return data as ToolInventoryItem;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['tool_inventory'] });
      toast.success('Tool added to inventory');
    },
    onError: (err: Error) => {
      if (err.message.includes('unique') || err.message.includes('duplicate')) {
        toast.error('A tool with that serial number already exists');
      } else {
        toast.error(`Failed to add tool: ${err.message}`);
      }
    },
  });
}

export function useUpdateToolInventoryItem() {
  const queryClient = useQueryClient();
  const { isAdmin } = useAuth();

  return useMutation({
    mutationFn: async ({ id, updates }: UpdateToolInventoryItemParams): Promise<ToolInventoryItem> => {
      if (!isAdmin) {
        throw new Error('Admin access required to update tool inventory');
      }

      const { data, error } = await supabase
        .from('tool_inventory')
        .update(updates as never)
        .eq('id', id)
        .select()
        .single();

      if (error) {
        throw error;
      }

      return data as ToolInventoryItem;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['tool_inventory'] });
      queryClient.invalidateQueries({ queryKey: ['well_event_fulfillment'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
      toast.success('Tool inventory updated');
    },
    onError: (err: Error) => {
      toast.error(`Failed to update tool inventory: ${err.message}`);
    },
  });
}

export function useAssignToolToEvent() {
  const queryClient = useQueryClient();
  const { user, isAdmin } = useAuth();

  return useMutation({
    mutationFn: async (params: AssignToolToEventParams): Promise<WellEventFulfillment> => {
      if (!isAdmin) {
        throw new Error('Admin access required to assign tools');
      }

      const { data, error } = await supabase
        .from('well_event_fulfillment')
        .update(
          withActorMetadata(
            buildFulfillmentToolAssignmentUpdates(params),
            user?.id ?? null,
            user?.displayName ?? user?.username ?? null,
          ) as never,
        )
        .eq('id', params.fulfillmentId)
        .select()
        .single();

      if (error) {
        throw error;
      }

      return data as WellEventFulfillment;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['well_event_fulfillment'] });
      queryClient.invalidateQueries({ queryKey: ['tool_inventory'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    },
    onError: (err: Error) => {
      toast.error(`Failed to assign tool: ${err.message}`);
    },
  });
}
