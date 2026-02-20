# klinke.studio Notes Rules

Apply these rules for `/Users/fabianklinke/Developer/klinke/klinke.studio/content/notes`.

## Scope and role

- Vault role: personal Wikipedia / Obsidian-style knowledge graph.
- Default mode: knowledge graph, not lecture transcript.
- Node model: atomic topic/term/concept nodes; avoid broad mixed-method dumps.
- Method granularity: keep major methods in separate notes (e.g., DTM, TF-IDF, LDA).
- Link strategy: inline wikilinks on relevant terms; no `see also`/`related notes` blocks.
- Avoid index/content-map notes by default; prefer direct cross-links between topic notes.
- Avoid linear/chronological flow summaries by default; use chronology only when explicitly requested.

## Source-first workflow

- Research tasks: scan relevant vault notes first; integrate findings before external lookup.
- Academic/scientific topics: proactively integrate relevant vault context.
- Durable outcomes (concepts, bug classes, design/workflow patterns, tradeoffs): write/update notes.
- Maintenance duty: amend existing notes for accuracy and clarity when needed.

## Format and syntax

- Location: `content/notes/` Markdown.
- Images: local relative links, e.g. `![](img.png)`.
- Math: `$...$` inline, `$$...$$` block.
- Wikilinks: `[[slug]]` or `[[slug|Label]]`.
- Citations: `[@key]` with keys in `content/bibliography/bibliography.bib`.
- Bibliography files: store PDFs in `content/bibliography/files/`; in site output they are served via `/pdf/` (Vercel Blob pipeline).
- URLs in reference lists: show as plain visible URLs.
- Notes URLs: canonical route `/notes/<full-slug>` (folder path); unique basename aliases must 301-redirect to canonical.

## Writing style

- Balanced prose + light structure; avoid bullet dumps and wall-of-text.
- Minimal purposeful headings.
- Bullets only when they improve clarity.
- High technical precision; short analogies acceptable when clarifying.
- Integrate clarifications directly in prose; avoid prefatory labels like `In plain terms` / `Einfach gesagt` / `Intuition`.
- Keep each note monolingual unless a technical term requires mixed language.

## Visual policy

- No full-slide screenshots.
- No slide screenshots of code/equations/tables.
- Use text-native math/code/table representations.
- Add visuals only when explanatory.
- Preferred visuals: source-backed images, PlantUML diagrams (CLI rendered), `matplotlib` plots.
- If a concept benefits from diagrams, create PlantUML and keep `.puml` source when possible.
- Prefer visuals from primary sources/web or self-made diagrams over generated images.
- Image generation: last resort.

## Citation policy

- Cite only sources actually checked in the current task.
- Cite only clearly relevant supporting sources.
- Prefer sources explicitly used in summarized material.
- No decorative citations; if uncertain, omit citation.

## Transparency footer

Add exactly one emphasized line at note end (always English):

- `_co-authored by an AI agent._`

## Notes overview copy

- Overview/docs copy about the notes system must transparently describe collaborative maintenance by Fabian + AI agents (read/write/curate).
- Do not frame notes as hand-written-only.

## Content boundary

- Keep vault content knowledge-centric.
- Exclude private/project-confidential details.
