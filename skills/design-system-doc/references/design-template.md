# DESIGN.md

> Living design system documentation. Platform-agnostic (web + iOS/macOS as applicable). Update in every task that changes UI or visual behavior.

## Platform Scope

- In scope: `web`, `ios`, `macos`
- Out of scope / N/A:

## Product Vibe

- Keywords:
- Emotional target:
- Anti-goals:

## Design Principles

1. Principle:
2. Principle:
3. Principle:

## Tokens

### Color System

| Semantic Token | Meaning | Web Mapping | iOS Mapping | macOS Mapping |
| --- | --- | --- | --- | --- |
| `color.surface.background` | Primary background | `--color-surface-bg` | `Color("surfaceBackground")` | `Color("surfaceBackground")` |
| `color.text.primary` | Primary text | `--color-text-primary` | `Color("textPrimary")` | `Color("textPrimary")` |

### Typography

| Semantic Token / Style | Web Mapping | iOS Mapping | macOS Mapping | Usage |
| --- | --- | --- | --- | --- |
| `type.body.default` | `font: var(--font-body)` | `.body` | `.body` | Body copy |
| `type.title.primary` | `font: var(--font-title)` | `.title2` | `.title2` | Section titles |

### Spacing / Radius / Elevation

| Semantic Token | Web Mapping | iOS Mapping | macOS Mapping | Usage |
| --- | --- | --- | --- | --- |
| `space.2` | `8px` / `var(--space-2)` | `8` pt | `8` pt | Tight gaps |
| `radius.md` | `12px` / `var(--radius-md)` | `12` pt corner radius | `12` pt corner radius | Cards/buttons |

### Motion

| Semantic Token | Web Mapping | iOS Mapping | macOS Mapping | Usage |
| --- | --- | --- | --- | --- |
| `motion.duration.fast` | `120ms` | `0.12s` | `0.12s` | Micro transitions |
| `motion.curve.standard` | `cubic-bezier(0.2,0,0,1)` | `.easeInOut` (or spring spec) | `.easeInOut` | Standard motion |

## Component System

### Component Inventory

| Component | Variants | States | Web Implementation | iOS Implementation | Notes |
| --- | --- | --- | --- | --- | --- |
| Button | `primary`, `secondary` | default, pressed, disabled, focus | `Button` + CSS classes | SwiftUI `ButtonStyle` variants | Keep semantic parity |
| Input / TextField | `text`, `search` | default, focused, error, disabled | `<input>` / component wrapper | SwiftUI `TextField` style | Error style parity |

### Usage Rules

- Do:
- Avoid:

## Accessibility Baselines

- Web contrast target: WCAG 2.2 AA minimum.
- Apple contrast target: support Increased Contrast and semantic color adaptation.
- Min interactive target: web `44x44 px`, iOS/macOS pointer/touch-appropriate minimum (`44x44 pt` on iOS).
- Typography scaling: responsive type on web; Dynamic Type support on iOS.
- Assistive tech: keyboard/focus-visible on web; VoiceOver labels/hints and rotor-friendly structure on iOS.
- Reduced motion support: web `prefers-reduced-motion`; iOS Reduce Motion accommodations.

## Decision Log

| Date (YYYY-MM-DD) | Decision | Rationale | Platform Impact | Affected Surfaces |
| --- | --- | --- | --- | --- |

## References

- Figma:
- Code (web):
- Code (ios):
- Code (macos):
- External:
