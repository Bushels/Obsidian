---
name: docs-maintainer
description: Update WellFi's current-source documentation after a feature, workflow, or architecture change. Use when the user asks to update docs, summarize completed work in the repo docs, align AGENTS/CLAUDE/GEMINI/current-state files, or remove stale plans and obsolete references.
---

# Docs Maintainer

Use this skill when documentation needs to be brought up to date, not just audited.

## Canonical files

- `../../AGENTS.md`
- `../../CLAUDE.md`
- `../../GEMINI.md`
- `../../docs/current-state.md`
- `../../docs/agent-workflows.md`
- `../../docs/monthly-production-refresh.md`
- `../documentation-patrol/SKILL.md`

## Workflow

### 1. Read the current-state docs first

Start with:

- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- `docs/current-state.md`
- the workflow-specific doc touched by the change

### 2. Update current-source docs, not archival notes

Prefer updating:

- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- `docs/current-state.md`
- workflow docs in `docs/`
- task runbooks in `skills/*/SKILL.md`

Do not add a new summary note if an existing current-source doc should be updated instead.

### 3. Sync model entrypoints in the same pass

If the change affects how future agents should operate in the repo:

- update `AGENTS.md` for Codex/OpenAI entry
- update `CLAUDE.md` for Claude entry
- update `GEMINI.md` for Gemini entry
- update `docs/agent-workflows.md` if workflow discovery or ownership changed

Do not update only one model-facing entrypoint and leave the others stale.

### 4. Keep model discovery vendor-neutral

If the workflow matters for future Claude or Gemini sessions:

- document it in `docs/agent-workflows.md`
- make sure the relevant `SKILL.md` is readable without Codex-only context
- add or update `agents/openai.yaml` for Codex/OpenAI discovery when appropriate

Treat `SKILL.md` as the portable runbook. Treat `agents/openai.yaml` as Codex/OpenAI discovery metadata, not the workflow itself.

### 5. Delete stale plans and obsolete references

If an old plan doc or architecture note no longer reflects reality and could mislead future work, delete it instead of leaving it in place.

### 6. Run documentation patrol logic

Before finishing, check for:

- stale file references
- stale commands
- stale architecture descriptions
- duplicate or conflicting workflow explanations
- drift across `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `docs/agent-workflows.md`

## Guardrails

- Be concise. Prefer one accurate current-state section over scattered notes.
- Use exact dates when referencing snapshot or rollout state.
- Do not preserve dead implementation plans just for history if they can mislead future agents.
- Keep documentation aligned with the actual rollout boundary, not the aspirational full rollout.
