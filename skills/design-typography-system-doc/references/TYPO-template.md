# TYPO.md

> Canonical typography doctrine for this repository. Strict, ratio-based, tokenized. Current state only.

## Scope

- Platforms in scope:
- Surfaces in scope:
- Accessibility target (AA/AAA):

## Typeface Policy

- Heading family:
- Body family:
- Mono/data family (if any):
- Fallback stacks:
- Allowed weights:
- Disallowed styles (faux/synthetic/stretch):

## Mathematical Model

- `B` (body base size):
- `R_head` (heading ratio):
- `R_text` (body/caption ratio):
- `G` (vertical rhythm grid):

Formulas:

- `size(step) = B * R^step`
- `lineHeightPx = round((sizePx * k) / G) * G`
- `paragraphGapPx = n * G`

## Role Scale

| Role | Step | Computed size | Weight | Line-height | Tracking | Use |
| --- | ---: | ---: | --- | --- | --- | --- |
| `h1` |  |  |  |  |  | Primary heading |
| `h2` |  |  |  |  |  | Section heading |
| `h3` |  |  |  |  |  | Subsection heading |
| `body` |  |  |  |  |  | Running text |
| `caption` |  |  |  |  |  | Meta/supporting text |

## Paragraph Rules

- Measure target:
- Alignment policy:
- Paragraph gap token:
- Indent policy (if used):
- Hyphenation policy:

## List Rules

### Bulleted

- Marker type:
- Marker offset/indent:
- Item spacing:
- Nested list rules:

### Numbered

- Number formatting:
- Indent/alignment:
- Item spacing:

### Spaced List Variant (optional)

- Trigger conditions:
- Item block spacing:

## Link Rules

- Default style:
- Hover style:
- Focus-visible style:
- Visited style:
- Underline suppression rules:

## Accessibility Invariants

- WCAG text spacing override support:
  - line-height `1.5`
  - paragraph spacing `2x`
  - letter spacing `0.12em`
  - word spacing `0.16em`
- Contrast thresholds:
- Zoom/reflow constraints:

## Token Mapping

| Semantic token | CSS/custom-property | iOS/macOS mapping | Notes |
| --- | --- | --- | --- |
| `type.h1` |  |  |  |
| `type.h2` |  |  |  |
| `type.h3` |  |  |  |
| `type.body` |  |  |  |
| `type.caption` |  |  |  |
| `type.leading.body` |  |  |  |
| `space.paragraph` |  |  |  |
| `space.list.item` |  |  |  |

## QA Gates

- [ ] All role values derive from declared ratios.
- [ ] No one-off typography values outside token set.
- [ ] Long-form measure within target range.
- [ ] No faux styles or stretched/compressed type.
- [ ] Links and lists match defined rules.
- [ ] WCAG spacing override stress test passes.

## Exceptions

| Surface | Exception | Justification | Approval |
| --- | --- | --- | --- |

