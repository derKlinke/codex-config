# AGENTS.MD
Name: Fabian S. Klinke. Background: M.Sc. Audio Technology + iOS/macOS dev.
Response style: precise, scientific terminology, minimal tokens, telegraph/noun-phrase acceptable.

## Core Protocol
- PR review: `gh pr view` / `gh pr diff` (no URLs).
- "Make a note" => edit `AGENTS.md`. Ignore `CLAUDE.md`.
- `AGENTS.md` = living memory; update when constraints/repo facts change.
- Commits: Conventional Commits (`feat|fix|refactor|build|ci|chore|docs|style|perf|test`).
- Keep files `<~500 LOC`; split/refactor when needed.
- Comments: concise why-comments allowed (DSP/RT/concurrency/math); avoid what-comments.
- New dependencies: quick health check (release cadence, recent commits, adoption).
- Web research: search early; quote exact errors; prefer 2024-2026 sources.

## Memory + Notes
- Hierarchy:
- `~/.codex/AGENTS.md` = global protocol.
- `~/.codex/memory.md` = cross-project durable ledger.
- Project memory = project `AGENTS.md` + local memory markdowns.
- Long-term notes default: `/Users/fabianklinke/Developer/klinke/klinke.studio/content/notes`.
- If repo has root `NOTES.md`: treat as note index; refresh via repo generator before major maintenance.
- Notes workflow source of truth: `/Users/fabianklinke/.codex/skills/notes-knowledge-graph/SKILL.md`.
- For note edits outside `klinke.studio`, still read `/Users/fabianklinke/Developer/klinke/klinke.studio/AGENTS.md`.

## Design Protocol
- Every UI/design repo should have root `DESIGN.md` (platform-agnostic; web + iOS/macOS).
- Before UI/design implementation/review: read `DESIGN.md`.
- If design decisions/tokens/components change: update `DESIGN.md` in same task.
- If missing and UI work exists: create from `design-system-doc` skill template.

## Subagent Orchestration
- Default for non-trivial work: use subagents (lanes: `dev`, `test`, `research`, `review`).
- Strong default: delegate research/code exploration before implementation.
- Parent owns decomposition, acceptance criteria, integration, final verification.
- Child prompt must include: file ownership, done condition, test command, output artifact.
- Loop: `plan -> assign -> execute -> verify -> review -> reassign`.
- Evidence gate: repro (if bug) -> failing test -> fix -> passing test -> reviewer findings cleared.
- Completion gate: 2 fresh-eye review agents; fix all findings; rerun 2-agent review until clean.
- Merge safety: single writer per file per loop.
- Depth bound: `d_max=2` (raise to 3 only for large refactor/research spikes).
- Escalation flag `--dangerously-bypass-approvals-and-sandbox`: only in externally sandboxed envs.

## Runtime + Tools
- Use repo runtime/package manager; no swaps without approval. JS/TS default: `bun`.
- New iOS projects: Tuist.
- Long jobs: Codex background; tmux only for interactive/persistent debugger/server.
- Core tools:
- `gh`: PRs/issues/actions.
- `bun`: runtime + PM.
- `tuist`: Xcode project tooling (prefer `just` if available).
- `xcodebuildmcp`: default Apple simulator build/test/run/log/UI automation.
- Canonical flow: `discover_projs -> list_schemes -> list_sims -> session_set_defaults -> build_sim/test_sim/build_run_sim`.
- Debug/UI: `start_sim_log_cap` + `stop_sim_log_cap`; `snapshot_ui`; `screenshot`.
- `prek`: pre-commit hooks.
- `trash`: safe delete to system Trash.

## Build + Test
- Bootstrap formatter/hooks: `npx @derklinke/miedinger --force`.
- Prefer repo `justfile` commands for build/test/generate/format.
- Apple targets: prefer `xcodebuildmcp` over raw `xcodebuild` for simulator workflows.
- CI red: inspect via `gh run list/view`, rerun/fix/push until green.
- Web projects: use `agent-browser` for UI/network/console inspection.

## Git Policy
- Branch changes require user consent.
- Destructive ops forbidden unless explicit (`reset --hard`, `clean`, `restore`, `rm`, ...).
- Remotes under `~/Developer`: prefer HTTPS; migrate SSH->HTTPS before pull/push.
- Before push: `git pull --rebase`.
- If user explicitly says command (e.g. "pull and push"), treat as consent.
- Ignore automation runtime logs: `automations/**/memory.md` untracked.
- If unexpected file movement/deletion appears: stop + ask.

## Critical Thinking
- Root cause fixes, not band-aids.
- If uncertain: read more code; if still blocked, ask short options.
- If constraints conflict: call out conflict; choose safer path.
- Unrecognized/unrelated local changes: assume parallel agent/user edits; focus own scope unless breakage.
- Leave breadcrumb notes in thread.

## Frontend Aesthetics
- Avoid generic/"AI slop" UI.
- Typography: system fonts / Helvetica Neue unless strong reason.
- Theme: committed palette + CSS vars; bold accents over timid gradients.
- Motion: 1-2 meaningful moments; avoid noisy micro-motion.
- Native platforms: prefer native components/styles; customize with purpose.
- Priorities: clarity, hierarchy, whitespace, emotional design.
- Avoid: purple-on-white clichés, generic grids, predictable layouts, gratuitous gradients/shadows.

## Skill Routing (Compressed)
- Do not duplicate a full skill catalog in this file.
- For each task: first take quick overview of runtime "Available skills" list.
- Source of truth for details: each skill `SKILL.md`.
- Default policy: always pick and apply relevant skill(s) when available.
- Trigger rule: if user names a skill or task clearly matches, use that skill (not optional).
- If multiple match: choose minimal relevant set and apply in explicit order.
- If none match: state "no relevant skill found", then proceed with best general workflow.
- Frequent picks:
- `notes-knowledge-graph`: note authoring/maintenance.
- `design-system-doc`: create/update `DESIGN.md`.
- `agent-browser`: web UI/network/console checks.
- `linear`: Linear workflow updates (set issue to In Progress at start).
- `gh-fix-ci`: GitHub Actions triage/fix.

## Workflow Extras
- Linear issues: set status to In Progress at start.
- Need upstream file: stage in `/tmp/`, then cherry-pick; never overwrite tracked.
- Bug report protocol: write failing repro test first; then fix; prove with passing test.
- Slash command location: `~/.codex/prompts/`.
