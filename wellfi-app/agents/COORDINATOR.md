# WellFi Swarm Coordinator Instructions

This file is the playbook for the **coordinator Claude Code session** — the top-level agent that reads the plan, spawns sub-agents, monitors progress, and gates each session.

---

## Before Starting Each Session

1. Read `agents/STATUS.json`
2. Confirm the gate sessions are `"completed"` (see MANIFEST.json for gates)
3. Check `agents/locks/` — remove any stale `.lock` files from crashed previous runs
4. Check `agents/proposals/` — apply any pending proposals before the next session

---

## How to Spawn Agents in Claude Code

Each session spawns two agents **in parallel** using the Task tool:

```
Session 1:  Task(agents/session-1/agent-db.md)
            Task(agents/session-1/agent-scaffold.md)

Session 2:  Task(agents/session-2/agent-map.md)     [gate: session 1 complete]
            Task(agents/session-2/agent-hooks.md)

Session 3:  Task(agents/session-3/agent-pump-change.md)  [gate: sessions 1+2]
            Task(agents/session-3/agent-wellfi.md)

Session 4:  Task(agents/session-4/agent-notifications.md)  [gate: sessions 1+2+3]
            Task(agents/session-4/agent-polish.md)
```

When using the Task tool, pass the **full content** of the agent's `.md` file as the prompt.

---

## Between Sessions: Coordinator Checklist

After each session completes:

### ☐ Verify Completion
- Read both agents' lock files — both should show `"completed"`
- Read both completion reports in `agents/proposals/`
- Verify the files listed were actually created (`ls` check)

### ☐ Apply Proposals (Session 4 especially)
- Read each `agents/proposals/polish-*.md`
- Apply the changes to the target files manually or by spawning a fix agent
- Test in browser after applying

### ☐ Update STATUS.json
- Mark both agents and the session as `"completed"`
- Add any new frozen files to the `frozen_files` array
- Set the next session's status from `"locked"` to `"pending"`

### ☐ Clear Old Locks
```bash
rm agents/locks/agent-*.lock  # Only completed ones
```

### ☐ Git Commit
```bash
git add .
git commit -m "feat: session N complete — [description]"
```

---

## Conflict Resolution Protocol

If two agents report they need to modify the same file:

1. **Check precedence** — lower number wins (1 beats 2)
2. **If same precedence** (shouldn't happen) — escalate to coordinator
3. **For frozen files** — read the proposals from both agents, merge manually, apply once

If an agent writes a file it doesn't own:
1. Read both versions
2. Keep the version from the file's true owner
3. Check if the unauthorized version has useful code — extract and give to the right agent

---

## Status Transitions

```
Session status flow:
  "locked" → "pending" (coordinator unlocks when gate is met)
  "pending" → "in_progress" (coordinator spawns agents)
  "in_progress" → "completed" (both agents complete)

Agent status flow:
  "pending" → "in_progress" (agent writes its lock file)
  "in_progress" → "completed" (agent updates lock file)
```

---

## Deployment Checklist (After Session 4)

### Supabase
- [ ] Run migrations: `supabase db push`
- [ ] Run seed: `python supabase/seed.py`
- [ ] Deploy edge function: `supabase functions deploy notify-pump-change`
- [ ] Set secrets (from agent-notifications completion report)
- [ ] Register database webhook in Supabase Dashboard

### Vercel
- [ ] Connect GitHub repo to Vercel
- [ ] Set env vars: `VITE_MAPBOX_TOKEN`, `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`
- [ ] Deploy: `vercel --prod`

### Verification
- [ ] Open app — confirm 211 well dots on Alberta satellite map
- [ ] Open two tabs — flag a pump change in tab 1 — confirm tab 2 updates within 2 seconds
- [ ] Install a WellFi on a test well — confirm cyan halo appears
- [ ] Test on mobile — confirm filter panel, popups, and forms work on touch

---

## Emergency Procedures

### Agent Stuck / Unresponsive
1. Read its lock file — is status still `"active"`?
2. Check what it was working on (last file in `"owns"`)
3. Manually complete that file using the agent's `.md` spec
4. Update lock to `"completed"`, update STATUS.json
5. Proceed

### Frozen File Needs Change
1. Do NOT modify the frozen file directly during an agent session
2. After the session, apply the change yourself
3. Update the file in the frozen_files list if it needs to stay frozen
4. Or remove it from frozen_files if it's now open for modification
