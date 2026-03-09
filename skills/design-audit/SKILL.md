---
name: design-audit
description: Use when reviewing or critiquing interface quality (design audits, design critiques, sign-off reviews) across hierarchy, usability, accessibility, responsiveness, and performance.
args:
  - name: area
    description: The feature or area to audit (optional)
    required: false
user-invokable: true
---

## Cross-Platform Applicability
- Treat this skill as interface-principle guidance across web, iOS, Android, and desktop surfaces.
- Translate implementation snippets to platform-native primitives; do not copy web syntax literally into native stacks.


## Related Skills
- [web-design-guidelines](../web-design-guidelines/SKILL.md): standards-oriented UI review
- [design-adapt](../design-adapt/SKILL.md): edge-case remediation
- [design/reference/articles/gestalt-visual-hierarchy.md](../design/reference/articles/gestalt-visual-hierarchy.md): hierarchy/grouping heuristics for audits


Run systematic quality checks and generate a comprehensive audit/critique report with prioritized issues and actionable recommendations. Default review skill for design feedback requests.

**First**: Use the design skill for design principles and anti-patterns.

## Audit Modes

- `Critique mode` (default for requests like "critique", "review design", "what do you think"): holistic design-director feedback plus prioritized issues.
- `Compliance mode` (for sign-off and pre-release checks): stricter gate/WCAG/performance framing.
- `Combined mode` (recommended): run critique first, then compliance checks.

## Required Gate Workflow (Integrated from design-quality-gates)

1. Read active doctrine first (`DESIGN.md` when present).
2. Identify affected surfaces: layout, typography, hierarchy, color, accessibility, interaction/motion.
3. Run all compliance gates below.
4. Mark each gate `pass/fail` with one-line evidence.
5. If a mandatory gate fails: do not sign off; provide concrete remediation or explicit tradeoff request.

## Compliance Gate Matrix (Integrated)

In `Compliance mode` or `Combined mode`, run explicit pass/fail gates with one-line evidence per gate:

1. `Layout + grid`
- Explicit container and breakpoint strategy is defined.
- Alignment is predictable: edges/baselines snap to grid.
- Spacing uses a consistent scale (no ad-hoc values).
- No accidental asymmetry unless it communicates priority.

2. `Typography`
- Typography serves content semantics; decoration never outranks hierarchy.
- Type scale is explicit, limited, and mapped to semantic roles.
- Prose measure is intentional (target `~45-75` characters per line).
- Leading is tuned to rhythm (typical body range `~1.2-1.45`).
- Spacing is systemic (letter/word/line/paragraph), not ad-hoc.
- Proper glyphs only: true quotes/apostrophes/dashes/ellipsis, ligatures/small caps when appropriate.
- No faux styles/distortion: never fake bold/italic/small caps or stretch/compress type.
- Justification/hyphenation settings prevent rivers, ladders, widows, and orphans.

3. `Visual hierarchy`
- One dominant focal point per screen/section.
- Primary action visually unambiguous.
- Scannability: users can identify structure within 5 seconds.
- Decorative emphasis does not compete with semantic emphasis.
- If contrasting aesthetics are used, core invariants remain stable.
- Gestalt cue alignment: proximity/similarity/enclosure do not conflict with intended hierarchy.
- Emphasis ladder is bounded (clear primary/secondary/tertiary tiers).
- Visual hierarchy aligns with semantic hierarchy (heading structure, reading sequence, labels).

4. `Color system`
- Color roles are semantic (primary/success/warning/error/info), not arbitrary.
- State communication is not color-only; shape/text/icon support is present.
- Accent usage is restrained and intentional.
- Contrast is checked before sign-off (not post-hoc).

5. `Accessibility`
- Text contrast at least 4.5:1 (normal), 3:1 (large).
- Non-text UI contrast at least 3:1.
- Touch/pointer targets meet platform minimums.
- For mobile overlays: row targets prefer `>=56px`; trigger/close controls `>=48px`.
- Reading/navigation order matches visual order.
- Zoom/reflow and text-spacing overrides do not break UI.
- Motion respects reduced-motion preferences.

