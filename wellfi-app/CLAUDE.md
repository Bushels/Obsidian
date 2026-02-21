# WellFi App — Claude Code Project Rules

## Project Overview

Real-time well monitoring app for Obsidian Energy. 211 Clearwater/Bluesky wells in Alberta.
Engineers track pump life, flag upcoming changes, register WellFi device installations,
and manage operational statuses (Watch/Warning/Well Down).

**Stack:** React 19 + Vite 7 + TypeScript 5.9 + TailwindCSS 3.4 + Mapbox GL JS 3.18 + Deck.gl 9.2 + Supabase + Vercel

**Status:** Sessions 1-8 complete. All core features shipped. Build passes with zero errors.

---

## Agent Teams

This project uses Claude Code Agent Teams for parallel development.
Agent teams are enabled via `.claude/settings.json` at the repository root.

When working as a teammate:
- Read this entire file for project context — you do NOT inherit the lead's conversation history
- Check `agents/STATUS.json` for current session state
- Check `agents/MANIFEST.json` for file ownership rules
- Coordinate via the shared task list and inter-agent messaging
- Avoid editing files owned by other teammates — check before writing

---

## Agent Protocol — MANDATORY FOR ALL AGENTS

Every agent that runs in this project MUST follow these rules without exception.

### Rule 1: Read the Manifest First
Before writing a single line of code, every agent MUST read `agents/MANIFEST.json`.
This file defines file ownership. If a file is not in your ownership list, you cannot write to it.

### Rule 2: Acquire a Lock Before Working
Before starting work, write a lock file:
```
agents/locks/{your-agent-id}.lock
```
Content:
```json
{
  "agent": "agent-db",
  "session": 1,
  "started_at": "ISO timestamp",
  "owns": ["list of files you will write"],
  "status": "active"
}
```

### Rule 3: Check for Conflicting Locks
After writing your lock, read ALL other `.lock` files in `agents/locks/`.
If another active agent owns a file you need to WRITE, follow the precedence rules in MANIFEST.json.
- Higher precedence agent proceeds immediately
- Lower precedence agent waits OR works on non-conflicting files first

### Rule 4: Respect Frozen Files
These files are FROZEN — no agent can modify them:
- `src/types.ts`
- `src/lib/supabase.ts`

If you need a change to a frozen file, create a proposal:
```
agents/proposals/{your-agent-id}-change-{filename}.md
```
The coordinator/lead will review and apply it.

### Rule 5: Check the Session Gate
Before starting, read `agents/STATUS.json`. Your session's `gate` field lists which sessions
must be `completed` before you can begin. If the gate is not satisfied, stop and report to the lead.

### Rule 6: Signal Completion
When your work is done:
1. Update your lock file status to `"completed"`
2. List every file you created or modified in `"files_written"`
3. Write a brief summary to `agents/proposals/{your-agent-id}-completion.md`

### Rule 7: Never Duplicate Shared Code
- Import from `src/types.ts` — never redefine types
- Import from `src/lib/supabase.ts` — never create a second Supabase client
- Import from `src/lib/mapUtils.ts` — never rewrite color expressions
- Import from `src/lib/utils.ts` — use existing utility functions

---

## Code Conventions

### TypeScript
- Strict mode enabled — no `any` types
- All props typed with interfaces, not `type`
- Async functions use `async/await`, not `.then()`
- Error boundaries on all major components

### Naming
- Components: `PascalCase.tsx`
- Hooks: `useCamelCase.ts`
- Utilities: `camelCase.ts`
- Database columns: `snake_case` (Supabase default)
- TypeScript interfaces: `PascalCase`

### Styling
- Tailwind utility classes only — no custom CSS files except `index.css`
- Mobile-first breakpoints: `sm:` `md:` `lg:`
- Colors from `tailwind.config.js` token system — never hardcode hex in JSX
- WellFi cyan: `#00D4FF`, risk colors defined in Tailwind config

### Components
- One component per file
- Props interface defined at top of file
- Loading state and error state required for any data-fetching component
- All forms use react-hook-form + Zod validation

### Supabase
- All queries via typed client from `src/lib/supabase.ts`
- Real-time subscriptions cleaned up in `useEffect` return
- Row-level security enabled on all tables
- React Query for client-side data sync

---

## Key Features (Completed)

