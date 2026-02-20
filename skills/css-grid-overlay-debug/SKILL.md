---
name: css-grid-overlay-debug
description: Build and debug deterministic CSS Grid visualization overlays (columns, rows, gutter hatching) with subgrid support. Use when grid guides are duplicated, missing, misaligned, or inconsistent across nested layouts and route transitions.
---

# CSS Grid Overlay Debug

## Overview

Use this skill to implement a stable, global grid-debug overlay for web layouts using CSS Grid and subgrid.  
Goal: one renderer, one scene graph, deterministic output, no duplicate guides.

## Use When

- User asks to visualize grid columns/rows/gutters globally.
- Current grid overlay draws duplicate lines/hatches in nested grids.
- Grid guides disappear after route transitions, DOM updates, resize, or font load.
- Subgrid layouts do not inherit or align with ancestor gutter visualization.

## Do Not Use When

- Task is only visual styling (colors/typography) with no grid instrumentation.
- User needs permanent production UI overlays (this skill is debug tooling).

## Canonical Architecture

1. **Global overlay root**
- Create one fixed/absolute overlay in `document.body`.
- Overlay has two layers: hatches + lines.
- Never mount per-grid overlay DOM inside each grid shell.

1. **Single-pass render**
- Collect all grid shells (`[data-site-grid-shell]`), sorted outer -> inner.
- Build a scene of primitives (column lines, row lines, column hatches, row hatches).
- Deduplicate/merge spans globally before paint.

1. **Subgrid-safe columns**
- For non-subgrid shells: compute gutter spans from resolved track sizes + `column-gap`.
- For subgrid shells: project gutter spans from nearest ancestor non-subgrid column source.
- Do not independently invent subgrid column gutters.
- **Subgrid inheritance contract:** the element with `grid-template-columns: subgrid` must also be the direct grid item in the parent grid.
- Do not place an extra wrapper between parent grid and subgrid container; wrapper indirection breaks track inheritance and causes visual misalignment.

1. **Row gutters from actual content rows**
- Group child boxes by row top (tolerance-based).
- Row gutter = gap between adjacent grouped rows.
- Draw hatch/lines only for real vertical gaps.

1. **Deterministic scheduling**
- Coalesce renders with `requestAnimationFrame`.
- Trigger from `ResizeObserver`, `MutationObserver`, `scroll`, `resize`, and route/page events.
- Keep a single debug state flag (`data-grid-debug="on"` + cookie).

## Repo-Proven Patterns (klinke.studio)

1. **Grid shell contract**
- `SiteGrid` emits both markers on the same root: `data-site-grid-shell` + `data-site-grid-grid`.
- Collector should still support fallback query (`shell.querySelector("[data-site-grid-grid]")`) for nested/wrapped usage.

1. **Rows-only instrumentation mode**
- Support `data-site-grid-rows-only` on shell or grid element.
- In rows-only mode, skip column gutter derivation but still compute row gutters and draw row guides.

1. **Boundary-line anti-duplication**
- Draw shell perimeter guides only for top-level shells (`depth === 0`).
- Allow nested shells to contribute gutter hatches/lines only.
- This avoids near-duplicate boundary lines from tiny nested offsets.

1. **Subgrid + ancestor projection**
- When `grid-template-columns` resolves to `subgrid`, do not create local column gutters.
- Project gutters from nearest ancestor marked as `isColumnSource`.
- Clamp projected gutters to current shell bounds.

1. **Numerical stability defaults**
- Use quantization and tolerances to absorb subpixel drift:
- `EPS = 1.25`, `QUANT = 1`, `ROW_GROUP_EPS = 4` are stable defaults in this repo.
- Merge spans before paint (`mergeSpans`) for both line and hatch primitives.

1. **Debug-state persistence + toggle sync**
- Persist debug state with cookie (`klinke_grid_debug`) and reflect with `data-grid-debug="on"` on `<html>`.
- Sync all `[data-grid-debug-toggle]` controls via `aria-pressed` + `data-on`.
- Expose runtime API for operators: `window.__klinkeSiteGridDebug = { renderAll, setEnabled }`.

1. **Lifecycle hooks for Astro**
- Rebind toggles and rerender on `astro:page-load`.
- Observe DOM churn with `MutationObserver` (`childList/subtree/attributes` and `attributeFilter: ["class", "style"]`).
- Schedule rerender after `document.fonts.ready` to handle late metric shifts.

## Implementation Workflow

1. Find current instrumentation:
- Search for `data-site-grid-shell`, `data-site-grid-grid`, existing debug scripts, and per-shell guide layers.

1. Remove per-shell paint logic:
- Keep shell markers, remove shell-local guide DOM/layers.
- Ensure only one global overlay owns guide rendering.

1. Build metric collectors:
- Bounds, track sizes, column gaps, row grouping.
- Subgrid detection from computed `grid-template-columns`.
- Verify DOM structure for every subgrid shell:
  - subgrid node is direct child/grid-item of parent grid
  - no intermediate wrapper between parent grid and subgrid node

1. Add primitive dedupe:
- Quantize coordinates (small step, e.g. `0.5px`).
- Merge overlapping spans by axis key.

1. Render scene:
- Paint merged hatches first, lines second.
- Use consistent masks for dotted lines + hatch orientation.

1. Wire observers/events:
- Route transitions (`astro:page-load` or framework equivalent).
- DOM mutations, resize, scroll, fonts ready.

1. Expose debug API:
- `window.__klinkeSiteGridDebug = { renderAll, setEnabled }`.

## Reliability Rules

- One overlay root only.
- No per-shell `replaceChildren` rendering.
- No recursive paint dependencies between nested shells.
- No mixed coordinate spaces (always normalize to document coordinates).
- Always merge spans before DOM paint.

## Quick Validation Checklist

- Toggle on/off repeatedly: no ghost lines remain.
- Nested grid + subgrid page: no duplicated column lines.
- Nested subgrid uses parent tracks exactly (no column drift/offset between parent and subgrid content).
- Deep content page: row gutters align to real row gaps.
- Scroll + resize + route navigation: overlay remains aligned.
- Font load/late content insertion: guides update once, no jitter.
- Rows-only shell (`data-site-grid-rows-only`) renders row guides without column guides.

## References

- Primary specs/docs: `references/primary-sources.md`

## Local Cross-References

- `design-system-doc` - Use when grid behavior should become a durable design rule.
