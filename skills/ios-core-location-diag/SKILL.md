---
name: ios-core-location-diag
description: "Use for Core Location troubleshooting: no updates, background failure, denied auth, poor accuracy, geofence misses, persistent location icon."
license: MIT
compatibility: iOS 17+, iPadOS 17+, macOS 14+, watchOS 10+
metadata:
  version: "1.0.0"
  last-updated: "2026-01-03"
---

# Core Location Diagnostics

Symptom-first diagnosis for modern Core Location APIs.

## Related Skills

- `ios-core-location` - implementation patterns
- `ios-core-location-ref` - API reference
- `ios-energy-diag` - battery diagnostics

## Symptom 1: Location Updates Never Arrive

### Quick checks

```swift
let manager = CLLocationManager()
print("Authorization: \(manager.authorizationStatus.rawValue)")
print("Services enabled: \(CLLocationManager.locationServicesEnabled())")
print("Accuracy: \(manager.accuracyAuthorization == .fullAccuracy ? "full" : "reduced")")
```

### Decision tree

1. `authorizationStatus`?
- `.notDetermined`: request authorization (`CLServiceSession(authorization: .whenInUse)` or `requestWhenInUseAuthorization()`)
- `.denied`: show rationale + Settings link
- `.restricted`: cannot override; offer manual location
- authorized states: continue

2. `locationServicesEnabled()` false?
- yes: prompt system enable path (Privacy -> Location Services)
- no: continue

3. Are you iterating `CLLocationUpdate.liveUpdates()`?
- no: no updates will arrive
- yes: continue

4. Task canceled/deallocated?
- yes: store task in a property
- no: continue

5. Inspect update flags:
- `locationUnavailable == true`: device cannot determine location now (indoors/airplane mode/no fix)
- `authorizationDenied` or `authorizationDeniedGlobally`: handle denial path explicitly

### Info.plist required keys

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Explain user value clearly</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Explain background benefit clearly</string>
```

Missing keys can cause silent failure/no prompt.

## Symptom 2: Background Location Not Working

### Quick checks

1. Capability enabled: Signing & Capabilities -> Background Modes -> Location updates
2. `UIBackgroundModes` includes `location`
3. `CLBackgroundActivitySession` is retained (property, not local)

### Decision tree

1. Background mode missing?
- yes: add capability and plist mode
- no: continue

2. `CLBackgroundActivitySession` retained?
- no: retain in property
- yes: continue

3. Session started in foreground?
- no: start from foreground only
- yes: continue

4. Relaunch recovery implemented?
- no: recreate session + restart updates in launch path
- yes: continue

5. Authorization level?
- `.authorizedWhenInUse`: valid with background activity session (+ blue indicator)
- `.authorizedAlways`: valid
- `.denied`: impossible

### Retention pattern

```swift
// Wrong: local session deallocates
func startTrackingWrong() {
    let session = CLBackgroundActivitySession()
    startLocationUpdates()
    _ = session
}

// Right: retained property
var backgroundSession: CLBackgroundActivitySession?

func startTracking() {
    backgroundSession = CLBackgroundActivitySession()
    startLocationUpdates()
}
```

## Symptom 3: Authorization Always Denied

### Decision tree

1. Fresh install auto-deny?
- usually missing/empty usage strings

2. Returning user previously denied?
- must re-enable in Settings

3. Requesting at wrong time?
- if `insufficientlyInUse`: request only during foreground user interaction

4. Restricted mode?
- `.restricted` (MDM/parental controls): cannot override

5. Copy quality poor?
- vague string -> higher denial
- specific user benefit -> lower denial

### Usage string quality

```xml
<!-- Bad -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location.</string>

<!-- Good -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location is used to show nearby places within walking distance.</string>
```

## Symptom 4: Accuracy Unexpectedly Poor

### Quick checks

```swift
let manager = CLLocationManager()
print("Accuracy auth: \(manager.accuracyAuthorization == .fullAccuracy ? "full" : "reduced")")

