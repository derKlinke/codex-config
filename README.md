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

## Credits

- Inspired by [@steipete](https://github.com/steipete).
- Many iOS skills are based on Axiom.
- Includes Vercel skills and the agent-browser integration.

## License

MIT. See `LICENSE`.
