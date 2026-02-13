---
description: Commit all changes in logically separated commits
argument-hint: [SCOPE=<optional-scope>] [DRY_RUN=true|false]
---

Review the current git working tree and commit all changes in several logically separated commits.

Constraints:
- Include modified, deleted, and untracked files.
- Group files by coherent intent. Do not mix unrelated changes in one commit.
- Use Conventional Commits (`feat|fix|refactor|build|ci|chore|docs|style|perf|test`).
- Prefer concise commit subjects (<= 72 chars). Add a body only if needed.
- If `SCOPE` is provided, use it where appropriate.

Execution:
1. Show a proposed commit plan (group -> commit message).
2. If `DRY_RUN=true`, stop after plan and print exact `git add`/`git commit` commands.
3. Otherwise stage each group and create commits sequentially until all changes are committed.
4. End with `git status --short` and a one-line summary per created commit.
