---
name: review-verification-before-completion
description: Use when about to claim work is complete, fixed, or passing, before handoff, commit, or PR updates
---

# Verification Before Completion

Evidence before assertions.

## When to Use

- Before saying `done`, `fixed`, `passing`, `green`, `ready for review`, or equivalent.
- After bug fixes, infra recovery, CI triage, or test-wrapper debugging.
- When partial signals disagree: green sub-targets, failing aggregate command, stale browser state, misleading Xcode text.

## Required Flow

1. Identify the actual completion claim.
- What exactly is being claimed: code changed, bug fixed, tests passing, deploy live, browser behavior confirmed.

2. Run the matching proof.
- Code/path change: targeted command or direct artifact inspection.
- Test pass: exact repo command or explicitly scoped substitute if repo entrypoint is the proven blocker.
- Browser/UI fix: live/browser confirmation, not source inspection alone.
- CI/deploy: current run status on the relevant job/date, not prior success.

3. Resolve contradictions before claiming success.
- If targeted tests pass but aggregate command fails, report aggregate failure.
- If wrapper fails but raw command passes, classify wrapper/tooling blocker; do not say suite is green.
- If browser session is stale or on an error page, reopen and re-check before concluding.

4. Report evidence compactly.
- Include exact command or artifact checked.
- Include exit code / decisive status / first failure line when relevant.
- State clearly whether the result proves success, proves a blocker, or is still ambiguous.

## Guardrails

- Never infer `fixed` from code inspection alone.
- Never collapse `product bug fixed` and `full verification green` into one claim unless both were proven.
- Never omit deferred verification; name the missing command exactly.
- Never let misleading tool text outrank stronger contradictory evidence.

## Output Pattern

- `Verified:` command/artifact + result.
- `Not verified:` exact remaining command or blocker.
- `Conclusion:` one sentence matching only what the evidence supports.
