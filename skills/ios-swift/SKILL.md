---
name: ios-swift
description: "Unified Apple-platform Swift skill. Use for Swift/SwiftUI/iOS engineering: concurrency, performance, testing, SwiftData, navigation, animation, gestures, Liquid Glass, AVFoundation audio, camera capture, networking, Core Location, privacy UX, haptics, StoreKit, TextKit, typography, cloud sync, energy, background tasks, deep-link debugging, and UI testing. Includes legacy aliases: avfoundation-ref, background-processing, camera-capture, cloud-sync, core-location, deep-link-debugging, energy, haptics, hig, networking, photo-library, privacy-ux, storekit-ref, swift-concurrency-expert, swift-performance, swift-testing, swiftdata, swiftui-26-ref, swiftui-animation-ref, swiftui-gestures, swiftui-liquid-glass, swiftui-nav, swiftui-performance, swiftui-view-refactor, synchronization, textkit-ref, typography-ref, ui-testing, ios-ux-design, swiftui-expert-skill."
metadata:
  aliases:
    - avfoundation-ref
    - background-processing
    - camera-capture
    - cloud-sync
    - core-location
    - deep-link-debugging
    - energy
    - haptics
    - hig
    - networking
    - photo-library
    - privacy-ux
    - storekit-ref
    - swift-concurrency-expert
    - swift-performance
    - swift-testing
    - swiftdata
    - swiftui-26-ref
    - swiftui-animation-ref
    - swiftui-gestures
    - swiftui-liquid-glass
    - swiftui-nav
    - swiftui-performance
    - swiftui-view-refactor
    - synchronization
    - textkit-ref
    - typography-ref
    - ui-testing
    - ios-ux-design
    - swiftui-expert-skill
---

# iOS + Swift Unified Skill

Single entrypoint for Apple-platform Swift work. This skill consolidates previous Swift/iOS subskills into a routed reference set to reduce top-level skill noise.

## When to Use

Use this skill for any Swift, SwiftUI, or iOS/macOS engineering task, including:

- Architecture or code review for Swift features
- SwiftUI implementation/refactor/performance/navigation
- iOS platform frameworks (AVFoundation, Network, Core Location, PhotoKit, StoreKit, TextKit)
- Reliability domains (background execution, energy, privacy, testing, synchronization)
- iOS UX/HIG reviews and implementation specs

## Routing Workflow

1. Identify the dominant domain from the user request.
2. Open only the mapped reference file(s) from `references/topic-index.md`.
3. Apply fixes/implementation with minimal surface area.
4. Validate with platform-appropriate tests/build commands.
5. For UI/style changes, enforce `<repo-root>/DESIGN.md` in the same task; if missing, create it via `design-system-doc` before implementation.

## Topic Router (Fast Path)

| Request Type | Reference to Load |
|---|---|
| AVFoundation audio pipelines/session | `references/ios-avfoundation-ref.md` |
| Background tasks (`BGTaskScheduler`) | `references/ios-background-processing.md` |
| Camera capture/photo/video | `references/ios-camera-capture.md` |
| Cloud sync/CloudKit/iCloud Drive | `references/ios-cloud-sync.md` |
| Core Location auth/monitoring | `references/ios-core-location.md` |
| Debug-only deep links for simulator/testing | `references/ios-deep-link-debugging.md` |
| Battery/energy diagnosis | `references/ios-energy.md` |
| Haptics/Core Haptics | `references/ios-haptics.md` |
| HIG compliance/Apple design decisions | `references/ios-hig.md` |
| Network.framework patterns | `references/ios-networking.md` |
| Photo picker/library permissions/save flow | `references/ios-photo-library.md` |
| Privacy manifests/ATT/permission UX | `references/ios-privacy-ux.md` |
| StoreKit 2 purchase/subscription flows | `references/ios-storekit-ref.md` |
| Swift concurrency remediation | `references/ios-swift-concurrency-expert.md` |
| Swift language/runtime performance | `references/ios-swift-performance.md` |
| Swift Testing/XCTest migration | `references/ios-swift-testing.md` |
| SwiftData modeling/query/migration | `references/ios-swiftdata.md` |
| SwiftUI iOS 26 feature adoption | `references/ios-swiftui-26-ref.md` |
| SwiftUI animation design/debug | `references/ios-swiftui-animation-ref.md` |
| SwiftUI gestures/composition conflicts | `references/ios-swiftui-gestures.md` |
| SwiftUI Liquid Glass implementation | `references/ios-swiftui-liquid-glass.md` |
| SwiftUI navigation/deep-linking | `references/ios-swiftui-nav.md` |
| SwiftUI rendering/scroll/list perf | `references/ios-swiftui-performance.md` |
| SwiftUI view-structure refactor | `references/ios-swiftui-view-refactor.md` |
| Low-level synchronization primitives | `references/ios-synchronization.md` |
| TextKit 2 and rich text editing | `references/ios-textkit-ref.md` |
| Apple typography and Dynamic Type | `references/ios-typography-ref.md` |
| XCTest UI automation/flakiness | `references/ios-ui-testing.md` |
| iOS UX design review/spec | `references/ios-ux-design.md` |
| General SwiftUI implementation/review | `references/swiftui-expert-skill.md` |

## Multi-Topic Requests

- Prefer one primary reference plus at most two supporting references.
- If task spans UI + platform API + performance, read in this order:
1. `swiftui-expert-skill`
2. API-specific reference
3. performance/concurrency reference

## Notes

- `references/topic-index.md` contains canonical mapping and alias inventory.
- Legacy skills were collapsed intentionally to keep `skills/` top-level smaller and less redundant.
