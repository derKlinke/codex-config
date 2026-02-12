# Common Failure Patterns

## macOS Signing / Load Failures

### Symptom
`code object is not signed at all`

Cause class: `signing`
Fix:
1. Sign final bundle artifact (after build output is complete).
2. Re-run `codesign -vvv --deep --strict`.

### Symptom
`a sealed resource is missing or invalid`

Cause class: `signing`
Fix:
1. Bundle contents changed after signing.
2. Re-sign bundle after all resources/binaries are finalized.

### Symptom
Flags show `0x0(none)` instead of `runtime`

Cause class: `signing`
Fix:
1. Re-sign with hardened runtime (`--options runtime`).
2. Re-test in signed host.

### Symptom
Plugin passes validation but not loaded in hardened DAW

Cause class: `entitlements` or `library-validation`
Fix:
1. Inspect plugin entitlements for required capabilities.
2. Verify host policy (`disable-library-validation` if needed for third-party loading model).

## AudioUnit (`auval`)

### Symptom
`FATAL ERROR: didn't find the component`

Cause class: `registration`
Fix:
1. Install AUv2 in standard Components path.
2. Run `killall -9 AudioComponentRegistrar`.
3. For AUv3, run host once or `pluginkit -a <appex>`.

### Symptom
Intermittent failures across repeats/stress

Cause class: `thread-safety` or `state`
Fix:
1. Run `auval -stress` and capture first failing section.
2. Inspect shared-state synchronization and initialization order.

## VST3 (`validator` / `pluginval`)

### Symptom
General load failure

Cause class: `binary/dependency`
Fix:
1. Confirm architecture compatibility (arm64/x86_64, etc.).
2. Ensure runtime dependencies are available/bundled.

### Symptom
Parameter suite failures

Cause class: `parameters`
Fix:
1. Ensure IDs are unique and stable.
2. Verify default/min/max and conversion functions.

### Symptom
Bus or arrangement failures

Cause class: `bus/layout`
Fix:
1. Validate bus activation transitions.
2. Confirm channel arrangements match advertised capabilities.

### Symptom
`pluginval` crashes on multi-bus plugin

Cause class: `tool-limitation`
Fix:
1. Re-run with Steinberg `validator` (authoritative for VST3 conformance).
2. Keep `pluginval` for supplemental stress only.

## CLAP (`clap-validator`)

### Symptom
Parameter flag conflicts

Cause class: `parameters`
Fix:
1. Remove incompatible flag combinations.
2. Re-run focused test with `--test-filter`.

### Symptom
State load test failures with empty/invalid data

Cause class: `state`
Fix:
1. Ensure invalid/empty state returns failure where required.
2. Harden deserialization validation paths.

## Reporting Rule

Always include:
1. Exact failing line(s)
2. Root-cause class
3. One command to verify the proposed fix
