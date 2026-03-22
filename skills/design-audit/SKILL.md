---
name: design-audit
description: Use when reviewing a new or modified user interface before sign-off, or when a UI feels generic, noisy, inaccessible, under-specified, or not yet production-grade.
---

# Design Audit

Audit before sign-off. Findings first. Failures beat praise.

## Required Gates

1. Hierarchy + grouping
   - Clear first/second/third look targets.
   - Spacing, type, contrast, and enclosure point to the same structure.
   - No decorative cards/containers that invent false grouping.

2. Interaction + state coverage
   - Core actions are obvious.
   - Default, hover, focus, active, disabled, loading, empty, error, and success states are covered where relevant.
   - High-frequency actions feel immediate; destructive actions use safer commit timing.

3. Responsive + ergonomic behavior
   - Mobile layout collapses cleanly; no horizontal spill.
   - Tap targets meet platform minimums.
   - Hover-only behavior never gates functionality.

4. Accessibility + semantics
   - Focus visible.
   - Contrast valid for text and controls.
   - Semantic order matches visual hierarchy.
   - Reduced motion and keyboard use are handled.

5. Motion + continuity
   - Motion explains change, preserves source/destination continuity, and stays interruptible.
   - Novelty budget matches interaction frequency.

6. Identity + anti-generic quality
   - Clear aesthetic point of view.
   - No template fingerprints: default gradients, equal-card triplets, untouched library styling, decorative metrics, empty “AI-polish”.
   - One memorable differentiator is present without harming usability.

7. First-screen litmus checks
   - Brand or product is unmistakable in the first screen when applicable.
   - One strong visual anchor exists.
   - Headlines alone reveal the page narrative.
   - Each section has one job.
   - Cards are necessary, not habit.
   - Motion improves hierarchy or atmosphere.
   - The design still works if decorative shadows are removed.

8. Copy-mode correctness
   - Marketing pages: promise, proof, convert.
   - Product UI: orient, status, act.
   - Fail if operational UI uses homepage-style filler or if marketing pages read like unlabeled back-office tooling.

## Severity Order

1. Accessibility blockers
2. Interaction correctness
3. Performance / responsiveness
4. Layout / hierarchy
5. Typography / color system
6. Motion polish
7. Cosmetic polish

## Output Contract

- For reviews: findings only, ordered by severity, with concrete remediation.
- For implementation sign-off: state `pass` or `fail`, then list blockers and residual risks.
- If no issues: say so explicitly and name remaining verification gaps.

## Common Failure Patterns

- Generic SaaS card grid as first impression
- Beautiful hero image with weak brand presence
- Strong headline with no clear action
- Busy imagery behind text
- Repeated sections with the same mood statement
- App UI built from stacked cards instead of layout

## Related Skills

- `design`: establish direction before implementation
- `design-interaction-motion-craft`: motion and gesture reasoning
