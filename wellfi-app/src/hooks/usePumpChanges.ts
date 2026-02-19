import { useEffect } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { Database } from '@/lib/supabase';
import type { PumpChange } from '@/types';

type PumpChangeInsert = Database['public']['Tables']['pump_changes']['Insert'];
type PumpChangeUpdate = Database['public']['Tables']['pump_changes']['Update'];

export function usePumpChanges(wellId?: string) {
  const queryClient = useQueryClient();

  const query = useQuery({
    queryKey: ['pump_changes', wellId],
    queryFn: async (): Promise<PumpChange[]> => {
      let q = supabase
        .from('pump_changes')
        .select('*')
        .order('flagged_at', { ascending: false });

      if (wellId) {
        q = q.eq('well_id', wellId);
      }

      const { data, error } = await q;
      if (error) throw error;
      return (data ?? []) as unknown as PumpChange[];
    },
  });

  // Real-time: invalidate on any change to pump_changes
  useEffect(() => {
    const channel = supabase
      .channel(`pump-changes-realtime-${wellId ?? 'all'}`)
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'pump_changes' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['pump_changes'] });
          queryClient.invalidateQueries({ queryKey: ['wells'] });
        },
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [queryClient, wellId]);

  return query;
}

export function useCreatePumpChange() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (pumpChange: PumpChangeInsert): Promise<PumpChange> => {
      const { data, error } = await supabase
        .from('pump_changes')
        .insert(pumpChange as never)
        .select()
        .single();
      if (error) throw error;
      return data as unknown as PumpChange;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pump_changes'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    },
  });
}

export function useUpdatePumpChange() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      id,
      updates,
    }: {
      id: string;
      updates: PumpChangeUpdate;
    }): Promise<PumpChange> => {
      const { data, error } = await supabase
        .from('pump_changes')
        .update(updates as never)
        .eq('id', id)
        .select()
        .single();
      if (error) throw error;
      return data as unknown as PumpChange;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pump_changes'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    },
  });
}
