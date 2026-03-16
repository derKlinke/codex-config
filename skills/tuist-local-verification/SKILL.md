---
name: tuist-local-verification
description: Use when local Tuist build/test verification fails due cloud auth, test-insights upload, xcodebuild 65 ambiguity, or repeated build DB lock contention.
---

# Tuist Local Verification

## Overview
Deterministic workflow for separating product-test failures from Tuist/Xcode tooling failures in local runs.

## Related Skills
- Follow `AGENTS.md` evidence-first reporting rules.

## When to Use
- `tuist test`/`just test-ios` fails before tests execute.
- Logs show upload/auth failures (Tuist cloud/insights) during local verification.
- `xcodebuild` exits `65` after run banner with unclear root cause.
- `build.db: database is locked` appears due concurrent Xcode/Tuist jobs.
- Raw `xcodebuild` works but repo wrapper (`just`, shebang recipe, helper script) reports misleading workspace/startup errors.

## Workflow
1. Classify failure source first.
- Capture command output + real exit code.
- Split into: `tooling/infra` vs `assertion/test`.
- Do not claim test failure until `.xcresult` or test summary confirms it.

2. Handle lock contention deterministically.
- If `build.db` lock appears, wait and rerun the same command.
- Never bypass via custom DerivedData sharding unless explicitly requested.
- Confirm no competing `tuist/xcodebuild` process remains before rerun.

3. Handle Tuist auth/upload blockers.
- Verify whether failure is from run-metadata upload or test-insights auth.
- Check repo-level Tuist config (for example `GenerationOptions`) before assuming env var support.
- Prefer minimal local-verification-safe config change over ad-hoc command drift.

4. Verify true test status.
- Inspect `.xcresult`/log for first failing test when exit is `65`.
- If no failing tests and tooling failed, report as tooling blocker, not product regression.

5. Probe wrapper-vs-command divergence.
- If wrapper says `*.xcworkspace is not a workspace file` but `xcodebuild -list -workspace ...` or raw `xcodebuild test` works, classify as wrapper/runtime failure first.
- Compare three paths in order:
  - raw `xcodebuild` in the app directory
  - raw `xcodebuild ... | xcbeautify`
  - repo entrypoint (`just ...` / `tuist ...`)
- If only the wrapper fails, do not keep mutating product code to chase the workspace text.
- Report the wrapper as the proven blocker and isolate whether cwd, shell wrapper, env injection, or simulator health differs.

6. Report with evidence.
- Provide exact command, exit code, decisive error lines, and classification.
- State whether product tests actually failed or were blocked.

## Guardrails
- No fallback to raw manual claims from streamed output.
- No contradictory reporting (`error 65` + `EXIT:0`).
- Preserve repo test entrypoints (`just`/`tuist`) unless they are the proven blocker.
- Do not trust `not a workspace file` at face value when direct workspace probes succeed.
