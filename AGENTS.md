# AGENTS.md
- Name: Fabian S. Klinke
- Background: M.Sc. Audio Technology; iOS/macOS dev
- Response style: precise, scientific terminology, minimal tokens; telegraph/noun-phrase OK

## Core Protocol
- "Make a note" => edit `AGENTS.md`; ignore `CLAUDE.md`.
- Keep `AGENTS.md` current when constraints/architecture change.
- Conventional Commit types only: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`.
- Keep files `<~500 LOC`; split/refactor early.
- Comments: concise why-comments; avoid what-comments.
- New deps: check release cadence, recent commits, adoption.
- Research early; quote exact errors; prefer recent sources.
- No legacy fallbacks/old patterns unless explicitly requested.
- Prefer clean/readable code over weak historical patterns.
- Never remove functionality without explicit consent.
- Enforce DRY; flag repetition.
- Testing mandatory; bias toward more tests.
- Keep implementations robust; avoid hacks/premature abstraction.
- Prefer explicit code over clever code.
- Simplicity first: minimal safe diff.
- Root-cause fixes only; no symptom masking.

## Working Conventions
- Prioritize root-cause remediation.
- If uncertain: read more code, then ask short option set.
- On constraint conflict: state tradeoff, choose safer path.
- Treat unrelated local edits as parallel work unless blocking.
- Avoid destructive ops unless explicitly requested.
- Branch changes require user consent.
- Before push: `git pull --rebase`.

## Design Protocol
- Default: content-first minimalism.
- Use whitespace/typography as primary hierarchy.
- Avoid decorative containers/effects unless functionally justified.
- Restrained palette/motion; usually one accent.
- Keep grid/alignment consistent.
- Before UI/design work: read `DESIGN.md`.
- Keep `DESIGN.md` as current-state design spec.
- Update `DESIGN.md` only for durable system-level rules.

## Documentation System
- Docs scope: architecture, behavior, interfaces/contracts, operations, troubleshooting.
- Reuse existing docs layout; avoid placeholder/duplicate docs.
- If behavior/interface/architecture/ops/constraints change, update docs in same task.
- Completion gate: docs updated, or explicit no-doc-impact statement.
- If touched area has no docs, create them.

## Runtime + Build + CI
- Core tools: `gh`, `bun`, `tuist` (prefer `just`), `prek`, `trash`.
- Prefer repo `justfile` for build/test/generate/format.
- Bootstrap hooks/formatter: `npx @derklinke/miedinger --force`.
- CI loop: inspect via `gh run list` / `gh run view`; fix/push until green.

## Skill Routing
- Review runtime skill list first.
- If task matches a listed skill, use it.
- Design tasks: always include `design-quality-gates` + relevant design/domain skill.
- Interaction/motion/gesture tasks: always include `interaction-motion-craft`.
- If no skill matches: state `no relevant skill found`, use best general workflow.

## Skill Memory System
- Treat `~/.codex/skills` as working memory for repeatable patterns.
- Non-trivial tasks: load at least two relevant skills.
- If skills are frequently paired, add bidirectional cross-references in both `SKILL.md` files.
- Convert reusable debugging/research patterns into new/updated skills immediately.
- Prefer skill docs optimized for Codex local execution context.
- Prune stale/duplicate skills aggressively.

## Token Efficiency
- Never re-read files you just edited.
- Never re-run commands unless outcome is uncertain.
- Avoid echoing large code/file blocks unless asked.
- Batch edits; avoid fragmented micro-edits.
- Skip status filler.
- Prefer one well-planned tool call over many.
- Do not summarize obvious completed actions.

## Execution Doctrine
- Use focused subagents aggressively for independent research/execution.
- After user correction: update `./AGENTS.md` with prevention rule.
- Do not claim completion without proof (tests/logs/diff/evidence).
- For non-trivial work: run an elegance pass; re-implement if solution is hacky.
- For bug reports: fix directly from evidence; minimize user context switching.
- For CI failures: inspect logs, fix root cause, re-run until green.
