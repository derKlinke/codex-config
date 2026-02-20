---
name: design-quality-gates
description: Use when any task includes UI or visual design decisions (layout, grids, typography, color, visual hierarchy, motion, accessibility), before implementation, critique, or sign-off.
---

# Design Quality Gates

## Overview

Convert design decisions from taste-led to constraint-led. Apply measurable gates to every design task and block sign-off until all mandatory gates pass.

## Mandatory Use

- Use for every design-related task: web, iOS, macOS, marketing pages, app UI, component libraries.
- Pair with domain skills (`design-system-doc`, `interface-design`, `frontend-design`, `ios-hig`) instead of replacing them.
- If a gate fails, do not finalize. Propose concrete remediation.

## Workflow

1. Read active design doctrine (`DESIGN.md` if present).
2. Identify task surface: layout, typography, hierarchy, color, accessibility, motion.
3. Run all gate checks below.
4. Mark pass/fail per gate with one-line evidence.
5. Fix failures or explicitly request user tradeoff approval.

## Gate Checks (Required)

### 1) Layout + Grid
- Explicit container and breakpoint strategy defined.
- Predictable alignment: edges/baselines snap to grid.
- Spacing uses a consistent scale (no ad-hoc values).
- No accidental asymmetry unless it communicates priority.

### 2) Typography
- Type scale is explicit and limited.
- Body line length and line-height tuned for sustained reading.
- Headings reflect information hierarchy, not decoration.
- Font usage is constrained; avoid unnecessary families/weights.

### 3) Visual Hierarchy
- One dominant focal point per screen/section.
- Primary action visually unambiguous.
- Scannability: user can identify structure within 5 seconds.
- Decorative emphasis does not compete with semantic emphasis.

### 4) Color System
- Color roles are semantic (primary/success/warning/error/info), not arbitrary.
- State communication is not color-only; shape/text/icon support present.
- Accent usage is restrained and intentional.
- Contrast checked before sign-off (not post-hoc).

### 5) Accessibility
- Text contrast: at least 4.5:1 (normal), 3:1 (large).
- Non-text UI contrast: at least 3:1.
- Touch/pointer targets meet platform minimums.
- Reading/navigation order matches visual order.
- Zoom/reflow and text-spacing overrides do not break UI.
- Motion respects reduced-motion preferences.

### 6) Interaction + Motion
- Transitions communicate causality (what changed and why).
- Gesture-driven feedback starts immediately and tracks user input.
- Repeated interactions use restrained timing; avoid novelty fatigue.
- Motion remains interruptible and reversible when possible.
- Apply `interaction-motion-craft` for principle-level review.

## Definition of Done

- No unresolved gate failures.
- Constraints documented when deviating from doctrine.
- Final notes include: failed-before-fixed gates and resulting design delta.

## Red Flags (Amateur Patterns)

- Grid drift: near-aligned but inconsistent edges.
- Type drift: too many one-off sizes/weights.
- Contrast debt: unreadable low-contrast text/buttons.
- Hierarchy collapse: multiple competing "primary" elements.
- Color drift: decorative palette with no semantic mapping.
- Accessibility retrofit late in cycle.

## Output Contract

- For implementation tasks: include concise gate pass/fail summary with fixes applied.
- For review tasks: findings ordered by severity with concrete remediation.
- If objective metrics were not verifiable, state that explicitly.

## Related Skills

- `design-system-doc` - source of durable design doctrine (`DESIGN.md`) that these gates enforce.
- `web-design-guidelines` - use for detailed WCAG/web interface audits after gate failures.
- `ios-hig` - use for Apple-platform-native interaction and accessibility constraints.
- `interaction-motion-craft` - interaction behavior and animation craft principles for motion/transition quality.
