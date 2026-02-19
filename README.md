# Codex Config Repo

Personal Codex configuration repo: global agent rules, reusable skills, prompt snippets, and local safety defaults.

## Current State

- Global source of truth is `AGENTS.md`.
- Skill system is the primary working memory (`skills/`).
- iOS skills use a unified `ios-*` naming convention.
- A large iOS skill pack has been imported and adapted for Codex use (not Claude-only command ecosystems).
- Skill cross-linking is active via `## Local Cross-References` blocks in related skills.

## Repo Layout

- `AGENTS.md`
  - Global behavior, engineering defaults, design/docs policy, and skill-memory policy.
- `skills/`
  - Reusable task skills.
  - `ios-*` skills for Apple-platform development (Swift/SwiftUI/Xcode/TestFlight/App Store/etc.).
  - Additional non-iOS skills for general engineering, cloud, docs, design, and tooling.
  - `.system/` contains system support skills.
- `prompts/`
  - Stored prompts (currently includes `commit-split.md`).
- `rules/`
  - Local allow-rules and command prefix policies (`default.rules`).
- `README.md`, `LICENSE`

## Local vs Versioned Files

- This repo tracks portable configuration and skills.
- Machine-local runtime/state files are intentionally ignored (`.gitignore`), including:
  - `config.toml`
  - auth/session/history/cache artifacts
  - `tmp/`, `sessions/`, `archived_sessions/`, `shell_snapshots/`, etc.

## Skill Conventions

- Naming:
  - iOS/platform skills: `ios-*`
  - General skills keep domain-specific names.
- Authoring:
  - Keep skills concise, operational, and action-first.
  - Prefer Codex-native workflows/tools.
- Maintenance:
  - If a reusable pattern is discovered, create or update a skill immediately.
  - If two skills are frequently used together, add bidirectional cross-references.
  - Prune stale or duplicate skills aggressively.

## Tooling Baseline

Common tools expected by these configs:

- `gh`
- `bun`
- `just`
- `tuist`
- `xcrun`
- `python`

MCP usage is configured locally (see `config.toml` on each machine), with commonly used servers including XcodeBuildMCP, Linear, Figma, Supabase, and ShipSwift.

## Credits

- Inspired by [@steipete](https://github.com/steipete).
- Includes Vercel skills and the agent-browser integration.
- Significant iOS skill content is adapted from Axiom and then curated for this Codex setup.

## License

MIT. See `LICENSE`.
