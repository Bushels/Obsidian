import { useEffect } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { Database } from '@/lib/supabase';
import type { WellFiDevice } from '@/types';

type WellFiDeviceInsert = Database['public']['Tables']['wellfi_devices']['Insert'];

export function useWellFiDevices(wellId?: string) {
  const queryClient = useQueryClient();

  const query = useQuery({
    queryKey: ['wellfi_devices', wellId],
    queryFn: async (): Promise<WellFiDevice[]> => {
      let q = supabase
        .from('wellfi_devices')
        .select('*')
        .order('created_at', { ascending: false });

      if (wellId) {
        q = q.eq('well_id', wellId);
      }

      const { data, error } = await q;
      if (error) throw error;
      return (data ?? []) as unknown as WellFiDevice[];
    },
  });

  // Real-time: invalidate on any change to wellfi_devices
  useEffect(() => {
    const channel = supabase
      .channel(`wellfi-devices-realtime-${wellId ?? 'all'}`)
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'wellfi_devices' },
        () => {
          queryClient.invalidateQueries({ queryKey: ['wellfi_devices'] });
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

export function useRegisterWellFiDevice() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (device: WellFiDeviceInsert): Promise<WellFiDevice> => {
      // 1. Deactivate any existing active devices for this well
      await supabase
        .from('wellfi_devices')
        .update({ is_active: false } as never)
        .eq('well_id', device.well_id)
        .eq('is_active', true);

      // 2. Insert the new device
      const { data, error } = await supabase
        .from('wellfi_devices')
        .insert(device as never)
        .select()
        .single();
      if (error) throw error;
      return data as unknown as WellFiDevice;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['wellfi_devices'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    },
  });
}

export function useDeactivateWellFiDevice() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (deviceId: string): Promise<WellFiDevice> => {
      const { data, error } = await supabase
        .from('wellfi_devices')
        .update({ is_active: false } as never)
        .eq('id', deviceId)
        .select()
        .single();
      if (error) throw error;
      return data as unknown as WellFiDevice;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['wellfi_devices'] });
      queryClient.invalidateQueries({ queryKey: ['wells'] });
    },
  });
}
