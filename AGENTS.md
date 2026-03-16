# AGENTS.md
- Name: Fabian S. Klinke
- Background: M.Sc. Audio Technology; iOS/macOS dev
- Response style: precise, scientific terminology, minimal tokens; telegraph/noun-phrase OK

## Core Protocol
- "Make a note" => edit `AGENTS.md`; ignore `CLAUDE.md`.
- Agent-to-agent language: English only.
- Keep `AGENTS.md` current when constraints, architecture, or durable workflow rules change.
- Conventional Commit types only: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`.
- Split commits when a message needs `and`, list syntax, or >1 scope.
- Keep files `<~500 LOC`; split/refactor early.
- Comments: concise why-comments; avoid what-comments.
- New deps: verify release cadence, recent commits, adoption.
- Research early; quote exact errors; prefer recent sources.
- No legacy fallbacks, old patterns, compatibility bridges, migration shims, compact adapters, or dual behavior unless explicitly requested.
- Local state policy: one canonical current-state path; fail fast; explicit recovery over automatic migration/glue.
- If temporary compatibility code is unavoidable, same diff must state why canonical path fails, deletion criteria, and ADR/task tracking for removal.
- Less code preferred: delete, consolidate, simplify control flow.
- Prefer clean/readable code over inherited weak patterns.
- Never remove functionality without explicit consent.
- Enforce DRY; eliminate repetition in touched scope.
- Testing mandatory for bug fixes and important behavior; prefer meaningful coverage over blanket TDD.
- Robust implementations only; no hacks or premature abstraction.
- Prefer explicit code over clever code.
- Simplicity first: minimal safe diff.
- Do not add fallback chains, duplicate guard rails, or impossible-state checks without evidence.
- Root-cause remediation only; no symptom masking.

## Working Conventions
- On touched code, treat obvious standards violations as in-scope: verbosity, weak readability, DRY breaks, wrong-layer logic, needless fallbacks, unnecessary error handling.
- Fix adjacent obvious issues when cheap and low-risk; avoid scope creep.
- If uncertain: read more code, then ask a short option set.
- On constraint conflict: state tradeoff; choose safer path.
- Treat unrelated local edits as parallel work unless blocking.
- Ignore unrelated changes from other agents unless blocking.
- Shared-worktree protocol: claim explicit file/module ownership before mutation; keep write sets disjoint; if scope shifts into another agent's active files, stop mutating and re-scope locally instead of editing through the overlap.
- Shared-worktree protocol: never delete, move, rename, or wholesale rewrite files outside current owned scope; for touched files with concurrent edits, prefer additive patches that preserve surrounding code.
- Shared-worktree protocol: if a referenced file disappears unexpectedly and removal intent is not explicit, restore the last known working tree or HEAD version immediately, then continue; ask only if multiple plausible replacements exist.
- Avoid destructive ops unless explicitly requested.
- Branch changes require user consent.

## Design + Docs
- Default design: content-first minimalism.
- Use whitespace/typography as primary hierarchy.
- Avoid decorative containers/effects unless functionally justified.
- Restrained palette/motion; usually one accent.
- Keep grid/alignment consistent.
- Before UI/design work: read `DESIGN.md`.
- Keep `DESIGN.md` current for durable system-level design rules only.
- Docs scope: architecture, behavior, interfaces/contracts, operations, troubleshooting.
- Reuse existing docs layout; avoid placeholder or duplicate docs.
- If behavior/interface/architecture/ops/constraints change, update docs in the same task.
- Update docs when the change adds durable knowledge worth preserving.

## Runtime + CI
- Core tools: `gh`, `bun`, `tuist` (prefer `just`), `prek`, `trash`, `actionlint`.
- AWS investigation/infrastructure path: official AWS MCP via global config; do not rely on local AWS CLI skills.
- Sentry investigation: MCP tools only; never legacy local scripts or `SENTRY_AUTH_TOKEN` helpers.
- Prefer repo `justfile` for build/test/generate/format.
- Bootstrap hooks/formatter: `npx @derklinke/miedinger --force`.
- Never run concurrent builds/tests for the same app/workspace to bypass locks.
- On Xcode/Tuist build lock contention: wait, rerun same command; do not shard DerivedData via custom temp paths/env vars.
- If you ran build/tests and saw failures, fix them before handoff; if verification was deferred, state that clearly and give the exact follow-up command.
- CI loop: inspect with `gh run list` / `gh run view`; fix/push until green.
- Run `actionlint` on touched GitHub Actions workflows before handoff/commit.
- Before push: `git pull --rebase`.

## Skill Routing
- Review runtime skill list first.
- If task matches a listed skill, use it.
- Prefer `rg` / `rg --files` for codebase text search and discovery.
- Prefer official AWS MCP over local AWS CLI skill wrappers for AWS operations and investigation.
- Skill naming groups:
- `review-*`: non-security review/audit/quality-gate flows.
- `plan-*`: planning/execution methodology flows.
- `git-*`: git-centric workflows.
- `infra-*`: infrastructure/platform delivery workflows.
- SwiftUI routing: `ios-swiftui-pro` is canonical; retired overlapping `ios-swiftui-*` entrypoints stay removed.
- Consider `code-simplifier` for non-trivial changes when the diff is not already minimal.
- Design routing: default to `design`, `design-audit`, and add `design-interaction-motion-craft` only when motion/gesture/transition behavior is in scope.
- Design feedback/sign-off review: default to `design-audit`.
- Interaction/motion/gesture tasks: include `design-interaction-motion-craft`.
- iOS API references belong under the parent skill's `references/` directory, not as standalone `*-ref` entrypoints.
- Use the most relevant skill(s); load multiple only when clearly beneficial.
- Treat `~/.codex/skills` as working memory for repeatable patterns.
- If skills are frequently paired, add bidirectional cross-references in both `SKILL.md` files.
- Convert reusable debugging/research patterns into new or updated skills immediately.
- Prefer skill docs optimized for Codex local execution context.
- Prune stale/duplicate skills aggressively.
- If no skill matches: state `no relevant skill found`; use best general workflow.

## Token Efficiency
- Never re-read files just edited.
- Never re-run commands unless outcome is uncertain.
- Avoid echoing large code/file blocks unless asked.
- Batch edits; avoid fragmented micro-edits.
- Skip status filler.
- Prefer one well-planned tool call over many.
- Do not summarize obvious completed actions.

## Execution Doctrine
- Use focused subagents when parallelism or deeper research clearly outweighs coordination overhead.
- After repeated user corrections, add a durable prevention rule to `./AGENTS.md` if broadly reusable.
- Prevention rule: when exploration reveals touched-scope issues, clean them up only if directly adjacent and low-risk.
- Prevention rule: refactoring/simplification target is fewer lines and fewer branches; justify any growth as strictly necessary.
- Prevention rule: when consolidating overlapping skills, delete redundant entrypoints; no alias/compatibility wrappers unless explicitly requested.
- Prevention rule: if a URL contains an anchor fragment, treat it as potentially accidental; confirm scope by reading the full source unless section-only extraction was requested.
- Prevention rule: naming-group proposals must preserve domain boundaries; e.g. security remains `security-*`, never absorbed into generic `review-*`.
- Prevention rule: new infrastructure skills default to `infra-*`; avoid unscoped infra names.
- Prevention rule: UI copy must prefer simple, user-facing language over internal/system terms; replace technical words like `anchor` with direct phrasing like `wake-up` or `bedtime` when accuracy is preserved.
- Do not claim pass/fix without proof; if verification was deferred, say so and give the exact command to verify.
- Completion gate: verify code shape when touched code is materially complex or misplaced; avoid mandatory cleanup passes for minor diffs.
- For bug reports: fix directly from evidence; minimize user context switching.
- For CI failures: inspect logs, fix root cause, rerun until green.
