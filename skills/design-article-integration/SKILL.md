---
name: design-article-integration
description: Use when ingesting design/UX articles into the local skill system by extracting reusable principles, writing reference notes, and patching affected skills.
---

# Design Article Integration

Convert external design writing into reusable, testable skill guidance with minimal drift and clear source traceability.

## Mandatory Workflow

1. Read full source
- Always read the full article first.
- If URL includes an anchor, treat it as optional unless user explicitly asks section-only extraction.
- Capture core thesis, constraints, and any explicit caveats from the author.

2. Distill reusable units
- Extract transferable rules, not anecdotes.
- Convert insights into atomic directives:
  - trigger condition
  - design/action rule
  - boundary or exception
  - anti-pattern
- Separate by domain: motion, hierarchy, color, interaction risk, accessibility, information scent.

3. Decide insertion targets
- Route principles into existing skills rather than duplicating:
  - `design` for broad UI craft and visual direction
  - `design-interaction-motion-craft` for behavior/motion logic
  - `design-audit` for pass/fail criteria
  - other specialized design skills only when scope is clearly narrower

4. Write references
- Add concise source notes under the target skill reference tree.
- File naming: `references/articles/<author>-<topic>.md` (or nearest existing equivalent).
- Each reference must include:
  - source URL
  - date read
  - distilled principles
  - direct mappings to skill rules

5. Patch skills
- Add only durable guidance; avoid trend-specific stylistic noise.
- Prefer short, enforceable bullets over long prose.
- Keep patches small and composable; avoid rewriting entire skills.

6. Validate
- Run link integrity checks for edited skills.
- Verify no duplicate/conflicting rules were introduced.
- Confirm references are actually linked/used by at least one active skill section.

## Quality Bar

- No speculative claims presented as facts.
- No copy-paste essays into SKILL bodies.
- Keep author nuance: include when guidance should *not* be applied.
- Preserve high-frequency UX performance constraints (no decorative regressions).

## Output Contract

- Report:
  - principles extracted
  - files added/updated
  - exact skills changed
  - verification commands run
