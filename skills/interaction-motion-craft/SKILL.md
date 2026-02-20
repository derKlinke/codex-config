---
name: interaction-motion-craft
description: Use when designing or reviewing transitions, gestures, state-change animations, micro-interactions, scroll-linked motion, or interaction feedback across web/iOS/macOS.
---

# Interaction Motion Craft

## Overview

Apply interaction and animation craft as a behavior system, not decoration. Motion must communicate causality, preserve context, and stay interruptible under real usage frequency.

## Mandatory Use Cases

- Navigation transitions, modal/sheet presentations, list reordering, drag/gesture UI.
- Loading/skeleton/progress states, success/error confirmation, hover/focus feedback.
- Any request containing animation polish, interaction feel, delight, fluidity, snappiness.

## Workflow (Required)

1. Define event chain: `trigger -> transition -> resulting state`.
2. Declare intent per motion segment: orient, emphasize, confirm, warn, or defer.
3. Decide coupling: real-time (`during gesture`) vs commit-time (`on release`).
4. Select principle set (below) and reject non-functional animation.
5. Validate interruptibility, reduced-motion behavior, and performance budget.

## Core Interaction Rules

- Motion must explain what changed and why.
- Gesture-linked feedback should start immediately and follow input direction/velocity.
- Prefer reversible transitions; avoid locking users into long non-interruptible sequences.
- Maintain object constancy: source and destination should be visually traceable.
- Repetition penalty: high-frequency interactions require subtle motion; novelty decays fast.
- System coherence: one motion language across product (easing, duration, spatial direction).

## Timing + Frequency Budget

- Interaction response onset: immediate perceptual feedback (target <=100ms).
- Micro interactions: typically 120-220ms.
- Structural transitions (screen/sheet/context shifts): typically 220-450ms.
- Repeated interactions (tab change, like, toggle): stay on the lower end.
- One-time onboarding/celebratory moments: may run longer if skippable and rare.

## 12 Animation Principles -> UI Translation

- `Squash/Stretch`: communicate state elasticity (press, drag resistance) without breaking readability.
- `Anticipation`: pre-cue significant movement (small pre-motion before large change).
- `Staging`: isolate primary action; suppress competing motion.
- `Straight Ahead/Pose-to-Pose`: key-state-first for UI transitions; avoid uncontrolled frame drift.
- `Follow-through/Overlap`: secondary elements settle after primary object for realism.
- `Slow In/Out`: ease-in/ease-out for natural acceleration curves.
- `Arcs`: prefer curved trajectories for floating objects and gesture-driven movement.
- `Secondary Action`: add supportive detail only if primary action remains clear.
- `Timing`: duration communicates weight/importance.
- `Exaggeration`: use sparingly for feedback clarity, not spectacle.
- `Solid Drawing`: preserve believable volume/depth cues in 2D/3D transforms.
- `Appeal`: motion style aligned with brand/product character.

## Failure Modes (Blockers)

- Delayed response after input (UI feels disconnected).
- Decorative motion with no semantic payload.
- Mismatched easing/duration across components.
- Uninterruptible long transitions.
- Motion that obscures hierarchy or causes tracking loss.
- No reduced-motion fallback.

## Output Contract

- For implementation tasks: include `intent map`, selected principles, and timing rationale.
- For reviews: list failures by severity and provide direct remediation.
- Always state reduced-motion handling.

## Related Skills

- `design-system-doc` - align motion language with repo-level design doctrine.
- `design-quality-gates` - objective sign-off gates for complete design quality.
- `interface-design` - product-specific UI structure and tone selection.
- `frontend-design` - high-fidelity frontend implementation once motion rules are set.
- `ios-swiftui-animation-ref` - Apple-platform API and implementation detail lookup.

## Source Basis

- https://rauno.me/craft/interaction-design
- https://www.userinterface.wiki/12-principles-of-animation
