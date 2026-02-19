---
name: design-system-doc
description: Maintain and enforce a repo-root DESIGN.md as a living, platform-agnostic design doctrine. Use for UI/design implementation or review tasks across web and Apple platforms (iOS/macOS) to keep language, aesthetic rules, and interaction principles consistent with current state.
metadata:
  short-description: Principle-led DESIGN.md governance
---

# Design System Doc

Use this skill whenever work touches UI, visual design, theming, motion, layout, component variants, or brand expression on any platform.

## Objective

Keep `<repo-root>/DESIGN.md` as the authoritative present-state design doctrine: language, style, interaction character, and system-level constraints across platforms.

## Required Workflow

1. Resolve repository root and open `DESIGN.md`.
2. If missing: create a concise doctrine-style `DESIGN.md` focused on principles and aesthetic rules.
3. Read current constraints before editing UI code: design language, hierarchy, motion posture, accessibility baseline, and platform expression.
4. Implement with strict adherence to documented system rules.
5. If divergence is required, update the doctrine directly (current state), preferring reusable rules over one-off exceptions.
6. Update `DESIGN.md` in the same task:
   - changed principles/language/aesthetic constraints
   - changed semantic token intent or interaction posture
   - per-platform expression updates (`web`, `ios`, optional `macos`)
   - remove stale implementation-specific detail that does not define durable system rules
7. In delivery notes, reference what was enforced and what was updated in `DESIGN.md`.

## Enforcement Rules

- Keep `DESIGN.md` designer-authored in tone: normative, concise, and principle-led.
- Avoid decision logs, rationale trails, ticket references, and per-feature implementation diaries.
- Avoid overly granular component inventories unless they describe reusable system primitives.
- Preserve established design language/vibe unless a rebrand is explicitly requested.
- Record accessibility implications per platform (for example WCAG contrast/focus for web, Dynamic Type/VoiceOver/reduced motion for iOS).
- Keep semantics stable: one visual cue should map to one meaning.
- Keep `DESIGN.md` concise and scannable; short sections and rule lists over long narrative.

## File Convention

- Canonical path: `<repo-root>/DESIGN.md`
- Prefer stable headings (for example scope, language, principles, accessibility, governance) for diff clarity.
- If a platform is not in scope, mark it as `N/A`.

## Output Contract

- For implementation tasks: deliver code changes + `DESIGN.md` updates together.
- For review tasks: deliver findings + concrete `DESIGN.md` patch suggestions.

## Local Cross-References

- `ios-hig` - Use for fast HIG-aligned decisions while editing UI and design tokens.
- `ios-hig-ref` - Use for detailed guideline lookups backing durable DESIGN.md updates.
- `ios-liquid-glass` - Use when introducing or refining iOS 26 material behaviors in the design system.
- `ios-swiftui-layout` - Use when layout constraints should become documented system-level rules.
- `ios-typography-ref` - Use for type hierarchy and Dynamic Type standards in DESIGN.md.
- `ios-sf-symbols` - Use for iconography policy and symbol behavior consistency.
