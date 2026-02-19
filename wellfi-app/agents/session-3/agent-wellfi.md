# Agent: agent-wellfi — WellFi Device Module
**Session:** 3 | **Precedence:** 2 | **Mode:** Parallel with agent-pump-change

---

## Pre-Start Checklist
1. Read `agents/MANIFEST.json`
2. Read `agents/STATUS.json` — Sessions 1 AND 2 must be `"completed"`
3. Read `src/types.ts` — Well, WellFiDevice interfaces
4. Read `src/hooks/useWellFiDevices.ts` — understand the mutation API
5. Read `src/hooks/useWells.ts` — understand the joined data structure
6. Write `agents/locks/agent-wellfi.lock`
7. Check `agents/locks/agent-pump-change.lock` — no file conflict (you own different files)

---

## Your Owned Files
```
src/components/forms/WellFiInstallForm.tsx
src/components/panels/RightPanel.tsx
src/components/panels/FilterBar.tsx
```

---

## Tasks

### Task 1 — WellFiInstallForm
File: `src/components/forms/WellFiInstallForm.tsx`

**Purpose:** Engineer registers a WellFi device installation and enters its parameters.
This is the key form — it makes the pulsing cyan halo appear on the map.

**Props:**
```typescript
interface WellFiInstallFormProps {
  well: Well;
  onSuccess: () => void;
  onCancel: () => void;
}
```

**Form Fields (react-hook-form + zod):**
```
installed_by                Text      Engineer name (pre-filled from localStorage)
installed_at                DateTime  Installation date/time (default: now)
serial_number               Text      WellFi device serial number (optional)
firmware_version            Text      e.g. "v2.4.1" (optional)
— WellFi Parameters —
pump_speed_rpm              Number    Target pump speed (RPM)
formation_pressure_kpa      Number    Formation pressure reading (kPa)
pump_intake_pressure_kpa    Number    Pump intake pressure (kPa)
target_surface_pressure_kpa Number    Target surface pressure (kPa)
notes                       Textarea  Additional notes (optional)
```

**On Submit:**
1. Call `useRegisterWellFiDevice().mutate()` — this deactivates any existing device first
2. Show toast: "WellFi installed on [well name] — device [serial] now active"
3. Call `onSuccess()`
4. Map will auto-update via real-time subscription (pulsing halo appears within ~1 second)

**UI Design:**
- Two-column layout on desktop (identity fields left, pressure params right)
- Section headers: "Device Info" and "WellFi Parameters"
- kPa unit labels on number fields
- Submit button: cyan background (#00D4FF), "📡 Register WellFi Installation"
- If well already has an active WellFi: show warning banner "This well already has an active WellFi (SN: [serial]). Submitting will deactivate it and register the new device."

### Task 2 — RightPanel (Well Detail)
File: `src/components/panels/RightPanel.tsx`

**Purpose:** Collapsible side panel that shows full well detail + action buttons.
Opens when an engineer clicks a well on the map.

**Props:**
```typescript
interface RightPanelProps {
  well: Well | null;    // null = panel is closed
  onClose: () => void;
}
```

**Panel Sections:**

**Section 1 — Well Identity**
- Well name (large)
- Formatted ID + Formation badge + Field badge
- Status: Pumping/Operating/Suspended/Abandoned
- On production since: [date] (X years)

**Section 2 — Pump Status**
- Risk level badge (full color)
- Months running: visual progress bar (0–20 months, red at 16+)
- Last production date
- Annual uptime %
- Status note (from `status_note` field)

**Section 3 — Production (2025)**
- Dec rate: X bbl/d
- 2025 total: X bbl
- Sparkline chart (12 bars for monthly_oil — use inline SVG, no chart library)

**Section 4 — WellFi Device**
- If `wellfi_device` exists:
  - Serial number, firmware version
  - Installed by [name] on [date]
  - Parameters table: pump speed, pressures
  - "Update Device" button → opens WellFiInstallForm
- If no device:
  - "No WellFi installed"
  - "📡 Register Installation" button → opens WellFiInstallForm

**Section 5 — Pump Change**
- If `active_pump_change` exists:
  - PumpChecklist component (import from agent-pump-change's file)
  - Scheduled date + status stepper
- If no active change:
  - Risk-based callout: "This well has been running X months. Consider flagging for pump change."
  - "🔔 Flag Pump Change" button → opens PumpChangeForm

**Mobile:** Full-screen bottom sheet on mobile (slides up from bottom). Sidebar on desktop.

### Task 3 — FilterBar
File: `src/components/panels/FilterBar.tsx`

**Purpose:** Collapsible filter panel. On desktop: left sidebar. On mobile: bottom drawer triggered by filter button.

**Props:**
```typescript
interface FilterBarProps {
  filters: MapFilters;
  onChange: (filters: MapFilters) => void;
  wellCounts: Record<string, number>;  // count per risk level
}
```

**Filter Controls:**

**Risk Level toggles** (show count per level):
```
☑ HIGH — DUE (146)     🔴
☑ DOWN NOW (25)         ⚫
☑ WATCH (6)            🟡
☑ RECENTLY CHANGED (9) 🟢
☑ LOW (9)              🟢
☑ UNKNOWN (10)         ⚫
```

**Formation** (radio):
`● All  ○ Bluesky  ○ Clearwater`

**Field** (multi-select checkboxes):
`☑ SEAL ☑ CADOTTE ☑ HARMON VALLEY ☑ SLAVE ☑ DAWSON ☑ UNDEFINED`

**WellFi Status** (toggle):
`○ All wells  ● WellFi installed only  ○ Not installed only`

**Upcoming Changes** (toggle):
`☐ Show upcoming changes only`

**Rate Filter** (slider):
`Min production: 0 bbl/d ————●———— 50 bbl/d`

**Reset** button at bottom.

**Mobile-specific:** Floating "🔍 Filters (3 active)" button at bottom of screen that opens the drawer.

---

## Completion
1. Update lock file → `"completed"`
2. Update `agents/STATUS.json`: set `sessions.3.agents.agent-wellfi` → `"completed"`
   - If agent-pump-change also done, set session 3 → `"completed"` and unlock Session 4
3. Create `agents/proposals/agent-wellfi-completion.md`

**FROZEN FILES — DO NOT TOUCH:** `src/types.ts`, `src/lib/supabase.ts`
**DO NOT TOUCH:** `src/components/map/**`, `src/hooks/**`, `supabase/**`
**DO NOT TOUCH:** `src/components/forms/PumpChangeForm.tsx`, `src/components/forms/PumpChecklist.tsx`, `src/components/panels/UpcomingList.tsx`
