/**
 * useOperationalStatuses — Session 8
 *
 * CRUD hook for well operational statuses (Watch / Warning / Well Down).
 * Follows the same patterns as usePumpChanges.ts.
 */

import { useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { OperationalStatus, OperationalStatusType } from '@/types/operationalStatus';
import { toast } from 'sonner';

// ─── Set Operational Status ──────────────────────────────────

interface SetStatusParams {
  well_id: string;
  status: OperationalStatusType;
  set_by: string;
  set_by_user_id?: string;
  notes?: string | null;
  pump_change_start?: string | null;
  pump_change_end?: string | null;
}

export function useSetOperationalStatus() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (params: SetStatusParams) => {
      // 1. Deactivate any existing active status for this well
      const { error: deactivateError } = await supabase
        .from('operational_statuses' as never)
        .update({ is_active: false } as never)
        .eq('well_id', params.well_id)
        .eq('is_active', true);

      if (deactivateError) throw deactivateError;

      // 2. Insert the new active status
      const { data, error } = await supabase
        .from('operational_statuses' as never)
        .insert({
          well_id: params.well_id,
          status: params.status,
          set_by: params.set_by,
          set_by_user_id: params.set_by_user_id ?? null,
          notes: params.notes ?? null,
          pump_change_start: params.pump_change_start ?? null,
          pump_change_end: params.pump_change_end ?? null,
          is_active: true,
        } as never)
        .select()
        .single();

      if (error) throw error;
      return data as unknown as OperationalStatus;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    },
    onError: (err: Error) => {
      toast.error(`Failed to set status: ${err.message}`);
    },
  });
}

// ─── Clear Operational Status ────────────────────────────────

export function useClearOperationalStatus() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (wellId: string) => {
      const { error } = await supabase
        .from('operational_statuses' as never)
        .update({ is_active: false } as never)
        .eq('well_id', wellId)
        .eq('is_active', true);

      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    },
    onError: (err: Error) => {
      toast.error(`Failed to clear status: ${err.message}`);
    },
  });
}
