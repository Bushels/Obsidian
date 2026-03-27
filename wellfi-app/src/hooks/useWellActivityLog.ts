import { useEffect } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import { useAuth } from '@/lib/auth-context';
import type { WellActivityLogEntry } from '@/types/wellEvents';

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

export function useWellActivityLog(wellId?: string) {
  const queryClient = useQueryClient();
  const { user } = useAuth();

  const query = useQuery({
    queryKey: [
      'well_activity_log',
      user?.id ?? 'anonymous',
      user?.operatorSlug ?? 'global',
      wellId ?? 'all',
    ],
    enabled: !!user,
    queryFn: async (): Promise<WellActivityLogEntry[]> => fetchAllPages<WellActivityLogEntry>(async (from, to) => {
      let request = supabase
        .from('well_activity_log')
        .select('*')
        .order('occurred_at', { ascending: false })
        .range(from, to);

      if (wellId) {
        request = request.eq('well_id', wellId);
      }

      const { data, error } = await request;
      return {
        data: (data ?? null) as WellActivityLogEntry[] | null,
        error,
      };
    }),
    staleTime: 30_000,
  });

  useEffect(() => {
    const channel = supabase.channel(`well-activity-log-realtime-${wellId ?? 'all'}`);
    const handleChange = () => {
      queryClient.invalidateQueries({ queryKey: ['well_activity_log'] });
    };

    if (wellId) {
      channel.on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'well_activity_log', filter: `well_id=eq.${wellId}` },
        handleChange,
      );
    } else {
      channel.on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'well_activity_log' },
        handleChange,
      );
    }

    channel.subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [queryClient, wellId]);

  return query;
}
