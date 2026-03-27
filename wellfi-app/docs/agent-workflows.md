# Agent Workflows

**Purpose:** one concise catalog of the repo workflows that future Codex, Claude, or Gemini sessions should use.

## Project Entrypoints

- **Codex/OpenAI:** start with `AGENTS.md`, then prefer the matching `skills/<name>/agents/openai.yaml` wrapper when one exists.
- **Claude:** start with `CLAUDE.md`, then use this file to find the right `skills/<name>/SKILL.md`.
- **Gemini:** start with `GEMINI.md`, then use this file to find the right `skills/<name>/SKILL.md`.

Treat this file as the discovery index. Treat each `SKILL.md` as the portable runbook.

## Cross-Model Rule

- Keep `AGENTS.md`, `CLAUDE.md`, and `GEMINI.md` aligned when workflow discovery changes.
- `agents/openai.yaml` is Codex/OpenAI discovery metadata only.
- `SKILL.md` must stay readable without Codex-only assumptions so Claude and Gemini can use it directly.

## Current Recommended Workflows

### `docs-maintainer`

Use when a change is complete and the repo docs need to reflect reality.

Responsibilities:

- update current-source docs
- sync `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `docs/current-state.md`
- update any affected workflow docs
- update this workflow index when discovery changes
- delete stale plan docs or obsolete architecture notes
- call `documentation-patrol` logic before finishing

Files:

- `skills/docs-maintainer/SKILL.md`
- `skills/docs-maintainer/agents/openai.yaml`

### `documentation-patrol`

Use when you want a documentation drift audit without necessarily rewriting docs.

Responsibilities:

- stale-reference scan
- workflow command scan
- architecture drift detection

Files:

- `skills/documentation-patrol/SKILL.md`
- `skills/documentation-patrol/agents/openai.yaml`

### `monthly-production-refresh`

Use for the monthly Clearwater / Bluesky CSV workflow.

Responsibilities:

- validate required columns
- rebuild production overlays
- insert new provisioned-operator wells
- sync production state into Supabase for provisioned operators
- backfill missing well names when the source file includes them
- verify snapshot month, production fields, and install-linked cohort safety
- report skipped not-yet-onboarded operators

Files:

- `skills/monthly-production-refresh/SKILL.md`
- `skills/monthly-production-refresh/agents/openai.yaml`

### `operator-onboarding`

Use to provision one operator and prepare/import its wells.

Files:

- `skills/operator-onboarding/SKILL.md`
- `skills/operator-onboarding/agents/openai.yaml`

### `operator-smoke-test`

Use to verify one provisioned operator login after onboarding or release work.

Files:

- `skills/operator-smoke-test/SKILL.md`
- `skills/operator-smoke-test/agents/openai.yaml`

### `wellfi-supabase-rollout`

Use for schema, RLS, and tenant rollout work in Supabase.

Files:

- `skills/wellfi-supabase-rollout/SKILL.md`
- `skills/wellfi-supabase-rollout/agents/openai.yaml`

## Current Source Of Truth

When these disagree, prefer this order:

1. `AGENTS.md`
2. `CLAUDE.md` / `GEMINI.md`
3. `docs/current-state.md`
4. workflow `SKILL.md` files
5. older historical `agents/` session artifacts
