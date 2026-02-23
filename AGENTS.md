# AGENTS.MD
- Name: Fabian S. Klinke
- Background: M.Sc. Audio Technology; iOS/macOS dev
- Response style: precise, scientific terminology, minimal tokens; telegraph/noun-phrase OK

## Core Protocol
- "Make a note" => edit `AGENTS.md`; ignore `CLAUDE.md`.
- Update `AGENTS.md` when constraints/architecture change.
- Conventional Commit types: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`.
- Keep files `<~500 LOC`; split/refactor when needed.
- Comments: concise why-comments; avoid what-comments.
- New dependencies: quick health check (release cadence, recent commits, adoption).
- Web research: search early, quote exact errors, prefer recent sources.
- Do not keep legacy fallbacks/old patterns unless explicitly requested.
- Prefer clean/readable code over preserving weak patterns.
- Never remove functionality without explicit user consent.
- Flag repetition aggressively; keep implementations DRY.
- Testing non-negotiable; prefer too much testing over too little.
- Keep solutions "engineered enough": avoid fragile hacks and premature abstraction.
- Bias toward explicit code over clever code.
- **Simplicity First**: Keep changes as simple as possible; minimize touched code.
- **No Laziness**: Find root cause; no temporary fixes; senior engineering standard.
- **Fix, Don't Mask**: Resolve issues; do not hide symptoms.

## Working Conventions
- Prioritize root-cause fixes; avoid band-aids.
- If uncertain: read more code, then ask short options.
- If constraints conflict: state tradeoff, choose safer path.
- Treat unrelated local edits as parallel work unless blocking.
- Avoid destructive ops unless explicitly requested.
- Branch changes require user consent.
- Before push: `git pull --rebase`.

## Design Protocol
- Default: content-first minimalism.
- Use whitespace/typography as primary hierarchy.
- Avoid decorative containers/effects unless functionally justified.
- Use restrained palette/motion; usually one primary accent.
- Keep grid/alignment consistent and predictable.
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
- CI checks: inspect via `gh run list` / `gh run view`; fix and push until green.

## Skill Routing
- Review runtime skill list first.
- If task matches a listed skill, use it.
- For any design-related task, always include `design-quality-gates` plus the relevant domain skill.
- For interaction/animation/transition/gesture work, always include `interaction-motion-craft`.
- If none match, state `no relevant skill found` and use best general workflow.

## Skill Memory System
- Treat `~/.codex/skills` as working memory for repeatable engineering patterns.
- For non-trivial tasks, load at least two relevant skills (e.g., domain + verification/review).
- If 2+ skills are frequently paired, add bidirectional cross-references in their `SKILL.md` files in the same task.
- When debugging/research finds a reusable pattern, create a new skill or update an existing one immediately.
- Prefer skill docs written for Codex local execution context (tools/workflows), not external agent-command ecosystems.
- Prune stale/duplicate skills aggressively; merge overlaps; remove skills that no longer improve decision quality.
- Keep skills concise, operational, and action-first.

## Token Efficiency
- Never re-read files you just wrote/edited; you know the contents.
- Never re-run commands to "verify" unless outcome was uncertain.
- Don't echo large code/file blocks unless asked.
- Batch related edits into one operation; don't do 5 edits when 1 handles it.
- Skip confirmations like "I'll continue..."; just do it.
- If a task needs 1 tool call, don't use 3; plan before acting.
- Do not summarize what you just did unless result is ambiguous or needs additional input.

## Execution Doctrine

### 2. Subagent Strategy
- Use subagents liberally to keep main context clean.
- Offload research, exploration, and parallel analysis to subagents.
- For complex problems, increase parallel compute via subagents.
- One task per subagent for focused execution.

### 3. Self-Improvement Loop
- After any correction from user: update `tasks/lessons.md` with the pattern.
- Write rules that prevent repeating the same mistake.
- Iterate on lessons until mistake rate drops.
- Review relevant lessons at session start.

### 4. Verification Before Done
- Never mark a task complete without proof.
- Diff behavior between `main` and changes when relevant.
- Ask: "Would a staff engineer approve this?"
- Run tests, inspect logs, demonstrate correctness.

### 5. Demand Elegance (Balanced)
- For non-trivial changes: ask "is there a more elegant way?"
- If fix feels hacky: re-implement with current full understanding.
- Skip elegance pass for simple/obvious fixes; avoid over-engineering.
- Challenge your own work before presenting it.

### 6. Autonomous Bug Fixing
- For bug reports: fix directly; avoid hand-holding requests.
- Point to logs/errors/failing tests, then resolve.
- Minimize user context switching.
- Fix failing CI tests without explicit step-by-step guidance.

## Task Management
1. **Plan First**: Write plan to `tasks/todo.md` with checkable items.
2. **Verify Plan**: Check in before starting implementation.
3. **Track Progress**: Mark items complete as you go.
4. **Explain Changes**: High-level summary at each step.
5. **Document Results**: Add review section to `tasks/todo.md`.
6. **Capture Lessons**: Update `tasks/lessons.md` after corrections.
