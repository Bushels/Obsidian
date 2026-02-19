# WellFi App — Claude Code Project Rules

## Project Overview
Real-time well monitoring app for Obsidian Energy. 211 Clearwater/Bluesky wells.
Engineers track pump life, flag upcoming changes, and register WellFi device installations.

**Stack:** React + Vite + TypeScript + TailwindCSS + Mapbox GL JS + Supabase + Vercel

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
After Session 1 completes, these files are FROZEN — no agent can modify them:
- `src/types.ts`
- `src/lib/supabase.ts`

If you discover you need a change to a frozen file, create a proposal:
```
agents/proposals/{your-agent-id}-change-{filename}.md
```
The coordinator will review and apply it before the next session.

### Rule 5: Check the Session Gate
Before starting, read `agents/STATUS.json`. Your session's `gate` field lists which sessions
must be `completed` before you can begin. If the gate is not satisfied, stop and report to coordinator.

### Rule 6: Signal Completion
When your work is done:
1. Update your lock file status to `"completed"`
2. List every file you created or modified in `"files_written"`
3. Write a brief summary to `agents/proposals/{your-agent-id}-completion.md`

### Rule 7: Never Duplicate Shared Code
- Import from `src/types.ts` — never redefine types
- Import from `src/lib/supabase.ts` — never create a second Supabase client
- Import from `src/lib/mapUtils.ts` — never rewrite color expressions

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
- Colors from `tailwind.config.ts` token system — never hardcode hex in JSX

### Components
- One component per file
- Props interface defined at top of file
- Loading state and error state required for any data-fetching component
- All forms use react-hook-form

### Supabase
- All queries via typed client from `src/lib/supabase.ts`
- Real-time subscriptions cleaned up in `useEffect` return
- Row-level security enabled on all tables

---

## Directory — What Lives Where

```
src/
  types.ts              ← FROZEN after Session 1. Source of truth for all types.
  lib/
    supabase.ts         ← FROZEN after Session 1. Single client instance.
    mapUtils.ts         ← Owned by agent-map. Read-only for others.
  hooks/                ← Owned by agent-hooks
  components/
    map/                ← Owned by agent-map
    panels/             ← Owned by agent-wellfi
    forms/              ← Split: pump change forms (agent-pump-change), wellfi forms (agent-wellfi)
    ui/                 ← shadcn components, installed by agent-scaffold
  pages/                ← Owned by agent-scaffold initially, panels added by feature agents
supabase/
  migrations/           ← Owned by agent-db
  seed.py               ← Owned by agent-db
  functions/            ← Owned by agent-notifications
agents/                 ← Coordination files, not shipped to production
```
