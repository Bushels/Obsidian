# Agent: Innovation — Session 5

## Identity
- **Agent ID:** `agent-innovation`
- **Session:** 5
- **Gate:** Sessions 1–4 complete
- **Precedence:** 1
- **Philosophy:** Think outside the box. Every interaction should feel intentional, fluid, and memorable. The goal is not feature count — it's *the moment an engineer opens this app and thinks "this is different."*

---

## Mandate

You are the Innovation Agent for WellFi. Your job is twofold:

1. **UX Wow-Factor** — Elevate the existing app from functional to exceptional. Micro-interactions, transitions, spatial awareness, and visual hierarchy that make engineers *want* to use this tool.
2. **Forward-Thinking Features** — Identify high-impact features that differentiate WellFi from every spreadsheet-and-SCADA tool these engineers have used before. Research trending patterns in industrial monitoring, data visualization, and real-time operations dashboards.

### Constraints (Non-Negotiable)
- **Do NOT create new files unless absolutely necessary.** Enhance what exists.
- **Do NOT add features that won't be used.** Every addition must serve a real engineer workflow.
- **Do NOT break existing functionality.** All changes must be additive and backward-compatible.
- **Respect frozen files:** `src/types.ts`, `src/lib/supabase.ts` are READ-ONLY.
- **Do NOT add new npm dependencies** without coordinator approval.
- **Do NOT interfere with Google Antigravity IDE** — no IDE-specific configs, no conflicting agent orchestration files.

---

## Phase 1: UX Wow-Factor Enhancements

### 1.1 Map Fly-To Animation
When a user clicks a well from the UpcomingList or FilterBar, the map should smoothly fly to that well's location with a zoom-in effect, not just select it.
- Use `map.flyTo({ center, zoom, speed, curve })` in WellMap.tsx
- Add a subtle bounce at destination
- Pair with a brief highlight pulse on the target well dot

### 1.2 Panel Transitions
- Right panel (desktop): slide-in from right with spring-like easing, not instant appear
- Bottom sheet (mobile): already has slide-up, but add momentum-based swipe-to-dismiss
- Panel content should stagger-animate cards (each card fades up 50ms after the previous)

### 1.3 Well Dot Micro-Interactions
- High-risk wells (DUE) should have a subtle pulsing glow animation on the map layer
- Hovered wells should smoothly scale up with a glow ring
- Selected well should have a persistent highlight ring that differs from hover

### 1.4 Login Page Polish
- Add a subtle particle/dot-field background that evokes well locations on a map
- Animate the WellFi logo on load (fade-in + slight scale)
- Add a typing indicator effect on the "Sign in to monitor your wells" subtitle
- Input focus should trigger a cyan glow border transition

### 1.5 Loading States
- LoadingMap: Add animated well-dot placeholders that pulse in a grid pattern (resembling the actual map)
- Number transitions: When production numbers update, they should count-up animate
- Skeleton states on RightPanel cards while data loads

### 1.6 Toast Notifications
- Pump change completions should trigger a celebratory micro-animation (checkmark with ring expansion)
- Error toasts should have a subtle shake animation

### 1.7 Keyboard Shortcuts (Power User UX)
- `Escape` — close any open panel or dialog
- `F` — focus filter search (if search exists)
- `/` or `Cmd+K` — quick well search/jump
- Arrow keys — cycle through wells in the upcoming list

---

## Phase 2: Forward-Thinking Features

### 2.1 Command Palette / Quick Search (Cmd+K)
A fast, keyboard-driven search overlay to jump to any well by name, ID, or field. This is the single highest-impact UX feature for engineers managing 211+ wells.
- Fuzzy search across well name, formatted_id, field, formation
- Recent wells shown by default
- Arrow key navigation + Enter to select
- Map flies to selected well

### 2.2 Well Cluster Markers
At low zoom levels (zoom < 8), individual dots become unreadable. Add intelligent clustering:
- Use Mapbox `cluster` source option on the wells GeoJSON source
- Cluster circles show count + dominant risk color
- Click cluster to zoom into its bounds
- Smooth transition from cluster to individual dots

### 2.3 Quick Stats Dashboard Bar
A collapsible horizontal bar below the header showing real-time aggregate metrics:
- Total wells | Active pump changes | High-risk count | WellFi coverage %
- Each stat clickable to apply that filter
- Animated number counters that update in real-time
- Collapse to just icons on mobile

### 2.4 Heat Map Toggle
Add a toggle alongside the existing LSD/Style buttons:
- Production rate heat map (warm colors = high production)
- Risk heat map (red zones = clusters of high-risk wells)
- Uses Mapbox `heatmap` layer type on the same wells source

### 2.5 Well Comparison Mode
Allow engineers to pin 2-3 wells and compare them side-by-side:
- Pin button in the well popup or right panel
- Comparison tray slides up from bottom with columns for each pinned well
- Side-by-side sparklines, risk badges, production metrics
- Quick way to decide which wells to prioritize for pump changes

---

## Phase 3: Performance & Build Optimization

### 3.1 Code Splitting
Current bundle is 2.5MB. Split into:
- `vendor-mapbox.js` — mapbox-gl (largest chunk)
- `vendor-ui.js` — Radix + shadcn components
- `app.js` — application code
Use `build.rollupOptions.output.manualChunks` in vite.config.ts

### 3.2 Lazy Loading
- Lazy-load the MapPage (React.lazy + Suspense)
- Lazy-load dialog forms (PumpChangeForm, WellFiInstallForm)
- Lazy-load the command palette

---

## File Ownership

### Owns (can modify directly)
- `src/index.css` (animations, transitions)
- `src/components/ui/*` (new UI primitives)
- `vite.config.ts` (build optimization only)

### Can Modify With Proposal
- `src/components/map/WellMap.tsx` (fly-to, clusters, heatmap, hover effects)
- `src/components/panels/RightPanel.tsx` (transitions, comparison pins)
- `src/components/panels/UpcomingList.tsx` (fly-to integration, keyboard nav)
- `src/components/panels/FilterBar.tsx` (keyboard shortcuts)
- `src/pages/MapPage.tsx` (command palette, stats bar, keyboard handling)
- `src/pages/LoginPage.tsx` (login polish)
- `src/App.tsx` (lazy loading, code splitting)

### Must Not Touch
- `src/types.ts` (FROZEN)
- `src/lib/supabase.ts` (FROZEN)
- `supabase/**` (database layer)
- `agents/session-1/**` through `agents/session-4/**` (completed sessions)

---

## Completion Criteria

1. Map flies to wells when selected from sidebar lists
2. Panel open/close has smooth spring-like transitions
3. High-risk wells pulse subtly on the map
4. Cmd+K command palette enables instant well search
5. Bundle split into ≤3 chunks, main app chunk under 500KB
6. All existing functionality preserved — zero regressions
7. Build passes with zero TypeScript errors

---

## Implementation Priority

| Priority | Feature | Impact | Effort |
|----------|---------|--------|--------|
| P0 | Map fly-to animation | High | Low |
| P0 | Code splitting | High | Low |
| P0 | Cmd+K quick search | Very High | Medium |
| P1 | Panel transitions | Medium | Low |
| P1 | Well dot hover/pulse | Medium | Low |
| P1 | Keyboard shortcuts | High | Low |
| P1 | Well clustering | High | Medium |
| P2 | Login page polish | Medium | Low |
| P2 | Quick stats bar | Medium | Medium |
| P2 | Heat map toggle | Medium | Medium |
| P3 | Well comparison mode | High | High |
| P3 | Number count-up animations | Low | Low |
