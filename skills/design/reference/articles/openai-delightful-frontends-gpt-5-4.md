# OpenAI - Designing Delightful Frontends with GPT-5.4 (Distilled)

- Source: https://developers.openai.com/blog/designing-delightful-frontends-with-gpt-5-4
- Date read: 2026-03-22
- Scope: frontend prompting patterns, composition defaults, visual references, narrative structure, verification

## Reusable Principles

1. Frontend quality improves when constraints are explicit
   - Define typography, palette, layout, section count, CTA count, and token roles early.
   - Low or medium reasoning is often enough for simpler frontend tasks; overthinking can reduce quality.

2. The first viewport should read as one composition
   - On branded landing pages, the brand/product must be hero-level, not incidental nav text.
   - The first screen should usually contain one dominant image/visual plane, one headline, one short supporting line, and one CTA group.
   - If the page still works after removing the hero image, the image is too weak. If the brand disappears after hiding nav, branding is too weak.

3. Default to cardless, image-led hierarchy
   - Cards are not the default. Use them only when they meaningfully contain interaction.
   - Decorative gradients, badge clusters, stat strips, and floating promo fragments are common failure modes.
   - The hero should usually be full-bleed, not an inset media card or split collage.

4. Structure pages as narrative, not section piles
   - Default marketing sequence: hero, support, detail, social proof, final CTA.
   - Each section should have one job, one dominant visual idea, and one primary takeaway/action.

5. Real content and real imagery reduce generic output
   - Provide product context and believable copy inputs.
   - Use visual references or mood boards to guide rhythm, type scale, spacing, and imagery treatment.
   - Imagery should do narrative work; decorative texture alone is not enough.

6. Product UI and marketing pages require different copy models
   - Product surfaces should use utility copy: orientation, status, action.
   - Avoid homepage-style aspirational copy on dashboards or operational tools unless explicitly requested.

7. Verification matters for frontend quality
   - Use browser tooling to inspect multiple viewports, flows, state changes, and visual fidelity.
   - Floating/fixed layers must stay clear of primary content across screen sizes.

## Skill Mapping

- `design`: add first-viewport composition rules, brand-first tests, visual thesis/content plan/interaction thesis, narrative structure, and copy-mode split.
- `design-audit`: add litmus checks for one composition, brand clarity, real visual anchor, card necessity, and product-vs-marketing copy misuse.
- `agent-browser`: use for visual verification across viewports and flows when the task warrants it.
