---
name: ios-swiftui-pro
description: Use when implementing, reviewing, refactoring, or debugging SwiftUI apps on Apple platforms, including architecture, state/data flow, layout, navigation, gestures, animation, search, performance, and iOS 26 APIs.
---

# iOS SwiftUI Pro

Canonical SwiftUI skill for Apple platforms. This skill replaces overlapping `ios-swiftui-*` specialist skills with one routing layer plus deep references.

## When to Use

- Any SwiftUI implementation/review task.
- SwiftUI runtime bugs (state, rendering, navigation, gesture, layout, search).
- SwiftUI architecture/refactor decisions.
- SwiftUI performance diagnostics with Instruments.
- SwiftUI iOS 26 API adoption.

## When Not to Use

- UIKit-only tasks without SwiftUI surface.
- Platform domain tasks with dedicated specialist skills (for example StoreKit, Core Data, Network.framework, CloudKit, Core ML).

## Invocation Routing (Mandatory)

Load only relevant references for the request:

1. API modernization and deprecation checks: `references/api.md`
1. View composition/modifier correctness: `references/views.md`
1. State/data flow/property wrappers: `references/data.md`
1. Navigation correctness: `references/navigation.md` plus `references/deep/navigation.md`
1. Accessibility/HIG compliance: `references/accessibility.md` and `references/design.md`
1. Performance profiling/optimization: `references/performance.md` plus `references/deep/performance.md`
1. Swift language/concurrency hygiene: `references/swift.md`
1. General maintainability pass: `references/hygiene.md`

For deeper issue classes, load deep references:

- Architecture: `references/deep/architecture.md`
- Debugging (basic/systematic): `references/deep/debugging.md`, `references/deep/debugging-diag.md`
- Layout and adaptive APIs: `references/deep/layout.md`, `references/deep/layout-ref.md`, `references/deep/containers.md`
- Navigation deep-link/state restoration/tabs: `references/deep/navigation.md`, `references/deep/navigation-diag.md`, `references/deep/navigation-ref.md`
- Gestures: `references/deep/gestures.md`
- Search: `references/deep/search.md`
- Animation: `references/deep/animation.md`
- iOS 26 additions: `references/deep/ios26.md`

## Core Protocol

- iOS 26 default baseline for new work unless project constraints say otherwise.
- Swift 6.2+ patterns and strict concurrency expectations.
- Prefer pure SwiftUI; use UIKit interop only when required by platform/API constraints.
- No third-party dependency introduction without explicit user approval.
- Root-cause fixes only; no symptom masking or speculative guard-rail inflation.
- Keep solutions explicit, testable, and minimal in branching complexity.

## Review / Implementation Pass

1. Map task to routing categories above; load minimal references.
1. Verify correctness and modern API usage first.
1. Verify data flow and actor isolation.
1. Verify navigation/search/gesture/layout invariants for the active feature.
1. Verify accessibility and HIG compliance.
1. Verify performance risk (body churn, identity churn, expensive recomputation).
1. Verify compile-time hygiene and maintainability.
1. Report only high-signal findings and concrete fixes.

## Output Contract

- Organize findings by file and line.
- For each finding: violated rule, impact, minimal fix.
- No speculative/nitpicky feedback.
- Prioritize by user impact and regression risk.

## Skill Consolidation Note

- `ios-swiftui-pro` is the canonical SwiftUI skill name.
- No alias skill directories should exist for retired SwiftUI-overlap skills.
