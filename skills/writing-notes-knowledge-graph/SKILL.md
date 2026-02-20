---
name: notes-knowledge-graph
description: "Create, revise, and curate Markdown notes as an Obsidian-style knowledge graph, including wikilinks, citations, math, and explanatory visuals. Use `matplotlib` for quantitative graphs and PlantUML for conceptual/system diagrams when visuals are needed. Trigger on note taking, note maintenance, research notes, content/notes/, Obsidian, knowledge graph, concept pages, literature summaries, or durable knowledge capture from coding/research work."
---

# Notes Knowledge Graph

Apply a strict workflow for note authoring and maintenance. Treat notes as reusable knowledge nodes, not linear transcripts.

## Workflow

1. Identify target note(s) and repository context.
2. If repo-root `NOTES.md` exists, use it first as the canonical note index and refresh it via the repo command if stale.
3. Scan relevant existing notes before drafting.
4. Read the skill reference file at `/Users/fabianklinke/.codex/skills/notes-knowledge-graph/references/klinke-studio-rules.md` when working in Fabian's `klinke.studio` vault (do not look for a repo-local `references/` directory).
5. Create or edit note content with atomic concept scope and inline wikilink integration.
6. Apply citation, visual, and language constraints from the reference, including visual tooling defaults (`matplotlib` and PlantUML).
7. Run final quality check: structure, links, formulas, citations, transparency line.

## Klinke Studio Rules (Required)

When working in `/Users/fabianklinke/Developer/klinke/klinke.studio`, treat `/Users/fabianklinke/.codex/skills/notes-knowledge-graph/references/klinke-studio-rules.md` as normative. Enforce:

- Notes system syntax: `content/notes/` Markdown; local relative images `![](img.png)`; math `$...$` and `$$...$$`; wikilinks `[[slug]]` or `[[slug|Label]]`; citations `[@key]` mapped to `content/bibliography/bibliography.bib`.
- Bibliography assets: PDFs stored in `content/bibliography/files/` and served via `/pdf/` (Vercel Blob pipeline).
- Notes URL policy: canonical route `/notes/<full-slug>` (folder path); unique basename aliases must redirect `301` to canonical.
- Note shape defaults: personal Wikipedia / Obsidian graph; atomic concept nodes; major methods split into separate notes; avoid index/content-map notes unless explicitly requested.
- Structure defaults: avoid chronological/linear lecture-flow summaries unless explicitly requested; prefer direct conceptual cross-links.
- Writing style: balanced prose + light structure; minimal purposeful headings; bullets only when clarity improves.
- Visual policy: no full-slide screenshots; no slide screenshots of code/equations/tables; represent code/math/tables natively in Markdown/LaTeX.
- Diagram/graph policy: use PlantUML (`.puml` source + rendered PNG) for conceptual/system diagrams; use `matplotlib` for explanatory quantitative plots.
- Visual source priority: primary-source/web visuals or self-made diagrams first; image generation last resort only.
- Linking/citation policy: references at note/page bottom use plain visible URLs; cite only checked, directly relevant sources; never decorative citations.
- Language/transparency policy: keep notes monolingual (preserve existing note language); no `see also` blocks; include one emphasized footer line in English: `_co-authored by an AI agent._`.
- Notes-overview copy policy: state collaborative maintenance by Fabian + AI agents (read/write/curate); avoid hand-written-only framing.

## Mandatory Behaviors

- Prefer updating/refining existing notes over adding duplicates.
- Keep note language monolingual; preserve existing note language.
- Use visuals only when explanatory signal > maintenance cost.
- For charts/curves/distributions/time-series: use `matplotlib`; render static local image files and embed via relative Markdown links.
- For architecture/concept/process diagrams: author PlantUML source (`.puml`), render to local image, embed relative link in the note.
- Add the transparency line at note end in English: `_co-authored by an AI agent._`.
- For research-heavy tasks, extract durable outcomes into notes.

## Output Contract

- Deliver edits directly in vault files.
- Keep prose precise, concise, and technically correct.
- Preserve graph quality: meaningful wikilinks, no decorative backlinks sections.
