# Codex Config Repo

Personal Codex configuration repo: agent policy, reusable skills, prompt snippets, and local safety defaults.

## Canonical Policy Sources

- `AGENTS.md` is the global source of truth for behavior, engineering defaults, docs policy, and skill routing/memory rules.
- `skills/` is the primary reusable working-memory system.

## Repository Layout

```text
.codex/
├── AGENTS.md
├── README.md
├── prompts/
├── rules/
└── skills/
    ├── .system/                # system support skills
    └── <skill-name>/           # flat namespace (no category nesting)
        ├── SKILL.md            # required
        ├── agents/openai.yaml  # recommended metadata
        └── (optional helpers)
            ├── references/
            ├── scripts/
            ├── assets/
            ├── templates/
            ├── examples/
            ├── data/
            └── rules/
```

## Skill Taxonomy + Naming

- Canonical format: `kebab-case`, pattern `<namespace>-<topic>[-<qualifier>]`.
- Directory name must equal SKILL frontmatter `name`.
- Required namespaces for new/refactored skills:
  - `ios-*` Apple platform/API/runtime
  - `design-*` UI/visual/layout/motion/interaction
  - `writing-*` writing/copy/editing/docs/notes
  - `marketing-*` CRO/SEO/behavioral marketing
  - `web-*` web framework/platform best practices
- Common qualifiers:
  - `*-diag` diagnostics
  - `*-ref` API/reference catalogs
  - `*-migration` migration guides
  - `*-best-practices` standards/pattern guidance

## Skill Authoring Rules (Current)

- `SKILL.md` is mandatory.
- Frontmatter supports `name` and `description` only for trigger semantics.
- `description` should start with `Use when...` and describe triggering conditions, not workflow summary.
- Keep wording dense and directive: one bullet, one rule; preserve normative terms (`must`, `never`, `required`, `before`).
- Prefer progressive disclosure:
  - Core workflow in `SKILL.md`
  - Heavy references in `references/`
  - Deterministic repeatable operations in `scripts/`
- New/updated skills should avoid auxiliary docs inside skill dirs (`README.md`, `CHANGELOG.md`, setup narratives).
- Keep cross-skill links explicit, canonical, and synchronized (including `## Local Cross-References` where used).

## Skill Maintenance Rules

- If debugging/research yields a reusable pattern, create or update a skill immediately.
- For non-trivial work, load at least two relevant skills (domain + verification/review).
- If two skills are frequently paired, add bidirectional cross-references.
- Prune stale/duplicate skills aggressively; merge overlap.

## Local vs Versioned Files

- This repo tracks portable config + skills.
- Machine-local runtime/state is intentionally ignored, including:
  - `config.toml`
  - auth/session/history/cache artifacts
  - `tmp/`, `sessions/`, `archived_sessions/`, `shell_snapshots/`

## Tooling Baseline

- `gh`
- `bun`
- `just`
- `tuist`
- `xcrun`
- `python`
- `prek`
- `trash`

MCP server configuration remains machine-local (`config.toml`).

## Credits

- Inspired by [@steipete](https://github.com/steipete)
- Includes Vercel skills and `agent-browser`
- iOS skill corpus adapted and curated for Codex-native workflows

## License

MIT. See `LICENSE`.
