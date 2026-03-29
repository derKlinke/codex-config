# AGENTS.md
- Name: Fabian S. Klinke
- Background: M.Sc. Audio Technology; iOS/macOS dev
- Response style: telegraph/noun-phrase OK

These rules are operating constraints, not suggestions. If a rule applies, follow it before convenience, habit, or local pattern-matching.

If applicable rules are skipped, usual failure mode: rework, style drift, unnecessary code, or regression masked as progress.

## Core Protocol
- "Make a note" => edit `AGENTS.md`; ignore `CLAUDE.md`.
- Agent-to-agent language: English only.
- Keep `AGENTS.md` current when constraints, architecture, or durable workflow rules change.
- Conventional Commit types only: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`.
- Split commits when a message needs `and`, list syntax, or >1 scope.
- Keep files `<~500 LOC`; split/refactor early.
- Comments: concise why-comments; avoid what-comments.
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
- Optimize for readability first: extremely easy to consume, skimmable code.
- Prefer straightforward control flow; avoid cleverness.
- Prefer early returns over nested conditionals when behavior is unchanged.
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

## Design
- Default design: content-first minimalism.
- Use large white space/empty space as primary hierarchy.
- Avoid decorative containers/effects unless functionally justified.
- Restrained palette/motion; usually one accent.
- Keep grid/alignment consistent.
- Treat padding and spacing adjustments as meaningful hierarchy changes; when asked to increase or decrease them, default to a clearly visible step rather than a 2-4px nudge.
- For substantial UI work: use `design` first to set direction; route motion/gesture problems to `design-interaction-motion-craft`; do not ship before an explicit audit of hierarchy, states, responsiveness, accessibility, reduced motion, and anti-generic quality.
- For branded landing pages: first viewport should read as one composition with brand-first hierarchy, one dominant visual anchor, cardless-by-default layout, and one clear job per section.
- Before UI/design work: read `DESIGN.md` first, then align decisions to it before editing UI code.
- If repo `DESIGN.md` is absent, define explicit design direction in-task before coding; no ad-hoc styling.
- Keep `DESIGN.md` current for durable system-level design rules only.

## Documentation
- Docs scope: architecture, behavior, interfaces/contracts, operations, troubleshooting.
- Reuse existing docs layout; avoid placeholder or duplicate docs.
- Do not persist implementation plans as Markdown docs; if durable documentation is warranted, document the approved design/architecture/behavior, not a task plan.
- If behavior/interface/architecture/ops/constraints change, update docs in the same task.
- Update docs when the change adds durable knowledge worth preserving.

## Token Efficiency
- Never re-read files just edited.
- Never re-run commands unless outcome is uncertain.
- Avoid echoing large code/file blocks unless asked.
- Batch edits; avoid fragmented micro-edits.
- Skip status filler.
- Prefer one well-planned tool call over many.
- Do not summarize obvious completed actions.
