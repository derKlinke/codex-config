# AGENTS.MD

My name is Fabian S. Klinke. Start: say hi + 1 motivating line.
Work style: telegraph; noun-phrases ok; drop grammar; min tokens.

## Agent Protocol

- PRs: use `gh pr view/diff` (no URLs).
- “Make a note” => edit AGENTS.md (shortcut; not a blocker). Ignore `CLAUDE.md`.
- Need upstream file: stage in `/tmp/`, then cherry-pick; never overwrite tracked.
- Bugs: add regression test when it fits.
- Keep files <~500 LOC; split/refactor as needed.
- Commits: Conventional Commits (`feat|fix|refactor|build|ci|chore|docs|style|perf|test`).
- Editor: `code <path>`.
- CI: `gh run list/view` (rerun/fix til green).
- Prefer end-to-end verify; if blocked, say what’s missing.
- New deps: quick health check (recent releases/commits, adoption).
- Slash cmds: `~/.codex/prompts/`.
- Web: search early; quote exact errors; prefer 2024–2026 sources; fallback Firecrawl (`pnpm mcp:*`) / `mcporter`.
- Style: telegraph. Drop filler/grammar. Min tokens (global AGENTS + replies).

## Flow & Runtime

- Use repo’s package manager/runtime; no swaps w/o approval.
- New iOS projects: use Tuist.
- Use Codex background for long jobs; tmux only for interactive/persistent (debugger/server).

## Build / Test

- Before handoff: run full gate (lint/typecheck/tests/docs).
- Every repo exposes core commands (build, test, generate, format) via justfile.
- CI red: `gh run list/view`, rerun, fix, push, repeat til green.
- When working on webprojects, use agent-browser for inspecting UI, network, console logs.
- Always use bun as runtime for JavaScript/TypeScript projects unless repo specifies otherwise.

## Git

- Safe by default: `git status/diff/log`. Push only when user asks.
- `git checkout` ok for PR review / explicit request.
- Branch changes require user consent.
- Destructive ops forbidden unless explicit (`reset --hard`, `clean`, `restore`, `rm`, …).
- Remotes under `~/Developer`: prefer HTTPS; flip SSH->HTTPS before pull/push.
- Don’t delete/rename unexpected stuff; stop + ask.
- No repo-wide S/R scripts; keep edits small/reviewable.
- Avoid manual `git stash`; if Git auto-stashes during pull/rebase, that’s fine (hint, not hard guardrail).
- If user types a command (“pull and push”), that’s consent for that command.
- No amend unless asked.
- Big review: `git --no-pager diff --color=never`.
- Multi-agent: check `git status/diff` before edits; ship small commits.

## Critical Thinking

- Fix root cause (not band-aid).
- Unsure: read more code; if still stuck, ask w/ short options.
- Conflicts: call out; pick safer path.
- Unrecognized changes: assume other agent; keep going; focus your changes. If it causes issues, stop + ask user.
- Leave breadcrumb notes in thread.

## Frontend Aesthetics

Avoid “AI slop” UI. Be opinionated + distinctive.

Do:

- Typography: use system fonts or Helvetica Neue; only use other fonts with strong purpose.
- Theme: commit to a palette; use CSS vars; bold accents > timid gradients.
- Motion: 1–2 high-impact moments (staggered reveal beats random micro-anim).
- Native: use platform native components/styles where possible, only customize purposefully.
- Focus on clarity, hierarchy, whitespace.
- Use emotional design principles.

Avoid: purple-on-white clichés, generic component grids, predictable layouts. Avoid gradients and shadows unless purposeful.
