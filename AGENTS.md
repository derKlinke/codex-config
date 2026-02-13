# AGENTS.MD
- Name: Fabian S. Klinke
- Background: M.Sc. Audio Technology + iOS/macOS dev
- Response style: precise, scientific terminology, minimal tokens, telegraph/noun-phrase acceptable

## Package Manager
- Use **bun** by default: `bun install`, `bun run <script>`, `bun test`
- Prefer repo recipes when available: `just <recipe>`

## Commit Attribution
- AI commits MUST include:
```text
Co-Authored-By: Codex (GPT-5) <noreply@openai.com>
```
- If another agent authors the change, use that agent identity instead

## Core Protocol
- PR review: `gh pr view` / `gh pr diff` (no URLs)
- "Make a note" => edit `AGENTS.md`; ignore `CLAUDE.md`
- `AGENTS.md` is living memory; update when constraints or repo facts change
- Commits use Conventional Commits: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`
- Keep files `<~500 LOC`; split/refactor when needed
- Comments: concise why-comments; avoid what-comments
- New dependencies: quick health check (release cadence, recent commits, adoption)
- Web research: search early; quote exact errors; prefer 2024-2026 sources

## Key Conventions
- Prioritize root-cause fixes; avoid band-aids
- If uncertain: read more code, then ask short options
- If constraints conflict: state tradeoff, choose safer path
- Treat unrelated local edits as parallel work unless blocking
- Leave breadcrumb notes in-thread
- Avoid destructive ops unless explicitly requested
- Branch changes require user consent
- Before push: `git pull --rebase`
- Ignore automation runtime logs: `automations/**/memory.md` untracked
- If unexpected file movement/deletion appears: stop + ask

## Memory + Notes
- Hierarchy:
- `~/.codex/AGENTS.md` (global protocol)
- `~/.codex/memory.md` (cross-project durable ledger)
- Project `AGENTS.md` + local memory notes
- For note edits outside `klinke.studio`, read `/Users/fabianklinke/Developer/klinke/klinke.studio/AGENTS.md`

## Design Protocol
- For UI/design work, keep `DESIGN.md` as current-state spec
- Before UI/design work: read `DESIGN.md`
- Update `DESIGN.md` whenever tokens/components/interaction patterns change
- `DESIGN.md` must document current design vibe (visual tone, interaction feel, aesthetic constraints)
- Do not keep changelogs/decision histories in `DESIGN.md`

## Frontend Aesthetics
- Native-first: iOS/macOS follow HIG/material constraints; avoid generic web-style chrome
- Content-first minimalism by default
- Use whitespace/typography as primary hierarchy
- Avoid decorative containers/effects unless functionally justified
- Restrained palette/motion; usually one primary accent
- Keep layout grid/alignment consistent and predictable

## Documentation System
- Keep docs focused: architecture, behavior, interfaces/contracts, operations, troubleshooting
- Use existing repo layout unless a new docs area is needed
- Avoid placeholder docs and duplicate scaffolding
- If behavior/interfaces/architecture/operations/constraints change, update docs in the same task
- Completion gate: docs touched or explicit no-doc-impact statement

## Runtime + Tools
- Core tools: `gh`, `bun`, `tuist` (prefer `just` if available), `prek`, `trash`

## Build + Test
- Prefer repo `justfile` commands for build/test/generate/format
- Bootstrap formatter/hooks: `npx @derklinke/miedinger --force`
- CI checks: inspect with `gh run list` / `gh run view`; fix and push until green

## Skill Routing
- Review runtime skill list first
- If task matches a listed skill, use it
- If none match, state `no relevant skill found` and use best general workflow

## Local Skills
- Agent docs: use `agents-md` skill (`/Users/fabianklinke/.codex/skills/agents-md/SKILL.md`)
- Notes graph: use `notes-knowledge-graph` skill (`/Users/fabianklinke/.codex/skills/notes-knowledge-graph/SKILL.md`)
- Design docs: use `design-system-doc` skill (`/Users/fabianklinke/.codex/skills/design-system-doc/SKILL.md`)
