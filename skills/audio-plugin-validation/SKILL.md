---
name: audio-plugin-validation
description: Unified validation workflow for audio plugins across VST3 (.vst3), AudioUnit (.component/.appex), CLAP (.clap), VST3 UI smoke-tests, and macOS code-signing/notarization checks. Use when users ask to validate plugin binaries, run auval/vst3 validator/pluginval/clap-validator/editorhost, or diagnose host load failures.
metadata:
  short-description: Validate VST3, AU, CLAP, UI, and macOS signing
---

# Audio Plugin Validation

## Overview

Single entrypoint for plugin QA across formats and platforms.
Route by artifact + goal, run the correct validator(s), capture exact failures, return remediation.

## Trigger Conditions

Use this skill when the user asks for any of:

- Validate `.vst3`, `.component`, `.appex`, `.clap`
- Run `auval`, `validator`, `pluginval`, `clap-validator`, or `editorhost`
- Debug "plugin does not load", "fails in host", "fails in signed DAW"
- Check macOS codesign, hardened runtime, entitlements, notarization
- Add CI-style validation gate before release

## Workflow

### Step 1: Classify artifact and intent

- Identify format from extension or explicit user request:
  - `.vst3` -> VST3
  - `.component`/`.appex` -> AudioUnit
  - `.clap` -> CLAP
- Identify goal:
  - Functional conformance
  - UI/editor smoke test
  - Signing/notarization diagnosis
  - Cross-check (run more than one validator)

### Step 2: Route to the primary tool

| Goal | Preferred Tool | Notes |
|---|---|---|
| VST3 conformance | `validator` | Use `-e` for deeper tests |
| VST3 UI smoke test | `editorhost` | For editor/window behavior only |
| AudioUnit conformance | `auval` | AU must be registered first |
| CLAP conformance | `clap-validator` | Supports focused test filtering |
| Cross-format stress | `pluginval` | Does not support CLAP |
| macOS load in signed DAW | `codesign` + `spctl` + `stapler` | Check runtime + entitlements + notarization |

Routing rules:
- Prefer `validator` over `pluginval` for multi-bus VST3.
- If artifact is AUv3 (`.appex`), confirm `pluginkit` registration before `auval`.
- For CLAP, do not substitute VST3/AU tools.
- On macOS host-load failures, run codesign checks even if conformance tests pass.

### Step 3: Preflight environment

Confirm tool availability before execution and report missing dependencies explicitly.

- macOS/Linux shell checks: `command -v <tool>`
- Windows PowerShell checks: `Get-Command <tool>`
- Windows CMD fallback: `where <tool>`
- macOS AU: `auval` (Xcode CLT)
- VST3: Steinberg `validator` and optionally `editorhost` (VST3 SDK build)
- CLAP: `clap-validator`
- Cross-format: `pluginval` or macOS app-bundle binary `/Applications/pluginval.app/Contents/MacOS/pluginval`
- macOS signing checks: `codesign`, `spctl`, `stapler`

Platform scope guard:
- AU + codesign flow is macOS-only.
- VST3/CLAP/pluginval flows are cross-platform.

If a tool is missing, stop and return install/build command(s) instead of partial inference.

### Step 4: Execute and capture evidence

Run the canonical command set from:
- `references/commands.md`

Execution standards:
- Quote exact failing lines/errors in results.
- Preserve command + exit code.
- Use stricter modes by default (`validator -e`, `pluginval --strictness-level 5`, `auval -strict` where feasible).
- For flaky/randomized tests (pluginval), capture and report seed for replay.

### Step 5: Return normalized report

Use this output schema:

```text
Artifact: <path>
Format: <VST3|AUv2|AUv3|CLAP>
Platform: <macOS|Windows|Linux>
Goal: <conformance|ui|codesign|cross-check>
Tools Run:
  - <tool + command + exit code>
Result: <PASS|FAIL|PARTIAL>
Key Failures:
  - "<exact error line 1>"
  - "<exact error line 2>"
Root Cause Class:
  - <signing|state|parameters|bus/layout|registration|ui|thread-safety|other>
Recommended Fixes:
  1. <concrete fix>
  2. <concrete fix>
Next Verification Command:
  - <single command proving fix>
```

## Failure Diagnosis

For symptom-to-cause mapping and remediation patterns, load:
- `references/failure-patterns.md`

## Guardrails

- Do not claim pass/fail without running a validator command.
- Do not mix formats (e.g., AU conclusions from VST3-only tests).
- When user asks "validate plugin" without format, infer from extension; if ambiguous, run discovery (`validator -list`, `auval -a`, `clap-validator list tests`) and state assumptions.
- For CI contexts, prefer headless-safe options (`--skip-gui-tests` in pluginval).
- Keep response concise and operational; no long background unless requested.

## Resources

### references/
- `references/commands.md` - canonical commands by format/tool
- `references/failure-patterns.md` - common failures, root-cause classes, and fixes

---

No scripts/assets required for this version.
