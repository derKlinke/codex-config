# Codex Agent Configs

Public release of my Codex coding-agent configuration: global rules, skills, prompts, and supporting files.

## What’s in this repo

- `AGENTS.md` — global operating rules for the agent.
- `skills/` — task-focused skill packs (many iOS skills based on Axiom).
- `prompts/` — reusable prompt snippets and slash commands.
- `rules/` — guardrails and policy overlays.
- `config.toml` and other runtime files — Codex settings and state.

## Tooling this repo relies on

- `just` — command entrypoint in every repo.
- `tuist` — iOS project generation and workflow.
- `gh` — GitHub CLI for PRs and CI.
- `vercel` — deploy flows and Vercel skill integration.
- `agent-browser` — browser automation skill for web testing.

## Recursive Subagent Workflow (Codex CLI)

- Default strategy: orchestrator + parallel specialist agents (`dev`, `test`, `research`, `review`).
- Recursive delegation allowed with bounded depth (`d_max = 2` default).
- Iterative loop: `plan -> assign -> execute -> verify -> review -> reassign`.

```bash
codex -C /path/to/repo exec --full-auto \
  "Orchestrator mode. Spawn subagents for dev/test/research/review. Recursive delegation allowed up to depth=2. Require patch/test/review artifacts."
```

```bash
codex -C /path/to/repo exec "Write failing repro test for <bug>. Stop after red test output."
codex -C /path/to/repo exec "Implement fix for <bug>. Run tests. Return diff + rationale."
codex -C /path/to/repo exec review --uncommitted "Find regressions, risk, missing tests."
```

## Credits

- Inspired by [@steipete](https://github.com/steipete).
- Many iOS skills are based on Axiom.
- Includes Vercel skills and the agent-browser integration.

## License

MIT. See `LICENSE`.
