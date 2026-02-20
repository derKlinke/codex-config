---
name: interface-design
description: This skill is for interface design — dashboards, admin panels, apps, tools, and interactive products. NOT for marketing design (landing pages, marketing sites, campaigns).
---

# Interface Design

Build interface design with craft and consistency.

## Scope

**Use for:** Dashboards, admin panels, SaaS apps, tools, settings pages, data interfaces.

**Not for:** Landing pages, marketing sites, campaigns. Redirect those to `/frontend-design`.

---

# The Problem

Model priors push toward generic dashboards. Process helps, but only active self-audit prevents template output.

---

# Where Defaults Hide

Defaults hide in "infrastructure":
- Typography: not a container; it defines product tone.
- Navigation: not scaffolding; it defines product mental model.
- Data presentation: not decoration; it must communicate meaning and action.
- Token naming: not implementation detail; tokens encode product world.

There are no purely structural choices. If you cannot answer "why this?", you defaulted.

---

# Intent First

Before code, answer explicitly:

**Who is this human?**
- Real user context, not generic "users": immediate environment, preceding task, next task.

**What must they accomplish?**
- Concrete verb/task (for example: grade, diagnose, approve). This sets hierarchy.

**What should this feel like?**
- Specific experiential target (for example: notebook-warm, terminal-cold, trading-dense, reading-calm).

If specifics are missing, stop and ask the user. Do not guess or default.

## Every Choice Must Be A Choice

For every decision, you must be able to explain WHY.

- Why this layout and not another?
- Why this color temperature?
- Why this typeface?
- Why this spacing scale?
- Why this information hierarchy?

If the answer is "common/clean/works," it is a default, not a choice.

**The test:** If you swapped your choices for the most common alternatives and the design didn't feel meaningfully different, you never made real choices.

## Sameness Is Failure

If another AI would produce roughly the same output, the design failed. Novelty is not the goal; specificity to problem/user/context is.

## Intent Must Be Systemic

Intent is a system-level constraint, not a label. If intent is warm/dense/calm, every token and layout choice must reinforce it.

---

# Product Domain Exploration

Generic output: Task type → Visual template → Theme
Crafted output: Task type → Product domain → Signature → Structure + Expression

Difference: time spent in the product domain before visual decisions.

## Required Outputs

**Do not propose any direction until you produce all four:**

- **Domain:** 5+ concepts/metaphors/vocabulary from the product world (not feature list).
- **Color world:** 5+ colors grounded in that world, not abstract warm/cool labels.
- **Signature:** one visual/structural/interaction element unique to this product.
- **Defaults:** 3 obvious visual/structural defaults to replace deliberately.

## Proposal Requirements

Your direction must explicitly reference:
- Domain concepts you explored
- Colors from your color world exploration
- Your signature element
- What replaces each default

**Test:** Remove product name. If purpose is unclear, it is generic; explore deeper.

---

# The Mandate

Before presenting, identify the likely "lacks craft" critique and fix it first.

## The Checks

Run these against your output before presenting:

- **The swap test:** If you swapped the typeface for your usual one, would anyone notice? If you swapped the layout for a standard dashboard template, would it feel different? The places where swapping wouldn't matter are the places you defaulted.

- **The squint test:** Blur your eyes. Can you still perceive hierarchy? Is anything jumping out harshly? Craft whispers.

- **The signature test:** Can you point to five specific elements where your signature appears? Not "the overall feel" — actual components. A signature you can't locate doesn't exist.

- **The token test:** Read your CSS variables out loud. Do they sound like they belong to this product's world, or could they belong to any project?

If any check fails, iterate before showing.

---

# Craft Foundations

## Subtle Layering

This is the backbone of craft. Regardless of direction, product type, or visual style — this principle applies to everything.

**Surfaces must be barely different but still distinguishable.** Study Vercel, Supabase, Linear. Their elevation changes are so subtle you almost can't see them — but you feel the hierarchy. Not dramatic jumps. Not obviously different colors. Whisper-quiet shifts.

**Borders must be light but not invisible.** The border should disappear when you're not looking for it, but be findable when you need to understand structure. If borders are the first thing you notice, they're too strong. If you can't tell where regions begin and end, they're too weak.

**The squint test:** Blur your eyes at the interface. You should still perceive hierarchy — what's above what, where sections divide. But nothing should jump out. No harsh lines. No jarring color shifts. Just quiet structure.

This separates professional interfaces from amateur ones. Get this wrong and nothing else matters.

## Infinite Expression

Every pattern has infinite expressions. **No interface should look the same.**

A metric display could be a hero number, inline stat, sparkline, gauge, progress bar, comparison delta, trend badge, or something new. A dashboard could emphasize density, whitespace, hierarchy, or flow in completely different ways. Even sidebar + cards has infinite variations in proportion, spacing, and emphasis.

**Before building, ask:**
- What's the ONE thing users do most here?
- What products solve similar problems brilliantly? Study them.
- Why would this interface feel designed for its purpose, not templated?

**NEVER produce identical output.** Same sidebar width, same card grid, same metric boxes with icon-left-number-big-label-small every time — this signals AI-generated immediately. It's forgettable.

