# Gestalt Principles + Visual Hierarchy (Authoritative Distillation)

- Date researched: 2026-03-09

## Sources

- Max Wertheimer (1923, Ellis translation): *Laws of Organization in Perceptual Forms*  
  <https://en.wikisource.org/wiki/Laws_of_Organization_in_Perceptual_Forms>
- Wagemans et al. (2012): *A Century of Gestalt Psychology in Visual Perception I*  
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC3482144/>
- Nielsen Norman Group: *Visual Hierarchy in UX: Definition*  
  <https://www.nngroup.com/articles/visual-hierarchy-ux-definition/>
- Nielsen Norman Group: *5 Visual-design Principles in UX*  
  <https://media.nngroup.com/media/articles/attachments/Principles_Visual_Design-Letter.pdf>
- W3C WAI Understanding SC 1.3.2 Meaningful Sequence  
  <https://www.w3.org/WAI/WCAG20/Understanding/meaningful-sequence>
- W3C WAI Understanding SC 2.4.6 Headings and Labels  
  <https://www.w3.org/WAI/WCAG21/Understanding/headings-and-labels>

## Reusable Design Principles

1. Grouping is not optional perception noise
   - People automatically group by proximity, similarity, and continuation.
   - Layout choices therefore *create* structure, even without borders.

2. Hierarchy is ordered attention
   - Hierarchy should define first, second, and third look targets.
   - Size, contrast, and grouping should agree; conflicting cues create scan friction.

3. Proximity defines relationship strength
   - Decrease spacing inside groups; increase spacing between groups.
   - If unrelated items are equally close, users infer a false relationship.

4. Similarity defines category
   - Consistent visual treatment (shape, color, type style) implies same function/type.
   - Breaking similarity should signal meaningful difference, not randomness.

5. Common region and enclosure should support intent
   - Cards/containers should reflect real semantic groups.
   - Decorative containers that do not map to semantics dilute hierarchy.

6. Figure-ground clarity is mandatory
   - Foreground interactive content must separate clearly from background surfaces.
   - Ambiguous figure-ground separation lowers comprehension and interaction confidence.

7. Bounded contrast budgets outperform maximal contrast
   - Too many contrast levels flatten priority ("if everything pops, nothing pops").
   - Keep a small set of contrast tiers and reserve strongest emphasis.

8. Semantic and visual hierarchy must align
   - DOM/reading order and heading labels must preserve intended meaning (WCAG 1.3.2, 2.4.6).
   - Visual prominence cannot contradict semantic sequence for assistive tech users.

## Skill Mapping

- `design`: composition protocol for grouping + hierarchy.
- `design-audit`: pass/fail checks for hierarchy cue agreement and semantic alignment.
- `design-audit`: diagnostic checks for false grouping, hierarchy conflicts, and sequence mismatches.