6. `Interaction + motion`
- Transitions communicate causality (what changed and why).
- Gesture-driven feedback starts immediately and tracks user input.
- Repeated interactions use restrained timing; avoid novelty fatigue.
- Motion remains interruptible and reversible when possible.
- Frequency x novelty fit is validated.
- High-risk actions use intent-safe trigger timing.
- Touch/pointer occlusion is assessed for precision interactions.
- Mobile overlays open/close with zero layout shift across repeated toggles.

7. `Navigation overlays` (when applicable)
- Section labels and destination links use distinct hierarchy.
- Section rhythm is explicit; avoid margin-stack drift.
- Focus trap + Escape + backdrop close + focus restore are verified.
- Safe-area insets are applied on top and bottom.

Definition of done for compliance pass:
- no unresolved gate failures
- documented constraints for any accepted deviation
- explicit before/after note for critical fixes
- objective metrics called out explicitly when unverifiable

Red-flag patterns:
- hierarchy collapse (multiple competing primaries)
- contrast debt
- gesture ambiguity for high-risk actions
- figure-ground ambiguity on interactive surfaces
- accessibility added only as late retrofit

## Diagnostic Scan

Run comprehensive checks across multiple dimensions:

1. **Accessibility (A11y)** - Check for:
   - **Contrast issues**: Text contrast ratios < 4.5:1 (or 7:1 for AAA)
   - **Missing ARIA**: Interactive elements without proper roles, labels, or states
   - **Keyboard navigation**: Missing focus indicators, illogical tab order, keyboard traps
   - **Semantic HTML**: Improper heading hierarchy, missing landmarks, divs instead of buttons
   - **Alt text**: Missing or poor image descriptions
   - **Form issues**: Inputs without labels, poor error messaging, missing required indicators

2. **Performance** - Check for:
   - **Layout thrashing**: Reading/writing layout properties in loops
   - **Expensive animations**: Animating layout properties (width, height, top, left) instead of transform/opacity
   - **Missing optimization**: Images without lazy loading, unoptimized assets, missing will-change
   - **Bundle size**: Unnecessary imports, unused dependencies
   - **Render performance**: Unnecessary re-renders, missing memoization

3. **Theming** - Check for:
   - **Hard-coded colors**: Colors not using design tokens
   - **Broken dark mode**: Missing dark mode variants, poor contrast in dark theme
   - **Inconsistent tokens**: Using wrong tokens, mixing token types
   - **Theme switching issues**: Values that don't update on theme change

4. **Responsive Design** - Check for:
   - **Fixed widths**: Hard-coded widths that break on mobile
   - **Touch targets**: Interactive elements < 44x44px
   - **Horizontal scroll**: Content overflow on narrow viewports
   - **Text scaling**: Layouts that break when text size increases
   - **Missing breakpoints**: No mobile/tablet variants

5. **Anti-Patterns (CRITICAL)** - Check against ALL the **DON'T** guidelines in the design skill. Look for AI slop tells (AI color palette, gradient text, glassmorphism, hero metrics, card grids, generic fonts) and general design anti-patterns (gray on color, nested cards, bounce easing, redundant copy).

6. **Gestalt + Visual Hierarchy Integrity** - Check for:
   - **False grouping**: Unrelated elements appear related due to proximity/similarity
   - **Broken grouping**: Related elements split by spacing/enclosure inconsistencies
   - **Cue conflict**: Size/contrast/position/enclosure imply different priority orders
   - **Hierarchy flattening**: Too many high-emphasis elements competing for first attention
   - **Figure-ground ambiguity**: Foreground interactive targets blend into background layers
   - **Semantic mismatch**: Heading/reading order contradicts visual hierarchy

## Critique Lens (Merged from design-critique)

Use this lens in `Critique mode` and `Combined mode`:

1. **Visual Hierarchy**
- Eye flow to primary objective within ~2 seconds
- Priority cues (size/color/position) are coherent, not competing

2. **Information Architecture**
- Grouping and navigation model are intuitive for first-time users
- Choice density is manageable; progressive disclosure is intentional

3. **Emotional Resonance**
- Interface emotion is identifiable and aligned with product intent
- Tone feels appropriate for target user context

