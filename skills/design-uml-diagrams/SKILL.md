---
name: design-uml-diagrams
description: Use when creating or refining UML, flow, system, architecture, or process diagrams where clarity, visual hierarchy, readable labels, and straight-line routing matter more than exhaustive detail.
---

# Design UML Diagrams

Design diagrams as communication artifacts first, notation artifacts second.

## Use This Skill

- UML, PlantUML, Mermaid, flowchart, system, pipeline, sequence, or process diagram work
- diagrams that feel busy, text-heavy, ambiguous, or hard to scan
- overlapping edge labels, curved connectors, or unclear primary flow
- paper figures, technical docs, architecture overviews, or review artifacts that must read fast

## Core Rule

One diagram should tell one story.

If the diagram is trying to show ingestion, do not also make it explain every schema field, exception path, or implementation detail. Split diagrams before adding clutter.

## Hierarchy Rules

1. Identify the primary reading path first.
   - Usually top-to-bottom or left-to-right.
   - Make the main path visually dominant and mostly linear.

2. Make side interactions visibly secondary.
   - Manual review, admin override, audits, and feedback loops should sit beside the main path, not interrupt it.

3. Prefer stages over annotations.
   - If a connector needs more than a few words, create a small process node instead.

4. Keep node text short.
   - Prefer 1-3 words, optionally with one compact second line.
   - Remove filler like "workflow", "system", "current", "canonical" unless it disambiguates meaning.

5. Collapse repeated concepts.
   - If two nodes are only there to explain an arrow, merge them or convert them into one stage label.

## Connector Rules

- Prefer straight or orthogonal connectors.
- Avoid swung or curved connectors unless the notation forces them.
- Minimize crossings; reroute before adding explanation text.
- Use arrow labels only for short relationship names.
- If multiple labels crowd the same area, move semantics into nodes.
- Keep bidirectional flows rare and intentional.
- When two-way interaction matters, place the side node adjacent to the main node so both arrows stay short.

## Text Rules

- Low text density wins.
- Noun phrases beat sentence fragments.
- Avoid putting full explanations on connectors.
- Avoid duplicate wording across node labels and captions.
- If the caption or surrounding text already explains the nuance, simplify the figure.

## Abstraction Ladder

Choose one level and stay there:

- Paper level: durable states and transformations only
- System level: user-visible or operator-visible subsystems
- Implementation level: jobs, tables, services, concrete modules

Do not mix all three in one figure.

## Editing Workflow

1. State the diagram’s single question.
   - Example: "How do we go from production moderation signals to training splits?"

2. Mark the primary path.
   - Keep it linear.

3. Demote side paths.
   - Move them beside the main path.

4. Remove overloaded edge text.
   - Convert long edge labels into stage boxes.

5. Shorten every node.
   - Keep only disambiguating words.

6. Re-check visual scan order.
   - First glance should reveal start, middle, end.

7. Re-render and inspect the actual image or PDF page.
   - Do not trust source alone.

## Common Fixes

- Too much text on arrows:
  - replace with intermediate process boxes

- Main flow is unclear:
  - reorder nodes into one dominant vertical or horizontal chain

- Side interaction steals attention:
  - move it beside the main node it modifies

- Diagram feels implementation-heavy:
  - remove file names, scripts, endpoints, and schema minutiae

- Labels overlap:
  - shorten labels, remove edge text, increase spacing, or split the diagram

- Bidirectional arrows look messy:
  - place nodes adjacent and shorten labels, or use one connector plus caption context

## Output Contract

When using this skill:

- say what the primary flow is
- identify which nodes are primary vs secondary
- simplify before beautifying
- prefer a smaller, clearer diagram over a more complete one
- verify by rendering when possible

## Related Skills

- `design`: broader interface and hierarchy direction
- `design-audit`: critique of finished visual work