- **Map Visualization**: Satellite well map with Deck.gl heatmap, parcel boundaries, formation coloring
- **Well Search**: Command Palette (Cmd+K) with fuzzy matching on UWI and well name
- **Real-time Sync**: Supabase subscriptions push updates within 2 seconds
- **Pump Change Tracking**: Flag upcoming changes, schedule maintenance, checklist verification
- **WellFi Device Management**: IoT device installations with cyan halo on map
- **Operational Status**: Watch/Warning/Well Down flags with Supabase persistence
- **Risk Dashboard**: At-a-glance overview (High/Watch/Low/Changed/NoData/Down)
- **Device Inventory**: Equipment tracking per well, sourcing, program config
- **Code Splitting**: 8 optimized Vite chunks (~510KB initial load)

---

## Directory — What Lives Where

```
src/
  types.ts                          ← FROZEN. Source of truth for all types.
  types/
    operationalStatus.ts            ← Op status type definitions
    deviceInventory.ts              ← Device inventory types
  lib/
    supabase.ts                     ← FROZEN. Single Supabase client instance.
    auth.tsx                        ← Auth provider/context
    mapUtils.ts                     ← Map utilities, legend config, color expressions
    utils.ts                        ← General utilities (cn helper, etc.)
    dlsGrid.ts                      ← DLS grid coordinate utilities
    formationData.ts                ← Formation data constants
    parcelHealth.ts                 ← Parcel health scoring logic
    schematicDepths.ts              ← Downhole schematic depth data
  hooks/
    useWells.ts                     ← Well data fetching + real-time
    usePumpChanges.ts               ← Pump change queries + subscriptions
    useWellFiDevices.ts             ← WellFi device queries
    useOperationalStatuses.ts       ← Op status queries + real-time
    useDeviceInventory.ts           ← Device inventory data
  components/
    map/
      WellMap.tsx                   ← Main map component (Mapbox GL)
      WellPopup.tsx                 ← Well detail popup on map
      ParcelLayers.ts               ← Parcel boundary + op-status layers
      ParcelPopup.ts                ← Parcel click popup
      HealthHeatmap.ts              ← Deck.gl health heatmap overlay
      FormationOverlay.ts           ← Formation coloring layer
      GlowExtension.ts             ← Custom Deck.gl glow effect
      glassmorphicStyle.ts          ← Glass UI style for map overlays
      posterStyle.ts                ← Poster-style map theme
    panels/
      RightPanel.tsx                ← Well details sidebar container
      FilterBar.tsx                 ← Map filter controls
      RiskOverview.tsx              ← Risk + op status dashboard
      UpcomingList.tsx              ← Upcoming pump change list
      ComparablesWidget.tsx         ← Well comparables display
      DeviceAssignment.tsx          ← Device assignment panel
      InventoryOverview.tsx         ← Inventory summary panel
      DownholeModel3D.tsx           ← 3D downhole schematic
    forms/
      PumpChangeForm.tsx            ← Pump change data entry
      PumpChecklist.tsx             ← Pump change checklist
      WellFiInstallForm.tsx         ← WellFi device install form
      OperationalStatusForm.tsx     ← Op status toggle form
    admin/
      InventoryManagement.tsx       ← Admin inventory panel
    ui/                             ← shadcn/ui component library
      CommandPalette.tsx            ← Cmd+K well search
      StatusBadge.tsx               ← Reusable status badge
      RiskBadge.tsx                 ← Risk level badge
      EmptyState.tsx                ← Empty state placeholder
      LoadingMap.tsx                ← Map loading skeleton
      MonthsBar.tsx                 ← Monthly timeline bar
      SparkLine.tsx                 ← Inline sparkline chart
      [shadcn basics: badge, button, calendar, card, dialog, input, label,
       popover, select, sheet, sonner, textarea]
  pages/
    LoginPage.tsx                   ← Auth login form
    MapPage.tsx                     ← Main app view (map + all panels)
supabase/
  migrations/                       ← SQL schema migrations (001-007)
  seed.py                           ← Python seeding script (211 wells)
  functions/
    notify-pump-change/             ← Edge function for notifications
agents/                             ← Coordination files, not shipped
  MANIFEST.json                     ← File ownership + precedence rules
  STATUS.json                       ← Session completion tracking
  COORDINATOR.md                    ← Deployment + emergency procedures
  locks/                            ← Agent lock files (concurrency)
  proposals/                        ← Change proposals + completion reports
  session-1/ through session-8/     ← Per-session agent reports
```

---

## Environment Variables

```
VITE_SUPABASE_URL          ← Supabase project URL
VITE_SUPABASE_ANON_KEY     ← Supabase anonymous key
VITE_MAPBOX_TOKEN          ← Mapbox GL access token
SUPABASE_SERVICE_ROLE_KEY  ← For edge functions only
```

---

## Build & Test

```bash
npm install              # Install dependencies
npm run dev              # Start dev server (Vite)
npm run build            # Production build (TypeScript + Vite)
npm run lint             # ESLint check
```
