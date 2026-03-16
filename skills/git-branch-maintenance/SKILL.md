---
name: git-branch-maintenance
description: Use when a task is Git-only branch maintenance (worktree setup, rebasing on main, resolving conflicts, and force-with-lease push) without product code changes.
---

# Git Branch Maintenance

## Overview
Deterministic workflow for branch maintenance tasks: prepare a dedicated worktree, rebase onto main, resolve conflicts safely, and push updated history.

## Related Skills
- `commit-conventions` for commit message/split rules when commits are required.
- Follow `AGENTS.md` evidence-first completion rules.

## When to Use
- Requests like: "rebase this branch", "sync branch with main", "resolve rebase conflicts", "force-push updated branch", "do this in a worktree".
- Task is operational Git maintenance, not feature implementation.

## Workflow
1. Preflight.
- Confirm current repo and branch targets.
- Verify local state with `git status --short` and `git branch --show-current`.
- If unrelated dirty changes block operation, stop and ask before touching them.

2. Worktree setup (preferred).
- Fetch refs: `git fetch --all --prune`.
- Create/enter dedicated worktree for target branch.
- If branch exists locally/remotely, check out tracking branch there.

3. Rebase sequence.
- Update main ref: `git fetch origin main`.
- Rebase target: `git rebase origin/main`.
- Never use interactive rebase unless explicitly requested.

4. Conflict handling.
- Inspect conflicted files: `git status --short`.
- Resolve only conflict markers and intended branch deltas.
- Continue with `git add <files>` + `git rebase --continue`.
- If conflict is ambiguous or crosses unrelated local work, stop and ask for direction.

5. Push safety.
- Push rewritten history with `git push --force-with-lease`.
- Never use plain `--force`.

6. Verification + report.
- Confirm branch tip and remote update (`git rev-parse --short HEAD`, push output).
- State whether tests were run. For Git-only maintenance, default: no tests unless requested.
- Report exact branch, worktree path, conflict files, and old->new commit range when available.

## Guardrails
- No destructive commands (`git reset --hard`, `git checkout --`) unless explicitly requested.
- Keep operations non-interactive.
- Do not modify product files beyond conflict resolution required for the rebase.
