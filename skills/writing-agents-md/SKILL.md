---
name: agents-md
description: Use when the user asks to create/update/maintain AGENTS.md, set up agent docs, or enforce high-density concise agent instructions.
---

# Maintaining AGENTS.md

AGENTS.md is canonical agent-facing documentation. Keep it minimal and dense; agents do not need hand-holding.

## Related Skills

- For editing/validating skill files themselves, use `writing-skills` (`~/.codex/skills/writing-skills/SKILL.md`).

## File Setup

1. Create `AGENTS.md` at project root
2. No symlink required; use `AGENTS.md` directly.

## Before Writing

Discover local skills to reference:

```bash
find .codex/skills -name "SKILL.md" 2>/dev/null
ls plugins/*/skills/*/SKILL.md 2>/dev/null
```

Read each skill frontmatter to decide references.

## Density Contract (Mandatory)

- Preserve all constraints/content unless user explicitly requests removal.
- Compress wording aggressively: shorter clauses, noun-phrase style, minimal glue words.
- Prefer one bullet = one rule; avoid explanatory prose.
- Remove repetition; merge semantically overlapping bullets.
- Replace verbose sentences with compact directives.
- Keep examples minimal; enough to disambiguate format only.
- Do not trade away precision for brevity; preserve normative force (`must`, `never`, `before`, etc.).
- Final pass required: remove filler, collapse duplicates, tighten phrasing.

## Writing Rules

- **Headers + terse bullets** - No paragraphs
- **Code blocks** - Commands/templates only
- **Reference, don't duplicate** - Point to skills: "Use `ios-database-migration` skill. See `.codex/skills/ios-database-migration/SKILL.md`"
- **No filler** - No intros, conclusions, pleasantries, or motivational phrasing
- **Trust capabilities** - Omit obvious context/explanations
- **Default to maximum density** - Keep all directives; minimize tokens

## Required Sections

### Package Manager
Which tool and key commands only:
```markdown
## Package Manager
Use **pnpm**: `pnpm install`, `pnpm dev`, `pnpm test`
```

### Key Conventions
Project-specific patterns agents must follow. Keep brief.

### Local Skills
Reference each discovered skill:
```markdown
## Database
Use `ios-database-migration` skill for schema changes. See `.codex/skills/ios-database-migration/SKILL.md`

## Testing
Use `test-driven-development` skill. See `.codex/skills/test-driven-development/SKILL.md`
```

## Optional Sections

Add only if truly needed:
- API route patterns (show template, not explanation)
- CLI commands (table format)
- File naming conventions
- Compression checklist (if AGENTS.md is verbose or recently expanded)

## Anti-Patterns

Omit these:
- "Welcome to..." or "This document explains..."
- "You should..." or "Remember to..."
- Content duplicated from skills (reference instead)
- Obvious instructions ("run tests", "write clean code")
- Explanations of why (just say what)
- Long prose paragraphs
- Duplicated constraints across sections
- Verbose rewrites that preserve wording but not density

## Example Structure

```markdown
# Agent Instructions

## Package Manager
Use **pnpm**: `pnpm install`, `pnpm dev`

## API Routes
[Template code block]

## Database
Use `ios-database-migration` skill. See `.codex/skills/ios-database-migration/SKILL.md`

## Testing
Use `test-driven-development` skill. See `.codex/skills/test-driven-development/SKILL.md`

## CLI
| Command | Description |
|---------|-------------|
| `pnpm cli sync` | Sync data |
```
