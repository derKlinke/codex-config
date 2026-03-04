---
description: Zero-argument review loop for all uncommitted changes with iterative fixes and final full-test gate.
---

Review and harden all current uncommitted changes in this repository.
Scope is fixed to the working tree delta only:
- staged tracked changes
- unstaged tracked changes
- untracked files

Mandatory skills:
- `$requesting-code-review`
- `$receiving-code-review`
- `$find-bugs`
- `$verification-before-completion`
- `$test-driven-development`
- `$security-review` (if auth, data access, secrets, crypto, networking, or trust boundaries are touched)

Hard constraints:
- Launch at least 2 independent review agents per round in parallel (fresh eyes, no shared reasoning).
- Review agents report only high-confidence findings with file/line evidence and severity.
- Do not ignore findings; fix or justify with concrete evidence.
- Do not claim completion without command-backed proof.

Execution loop:
1. Read local `AGENTS.md` and relevant docs for touched paths.
2. Build change set from `git status --short`, `git diff`, `git diff --cached`, and untracked file contents.
3. Derive test commands automatically (no questions):
   - Targeted test: fastest reliable suite for touched area from repo tooling (`justfile` preferred).
   - Full test: repository-wide gate (`just verify-all-tests` if available; else best full-suite command defined by repo tooling/docs).
4. Run targeted tests. Fix failures before review.
5. Spawn parallel review agents over the uncommitted change set only:
   - Agent A: correctness/regressions using `$find-bugs` + `$requesting-code-review`.
   - Agent B: security/robustness using `$find-bugs` + `$security-review` (or second general reviewer if not security-relevant).
6. Aggregate findings into a deduplicated action list (`critical`, `high`, `medium`).
7. If any findings exist:
   - Apply fixes using `$receiving-code-review` discipline.
   - Re-run targeted tests.
   - Repeat from step 5.
8. If no findings exist:
   - Run full test suite.
   - If full suite fails, fix root cause and continue loop from step 5.
9. Stop only when both conditions hold in the same round:
   - zero review findings
   - full suite green

Final output contract:
- Changed files + why.
- Review rounds summary (findings count per round).
- Final test evidence (commands + pass/fail output summary):
  - latest targeted test run
  - passing full-suite run
- Residual risks (if any) or explicit `none`.
