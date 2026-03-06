---
name: ios-gesture-arbitration-diag
description: Use when a child tap, swipe, long press, or drag conflicts with scrolling or another recognizer inside ScrollView, List, UITableView, UICollectionView, or mixed SwiftUI/UIKit gesture stacks.
---

# iOS Gesture Arbitration Diagnostics

## Overview

Simultaneous recognition is not ownership. Gesture conflicts in scroll containers are usually recognizer-arbitration bugs, not animation or state bugs.

## Use When

- tap inside a scrolling row opens instead of scrolling
- one cell variant scrolls, another steals touches
- `.simultaneousGesture` helped partially or inconsistently
- SwiftUI gesture modifiers live inside `UITableView` / `UICollectionView` / `UIScrollView`
- `UIViewRepresentable` introduces UIKit recognizers into SwiftUI content
- single tap, double tap, long press, and swipe all exist on the same surface

## Do Not Start With

- adding more `.simultaneousGesture` by reflex
- adding `.highPriorityGesture` without an ownership model
- guessing with `minimumDistance` alone
- declaring success from one subview variant or one simulator run

## Decision Tree

```
Gesture conflict?
├─ Pure SwiftUI, no UIKit scroll host
│  ├─ discrete tap -> prefer Button / NavigationLink
│  ├─ continuous drag -> axis-gate with GestureState
│  └─ single + double tap -> keep both in one owner
└─ UIKit scroll host or mixed stack
   ├─ discrete child action -> require child recognizer to fail by parent pan or move recognizer to container
   ├─ reused cells -> prefer recognizer on table/collection container
   └─ still inconsistent -> log ancestor chain and recognizer states, then UI-test the real scroll surface
```

## Core Rules

1. `Button` beats bare `.onTapGesture` for primary actions inside scroll content.
2. `.simultaneousGesture` means “both may run”, not “scroll owns the drag”.
3. If the parent scroll must win, encode that directly with:
   - `require(toFail:)`
   - `gestureRecognizer(_:shouldRequireFailureOf:)`
   - `gestureRecognizer(_:shouldBeRequiredToFailBy:)`
4. If the child horizontal gesture should win only after intent is clear, gate on axis ratio before committing behavior.
5. Keep single and double tap in the same recognizer owner; single tap must require double tap to fail.
6. In collection/table containers, attach container-level recognizers when the interaction is conceptually container-owned.
7. Prefer built-in container behaviors over blanket wrapper gestures; use `scrollDismissesKeyboard` before adding global tap/drag recognizers for keyboard dismissal.

## Recipes

### Scroll-hosted custom tap

- first choice: `Button(...).buttonStyle(.plain)`
- if custom recognizer is still required:
  - host it in `UIViewRepresentable`
  - locate the enclosing scroll view
  - wire the child recognizer against `scrollView.panGestureRecognizer`

### Horizontal swipe in vertical scroll

- delay activation until horizontal intent is dominant
- compare absolute `x` vs `y` translation
- do not trigger business logic on the first few `.onChanged` events

### Reused UIKit container

- do not trust behavior from a single reused cell
- verify ownership after reuse, after image/video variant swaps, and after scrolling away/back

## Verification Protocol

1. Start scroll from every interactive descendant variant.
2. Repeat after reuse and after state changes.
3. Verify single tap, double tap, long press, and swipe ordering.
4. Add unit coverage for recognizer ordering.
5. Add UI coverage when the bug depends on the real scroll surface.

## Apple Sources

- [Handling UIKit gestures](https://developer.apple.com/documentation/uikit/handling-uikit-gestures)
- [Supporting gesture interaction in your apps](https://developer.apple.com/documentation/uikit/supporting-gesture-interaction-in-your-apps)
- [Preferring one gesture over another](https://developer.apple.com/documentation/uikit/preferring-one-gesture-over-another)
- [Allowing the simultaneous recognition of multiple gestures](https://developer.apple.com/documentation/uikit/allowing-the-simultaneous-recognition-of-multiple-gestures)
- [UIGestureRecognizerDelegate](https://developer.apple.com/documentation/uikit/uigesturerecognizerdelegate)
- [Gestures — Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/gestures)
- [Incorporating Gesture Support](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/IncorporatingGestureSupport/IncorporatingGestureSupport.html)

## Cross-links

- Pair with `ios-swiftui-gestures` for pure SwiftUI composition mechanics.
- Pair with `ios-swiftui-debugging-diag` when recognizers fire but rendering/state still looks wrong.
- Pair with `ios-swiftui-layout` when hit regions, coordinate spaces, or container shape are suspect.
- Pair with `ios-swiftui-nav` when navigation taps and long presses coexist.
- Pair with `ios-xctest-automation` or `ios-ui-testing` for regression coverage.
- Pair with `ios-accessibility-diag` to provide non-gesture alternatives.
