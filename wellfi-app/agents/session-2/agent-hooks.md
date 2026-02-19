# Agent: agent-hooks — Supabase Hooks & Realtime
**Session:** 2 | **Precedence:** 2 | **Mode:** Parallel with agent-map

---

## Pre-Start Checklist
1. Read `agents/MANIFEST.json`
2. Read `agents/STATUS.json` — Session 1 must be `"completed"`
3. Read `src/types.ts` — memorize the Well, WellFiDevice, PumpChange interfaces exactly
4. Read `src/lib/supabase.ts` — import from here only
5. Read `supabase/migrations/` — understand the table schema
6. Write `agents/locks/agent-hooks.lock`
7. Check `agents/locks/agent-map.lock` — no conflict (you own `hooks/`, they own `components/map/`)

---

## Your Owned Files
```
src/hooks/useWells.ts
src/hooks/usePumpChanges.ts
src/hooks/useWellFiDevices.ts
```

---

## Critical: Real-time Architecture
All three hooks follow the same pattern:
1. Initial query via TanStack Query (`useQuery`)
2. Supabase Realtime subscription that calls `queryClient.invalidateQueries()` on change
3. Cleanup subscription in `useEffect` return function

---

## Tasks

### Task 1 — useWells
File: `src/hooks/useWells.ts`

```typescript
// Fetches all wells with their joined WellFi device and active pump change.
// Uses a single query that joins wellfi_devices and pump_changes.
// Real-time: subscribes to changes on wells, wellfi_devices, AND pump_changes.
//   Any change to any of the three tables triggers wells re-fetch.

import { useEffect } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import { supabase } from '../lib/supabase';
import type { Well } from '../types';

export function useWells() {
  const queryClient = useQueryClient();

  const query = useQuery({
    queryKey: ['wells'],
    queryFn: async (): Promise<Well[]> => {
      // 1. Fetch all wells
      const { data: wells, error } = await supabase
        .from('wells')
        .select('*')
        .order('months_running', { ascending: false, nullsFirst: false });
      if (error) throw error;

      // 2. Fetch active WellFi devices
      const { data: devices } = await supabase
        .from('wellfi_devices')
        .select('*')
        .eq('is_active', true);

      // 3. Fetch active pump changes
      const { data: pumpChanges } = await supabase
        .from('pump_changes')
        .select('*')
        .in('status', ['warning', 'scheduled', 'in_progress']);

      // 4. Join in memory
      const deviceMap = new Map(devices?.map(d => [d.well_id, d]) ?? []);
      const changeMap = new Map(pumpChanges?.map(p => [p.well_id, p]) ?? []);

      return (wells ?? []).map(w => ({
        ...w,
        wellfi_device: deviceMap.get(w.id) ?? null,
        active_pump_change: changeMap.get(w.id) ?? null,
      }));
    },
    staleTime: 30_000,
  });

  // Real-time: invalidate on any change to wells, devices, or pump_changes
  useEffect(() => {
    const channel = supabase.channel('wells-realtime')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'wells' },
        () => queryClient.invalidateQueries({ queryKey: ['wells'] }))
      .on('postgres_changes', { event: '*', schema: 'public', table: 'wellfi_devices' },
        () => queryClient.invalidateQueries({ queryKey: ['wells'] }))
      .on('postgres_changes', { event: '*', schema: 'public', table: 'pump_changes' },
        () => queryClient.invalidateQueries({ queryKey: ['wells'] }))
      .subscribe();

    return () => { supabase.removeChannel(channel); };
  }, [queryClient]);

  return query;
}
```

### Task 2 — usePumpChanges
File: `src/hooks/usePumpChanges.ts`

```typescript
// Fetches pump changes with optional well filter.
// Mutations: createPumpChange, updatePumpChange, updateChecklist
// Real-time: subscribes to pump_changes table.

import type { PumpChange, PumpChangeStatus } from '../types';

// Exports:
export function usePumpChanges(wellId?: string): {
  data: PumpChange[] | undefined;
  isLoading: boolean;
  error: Error | null;
}

export function useCreatePumpChange(): {
  mutate: (change: Omit<PumpChange, 'id' | 'created_at' | 'updated_at'>) => void;
  isPending: boolean;
}

export function useUpdatePumpChange(): {
  mutate: (params: { id: string; updates: Partial<PumpChange> }) => void;
  isPending: boolean;
}

// Implementation notes:
// - usePumpChanges fetches ALL if no wellId, or filters by well_id
// - createPumpChange uses supabase.from('pump_changes').insert()
// - updatePumpChange uses supabase.from('pump_changes').update().eq('id', id)
// - On success, invalidate ['wells'] and ['pump_changes'] query keys
// - Real-time channel: subscribe to pump_changes table, invalidate on any event
```

### Task 3 — useWellFiDevices
File: `src/hooks/useWellFiDevices.ts`

```typescript
// Fetches WellFi devices. Mutation: registerWellFiDevice.
// Real-time: subscribes to wellfi_devices table.

import type { WellFiDevice } from '../types';

export function useWellFiDevices(wellId?: string): {
  data: WellFiDevice[] | undefined;
  isLoading: boolean;
  error: Error | null;
}

export function useRegisterWellFiDevice(): {
  mutate: (device: Omit<WellFiDevice, 'id' | 'created_at' | 'updated_at'>) => void;
  isPending: boolean;
}

export function useDeactivateWellFiDevice(): {
  mutate: (deviceId: string) => void;
  isPending: boolean;
}

// Implementation notes:
// - registerWellFiDevice: before insert, deactivate any existing active device for that well
//   (supabase.from('wellfi_devices').update({ is_active: false }).eq('well_id', wellId))
// - deactivateWellFiDevice: update is_active = false
// - On success, invalidate ['wells'] and ['wellfi_devices'] query keys
// - Real-time: invalidate ['wells'] on any wellfi_devices change
```

---

## Completion
1. Update lock file → `"completed"`
2. Update `agents/STATUS.json`: set `sessions.2.agents.agent-hooks` → `"completed"`
   - If agent-map also done, set session 2 → `"completed"` and unlock Session 3
3. Create `agents/proposals/agent-hooks-completion.md`

**FROZEN FILES — DO NOT TOUCH:** `src/types.ts`, `src/lib/supabase.ts`
**DO NOT TOUCH:** `src/components/**`, `supabase/**`, `src/pages/**`