for try await update in CLLocationUpdate.liveUpdates() {
    if update.accuracyLimited { print("Accuracy limited") }
    if let location = update.location {
        print("Horizontal accuracy: \(location.horizontalAccuracy)m")
    }
}
```

### Decision tree

1. `accuracyAuthorization == .reducedAccuracy`?
- accept reduced accuracy if feature tolerates it
- or request temporary full accuracy with purpose key

2. `horizontalAccuracy` values:
- `< 0`: invalid; discard
- `> 100m`: likely non-GPS conditions
- `10-100m`: normal for many apps
- `< 10m`: strong GPS fix

3. `LiveConfiguration` too low/high for use case?
- `.default`: general/battery-balanced
- `.fitness`/`.otherNavigation`: better tracking
- `.automotiveNavigation`: highest accuracy, highest battery

4. Stale timestamp?
- old timestamp or `isStationary` can indicate paused movement state

### Temporary full accuracy (iOS 18+)

```swift
// Requires NSLocationTemporaryUsageDescriptionDictionary key
let session = CLServiceSession(
    authorization: .whenInUse,
    fullAccuracyPurposeKey: "NavigationPurpose"
)
```

## Symptom 5: Geofence Events Not Triggering

### Quick checks

```swift
let monitor = await CLMonitor("MyMonitor")
print("Conditions: \(await monitor.identifiers.count)/20")

if let record = await monitor.record(for: "MyGeofence") {
    print("State: \(record.lastEvent.state)")
    print("Date: \(record.lastEvent.date)")
}
```

### Decision tree

1. At 20-condition limit?
- yes: prioritize/swap dynamically (`conditionLimitExceeded`)

2. Radius < 100m?
- yes: unreliable; increase radius

3. Awaiting `monitor.events`?
- no: events not processed

4. Monitor recreated on launch?
- no: recreate with same name on launch

5. `lastEvent.state` interpretation:
- `.unknown`: undecided yet
- `.satisfied`: currently inside; wait for exit
- `.unsatisfied`: currently outside; wait for entry

6. `lastEvent.accuracyLimited` true?
- reduced accuracy can break geofence reliability

### Event loop requirement

```swift
let monitor = await CLMonitor("App")
await monitor.add(condition, identifier: "Place")

Task {
    for try await event in monitor.events {
        switch event.state {
        case .satisfied: handleEntry(event.identifier)
        case .unsatisfied: handleExit(event.identifier)
        case .unknown: break
        @unknown default: break
        }
    }
}
```

One monitor instance per name; avoid duplicate instances with same identifier.

## Symptom 6: Location Icon Won't Go Away

### Decision tree

1. Still iterating `liveUpdates`?
- yes: cancel task

2. `CLBackgroundActivitySession` retained?
- yes: `invalidate()` and nil it

3. `CLMonitor` conditions still active?
- yes: icon is expected; remove all if done

4. Legacy `CLLocationManager` still running?
- call `stopUpdatingLocation`, stop significant changes/visits/regions

5. Other frameworks requesting location?
- e.g., `MKMapView.showsUserLocation = true`

### Force-stop pattern

```swift
locationTask?.cancel()
backgroundSession?.invalidate()
backgroundSession = nil

for id in await monitor.identifiers {
    await monitor.remove(id)
}

manager.stopUpdatingLocation()
manager.stopMonitoringSignificantLocationChanges()
manager.stopMonitoringVisits()
for region in manager.monitoredRegions {
    manager.stopMonitoring(for: region)
}
```

## Console Diagnostics

```bash
log stream --predicate 'subsystem == "com.apple.locationd"' --level debug
log stream --predicate 'subsystem == "com.apple.CoreLocation"' --level debug
log stream --predicate 'process == "YourAppName" AND subsystem == "com.apple.CoreLocation"'
```

| Log message | Meaning |
|---|---|
| `Client is not authorized` | Authorization missing/denied |
| `Location services disabled` | System toggle off |
| `Accuracy authorization is reduced` | Approximate location mode |
| `Condition limit exceeded` | 20-condition cap reached |
| `Background location access denied` | Missing capability/session |

## Resources

- WWDC: 2023-10180, 2023-10147, 2024-10212
- Docs: `/corelocation`, `/corelocation/clmonitor`, `/corelocation/cllocationupdate`
- Skills: `ios-core-location`, `ios-core-location-ref`, `ios-energy-diag`
