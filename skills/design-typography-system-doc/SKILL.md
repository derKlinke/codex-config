---
name: design-typography-system-doc
description: Use when defining, refactoring, or auditing a strict project typography system with mathematical ratios and canonical role rules, and when creating/updating repo-root TYPO.md.
---

# Typography System Doc

Create and maintain a strict, tokenized typography doctrine in `<repo-root>/TYPO.md`.

## Mandatory Pairing

- Run with `design-quality-gates` for pass/fail validation.
- Run with `design-system-doc` when typography changes also affect broader design doctrine.

## Output Artifacts

- Required: `<repo-root>/TYPO.md` (canonical typography spec)
- Optional: token map updates in code (`--type-*`, `--space-*`, design tokens)

## Role Set (Minimum)

Use exactly these baseline semantic roles unless product scope requires more:

- `h1` (page/section primary heading)
- `h2` (section heading)
- `h3` (subsection heading)
- `body` (default reading text)
- `caption` (supporting/meta text)

## Workflow (Required)

1. Read current doctrine (`DESIGN.md`, if present) and existing type usage.
2. Define the mathematical model:
   - `B`: body base size
   - `R_head`: heading ratio
   - `R_text`: body/caption ratio
   - `G`: vertical rhythm grid
3. Compute role sizes from ratios (no ad-hoc values).
4. Quantize line-height and spacing to `G`.
5. Define list/link/paragraph rules (below).
6. Encode all rules in `<repo-root>/TYPO.md` using template.
7. Validate with `design-quality-gates` before sign-off.

## Mathematical Spec

Use explicit formulas in `TYPO.md`:

- `size(step) = B * R^step`
- `lineHeightPx = round((sizePx * k) / G) * G`
- `paragraphGapPx = n * G`

Recommended starting ranges:

- `B`: `16px` (web default baseline)
- `R_head`: `1.2` to `1.333`
- `R_text`: `1.067` to `1.125`
- `G`: `4px` or `5px` (pick one; no mixed grids)

## Typesetting Rules (Required)

- Semantics first: visual hierarchy must map to document structure.
- Measure: long-form body text targets `~45-75ch` (up to `~90ch` context-dependent).
- Leading: running text typically `>=1.5` for accessibility robustness.
- Paragraph rhythm: fixed tokenized spacing; avoid one-off margins.
- Links: underlined by default in prose; visited state defined; remove underline only in clearly navigational context.
- Lists:
  - Bulleted list for unordered items.
  - Numbered list when order is meaningful.
  - Optional spaced-list variant for multiline items.
- Glyph integrity: true quotes/apostrophes/dashes/ellipsis; no faux bold/italic/small caps; no stretched/compressed text.
- Justification caution: avoid full justification unless hyphenation + river/ladder control is verified.

## Accessibility Invariants

Must explicitly pass:

- WCAG text spacing adaptability: no content/functionality loss at:
  - line-height `1.5`
  - paragraph spacing `2x` font size
  - letter spacing `0.12em`
  - word spacing `0.16em`
- Contrast rules for text and links (per project AA/AAA target).
- Reflow/zoom checks on core templates.

## TYPO.md Contract

`TYPO.md` must include:

1. Scope and intent
2. Typeface stack policy
3. Ratio model (`B`, `R_head`, `R_text`, `G`)
4. Role table (`h1`, `h2`, `h3`, `body`, `caption`) with size/line-height/weight/tracking
5. Paragraph rules (measure, spacing, alignment)
6. List rules (bullet/number/spaced variant)
7. Link rules (default/hover/visited/focus)
8. Accessibility and QA gates
9. Token mapping (web + platform mappings if applicable)
10. Allowed exceptions and approval policy

Template: `references/TYPO-template.md`

## Failure Conditions (Blockers)

- Missing canonical `TYPO.md`.
- Role values not derivable from declared ratios.
- Unscoped one-off font sizes/line-heights.
- Missing `h3` definition.
- Link/list behavior unspecified.
- WCAG spacing override breakage.

## Related Skills

- `design-quality-gates` - sign-off validation.
- `design-system-doc` - align typography doctrine with `DESIGN.md`.
- `design-frontend` - implementation once tokens/rules are fixed.

## Sources

- `references/sources.md`
