---
name: session-skill-audit
description: Use when reviewing Codex session transcripts to detect skill-usage friction, decide whether personal skills need updates, and propose/create new reusable skills from repeated workflow pain.
---

# Session Skill Audit

Analyze recent `~/.codex/sessions` JSONL logs for skill failure patterns; update personal skills only when evidence is strong.

## Related Skills

- For editing skill docs after evidence collection, use `writing-skills` (`~/.codex/skills/writing-skills/SKILL.md`).
- For creating a new skill from repeated pain, use `skill-creator` (`~/.codex/skills/.system/skill-creator/SKILL.md`).

## Scope Rules

- Default window: last 24 hours (`find ~/.codex/sessions -type f -mtime -1 -name '*.jsonl'`).
- Personal skills only: `~/.codex/skills/**`; never modify repo-local `skills/`.
- Edit only when there is a concrete transcript-backed issue.

## Evidence Pipeline (Mandatory)

1. Enumerate candidate session files in time window.
2. Extract only message text fields with `jq`:
   - `event_msg` with `payload.type=="agent_message"`
   - `response_item` with `payload.type=="message"` (assistant/user)
3. Search extracted text for skill-friction signals:
   - `no relevant skill found`
   - `skill ... not found`
   - `missing/broken/deleted skill references`
   - `overcounted/noisy scan` during skill maintenance
   - repeated manual workarounds tied to the same workflow
4. Capture at least one direct quote per proposed skill change.

## Noise Controls

- Do not grep raw JSONL for `skill` without field filtering; prompt boilerplate dominates hits.
- Ignore duplicated assistant messages from mirrored event streams; dedupe by session id + normalized quote.
- Treat single accidental command mistakes as execution noise, not skill-design defects.

## Decision Thresholds

- Update existing skill when:
  - same avoidable failure appears in >=2 sessions, or
  - one severe failure caused incorrect edits/claims and the skill lacked a guardrail.
- Create new skill when:
  - workflow recurs across sessions,
  - no current skill gives a deterministic path, and
  - guidance is reusable beyond one repo/task.
- Otherwise: no change.

## Output Contract

- Report:
  - `sessions scanned`
  - `issues found` (with short quotes)
  - `skills changed` (or explicit `none`)
  - `why this change is durable`
- Keep diffs minimal; prefer adding one precise rule over broad rewrites.
