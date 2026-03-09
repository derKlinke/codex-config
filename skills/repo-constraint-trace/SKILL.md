---
name: repo-constraint-trace
description: Use when locating exact enforcement checks, threshold constants, and UI/backend decision paths in an unfamiliar repository. Trigger on requests like "where is this check", "what radius/limit is used", "why does UI show this message", or "find every enforcement path".
---

# Repo Constraint Trace

## Overview
Fast workflow to map behavior from user-visible symptom to exact gate logic and constants.

## Workflow
1. Anchor with user-visible evidence.
- Start from an exact message string, endpoint name, setting label, or failing scenario.
- Search with `rg -n "<exact phrase>"` before broad semantic terms.

2. Trace all enforcement layers.
- Find direct checks first (view-model/controller/service), then upstream/downstream validators.
- Always verify both client and server paths when behavior could be duplicated.

3. Extract hard facts only.
- Record concrete values (radius, timeout, limit, enum case).
- Record file path + symbol + condition expression for each gate.

4. Confirm divergence.
- Identify whether layers use different thresholds or error mapping.
- Note when distinct failures collapse into one generic user message.

5. Report minimal actionable output.
- `Current rule`: exact condition and value.
- `Execution path`: ordered call chain.
- `Mismatch`: client/server divergence or none.
- `Fix point`: smallest safe place to change behavior.

## Commands
```bash
rg -n "check in failed|too far|out of range|radius|threshold|limit" .
rg -n "if .*distance|guard .*distance|validate|enforce|policy" .
rg -n "toast|alert|errorMessage|localizedDescription" .
```

## Guardrails
- Do not infer constants from comments/tests if runtime code differs.
- Do not stop at first match; prove there is no second enforcement path.
- Prefer code-path evidence over assumption when UI and backend disagree.
