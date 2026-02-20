---
name: ios-background-processing-diag
description: Use for symptom-based background task troubleshooting: task never runs, terminates early, delegate not called, dev/prod mismatch, inconsistent scheduling, launch crash, duplicate runs.
license: MIT
metadata:
  version: "1.0.0"
---

# Background Processing Diagnostics

Symptom-first diagnostics for `BGTaskScheduler` and background URLSession behavior.

Related: `ios-background-processing`, `ios-background-processing-ref`.

## Symptom 1: Task Never Runs

### 5-min triage

1. Info.plist
- `BGTaskSchedulerPermittedIdentifiers` includes exact identifier (case-sensitive)
- `UIBackgroundModes` contains needed mode (`fetch`/`processing`)

2. Registration timing
- `register(...)` in `didFinishLaunchingWithOptions`
- registration occurs before first `submit()`

3. App/system state
- app not force-quit from app switcher
- Background App Refresh enabled

### Time-cost guidance

| Approach | Time | Success |
|---|---|---|
| plist + registration audit | ~5 min | high for common failures |
| add logs | ~15 min | higher confidence |
| LLDB simulate launch | ~5 min | highest for handler wiring |
| random code edits | high | low |

### LLDB launch test

```lldb
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.yourapp.refresh"]
```

- Breakpoint hits: wiring is correct; issue is scheduling constraints.
- No hit: registration path broken.

## Symptom 2: Task Terminates Early

### 5-min triage

1. Expiration handler set first line in handler.
2. `setTaskCompleted(success:)` called in all paths (success/failure/expiration).
3. Task duration within budget:
- `BGAppRefreshTask`: short work only
- long work: checkpoint/chunk or move to `BGProcessingTask`

### Common causes

| Cause | Fix |
|---|---|
| no expiration handler | add immediately |
| missing completion call | call in every path |
| task too long | chunk/checkpoint |
| long network timeout | prefer background URLSession |
| async callback after expiration | gate work with cancellation flag |

### LLDB expiration test

```lldb
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.yourapp.refresh"]
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateExpirationForTaskWithIdentifier:@"com.yourapp.refresh"]
```

## Symptom 3: Background URLSession Delegate Not Called

### 5-min triage

1. Session config must be `URLSessionConfiguration.background(...)`
2. Unique session identifier
3. `sessionSendsLaunchEvents = true`
4. App delegate handler implemented and completion handler retained
5. Delegate still alive when events complete

### Required AppDelegate hooks

```swift
var backgroundSessionCompletionHandler: (() -> Void)?

func application(_ application: UIApplication,
                 handleEventsForBackgroundURLSession identifier: String,
                 completionHandler: @escaping () -> Void) {
    backgroundSessionCompletionHandler = completionHandler
}

func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
    DispatchQueue.main.async {
        self.backgroundSessionCompletionHandler?()
        self.backgroundSessionCompletionHandler = nil
    }
}
```

## Symptom 4: Works in Dev, Fails in Production

### 10-min triage

1. System constraints
- low power mode
- background refresh disabled
- low battery discretionary throttling

2. App state
- force-quit disables background execution until next manual launch
- low app usage lowers scheduling priority

3. Build differences
- debug/release behavior
- `#if DEBUG` divergence
- release bundle identifier mismatch

4. Add production telemetry
- scheduled / started / completed / failed events

### Scheduling factors to check

- critically low battery
- Low Power Mode
- user app usage frequency
- app switcher force-quit
- Background App Refresh setting
- system background budgets
- task rate limiting

## Symptom 5: Inconsistent Scheduling

### 5-min triage

1. `earliestBeginDate` is lower bound, not execution time guarantee.
2. Avoid setting dates too far out.
3. Avoid duplicate scheduling; inspect pending requests.
4. Re-schedule in handler for recurring behavior.
5. Understand expected behavior:
- `BGAppRefreshTask`: usage-predictive windows
- `BGProcessingTask`: typically charging + idle windows

## Symptom 6: Crash on Background Launch

### 5-min triage

1. Launch path safety
- no UI assumptions in background launch
- avoid force unwraps in background-only paths
- handle file protection state (device locked)

2. Handler safety
- weak capture where appropriate
- no UI work off main

3. Data protection
- ensure files needed in background are accessible (`...UntilFirstUserAuthentication` etc.)

### Safe handler skeleton

```swift
BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.app.refresh", using: nil) { [weak self] task in
    guard let self else {
        task.setTaskCompleted(success: false)
        return
    }
    self.performBackgroundWork(task: task)
}
```

## Symptom 7: Task Runs Multiple Times

### 5-min triage

1. Avoid scheduling from multiple call sites.
2. Use unique identifiers per task purpose.
3. Check pending requests before submit.
4. Ensure `setTaskCompleted` is called promptly.

### Duplicate-prevention pattern

```swift
func scheduleRefreshIfNeeded() {
    BGTaskScheduler.shared.getPendingTaskRequests { requests in
        let exists = requests.contains { $0.identifier == "com.app.refresh" }
        if !exists { self.scheduleRefresh() }
    }
}
```

## Quick Checklist

### 30 seconds
- [ ] identifier exists in plist
- [ ] registration in launch path
- [ ] app not force-quit

### 5 minutes
- [ ] identifier exact match
- [ ] background mode enabled
- [ ] completion called in all paths
- [ ] expiration handler set first

### 15 minutes
- [ ] LLDB simulated launch succeeds
- [ ] LLDB simulated expiration handled
- [ ] console logs show register -> schedule -> start -> complete
- [ ] tested on real device + release build
- [ ] Background App Refresh enabled during test

## Logs

Filter:

```text
subsystem:com.apple.backgroundtaskscheduler
subsystem:com.apple.backgroundtaskscheduler message:"com.yourapp"
```

Expected sequence:
1. registered handler
2. scheduled task
3. started task
4. app work
5. task completed

## Resources

- WWDC: 2019-707, 2020-10063
- Skills: `ios-background-processing`, `ios-background-processing-ref`
- Platforms: iOS 13+
- Last Updated: 2025-12-31
