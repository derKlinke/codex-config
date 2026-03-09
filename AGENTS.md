# AGENTS.md
- Name: Fabian S. Klinke
- Background: M.Sc. Audio Technology; iOS/macOS dev
- Response style: precise, scientific terminology, minimal tokens; telegraph/noun-phrase OK

## Core Protocol
- "Make a note" => edit `AGENTS.md`; ignore `CLAUDE.md`.
- Language policy: always communicate in English with each other.
- Keep `AGENTS.md` current when constraints/architecture change.
- Conventional Commit types only: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`.
- Commit split trigger: if commit message needs `and`, list syntax, or >1 scope, split into separate commits.
- Keep files `<~500 LOC`; split/refactor early.
- Comments: concise why-comments; avoid what-comments.
- New deps: check release cadence, recent commits, adoption.
- Research early; quote exact errors; prefer recent sources.
- No legacy fallbacks/old patterns unless explicitly requested.
- Hard-cut product policy for local state evolution:
  - optimize for one canonical current-state implementation, not historical local states.
  - do not add compatibility bridges, migration shims, fallback paths, compact adapters, or dual behavior for old local states unless explicitly requested.
  - prefer one canonical codepath, fail-fast diagnostics, and explicit recovery steps over automatic migration, compatibility glue, silent fallbacks, or "temporary" second paths.
  - if temporary compatibility code is truly required, same diff must state: why needed, why canonical path is insufficient, exact deletion criteria, and ADR/task tracking removal.
  - default stance: delete old-state compatibility code instead of carrying it forward.
- Less code is better: prefer deletion, consolidation, and simpler control flow over additive "safety" code.
- Prefer clean/readable code over weak historical patterns.
- Never remove functionality without explicit consent.
- Enforce DRY; flag repetition.
- Testing mandatory; bias toward more tests.
- Keep implementations robust; avoid hacks/premature abstraction.
- Prefer explicit code over clever code.
- Simplicity first: minimal safe diff.
- Do not add fallback chains, duplicate guard rails, or error checks for highly controlled/impossible states without concrete evidence they are needed.
- After implementation, simplify aggressively: use `code-simplifier` when needed; refactor until code lives in the right layer/module and follows KISS, DRY, and clean-code principles.
- Root-cause fixes only; no symptom masking.

## Working Conventions
- Prioritize root-cause remediation.
- If uncertain: read more code, then ask short option set.
- On constraint conflict: state tradeoff, choose safer path.
- Treat unrelated local edits as parallel work unless blocking.
- Ignore unrelated changes made by other agents; do not pause work for them unless they block the active task.
- Build-lock policy: never run concurrent builds/tests for the same app/workspace to bypass locks.
- On Xcode/Tuist build lock contention: wait, then rerun the same command; do not shard DerivedData via custom temp paths/env vars.
- Always fix encountered compiler and test failures before handoff; no "known failing" state in completion reports.
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
- Core tools: `gh`, `bun`, `tuist` (prefer `just`), `prek`, `trash`, `actionlint`.
- Sentry investigation path: MCP tools only; do not use legacy local scripts or `SENTRY_AUTH_TOKEN`-driven helpers for issue/event inspection.
- Prefer repo `justfile` for build/test/generate/format.
- Bootstrap hooks/formatter: `npx @derklinke/miedinger --force`.
- CI loop: inspect via `gh run list` / `gh run view`; fix/push until green.
- GitHub Actions workflow verification: run `actionlint` on touched workflow files before handoff/commit.

## Skill Routing
- Review runtime skill list first.
- If task matches a listed skill, use it.
- Skill naming conventions (grouping-first):
  - `review-*` for non-security code review/audit/quality-gate flows (examples: bug-finding, review intake/response, pre-handoff verification).
  - `plan-*` for planning/execution methodology flows (examples: plan authoring, execution from plan, engineering pre-implementation review, TDD workflow).
  - `git-*` for git-centric workflows (examples: branch maintenance, commit/push/PR handoff).
  - `infra-*` for infrastructure/platform delivery workflows (examples: Vercel/Cloudflare/AWS setup and deploy).
- SwiftUI routing: use `ios-swiftui-pro` as canonical entry point; treat retired overlapping `ios-swiftui-*` skills as removed.
- After non-trivial code changes, deliberately invoke `code-simplifier` before final verification/handoff unless the diff is already trivially minimal.
- Any UI/design task: invoke `design` first, then `design-audit`, then the most relevant specialized design skill(s).
- Design tasks: always include `design-audit` + relevant design/domain skill.
- For design feedback, critique, or sign-off review requests, default to `design-audit`.
- Interaction/motion/gesture tasks: always include `design-interaction-motion-craft`.
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
- Prevention rule: when refactoring/simplifying, default target is fewer lines and fewer branches; if code grows, justify why the added complexity is strictly necessary.
- Prevention rule: when consolidating overlapping skills, delete redundant skill entrypoints; do not ship alias/compatibility wrappers unless explicitly requested.
- Prevention rule: when a URL contains an anchor fragment, treat it as potentially accidental and confirm scope by reading the full source unless the user explicitly requests section-only extraction.
- Prevention rule: when proposing naming-group conventions, preserve domain boundaries (e.g., security stays `security-*`, never absorbed into generic `review-*`).
- Prevention rule: when creating infrastructure skills, default to `infra-*` naming scope; avoid unscoped skill names for infra domains.
- Do not claim completion without proof (tests/logs/diff/evidence).
- For non-trivial work: run `code-simplifier` / elegance pass; re-implement if solution is hacky.
- Completion gate: verification includes code-shape review, not just test/build success; simplify and relocate code before handoff if structure is wrong.
- For bug reports: fix directly from evidence; minimize user context switching.
- For CI failures: inspect logs, fix root cause, re-run until green.