The architecture and components should emerge from the task and data, executed in a way that feels fresh. Linear's cards don't look like Notion's. Vercel's metrics don't look like Stripe's. Same concepts, infinite expressions.

## Color Lives Somewhere

Every product exists in a world. That world has colors.

Before you reach for a palette, spend time in the product's world. What would you see if you walked into the physical version of this space? What materials? What light? What objects?

Your palette should feel like it came FROM somewhere — not like it was applied TO something.

**Beyond Warm and Cold:** Temperature is one axis. Is this quiet or loud? Dense or spacious? Serious or playful? Geometric or organic? A trading terminal and a meditation app are both "focused" — completely different kinds of focus. Find the specific quality, not the generic label.

**Color Carries Meaning:** Gray builds structure. Color communicates — status, action, emphasis, identity. Unmotivated color is noise. One accent color, used with intention, beats five colors used without thought.

---

# Design Principles

## Spacing
Pick a base unit and stick to multiples. Consistency matters more than the specific number. Random values signal no system.

## Padding
Keep it symmetrical. If one side is 16px, others should match unless there's a clear reason.

## Depth
Choose ONE approach and commit:
- **Borders-only** — Clean, technical. For dense tools.
- **Subtle shadows** — Soft lift. For approachable products.
- **Layered shadows** — Premium, dimensional. For cards that need presence.

Don't mix approaches.

## Border Radius
Sharper feels technical. Rounder feels friendly. Pick a scale and apply consistently.

## Typography
Typography is structural, not decorative. Enforce:
- Semantics first: map display/headline/subhead/body/meta/data to information roles.
- Measure: reading-heavy text targets `~45-75` characters per line.
- Leading: body copy generally `~1.2-1.45`; tune by density and x-height.
- Rhythm: consistent paragraph/section spacing; avoid arbitrary spacing jumps.
- Data UI: use tabular numerals/monospace where comparison speed matters.
- Glyph correctness: true punctuation marks and approved OpenType features only.
- Ban typographic fraud: no fake bold/italic/small caps; no stretched/compressed text.
- Long-form quality: control widows/orphans; prevent rivers/ladders in justified blocks.

## Color & Surfaces
Build from primitives: foreground (text hierarchy), background (surface elevation), border (separation hierarchy), brand, and semantic (destructive, warning, success). Every color should trace back to these. No random hex values — everything maps to the system.

## Animation
Fast micro-interactions (~150ms), smooth easing. No bouncy/spring effects.
For transition/gesture behavior decisions, apply `interaction-motion-craft`.

## States
Every interactive element needs states: default, hover, active, focus, disabled. Data needs states too: loading, empty, error. Missing states feel broken.

## Controls
Native `<select>` and `<input type="date">` can't be styled. Build custom components.

---

# Avoid

- **Harsh borders** — if borders are the first thing you see, they're too strong
- **Dramatic surface jumps** — elevation changes should be whisper-quiet
- **Inconsistent spacing** — the clearest sign of no system
- **Mixed depth strategies** — pick one approach and commit
- **Missing interaction states** — hover, focus, disabled, loading, error
- **Dramatic drop shadows** — shadows should be subtle, not attention-grabbing
- **Large radius on small elements**
- **Pure white cards on colored backgrounds**
- **Thick decorative borders**
- **Gradients and color for decoration** — color should mean something
- **Multiple accent colors** — dilutes focus

---

# Workflow

## Communication
Be invisible. Don't announce modes or narrate process.

**Never say:** "I'm in ESTABLISH MODE", "Let me check system.md..."

**Instead:** Jump into work. State suggestions with reasoning.

## Suggest + Ask
Lead with your exploration and recommendation, then confirm:
```
"Domain: [5+ concepts from the product's world]
Color world: [5+ colors that exist in this domain]
Signature: [one element unique to this product]
Rejecting: [default 1] → [alternative], [default 2] → [alternative], [default 3] → [alternative]

Direction: [approach that connects to the above]"

[AskUserQuestion: "Does that direction feel right?"]
```

## If Project Has system.md
Read `.interface-design/system.md` and apply. Decisions are made.

## If No system.md
1. Explore domain — Produce all four required outputs
2. Propose — Direction must reference all four
3. Confirm — Get user buy-in
4. Build — Apply principles
5. **Evaluate** — Run the mandate checks before showing
6. Offer to save

## Related Skills

- `design-quality-gates` - mandatory pass/fail validation before sign-off, including typography defects.
- `design-system-doc` - persist durable type hierarchy, spacing, and glyph policy in `DESIGN.md`.

---

# After Completing a Task

When you finish building something, **always offer to save**:

```
"Want me to save these patterns for future sessions?"
```

If yes, write to `.interface-design/system.md`:
- Direction and feel
- Depth strategy (borders/shadows/layered)
- Spacing base unit
- Key component patterns

This compounds — each save makes future work faster and more consistent.

---

# Deep Dives

For more detail on specific topics:
- `references/principles.md` — Code examples, specific values, dark mode
- `references/validation.md` — Memory management, when to update system.md

# Commands

- `/interface-design:status` — Current system state
- `/interface-design:audit` — Check code against system
- `/interface-design:extract` — Extract patterns from code