4. **Discoverability & Affordance**
- Interactive elements read as interactive without instructions
- Feedback states (hover/focus/active) improve confidence, not noise

5. **Composition & Balance**
- Visual weight is intentional; whitespace supports comprehension
- Rhythm/repetition/asymmetry feel designed, not accidental

6. **Typography as Communication**
- Type hierarchy clearly signals read order
- Text is comfortable to read (measure, spacing, contrast, level separation)

7. **Color with Purpose**
- Color communicates role/state, not decoration only
- Accent usage directs attention to intended actions

8. **States & Edge Cases**
- Empty/loading/error/success states guide next action
- State transitions preserve context and user confidence

9. **Microcopy & Voice**
- Labels/actions are unambiguous
- Voice matches brand and user stress level (especially in errors)

**CRITICAL**: This is an audit, not a fix. Document issues thoroughly with clear explanations of impact. Use other commands (normalize, optimize, adapt, etc.) to fix issues after audit.

## Generate Comprehensive Report

Create a detailed audit report with the following structure:

### Anti-Patterns Verdict
**Start here.** Pass/fail: Does this look AI-generated? List specific tells from the skill's Anti-Patterns section. Be brutally honest.

### Overall Impression
- One concise design-director read: what works, what fails, and largest opportunity.

### Executive Summary
- Total issues found (count by severity)
- Most critical issues (top 3-5)
- Overall quality score (if applicable)
- Recommended next steps

### Detailed Findings by Severity

For each issue, document:
- **Location**: Where the issue occurs (component, file, line)
- **Severity**: Critical / High / Medium / Low
- **Category**: Accessibility / Performance / Theming / Responsive
- **Description**: What the issue is
- **Impact**: How it affects users
- **WCAG/Standard**: Which standard it violates (if applicable)
- **Recommendation**: How to fix it
- **Suggested command**: Which command to use (e.g., `/normalize`, `/optimize`, `/adapt`)

#### Critical Issues
[Issues that block core functionality or violate WCAG A]

#### High-Severity Issues  
[Significant usability/accessibility impact, WCAG AA violations]

#### Medium-Severity Issues
[Quality issues, WCAG AAA violations, performance concerns]

#### Low-Severity Issues
[Minor inconsistencies, optimization opportunities]

### Patterns & Systemic Issues

Identify recurring problems:
- "Hard-coded colors appear in 15+ components, should use design tokens"
- "Touch targets consistently too small (<44px) throughout mobile experience"
- "Missing focus indicators on all custom interactive components"
- "Gestalt cue conflicts repeat across modules (spacing says grouped; styling says unrelated)"
- "Visual hierarchy tiers are inconsistent, creating attention thrash"

### Positive Findings

Note what's working well:
- Good practices to maintain
- Exemplary implementations to replicate elsewhere

### Priority Issues (Critique Synthesis)

List top 3-5 design problems as:
- `What`: concrete design problem
- `Why it matters`: user/task impact
- `Fix direction`: concrete remediation path
- `Suggested command`: `/normalize`, `/polish`, `/adapt`, `/optimize`, etc.

### Recommendations by Priority

Create actionable plan:
1. **Immediate**: Critical blockers to fix first
2. **Short-term**: High-severity issues (this sprint)
3. **Medium-term**: Quality improvements (next sprint)
4. **Long-term**: Nice-to-haves and optimizations

### Suggested Commands for Fixes

Map issues to appropriate commands:
- "Use `/normalize` to align components with design system (addresses 23 theming issues)"
- "Use `/optimize` to improve performance (addresses 12 performance issues)"
- "Use `/adapt` to improve i18n and text handling (addresses 8 edge cases)"

**IMPORTANT**: Be thorough but actionable. Too many low-priority issues creates noise. Focus on what actually matters.

**NEVER**:
- Report issues without explaining impact (why does this matter?)
- Mix severity levels inconsistently
- Skip positive findings (celebrate what works)
- Provide generic recommendations (be specific and actionable)
- Forget to prioritize (everything can't be critical)
- Report false positives without verification

Remember: You're a quality auditor with exceptional attention to detail. Document systematically, prioritize ruthlessly, and provide clear paths to improvement. A good audit makes fixing easy.
