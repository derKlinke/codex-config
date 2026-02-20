---
name: algorithmic-art
description: Creating algorithmic art using p5.js with seeded randomness and interactive parameter exploration. Use this when users request creating art using code, generative art, algorithmic art, flow fields, or particle systems. Create original algorithmic art rather than copying existing artists' work to avoid copyright violations.
license: Complete terms in LICENSE.txt
---

Create algorithmic art in two phases:
1. Algorithmic philosophy (`.md`)
2. p5.js implementation (`.html` artifact with inline JS)

Output artifacts: `.md` philosophy + `.html` viewer; algorithm code may also be emitted as `.js` when explicitly requested.

Process-first rule: beauty must emerge from execution, not static composition.

## 1) Algorithmic Philosophy (Required)

Produce a movement-style philosophy, not a static template.

### Requirements

- Name: 1-2 words.
- Length: 4-6 paragraphs.
- Focus: computational process, emergence, seeded variation, field/particle/force logic, parametric control.
- Include all of:
  - computational/mathematical relationships,
  - noise/randomness behavior,
  - temporal/system evolution,
  - emergent complexity.
- Avoid redundancy; each concept should add new information.
- Repeatedly emphasize craftsmanship and refinement (must feel master-level, meticulously tuned, deeply optimized).
- Keep creative room for implementation choices.

### Core framing

- User input is a subtle seed, not a hard constraint.
- Philosophy defines the computational worldview.
- Implementation must be ~90% generative process, ~10% essential controls.

## 2) Deduce Conceptual Seed (Required)

Before coding, infer a subtle conceptual thread from the request.

- Reference must be embedded in behavior/parameters/emergence, not explicit illustration.
- It should reward informed viewers while remaining strong for general viewers.
- Keep it refined, quiet, and integrated into algorithmic structure.

## 3) Implementation (p5.js)

Use the generated philosophy and conceptual seed as the sole design basis.

### Step 0: template first (mandatory)

Before writing HTML, you must:
1. Read `templates/viewer.html`.
2. Use it as the literal starting point.
3. Keep fixed sections exactly.
4. Replace only marked variable sections.

#### Fixed (must remain)

- Layout shell (header/sidebar/main)
- Anthropic branding (fonts/colors/gradient)
- Seed controls section (display, prev/next/random/jump)
- Actions section (Regenerate, Reset, Download PNG)

#### Variable (must customize)

- Entire p5.js algorithm
- Parameter model and control set
- Parameter names/ranges/control types
- Optional color controls

### Do / Don’t

- ✅ Build from template.
- ✅ Keep seed + action UX structure.
- ✅ Express philosophy through algorithm, not pattern copying.
- ❌ Do not create HTML from scratch.
- ❌ Do not alter fixed shell/branding/sidebar structure.
- ❌ Do not copy existing artists' work.

## Technical Requirements

### Seeded randomness (required)

```javascript
let seed = 12345;
randomSeed(seed);
noiseSeed(seed);
```

Same seed must always produce identical output.

### Parameter architecture (required)

Define tunable system properties (quantity, scale, probability, ratio, angle, threshold) derived from philosophy.

```javascript
let params = {
  seed: 12345,
  // algorithm-specific controls
};
```

### Algorithm derivation (required)

Choose mechanics from philosophy intent:
- organic emergence: accumulation, constraints, feedback,
- mathematical beauty: geometry, harmonic relations, precise transforms,
- controlled chaos: bounded randomness, bifurcation, phase shifts.

Rule: algorithm follows philosophy; never pick from a generic pattern menu.

### Canvas baseline

```javascript
function setup() {
  createCanvas(1200, 1200);
}

function draw() {
  // generative system
}
```

## Craftsmanship Bar (mandatory)

Algorithm must read as expert work: tuned, intentional, balanced.

Required quality traits:
- complexity without visual noise,
- coherent palette logic,
- compositional hierarchy despite stochasticity,
- real-time-safe performance (if animated),
- strict reproducibility.

## Output Format

Deliver:
1. Algorithmic philosophy (`.md` or markdown block)
2. Single self-contained `.html` artifact built from `templates/viewer.html`

The HTML must run immediately in Codex artifacts or any browser.

## Artifact Requirements

### Parameter controls
- sliders/inputs for numeric parameters,
- color pickers when relevant,
- live updates,
- reset to defaults.

### Seed navigation
- current seed display,
- prev/next/random/jump,
- optional presets/gallery mode when requested,
- when user requests 100 variations, provide seed coverage for `1...100` in the same artifact workflow.

### Single-file constraint

- Inline CSS + JS.
- Only allowed external dependency: p5.js CDN.
- No additional files/imports/runtime setup.

## Sidebar Contract

1. Seed: fixed structure and behavior.
2. Parameters: variable controls matching algorithm.
3. Colors: optional, only if needed.
4. Actions: fixed controls and behavior.

All controls must function.

## Creative Workflow

User intent → philosophy → algorithm → parameters → controls.

Constants:
- template shell/branding,
- seed navigation,
- self-contained artifact.

Variables:
- algorithm,
- parameter system,
- control design,
- visual output.

## Resources

- `templates/viewer.html` (required base)
  - Keep shell/branding/seed/actions unchanged.
  - Replace algorithm + parameter sections only.
- `templates/generator_template.js` (reference)
  - Use for structure and seeded-randomness practices.
  - Do not treat as a pattern library to copy.
