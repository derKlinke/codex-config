---
name: session-skill-audit
description: Use when auditing recent Codex session logs for skill-usage failures, missing-skill gaps, or repeated friction patterns before updating personal skills.
---

# Session Skill Audit

## Overview
Deterministic workflow for extracting signal from `~/.codex/sessions` without being misled by injected prompt text.

## Related Skills
- `writing-skills` for concise, constraint-preserving SKILL.md edits.
- `skill-creator` when friction justifies a new skill.

## Workflow
1. Scope files by recency.
- `find ~/.codex/sessions -type f -mtime -1 -name '*.jsonl'`

2. Extract assistant messages only.
- Never grep raw session files first; that matches user/developer payload noise.
- Use jq filter:
```bash
find ~/.codex/sessions -type f -mtime -1 -name '*.jsonl' -print0 |
  while IFS= read -r -d '' f; do
    jq -r --arg f "$f" '
      select(.type=="response_item" and .payload.type=="message" and .payload.role=="assistant")
      | .payload.content[]?
      | select(.type=="output_text" or .type=="text" or .type=="input_text")
      | [$f, .text] | @tsv
    ' "$f" 2>/dev/null
  done
```

3. Search for friction markers in extracted stream.
- Primary patterns:
  - `no relevant skill found`
  - `missing skill`, `path can't be read`
  - `skip .*skill`, `couldn't apply .*skill`
  - repeated manual workaround language

4. Classify findings.
- `Broken skill`: Triggered but ineffective/inaccurate.
- `Missing skill`: repeated task class with no fitting skill.
- `No action`: one-off or non-skill failure (build/network/env).

5. Edit policy.
- Personal skills only: `~/.codex/skills/**`.
- Prefer minimal SKILL.md patch over creating new skill.
- Create new skill only if friction appears in multiple sessions or recurs in automation runs.

6. Verification before reporting.
- Re-run extraction + pattern scan after edits.
- Confirm no syntax/frontmatter break in updated SKILL.md files.

## Decision Rule
- If evidence is weak or one-off: do not update skills.
- If evidence is repeated and process-level: patch existing skill.
- If repeated and no fit exists: create new focused skill with narrow trigger description.
