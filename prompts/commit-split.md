---
description: Commit all changes in logically separated commits
---

Review the current git working tree and commit all changes in several logically separated commits.

Constraints:
- Include modified, deleted, and untracked files.
- Group files by coherent intent. Do not mix unrelated changes in one commit.
- Use Conventional Commits (`feat|fix|refactor|build|ci|chore|docs|style|perf|test`).
- Prefer concise commit subjects (<= 72 chars). Add a body only if needed.
- Only scope commits if repo rules require it. Otherwise, omit scopes.

Execution:
1. Show a proposed commit plan (group -> commit message).
2. Stage each group and create commits sequentially until all changes are committed.
3. End with `git status --short` and a one-line summary per created commit.
