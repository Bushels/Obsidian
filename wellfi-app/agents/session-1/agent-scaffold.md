# Agent: agent-scaffold — Project Scaffold & Auth
**Session:** 1 | **Precedence:** 2 | **Mode:** Parallel with agent-db

---

## Pre-Start Checklist
1. Read `agents/MANIFEST.json`
2. Read `agents/STATUS.json` — Session 1 must be `pending` or `in_progress`
3. Write `agents/locks/agent-scaffold.lock`
4. Check for `agents/locks/agent-db.lock` — if active, no conflict (you own different files)

---

## Your Owned Files (only you write these)
```
src/types.ts              ← BECOMES FROZEN when this session completes
src/lib/supabase.ts       ← BECOMES FROZEN when this session completes
src/pages/LoginPage.tsx
src/pages/MapPage.tsx
src/App.tsx
src/main.tsx
src/index.css
tailwind.config.ts
vite.config.ts
tsconfig.json
package.json
index.html
.env.example
.gitignore
README.md
```

---

## Critical: types.ts and supabase.ts Will Be Frozen
After this session, `src/types.ts` and `src/lib/supabase.ts` are frozen.
Define them completely and correctly — every other agent depends on them.

---

## Tasks

### Task 1 — Project Init
Run these commands in project root:
```bash
npm create vite@latest . -- --template react-ts
npm install
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
npm install @supabase/supabase-js
npm install react-router-dom
npm install @tanstack/react-query
npm install react-hook-form @hookform/resolvers zod
npm install lucide-react
npm install clsx tailwind-merge
```

Install shadcn/ui:
```bash
npx shadcn@latest init
```
Select: TypeScript, tailwind, default style, slate base color, CSS variables: yes.

Install required shadcn components:
```bash
npx shadcn@latest add button input label card badge sheet dialog select textarea toast
```

### Task 2 — TypeScript Types (CRITICAL — defines all data shapes)
File: `src/types.ts`

```typescript
// ============================================================
// FROZEN after Session 1. Do not modify without coordinator approval.
// All agents import from here. Never redefine these types.
// ============================================================

export type RiskLevel =
  | 'HIGH — DUE'
  | 'WATCH'
  | 'LOW'
  | 'RECENTLY CHANGED'
  | 'DOWN NOW'
  | 'NO DATA'
  | 'UNKNOWN';

export type WellStatus = 'Pumping' | 'Operating' | 'Suspended' | 'Abandoned';
export type Formation = 'Bluesky' | 'Clearwater';
export type PumpChangeStatus = 'warning' | 'scheduled' | 'in_progress' | 'completed' | 'cancelled';

export interface Well {
  id: string;
  well_id: string;
  formatted_id: string | null;
  name: string | null;
  lat: number;
  lon: number;
  formation: Formation | null;
  field: string | null;
  well_status: WellStatus | null;
  risk_level: RiskLevel | null;
  months_running: number | null;
  dec_rate_bbl_d: number | null;
  total_2025_bbl: number | null;
  cumulative_oil: number | null;
  on_production_date: string | null;
  last_production_date: string | null;
  annual_uptime_pct: number | null;
  total_downtime_days: number | null;
  monthly_hrs: number[] | null;      // 12-element, Jan–Dec 2025
  monthly_oil: number[] | null;
  monthly_uptime: number[] | null;
  status_note: string | null;
  created_at: string;
  updated_at: string;
  // Joined fields (not DB columns — populated by hooks)
  wellfi_device?: WellFiDevice | null;
  active_pump_change?: PumpChange | null;
}

export interface WellFiDevice {
  id: string;
  well_id: string;
  serial_number: string | null;
  installed_at: string | null;
  installed_by: string;
  is_active: boolean;
  pump_speed_rpm: number | null;
  formation_pressure_kpa: number | null;
  pump_intake_pressure_kpa: number | null;
  target_surface_pressure_kpa: number | null;
  firmware_version: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface PumpChange {
  id: string;
  well_id: string;
  status: PumpChangeStatus;
  flagged_by: string;
  flagged_at: string;
  scheduled_date: string | null;
  notes: string | null;
  formation_pressure_kpa: number | null;
  pump_pressure_kpa: number | null;
  pump_speed_rpm: number | null;
  device_sourced: boolean;
  program_configured: boolean;
  installation_scheduled: boolean;
  actual_date: string | null;
  completed_by: string | null;
  wellfi_installed_after: boolean;
  notification_sent: boolean;
  created_at: string;
  updated_at: string;
}

// UI-only types
export type MapColorMode = 'risk' | 'formation' | 'field';

export interface MapFilters {
  riskLevels: RiskLevel[];
  formations: Formation[];
  fields: string[];
  showWellFiOnly: boolean;
  showUpcomingOnly: boolean;
  minRateBblD: number;
}

export interface AppUser {
  name: string;       // Shared login — just a name, no individual auth
  email: string;
}
```

