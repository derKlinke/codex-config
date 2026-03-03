---
name: codex-memory-consolidation
description: Use when consolidating Codex memory artifacts (`~/.codex/memories/MEMORY.md`, `memory_summary.md`) from recent session/raw-memory deltas with minimal-churn edits and evidence-backed citation blocks.
---

# Codex Memory Consolidation

## Overview
Incremental memory-rollup workflow for converting recent session evidence into durable routing entries without rewriting unrelated history.

## Related Skills
- `session-skill-audit` for assistant-only extraction and friction classification.
- `writing-skills` for high-density memory prose and duplicate collapse.

## Trigger Conditions
- User asks to "consolidate memory", "update MEMORY.md", "sync memory summary", or "scan recent sessions and merge learnings".
- Automation run requires delta updates from `raw_memories.md`/recent rollouts.

## Workflow
1. Scope the delta first.
- Collect candidate rollout/session IDs and timestamps from the requested window.
- Ignore threads already represented unless new evidence changes conclusions.

2. Extract only assistant-authored evidence.
- Parse `response_item` assistant message payloads.
- Do not rely on raw keyword grep over full JSONL (prompt-text noise).

3. Classify each candidate.
- `new durable pattern` -> add/update task-group entry in `MEMORY.md`.
- `one-off execution noise` -> do not add.
- `stale/conflicting memory` -> correct existing entry explicitly.

4. Update `MEMORY.md` with minimal churn.
- Preserve task-group taxonomy and ordering.
- Append concise `desc` + `learnings` with concrete anchors (commands/files/errors).
- Prefer merge into existing groups over new groups unless domain is genuinely new.

5. Update `memory_summary.md` only for routing-level deltas.
- Refresh recent window and general tips only when operational behavior changed.
- Keep summary short; avoid replaying full rollout details.

6. Validate before reporting.
- Re-run coverage check: all in-scope thread IDs represented or explicitly deferred.
- Re-scan for duplicate/conflicting bullets.
- Confirm cited line ranges are non-empty and exact.

## Output Contract
- Report changed files and what changed materially.
- Include explicit "no skill changes" or "skill changes" note when relevant.
- If memory files were used, provide one `<oai-mem-citation>` block with exact line ranges.

## Guardrails
- No speculative facts; memory must reflect observed evidence.
- No broad rewrites for style-only reasons.
- Prefer additive/targeted edits over structural churn.
