---
description: Commit all changes with logical grouping using the commit-conventions skill
---

Use `$commit-conventions` and commit the current git working tree.

Constraints:
- Include modified, deleted, and untracked files.
- Enforce `$commit-conventions` workflow and rules.
- Group files by coherent intent; never mix unrelated changes in one commit.
- If all changes are one logical unit, create exactly one commit.
- If changes span multiple logical units, create multiple commits.
- Use Conventional Commits (`feat|fix|refactor|build|ci|chore|docs|style|perf|test`).
- Prefer concise commit subjects (<= 72 chars). Add a body only if needed.
- Scope only for monorepos with multiple targets; then scope to target. Otherwise, no scope.

Execution:
1. Show a proposed commit plan (group -> commit message).
2. Stage each group and create commits sequentially until all changes are committed.
3. End with `git status --short` and a one-line summary per created commit.
