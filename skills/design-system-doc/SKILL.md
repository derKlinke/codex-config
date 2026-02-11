---
name: design-system-doc
description: Maintain and enforce a repo-root DESIGN.md as living, platform-agnostic design system documentation. Use for UI/design implementation or review tasks across web and Apple platforms (iOS/macOS) to keep tokens and component rules consistent with current state.
metadata:
  short-description: Current-state DESIGN.md governance
---

# Design System Doc

Use this skill whenever work touches UI, visual design, theming, motion, layout, component variants, or brand expression on any platform.

## Objective

Keep `<repo-root>/DESIGN.md` as the operational single source of truth for current design system constraints across platforms.

## Required Workflow

1. Resolve repository root and open `DESIGN.md`.
2. If missing: create from `references/design-template.md`, then tailor to project context.
3. Read current constraints before editing UI code: tokens, typography, spacing/radius, motion, component rules, vibe, and platform mappings.
4. Implement changes with strict adherence to documented tokens/components.
5. If divergence is required, update the system spec directly (current state), and prefer system-level updates over one-off overrides.
6. Update `DESIGN.md` in the same task:
   - changed tokens/styles/components
   - per-platform mappings (`web`, `ios`, optional `macos`)
   - affected screens/surfaces (current coverage)
   - remove/replace stale statements so file reflects only what is true now
7. In delivery notes, reference what was enforced and what was updated in `DESIGN.md`.

## Enforcement Rules

- Avoid introducing raw color/spacing/typography values when tokens exist.
- Avoid undocumented component variants, states, or interaction patterns.
- Preserve established style/vibe unless user requests a rebrand.
- Record accessibility implications per platform (e.g., WCAG contrast/focus for web, Dynamic Type/VoiceOver/reduced motion for iOS).
- Require explicit mapping for each core token/component to target platform implementations (e.g., CSS vars/classes, SwiftUI `Color`/`Font`/tokens).
- Keep `DESIGN.md` concise and scannable; favor tables/checklists over long prose.
- `DESIGN.md` is present-state authoritative spec: no changelog, no decision log, no historical timeline.

## File Convention

- Canonical path: `<repo-root>/DESIGN.md`
- Bootstrap source: `references/design-template.md`
- Keep section names stable to preserve diff readability over time.
- If a platform is not in scope, mark mapping as `N/A` rather than removing structure.

## Output Contract

- For implementation tasks: deliver code changes + `DESIGN.md` updates together.
- For review tasks: deliver findings + concrete `DESIGN.md` patch suggestions.
