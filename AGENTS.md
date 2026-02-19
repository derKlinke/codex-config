# AGENTS.MD
- Name: Fabian S. Klinke
- Background: M.Sc. Audio Technology + iOS/macOS dev
- Response style: precise, scientific terminology, minimal tokens, telegraph/noun-phrase acceptable

## Core Protocol

- "Make a note" means edit `AGENTS.md`; ignore `CLAUDE.md`.
- Keep `AGENTS.md` current when constraints or architecture change.
- Commits use Conventional Commits: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`.
- Keep files `<~500 LOC`; split/refactor when needed.
- Comments: concise why-comments; avoid what-comments.
- New dependencies: quick health check (release cadence, recent commits, adoption).
- Web research: search early, quote exact errors, prefer recent sources.
- Do not keep legacy fallbacks or old patterns alive unless explicitly requested.
- Prioritize clean code and readability over preserving existing weak patterns.
- Never remove functionality without explicit user consent.
- Flag repetition aggressively and keep implementations DRY.
- Well-tested code is non-negotiable; prefer too much testing over too little.
- Keep solutions "engineered enough": avoid both fragile hacks and premature abstraction.
- Bias toward explicit code over clever code.

## Working Conventions

- Prioritize root-cause fixes; avoid band-aids.
- If uncertain: read more code, then ask short options.
- If constraints conflict: state tradeoff, choose safer path.
- Treat unrelated local edits as parallel work unless blocking.
- Avoid destructive ops unless explicitly requested.
- Branch changes require user consent.
- Before push: `git pull --rebase`.

## Design Protocol

- Content-first minimalism by default
- Use whitespace/typography as primary hierarchy
- Avoid decorative containers/effects unless functionally justified
- Restrained palette/motion; usually one primary accent
- Keep layout grid/alignment consistent and predictable
- Before design work, review existing design docs and ensure alignment.
- For UI/design work, keep `DESIGN.md` as current-state spec.
- Before UI/design work: read `DESIGN.md`.
- Update `DESIGN.md` when durable system-level design rules change.
- Keep `DESIGN.md` principle-led; avoid feature-by-feature logs.

## Documentation System

- Keep docs focused: architecture, behavior, interfaces/contracts, operations, troubleshooting.
- Use existing repo layout unless a new docs area is required.
- Avoid placeholder docs and duplicate scaffolding.
- If behavior/interfaces/architecture/operations/constraints change, update docs in the same task.
- Completion gate: docs touched or explicit no-doc-impact statement.
- If you touch an area with no existing docs, create docs for it.

## Runtime + Tools

- Core tools: `gh`, `bun`, `tuist` (prefer `just` when available), `prek`, `trash`.

## Build + Test

- Prefer repo `justfile` commands for build/test/generate/format.
- Bootstrap formatter/hooks: `npx @derklinke/miedinger --force`.
- CI checks: inspect with `gh run list` / `gh run view`; fix and push until green.

## Skill Routing

- Review runtime skill list first.
- If task matches a listed skill, use it.
- If none match, state `no relevant skill found` and use best general workflow.

## Skill Memory System

- Treat `~/.codex/skills` as working memory for repeatable engineering patterns.
- For non-trivial tasks, load at least two relevant skills (for example domain + verification/review).
- If two or more skills are frequently used together, add bidirectional cross-references in their `SKILL.md` files in the same task.
- When debugging/research uncovers a reusable pattern, create a new skill or update an existing one immediately so the pattern is retained.
- Prefer skill docs written for Codex execution context (local tools/workflows), not external agent-command ecosystems.
- Prune stale/duplicate skills aggressively; merge overlaps and remove skills that no longer improve decision quality.
- Keep skills concise, operational, and action-first.
