# Codex Workspace

Portable Codex configuration and skills for local agent execution.

## Source of Truth

- `AGENTS.md`: behavior, workflow, commit policy, docs policy.
- `skills/`: reusable skill library (`SKILL.md` + optional helpers).

## Repo Scope

Versioned:

- `AGENTS.md`
- `skills/`
- `prompts/`
- `rules/`
- repo-level docs/config (`README.md`, lint/format config, license)

Not versioned (local/private runtime state):

- `config.toml`, auth/session/history/cache artifacts
- sqlite/runtime state files
- `sessions/`, `archived_sessions/`, `shell_snapshots/`, `tmp/`
- `memories/`

See [`.gitignore`](/Users/fabianklinke/.codex/.gitignore) for the exact list.

## Maintenance Rules

- Keep `AGENTS.md` current when workflow or constraints change.
- When changing skill behavior, update the corresponding `SKILL.md` in the same task.
- Keep docs concise, operational, and aligned with actual repo state.

## Tooling

Primary local tools: `gh`, `bun`, `just`, `tuist`, `xcrun`, `python`, `prek`, `trash`.

## License

MIT. See [`LICENSE`](/Users/fabianklinke/.codex/LICENSE).
