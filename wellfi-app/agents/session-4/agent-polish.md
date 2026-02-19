# Agent: agent-polish — UI Polish & Mobile
**Session:** 4 | **Precedence:** 2 | **Mode:** Parallel with agent-notifications

---

## Pre-Start Checklist
1. Read `agents/MANIFEST.json`
2. Read `agents/STATUS.json` — Sessions 1, 2, AND 3 must all be `"completed"`
3. Read ALL files in `src/components/` and `src/pages/` — understand what each agent built
4. Read `src/types.ts` and `src/lib/mapUtils.ts`
5. Write `agents/locks/agent-polish.lock`
6. Check `agents/locks/agent-notifications.lock` — no file conflict (they own `supabase/functions/`)

---

## IMPORTANT: Proposal Protocol
You may NOT directly modify files owned by other agents (components, hooks, pages).
Instead, for each change needed, create:
```
agents/proposals/polish-{component-name}-{change-type}.md
```
Content: the exact diff or replacement code + rationale.
The coordinator will review and apply these before deployment.

**You MAY directly write:**
```
src/components/ui/**    (shadcn components + custom UI primitives)
src/index.css          (global styles)
```

---

## Tasks

### Task 1 — Global Styles & Loading States
File: `src/index.css`

Add:
```css
/* Mapbox GL reset */
.mapboxgl-map { font-family: 'Inter', -apple-system, sans-serif; }
.mapboxgl-popup-content { padding: 0; border-radius: 12px; overflow: hidden; box-shadow: 0 8px 32px rgba(0,0,0,0.2); }
.mapboxgl-popup-close-button { top: 8px; right: 8px; font-size: 18px; color: #6b7280; }

/* WellFi halo pulse animation */
@keyframes wellfi-pulse {
  0%, 100% { opacity: 0.3; transform: scale(1); }
  50% { opacity: 1; transform: scale(1.15); }
}
.wellfi-pulse { animation: wellfi-pulse 2s ease-in-out infinite; }

/* Risk color utilities */
.risk-high { color: #EF4444; }
.risk-orange { color: #F97316; }
.risk-yellow { color: #EAB308; }
.risk-green { color: #22C55E; }
.risk-gray { color: #6B7280; }
.risk-purple { color: #A855F7; }
.risk-cyan { color: #00D4FF; }

/* Mobile map touch improvements */
@media (max-width: 768px) {
  .mapboxgl-ctrl-group { margin: 8px; }
  .mapboxgl-ctrl-bottom-right { bottom: 80px; }
}

/* Smooth panel transitions */
.panel-slide-in { animation: slideInRight 0.25s ease-out; }
@keyframes slideInRight {
  from { transform: translateX(100%); opacity: 0; }
  to { transform: translateX(0); opacity: 1; }
}
```

### Task 2 — Custom UI Primitives
Files in `src/components/ui/`:

**RiskBadge.tsx** — Colored pill for risk levels:
```typescript
interface RiskBadgeProps { risk: RiskLevel | null; size?: 'sm' | 'md'; }
// Returns a <span> with the right background/text color from tailwind config tokens
```

**MonthsBar.tsx** — Visual pump age bar:
```typescript
interface MonthsBarProps { months: number | null; showLabel?: boolean; }
// Progress bar from 0–20 months. Green 0-8, yellow 9-13, orange 14-16, red 17+
// Shows "X mo" label. Red pulsing animation when 17+.
```

**SparkLine.tsx** — 12-bar mini production chart:
```typescript
interface SparkLineProps { data: number[]; height?: number; color?: string; }
// Pure SVG, no chart library. 12 bars for Jan–Dec.
// Auto-scales to max value. Zero bars in light red.
```

**LoadingMap.tsx** — Map loading skeleton:
```typescript
// Full-screen skeleton with animated shimmer + "Loading well data..." text
// Shows while useWells() isLoading
```

**EmptyState.tsx** — No results state:
```typescript
interface EmptyStateProps { icon: string; title: string; description: string; }
```

### Task 3 — Mobile Responsiveness Proposals
Create these proposal files. Each contains the exact changes needed:

**`agents/proposals/polish-MapPage-mobile.md`**
```
File: src/pages/MapPage.tsx
Change: Responsive layout
Desktop: Three-column flex (FilterBar 280px | Map flex-1 | RightPanel 380px)
Mobile: Map full-screen, FilterBar as bottom drawer, RightPanel as bottom sheet
Add: Mobile header bar with "WellFi" logo + filter toggle button + upcoming count badge
```

**`agents/proposals/polish-RightPanel-mobile.md`**
```
File: src/components/panels/RightPanel.tsx
Change: On mobile (< 768px), render as a bottom Sheet (slides up) instead of sidebar
Use: shadcn Sheet component with side="bottom"
Height: 80vh on mobile, full sidebar on desktop
```

**`agents/proposals/polish-FilterBar-mobile.md`**
```
File: src/components/panels/FilterBar.tsx
Change: On mobile, hide by default. Show via floating "🔍 Filters" button.
Use: shadcn Sheet with side="bottom"
Add: Active filter count badge on the toggle button
```

**`agents/proposals/polish-WellMap-mobile.md`**
```
File: src/components/map/WellMap.tsx
Change: Touch gestures — ensure Mapbox touches don't conflict with panel swipes
Add: "Locate me" button (navigator.geolocation) for field use
Add: Zoom to fit all wells button
```

### Task 4 — Loading & Error States Proposals

**`agents/proposals/polish-MapPage-loading.md`**
```
File: src/pages/MapPage.tsx
Change: While useWells().isLoading, show <LoadingMap /> full-screen
While useWells().isError, show error banner: "Could not load well data — check connection"
```

**`agents/proposals/polish-forms-loading.md`**
```
Files: PumpChangeForm.tsx, WellFiInstallForm.tsx
Change: Disable submit button + show spinner while mutation isPending
Add: Error toast on mutation error with retry button
```

### Task 5 — Map Legend Enhancement Proposal

**`agents/proposals/polish-WellMap-legend.md`**
```
File: src/components/map/WellMap.tsx
Change: Enhance existing legend with:
  - Animated WellFi halo preview swatch
  - Pump age color gradient bar (green → red)
  - Interactive: click legend item to filter map
  - Collapse toggle on mobile
  - Well count per category in parentheses
```

### Task 6 — Accessibility Proposals

**`agents/proposals/polish-accessibility.md`**
```
Across all components:
- All buttons have aria-label
- Color indicators have text alternatives (don't rely on color alone)
- Keyboard navigation for filter toggles
- Focus trap in modals/sheets
- Map popups accessible via keyboard
```

---

## Completion
1. Update lock file → `"completed"`
2. Update `agents/STATUS.json`: set `sessions.4.agents.agent-polish` → `"completed"`
   - If agent-notifications also done, set ALL sessions complete → `"completed"`
   - Set overall project status to `"ready_for_deployment"`
3. Create `agents/proposals/agent-polish-completion.md` with:
   - List of all proposal files created (coordinator to review + apply)
   - List of files directly written (`src/components/ui/`, `src/index.css`)
   - Estimated time to apply all proposals: ~2 hours for coordinator
