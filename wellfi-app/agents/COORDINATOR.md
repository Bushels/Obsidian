# WellFi Swarm Coordinator Instructions

This file is the operating guide for the top-level coordination session that manages the repo agents, verifies gates, and closes each implementation phase cleanly.

---

## Before Starting Each Session

1. Read `agents/STATUS.json`.
2. Confirm the required gate sessions are marked `completed`.
3. Check `agents/locks/` and remove stale lock files from crashed runs.
4. Check `agents/proposals/` and apply any pending proposals before starting the next phase.

---

## How to Spawn Agents

Each session can run its assigned agents in parallel using the Task tool.

```text
Session 1: Task(agents/session-1/agent-db.md)
           Task(agents/session-1/agent-scaffold.md)

Session 2: Task(agents/session-2/agent-map.md)
           Task(agents/session-2/agent-hooks.md)

Session 3: Task(agents/session-3/agent-pump-change.md)
           Task(agents/session-3/agent-wellfi.md)

Session 4: Task(agents/session-4/agent-notifications.md)
           Task(agents/session-4/agent-polish.md)
```

Pass the full contents of the target agent markdown file into the task prompt.

---

## Between Sessions

### Verify Completion

- Read both lock files.
- Read both completion reports in `agents/proposals/`.
- Confirm the expected files were actually created or updated.

### Apply Proposals

- Review each pending proposal.
- Apply approved changes manually or with a follow-up agent task.
- Run a browser check after UI-impacting changes.

### Update STATUS.json

- Mark completed agents and sessions.
- Add any newly frozen files.
- Unlock the next session when its gate is satisfied.

### Clear Old Locks

```bash
rm agents/locks/agent-*.lock
```

Only remove completed lock files.

### Git Commit

```bash
git add .
git commit -m "feat: session N complete"
```

---

## Conflict Resolution

If two agents need the same file:

1. Lower precedence number wins.
2. If the file is frozen, merge through a proposal and apply once.
3. If an agent writes outside its ownership, keep the owner version and manually extract any useful changes.

---

## Deployment Checklist

### Supabase

- [ ] Run migrations: `supabase db push`
- [ ] Run seed data if needed: `python supabase/seed.py`
- [ ] Deploy edge function: `supabase functions deploy notify-operational-status`
- [ ] Set required secrets
- [ ] Register the database webhook for `operational_statuses`

### Vercel

- [ ] Set `VITE_MAPBOX_TOKEN`
- [ ] Set `VITE_SUPABASE_URL`
- [ ] Set `VITE_SUPABASE_ANON_KEY`
- [ ] Deploy production

### Verification

- [ ] Open the app and confirm the main dashboard loads with well markers
- [ ] Open two tabs and confirm an operational status update appears in the second tab within a few seconds
- [ ] Confirm a WellFi install still shows the cyan halo
- [ ] Run a browser smoke test with Playwright or another AI browser driver
- [ ] Test mobile layout, filters, and forms

---

## Mandatory 6-Gate Workflow DAG

Every session or feature track MUST pass through all six gates in order.
Gates 3-6 are **NON-NEGOTIABLE**. No skipping, no "we'll fix it later."

> **Lesson learned:** Track #17 in bushel-board-app shipped with 9 bugs because
> gates 3-5 were skipped. That mistake is not repeated here.

```
┌─────────┐    ┌─────────────┐    ┌──────────┐    ┌──────────┐    ┌──────┐    ┌──────┐
│ 1. Plan │───▶│ 2. Implement│───▶│ 3. Verify│───▶│4. Document│───▶│5. Ship│───▶│6. QC │
└─────────┘    └─────────────┘    └──────────┘    └──────────┘    └──────┘    └──────┘
                                   ▲                                           │
                                   └───────────── FAIL? Loop back ◀────────────┘
```

### Gate 1: Plan

