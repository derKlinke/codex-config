---
name: ios-energy-diag
description: Use for symptom-based energy diagnostics: high battery ranking, heat, background drain, cellular-heavy drain, and action-specific spikes.
license: MIT
metadata:
  version: "1.0.0"
---

# Energy Diagnostics

Symptom-first triage for iOS energy issues.

Related: `ios-energy`, `ios-energy-ref`.

## Symptom 1: App High in Battery Settings

### Decision path

1. Run Power Profiler first.
2. Identify dominant subsystem:
- CPU high: timer leak, polling loop, repeated parsing
- Network high: many small requests, fixed-interval polling
- GPU high: heavy effects/animations running offscreen
- Display high: bright/light-heavy UI on OLED

3. Check Battery Settings background section:
- high background time + location icon -> continuous location
- audio active when idle -> session leak
- long BGTasks -> late completion calls

### Time-cost

| Approach | Time | Accuracy |
|---|---|---|
| Power Profiler first | 15-20 min | high |
| random optimization | 4h+ | low |
| broad code read only | 2h+ | medium |

## Symptom 2: Device Gets Hot

### Decision path

1. Heat during specific action?
- video/camera: verify hardware encode + release capture session
- scrolling/animation: reduce GPU effects, cap frame rate
- data processing: move heavy work off main, cache outputs

2. Heat during normal idle-ish use?
- profile CPU/GPU/Network continuously
- check for loops/runaway recursion with Time Profiler

3. Heat in background?
- continuous location
- active audio session
- long-running BGTasks

### Time-cost

| Approach | Time | Outcome |
|---|---|---|
| Power + Time Profiler | 20-30 min | root cause likely |
| manual code scan | 1-2h | partial |

## Symptom 3: Background Battery Drain

### Decision path

1. Audit background modes in Info.plist:
- `location`: remove unless required; if required, reduce accuracy and stop when done
- `audio`: deactivate session when idle; never use silent-audio keepalive hack
- `fetch` / `remote-notification`: verify schedule cadence and handler efficiency

2. Audit `BGTaskScheduler`:
- refresh frequency too high?
- processing task missing `requiresExternalPower` for non-urgent work?
- missing `setTaskCompleted` or expiration handling?

3. Audit `beginBackgroundTask`:
- `endBackgroundTask` called immediately after work?
- overlapping task identifiers cleaned up?

### Common signatures

| Pattern | Power profile signature | Fix |
|---|---|---|
| continuous location | CPU + location indicator | significant-change/stop logic |
| audio session leak | steady CPU/audio path | `setActive(false)` when idle |
| timer leak | periodic CPU spikes | invalidate timers on background |
| background polling | periodic network lane | push-driven updates |
| BGTask too long | sustained CPU | chunk/checkpoint + faster completion |

## Symptom 4: Drain Mainly on Cellular

### Decision path

1. URLSession config
- `allowsExpensiveNetworkAccess` false for non-urgent traffic
- `isDiscretionary` true for deferred/background transfers
- `waitsForConnectivity` true to avoid churn

2. Request pattern
- batch small requests
- replace polling with push
- defer large non-urgent downloads

3. Low Data Mode behavior
- respect constrained/expensive access flags
- reduce payload size under low-data conditions

### Time-cost

| Approach | Time | Outcome |
|---|---|---|
| config review | ~15 min | quick wins |
| discretionary tuning | ~30 min | significant savings |
| poll->push redesign | 2-4h | largest impact |

## Symptom 5: Spike During One Action

### Decision path

1. Record Power Profiler around action.
2. Branch on subsystem spike:
- CPU: repeated parsing, eager view creation, sync image processing
- GPU: blur/shadow/mask complexity, unnecessary high FPS
- Network: large/parallel/retry-heavy traffic
- Display: unusual unless app manipulates brightness

3. Deep profile matching subsystem:
- CPU -> Time Profiler
- GPU -> render/fps analysis
- Network -> request pattern and concurrency

### Time-cost

| Approach | Time | Outcome |
|---|---|---|
| profiler capture during action | 5-10 min | subsystem isolated |
| targeted deep profile | 10-15 min | function/path isolated |
| no-profile code guessing | 1h+ | low certainty |

## Quick Checklist

### 30-second
- [ ] device plugged in? (power metrics skew)
- [ ] debug vs release build considered
- [ ] Low Power Mode state known

### 5-minute
- [ ] dominant subsystem identified
- [ ] sustained vs spiky pattern identified
- [ ] foreground vs background clarified

### 15-minute
- [ ] CPU path sampled with Time Profiler
- [ ] network frequency/size inspected
- [ ] animation frame behavior inspected
- [ ] background modes audited

## Fast Fix Table

| Finding | Fix | Time |
|---|---|---:|
| timer without tolerance | add `timer.tolerance` | ~1 min |
| eager list rendering | use lazy stacks | ~1 min |
| expensive network allowed by default | set expensive/constrained policies | ~1 min |
| missing location stop | explicit stop calls | ~2 min |
| no dark assets on OLED-heavy UI | add dark variants | ~30 min |
| audio session always active | deactivate when idle | ~5 min |

## Escalation

- Use `ios-energy` for full architecture-level optimization patterns.
- Use `ios-energy-ref` for API-level implementation detail.
- Run repository energy audit/profile workflow when available.

Last Updated: 2025-12-26
Platforms: iOS 26+, iPadOS 26+
