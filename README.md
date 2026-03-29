# Codex Workspace

Portable Codex workspace: agent instructions, reusable skills, prompts, and local execution scaffolding.

## Status

Archived.

Writing and design skills moved to [`derKlinke/codex-plugins`](https://github.com/derKlinke/codex-plugins) as installable Codex plugins.

## Purpose

This repo is the durable control plane for local Codex usage.

- `AGENTS.md`: global operating constraints, workflow rules, documentation policy, design defaults.
- `skills/`: reusable task guides; each skill lives in its own directory with `SKILL.md` as entrypoint.
- `prompts/`, `rules/`: supporting prompt/rule assets used by the workspace.

Runtime state also exists in this directory, but most of it is intentionally local/private rather than versioned.

## Operating Model

- Treat `AGENTS.md` as the primary source of truth for agent behavior.
- Treat each `SKILL.md` as the source of truth for that skill's routing and execution guidance.
- Keep durable docs aligned with actual behavior; do not leave stale workflow text behind.
- When changing agent behavior, update the relevant instruction doc in the same task.
- When changing skill behavior, update the corresponding `SKILL.md` in the same task.

## Editing Guidance

- Prefer concise, operational documentation over narrative explanation.
- Preserve tracked docs; do not commit private runtime state.
- Keep skills self-contained, cross-referenced where useful, and easy for agents to discover.

## License

MIT. See [LICENSE](/Users/fabianklinke/.codex/LICENSE).