- Write a design doc in `docs/plans/YYYY-MM-DD-{feature-slug}.md`
- Brainstorm with user (and optionally Gemini for map/data/3D work)
- Get explicit user approval before proceeding
- Define success criteria and scope boundaries
- Identify frozen files, ownership conflicts, and migration needs

### Gate 2: Implement

- Subagent-driven or parallel execution via Task tool
- TDD where feasible — write tests alongside features
- Frequent commits with descriptive messages
- Respect all agent protocol rules (locks, ownership, frozen files)
- Follow the agent specs in `agents/session-{N}/agent-*.md`

### Gate 3: Verify (NON-NEGOTIABLE)

- [ ] TypeScript build passes: `npm run build` — zero errors
- [ ] No console errors in browser dev tools
- [ ] Visual verification via preview tools (screenshot or snapshot)
- [ ] Gemini audit for map/data/visualization changes (race conditions, NaN guards, normalization)
- [ ] All existing filters, popups, and interactions still work (no regressions)
- [ ] Mobile layout not broken

### Gate 4: Document (NON-NEGOTIABLE)

- [ ] Update `MEMORY.md` with new session summary, architecture changes, data counts
- [ ] Update `agents/STATUS.json` with completion entry
- [ ] Update `agents/MANIFEST.json` if new agents or sessions were added
- [ ] Update design doc with final implementation notes if it diverged from plan
- [ ] Check for stale references: old well counts, removed features, changed color constants, deprecated files
- [ ] Mark any newly deprecated files in MEMORY.md (e.g., "UNUSED — kept for reference")

### Gate 5: Ship (NON-NEGOTIABLE)

- [ ] Deploy frontend to Vercel (automatic via git push, or manual `vercel --prod`)
- [ ] Run Supabase migrations if backend changes: `supabase db push`
- [ ] Deploy edge functions if changed: `supabase functions deploy {name}`
- [ ] Set any new environment variables or secrets
- [ ] **Never ship without passing Gate 3 (Verify)**

### Gate 6: QC (NON-NEGOTIABLE)

Post-deploy verification on the live production URL:

- [ ] Production glow heatmaps render for both formations (CW green, BS amber)
- [ ] Filters work: formation toggle, op status, search
- [ ] Legend displays correct colors and labels
- [ ] Well dots appear at appropriate zoom level (11-13 crossfade)
- [ ] Hover popups show correct data (UWI, operator, formation, rates)
- [ ] Device inventory counts match expected totals
- [ ] Operational status badges display correctly
- [ ] No console errors in production
- [ ] If QC fails, loop back to Gate 3 — do not leave broken code in production

---

## Between Sessions Checklist

Run this checklist every time a session completes, before starting the next one.

```markdown
### Between Sessions: Session {N} → Session {N+1}

- [ ] Clear old lock files: `rm agents/locks/agent-*.lock` (only completed ones)
- [ ] Update `agents/STATUS.json` with completion entry for Session {N}
- [ ] Update `agents/MANIFEST.json` if new agents or sessions were added
- [ ] Run documentation patrol:
      - grep for stale well counts (was 211, now 210; CW/BS counts)
      - grep for removed/renamed components or files
      - grep for old color constants or theme references
      - verify all "UNUSED"/"DEPRECATED" markers are accurate
- [ ] Verify all memory files are current:
      - `MEMORY.md` — main project memory
      - `project_production_glow.md` — production viz details
      - `project_operator_aliases.md` — operator data notes
      - `project_stackdx_workflow.md` — data refresh workflow
- [ ] Confirm no pending proposals in `agents/proposals/`
- [ ] Git commit the cleanup: `git commit -m "chore: session {N} cleanup"`
```

---

## Emergency Procedure

If an agent gets stuck:

1. Read its lock file.
2. Inspect the last owned file it was working on.
3. Complete that work manually from the agent spec.
4. Mark the lock as completed.
5. Update `agents/STATUS.json` and continue.
