# Rauno - Interaction Design (Distilled, Full Article)

- Source: https://rauno.me/craft/interaction-design
- Date read: 2026-03-09
- Scope: full article (metaphors, kinetic physics, swipe triggers, responsiveness, spatial continuity, morphing, frequency/novelty, fidgetability, scroll landmarks, touch visibility, implicit input, Fitts's law)

## Section-Level Reusable Learnings

### 1) Metaphors
- Reuse familiar physical metaphors (layers, cards, pages, grabbing/precision).
- Learning compounds when one gesture metaphor unlocks many surfaces.
- Form-only elegance is insufficient; interaction must support task completion.

### 2) Kinetic Physics
- Motion should preserve perceived momentum and direction.
- Small physical irregularities can increase naturalness versus perfectly uniform timing/centering.

### 3) Swipe Gesture Triggering
- Trigger-during-gesture works for lightweight/reversible outcomes.
- Trigger-on-gesture-end is safer for destructive/high-risk actions.
- Threshold policy is about intent confidence, not only movement distance.

### 4) Responsive Gestures
- Even with thresholds, users need immediate coupled feedback from the first movement.
- Pure threshold-gated 0->1 animations feel unresponsive and reduce affordance confidence.

### 5) Spatial Consistency
- Entry/exit motion should communicate source and destination relationships.
- Transition direction can encode stack position and object provenance.

### 6) Fluid Morphing
- Morph quality depends on asset constraints (safe zones, geometry assumptions).
- System-level effects can degrade when inputs violate format assumptions.

### 7) Frequency & Novelty
- High-frequency interactions should minimize novelty and animation overhead.
- Low-frequency/high-significance moments can carry expressive motion.
- Perceived speed can improve by removing "pleasant" motion from core loops.

### 8) Fidgetability
- Some repeated micro-interactions can be intentionally satisfying beyond utility.
- Fidget affordances should not interfere with primary tasks.

### 9) Scroll Landmarks
- Long-form navigation benefits from reversible position landmarks.
- Fast-return mechanisms reduce navigation anxiety and context loss.

### 10) Touch Content Visibility
- Touch can occlude critical content; temporary reveal/magnification patterns help precision.
- Drag interactions should preserve control continuity even when pointer/finger leaves thin controls.

### 11) Implicit Input
- Context can be treated as input (state inference without explicit user commands).
- Implicit behavior must include safety/privacy guards and predictable boundaries.

### 12) Fitts's Law
- Target acquisition time follows distance/size tradeoffs; primary controls should reflect this.

## Cross-Section Synthesis

1. Intent first: choose trigger timing and coupling based on reversibility/risk.
2. Responsiveness first: immediate feedback outranks decorative smoothness.
3. Repetition-aware craft: evaluate interactions at realistic daily usage frequency.
4. Continuity first: transitions should preserve source/destination legibility.
5. Ergonomics first: respect occlusion, targeting, and error-recovery paths.

## Skill Mapping

- `design-interaction-motion-craft`: trigger timing by risk, immediate-coupling rules, continuity checks, repetition-aware novelty budget.
- `design-audit`: pass/fail checks for high-frequency novelty overuse, occlusion handling, and intent-safe trigger policies.
- `design`: interaction guidelines for metaphor consistency, occlusion compensation, and contrast of expressive vs utility motion.