### Task 3 — Supabase Client (CRITICAL — single instance, used everywhere)
File: `src/lib/supabase.ts`

```typescript
// ============================================================
// FROZEN after Session 1. Single Supabase client for the entire app.
// Import this — never create another client.
// ============================================================
import { createClient } from '@supabase/supabase-js';
import type { Well, WellFiDevice, PumpChange } from '../types';

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL as string;
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY as string;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  throw new Error('Missing Supabase environment variables. Check .env file.');
}

export type Database = {
  public: {
    Tables: {
      wells: { Row: Well; Insert: Omit<Well, 'id' | 'created_at' | 'updated_at' | 'wellfi_device' | 'active_pump_change'>; Update: Partial<Well>; };
      wellfi_devices: { Row: WellFiDevice; Insert: Omit<WellFiDevice, 'id' | 'created_at' | 'updated_at'>; Update: Partial<WellFiDevice>; };
      pump_changes: { Row: PumpChange; Insert: Omit<PumpChange, 'id' | 'created_at' | 'updated_at'>; Update: Partial<PumpChange>; };
    };
  };
};

export const supabase = createClient<Database>(SUPABASE_URL, SUPABASE_ANON_KEY);
```

### Task 4 — Auth Setup (Shared Login)
File: `src/pages/LoginPage.tsx`

Simple email/password form. Single set of credentials shared by the team.
- Uses react-hook-form + zod validation
- On success: stores engineer name in localStorage (`wellfi_engineer_name`)
- Redirects to `/map`
- Use shadcn Card, Input, Button, Label components

### Task 5 — Map Page Shell
File: `src/pages/MapPage.tsx`

Shell component only — placeholder divs for the panels other agents will build:
```tsx
// Placeholder layout:
// - Full-height flex container
// - Left: FilterBar (placeholder div with id="filter-bar-mount")
// - Center: WellMap (placeholder div with id="map-mount")
// - Right: RightPanel (placeholder div with id="right-panel-mount")
// Import nothing from other agents' files yet — use placeholders
```

### Task 6 — App Entry + Routing
File: `src/App.tsx`
- React Router: `/` → LoginPage, `/map` → MapPage
- QueryClientProvider wrapping everything
- Toaster from shadcn for notifications

File: `src/main.tsx` — standard Vite entry point

### Task 7 — Tailwind Config
File: `tailwind.config.ts`

Add WellFi brand colors as tokens:
```typescript
colors: {
  'wellfi-cyan': '#00D4FF',      // WellFi installed halo
  'risk-red': '#EF4444',         // Overdue 17+ months
  'risk-orange': '#F97316',      // Due 14–16 months
  'risk-yellow': '#EAB308',      // Watch 9–13 months
  'risk-green': '#22C55E',       // Healthy 1–8 months
  'risk-purple': '#A855F7',      // Upcoming pump change warning
  'risk-gray': '#6B7280',        // Down / no data
}
```

### Task 8 — Environment Template
File: `.env.example`
```
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
VITE_MAPBOX_TOKEN=pk.your-mapbox-token
```

---

## Completion
1. Update lock file → `"completed"`, list all files written
2. Update `agents/STATUS.json`:
   - Set `sessions.1.agents.agent-scaffold` → `"completed"`
   - If agent-db is also completed: set `sessions.1.status` → `"completed"`, add `"src/types.ts"` and `"src/lib/supabase.ts"` to `frozen_files`, unlock Session 2
3. Create `agents/proposals/agent-scaffold-completion.md`

**DO NOT touch:** `supabase/` directory, any agent-db owned files
