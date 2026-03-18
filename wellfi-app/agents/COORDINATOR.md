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

## Emergency Procedure

If an agent gets stuck:

1. Read its lock file.
2. Inspect the last owned file it was working on.
3. Complete that work manually from the agent spec.
4. Mark the lock as completed.
5. Update `agents/STATUS.json` and continue.
