# AGENTS.MD
Name: Fabian S. Klinke. Background: M.Sc. Audio Technology + iOS/macOS dev.
Response style: precise, scientific terminology, minimal tokens, telegraph/noun-phrase acceptable.

## Core Protocol
- PR review: `gh pr view` / `gh pr diff` (no URLs).
- "Make a note" => edit `AGENTS.md`. Ignore `CLAUDE.md`.
- `AGENTS.md` is living memory; update it when constraints or repo facts change.
- Commits use Conventional Commits (`feat|fix|refactor|build|ci|chore|docs|style|perf|test`).
- Keep files `<~500 LOC`; split/refactor when needed.
- Comments: concise why-comments, avoid what-comments.
- New dependencies: quick health check (release cadence, recent commits, adoption).
- Web research: search early; quote exact errors; prefer 2024-2026 sources.

## Memory + Notes
- Hierarchy:
- `~/.codex/AGENTS.md` (global protocol)
- `~/.codex/memory.md` (cross-project durable ledger)
- Project `AGENTS.md` + local memory notes
- For note edits outside `klinke.studio`, read `/Users/fabianklinke/Developer/klinke/klinke.studio/AGENTS.md`.

## Design Protocol
- For UI/design work, keep `DESIGN.md` as current-state spec.
- Before UI/design work: read `DESIGN.md`.
- Update `DESIGN.md` whenever tokens/components/interaction patterns change.
- `DESIGN.md` must explicitly document the current design vibe (visual tone, interaction feel, aesthetic constraints) and be updated whenever that vibe changes.
- Do not keep changelogs/decision histories inside `DESIGN.md`.

## Claude Code Design Delegation
- Small design tasks: implement directly in Codex.
- Larger design tasks: launch Claude Code CLI by default.
- Claude context package must include:
  - Global `~/.codex/AGENTS.md`
  - Local/project `AGENTS.md`
  - Relevant `DESIGN.md` design spec files
  - Target feature/component files and constraints
- Claude prompt requirement: improve design quality while preserving existing design guidelines and product vibe.
- Post-Claude gate (mandatory): review generated code in Codex, fix potential bugs/issues, and refactor non-optimal implementations to repo standards.
- Example launch:
  - `cd /Users/fabianklinke/.codex && claude -p "Use ~/.codex/AGENTS.md, this repo's AGENTS.md, and relevant DESIGN.md files. Improve the design while preserving current visual language and product constraints."`

## Frontend Aesthetics
- Native-first: iOS/macOS follow HIG/material constraints; avoid generic, web-style chrome.
- Default to content-first minimalism; reduce visual novelty unless it improves task clarity.
- Use whitespace and typography as primary hierarchy; avoid decorative containers and ornamental effects.
- Avoid unnecessary boxes, borders, shadows, and gradients unless they carry functional meaning.
- Use restrained palette and restrained motion; one primary accent is usually enough.
- Keep layout grid/alignment consistent and predictable for readability and motor predictability.

## Documentation System
- Purpose: project-specific memory + operator how-to for how the system works.
- No mandatory docs folder hierarchy.
- Use existing repo layout; introduce new structure only if a new documentation area is needed.
- Avoid placeholder docs: no empty folders, duplicate README scaffolding, or unused index pages.
- Keep documentation focused on:
  - Architecture and system behavior (scope, boundaries, data/control flow, invariants)
  - Feature behavior and requirements (acceptance criteria, edge cases, failure modes)
  - Interfaces/contracts (APIs, schemas, config/env, migrations/versioning)
  - Operations/runbooks (setup, build/test/run flow, recovery)
  - Design/reference contracts (when behavior depends on them)
  - High-impact decision notes (architecture/system choices)
  - Incident/troubleshooting notes (diagnostics, remediation, rollback)
- Change policy: if behavior, interfaces, architecture, operations, or constraints change, update relevant docs in the same task.
- Completion gate: verify docs touched or explicitly justify no-doc-impact.

## Runtime + Tools
- Use repo runtime/package manager (`bun` for JS/TS by default unless overridden).
- Core tools:
- `gh`: PRs/issues/actions.
- `bun`: runtime + PM.
- `tuist`: Xcode project tooling (prefer `just` if available).
- `prek`: pre-commit hooks.
- `trash`: safe delete to system Trash.

## Build + Test
- Prefer repo `justfile` commands for build/test/generate/format.
- Bootstrap formatter/hooks with: `npx @derklinke/miedinger --force`.
- CI checks: inspect with `gh run list/view`, fix and push until green.

## Git Policy
- Branch changes require user consent.
- Avoid destructive ops unless explicitly requested.
- Before push: `git pull --rebase`.
- If user explicitly says command (e.g. "pull and push"), treat as consent.
- Ignore automation runtime logs: `automations/**/memory.md` untracked.
- If unexpected file movement/deletion appears: stop + ask.

## Critical Thinking
- Prioritize root-cause fixes, not band-aids.
- If uncertain: read more code; then ask short options.
- If constraints conflict: call out tradeoff and pick a safer path.
- Treat unrelated local edits as parallel work unless they break this task.
- Leave breadcrumb notes in-thread.

## Skill Routing
- First review the runtime skill list.
- If a task matches a listed skill, use it.
- If none match, state `no relevant skill found` and use best general workflow.
- Frequent picks:
  - `notes-knowledge-graph`
  - `design-system-doc`

## Workflow Extras
- Need upstream file: stage in `/tmp/`, then cherry-pick; never overwrite tracked.
- Keep debugging evidence-based: reproduce, fix, and verify.
