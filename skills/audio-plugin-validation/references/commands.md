# Audio Plugin Validation Commands

## Tool Availability

```bash
# macOS / Linux
command -v validator
command -v editorhost
command -v auval
command -v clap-validator
command -v pluginval
command -v codesign
command -v spctl
command -v stapler
```

```powershell
# Windows PowerShell
Get-Command validator
Get-Command editorhost
Get-Command clap-validator
Get-Command pluginval
```

```bat
:: Windows CMD fallback
where validator
where editorhost
where clap-validator
where pluginval
```

## VST3 (`.vst3`)

```bash
# Standard validation
validator /path/to/plugin.vst3

# Extensive suites (preferred for release checks)
validator -e /path/to/plugin.vst3

# Quiet mode (errors only)
validator -q /path/to/plugin.vst3
```

### VST3 UI Smoke Test

```bash
editorhost /path/to/plugin.vst3
editorhost --componentHandler /path/to/plugin.vst3
editorhost --secondWindow /path/to/plugin.vst3
```

## AudioUnit (`.component`, `.appex`) - macOS

```bash
# Rescan AUv2 registry after rebuild/install
killall -9 AudioComponentRegistrar

# AUv3 registration checks
pluginkit -m -v -p <bundle-id>
pluginkit -a /path/to/MyAU.appex

# Validation (replace type/subtype/manufacturer)
auval -v aufx <subtype> <manufacturer>

# Strict validation
auval -strict -v aufx <subtype> <manufacturer>

# Fast open/init check
auval -o -v aufx <subtype> <manufacturer>
```

## CLAP (`.clap`)

```bash
# Full validation
clap-validator validate /path/to/plugin.clap

# Failures and warnings only
clap-validator validate --only-failed /path/to/plugin.clap

# Focused repro for one test
clap-validator validate --in-process --test-filter <REGEX> /path/to/plugin.clap

# Machine-readable output
clap-validator validate --json /path/to/plugin.clap
```

## Cross-Format Stress (`pluginval`)

```bash
# macOS app bundle path
/Applications/pluginval.app/Contents/MacOS/pluginval --strictness-level 5 /path/to/plugin.vst3

# Headless CI pattern
pluginval --strictness-level 5 --skip-gui-tests --timeout-ms 60000 /path/to/plugin.vst3

# Reproducible rerun (seed from failing log)
pluginval --strictness-level 5 --seed 0x374115a /path/to/plugin.vst3
```

```powershell
# Windows
pluginval.exe --strictness-level 5 --skip-gui-tests --timeout-ms 60000 "C:\path\to\plugin.vst3"
```

```bash
# Linux
pluginval --strictness-level 5 --skip-gui-tests --timeout-ms 60000 /path/to/plugin.vst3
```

Notes:
- `pluginval` does not validate CLAP.
- For multi-bus VST3 failures in pluginval, confirm with Steinberg `validator`.

## macOS Code-Signing / Notarization

```bash
# Signature integrity
codesign -vvv --deep --strict /path/to/plugin.vst3

# Signing metadata (look for flags=...runtime)
codesign -d --verbose=4 /path/to/plugin.vst3

# Entitlements
codesign -d --entitlements - /path/to/plugin.vst3

# Gatekeeper assessment
spctl --assess --verbose=4 --type exec /path/to/plugin.vst3

# Stapled notarization ticket
stapler validate /path/to/plugin.vst3
```

## Discovery Commands

```bash
# VST3 discovered by Steinberg validator scan locations
validator -list

# AudioUnits currently registered
auval -a

# CLAP plugins visible to clap-validator
clap-validator list tests

# Optional manual CLAP discovery by location
find ~/.clap /usr/lib/clap /usr/local/lib/clap -maxdepth 2 -name "*.clap" 2>/dev/null
```
