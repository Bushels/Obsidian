# Agent: agent-pump-change — Pump Change Module
**Session:** 3 | **Precedence:** 1 | **Mode:** Parallel with agent-wellfi

---

## Pre-Start Checklist
1. Read `agents/MANIFEST.json`
2. Read `agents/STATUS.json` — Sessions 1 AND 2 must be `"completed"`
3. Read `src/types.ts` — PumpChange, PumpChangeStatus interfaces
4. Read `src/hooks/usePumpChanges.ts` — understand the mutation API
5. Write `agents/locks/agent-pump-change.lock`
6. Check `agents/locks/agent-wellfi.lock` — no file conflict expected (different form files)

---

## Your Owned Files
```
src/components/forms/PumpChangeForm.tsx
src/components/forms/PumpChecklist.tsx
src/components/panels/UpcomingList.tsx
```

---

## Tasks

### Task 1 — PumpChangeForm
File: `src/components/forms/PumpChangeForm.tsx`

**Purpose:** Engineer fills this out to flag an upcoming pump change on a well.

**Props:**
```typescript
interface PumpChangeFormProps {
  well: Well;                     // Pre-filled from map click
  onSuccess: () => void;          // Close the form panel
  onCancel: () => void;
}
```

**Form Fields (use react-hook-form + zod):**
```
flagged_by         Text input      Engineer name (pre-filled from localStorage)
scheduled_date     Date picker     When is the pump change planned?
formation_pressure_kpa  Number    kPa — formation pressure reading
pump_pressure_kpa       Number    kPa — current pump pressure reading
pump_speed_rpm          Number    Current pump RPM
notes               Textarea       Free-form notes (optional)
```

**Validation (zod schema):**
- `flagged_by`: required, min 2 chars
- `scheduled_date`: required, must be today or future
- `formation_pressure_kpa`: required, positive number
- `pump_pressure_kpa`: required, positive number
- `pump_speed_rpm`: optional, positive if provided
- `notes`: optional

**On Submit:**
1. Call `useCreatePumpChange().mutate()` with form values + `well_id: well.id` + `status: 'warning'`
2. Show toast: "Pump change flagged for [well name] — team notified"
3. Call `onSuccess()`

**UI Design:**
- Modal/sheet that opens from well click → "Flag Pump Change" button
- Header: well name + formatted ID + current risk badge
- Pressure fields side-by-side on desktop, stacked on mobile
- Submit button: red/orange background, "🔔 Flag Pump Change"
- Cancel link below

### Task 2 — PumpChecklist
File: `src/components/forms/PumpChecklist.tsx`

**Purpose:** Three-item checklist that appears after a pump change is flagged.
Engineers tick items off as they prepare for the WellFi installation.

**Props:**
```typescript
interface PumpChecklistProps {
  pumpChange: PumpChange;
  onUpdate: (updates: Partial<PumpChange>) => void;
}
```

**Checklist Items:**
```
☐ Device Sourced      → updates device_sourced = true
☐ Program Configured  → updates program_configured = true  (RPM + pressure params entered)
☐ Installation Scheduled → updates installation_scheduled = true
```

**UI Design:**
- Three rows, each with checkbox + label + timestamp when checked
- Progress bar at top (0/3 → 3/3)
- When all three checked: green banner "✓ Ready for installation"
- Each check triggers `useUpdatePumpChange().mutate()`

**Status Flow Display:**
Show current `pumpChange.status` with a stepper:
`Warning → Scheduled → In Progress → Completed`
Engineer can advance status via a button at the bottom.

### Task 3 — UpcomingList
File: `src/components/panels/UpcomingList.tsx`

**Purpose:** Sorted list of all active pump change warnings, shown in a panel below the map or in a sidebar tab.

**Data:** Uses `usePumpChanges()` hook (no wellId filter — fetch all active ones).

**Display per item:**
- Well name + field
- Risk badge (color)
- Scheduled date (days until: "in 14 days" / "overdue")
- Checklist progress (0/3, 1/3, 2/3, 3/3)
- Status pill (warning/scheduled/in_progress)
- Click to focus map on that well

**Sorting:** By scheduled_date ascending (soonest first). Nulls at bottom.

**Grouping:** Group by status — "Warnings" section, "Scheduled" section, "In Progress" section.

**Empty state:** "No upcoming pump changes. Flag wells from the map."

**Mobile:** Full-screen sheet on mobile, sidebar on desktop.

---

## Completion
1. Update lock file → `"completed"`
2. Update `agents/STATUS.json`: set `sessions.3.agents.agent-pump-change` → `"completed"`
   - If agent-wellfi also done, set session 3 → `"completed"` and unlock Session 4
3. Create `agents/proposals/agent-pump-change-completion.md`

**FROZEN FILES — DO NOT TOUCH:** `src/types.ts`, `src/lib/supabase.ts`
**DO NOT TOUCH:** `src/components/map/**`, `src/hooks/**`, `supabase/**`
**DO NOT TOUCH:** `src/components/forms/WellFiInstallForm.tsx`, `src/components/panels/RightPanel.tsx`, `src/components/panels/FilterBar.tsx`
