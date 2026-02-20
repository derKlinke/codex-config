---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, or applications. Generates creative, polished code that avoids generic AI aesthetics.
license: Complete terms in LICENSE.txt
---

This skill guides creation of distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details and creative choices.

The user provides frontend requirements: a component, page, application, or interface to build. They may include context about the purpose, audience, or technical constraints.

## Project Design Memory (Required)

Before proposing or implementing UI styles:

1. Check `<repo-root>/DESIGN.md`.
2. If present, treat it as the design system source of truth (tokens, typography, component rules, vibe).
3. If missing and task includes UI/design work, create it via the `design-system-doc` skill template and align implementation to it.
4. After significant design changes, update `DESIGN.md` in the same task.

## Design Thinking

Before coding, understand the context and commit to a BOLD aesthetic direction:

- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick an extreme: brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, etc. There are so many flavors to choose from. Use these for inspiration but design one that is true to the aesthetic direction.
- **Constraints**: Technical requirements (framework, performance, accessibility).
- **Differentiation**: What makes this UNFORGETTABLE? What's the one thing someone will remember?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work - the key is intentionality, not intensity.

Then implement working code (HTML/CSS/JS, React, Vue, etc.) that is:

- Production-grade and functional
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view
- Meticulously refined in every detail

## Frontend Aesthetics Guidelines

Focus on:

- **Typography**: Default to system fonts or Helvetica Neue unless the repository design system specifies otherwise. Introduce custom type only with product-specific rationale and intentional display/body pairing.
- **Color & Theme**: Commit to a cohesive aesthetic. Use CSS variables for consistency. Dominant colors with sharp accents outperform timid, evenly-distributed palettes.
- **Motion**: Use animations for effects and micro-interactions. Prioritize CSS-only solutions for HTML. Use Motion library for React when available. Focus on high-impact moments: one well-orchestrated page load with staggered reveals (animation-delay) creates more delight than scattered micro-interactions. Use scroll-triggering and hover states that surprise. Before finalizing, apply `design-interaction-motion-craft` to validate intent, interruptibility, and timing discipline.
- **Spatial Composition**: Unexpected layouts. Asymmetry. Overlap. Diagonal flow. Grid-breaking elements. Generous negative space OR controlled density.
- **Backgrounds & Visual Details**: Create atmosphere and depth rather than defaulting to solid colors. Add contextual effects and textures that match the overall aesthetic. Apply creative forms like gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, custom cursors, and grain overlays.

## Typography Protocol (Bringhurst Baseline)

Apply these checks to any reading-heavy region (hero copy, article, docs, dense feature explanations):

- Semantics first: heading/eyebrow/body/caption roles map to content structure, not decoration.
- Measure: sustained prose targets `~45-75` characters/line.
- Leading: sustained body copy typically `~1.2-1.45`; tune by typeface x-height and weight.
- Texture: keep paragraph color even; avoid abrupt tracking/weight swings without semantic reason.
- Glyph integrity: use true quotes/apostrophes/dashes/ellipsis; enable ligatures/small caps only when typeface supports them.
- Ban typographic fakes: no faux bold/italic/small caps; no horizontal/vertical scaling of glyphs.
- Line-break quality: avoid widows/orphans and severe rivers/ladders (especially in justified copy).

## Mobile Nav Overlay Baseline (Web)

Use this baseline whenever a mobile full-screen menu/sheet/overlay is implemented or polished.

- **Target sizes**: hard floor `44x44`; prefer `>=56px` for primary nav rows; trigger/close controls `>=48px`.
- **Type hierarchy**: section labels use compact uppercase meta scale; link rows use body-size or larger. Do not use identical scales for both.
- **Rhythm**: section spacing must be explicit; avoid stacked ad-hoc margins; use subtle separators when lists are dense.
- **Link styling**: avoid default underlines in overlay nav rows; active state should include a clear structural cue (for example background + leading accent), not color/weight only.
- **Modal behavior**: trap focus, close via Escape + backdrop + navigation tap, restore trigger focus, and set non-dialog regions inert.
- **No layout shift rule**: opening/closing overlay must not move the underlying page position; avoid `position: fixed` body lock patterns that cause jump on close.
- **Safe areas**: include `env(safe-area-inset-top)` and `env(safe-area-inset-bottom)` in overlay paddings.
- **Motion envelope**: backdrop ~`120-160ms`; content ~`200-240ms`; short stagger only; disable non-essential motion for reduced-motion users.
- **QA pass**: verify smallest mobile viewport + one large phone viewport; explicitly test repeated open/close for zero jump and stable header baseline.

NEVER use generic AI-generated aesthetics like overused font families (Inter, Roboto, Arial), cliched color schemes (particularly purple gradients on white backgrounds), predictable layouts and component patterns, and cookie-cutter design that lacks context-specific character.

Interpret creatively and make unexpected choices that feel genuinely designed for the context. Across different projects, avoid converging on repetitive aesthetics; within the same project, keep palette and typography consistent with the established design system.

**IMPORTANT**: Match implementation complexity to the aesthetic vision. Maximalist designs need elaborate code with extensive animations and effects. Minimalist or refined designs need restraint, precision, and careful attention to spacing, typography, and subtle details. Elegance comes from executing the vision well.

Remember: Codex is capable of extraordinary creative work. Don't hold back, show what can truly be created when thinking outside the box and committing fully to a distinctive vision.

## Related Skills

- `design-system-doc` - enforce/update durable doctrine (`DESIGN.md`) after nav behavior/token changes.
- `design-quality-gates` - objective sign-off checks (including target size, spacing rhythm, and accessibility).
- `design-interaction-motion-craft` - motion timing, causality, and reduced-motion review for overlays/transitions.
