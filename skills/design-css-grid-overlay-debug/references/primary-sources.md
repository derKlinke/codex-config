# CSS Grid Primary Sources

## Core Specs

- CSS Grid Layout Module Level 2 (includes subgrid):  
  https://www.w3.org/TR/css-grid-2/
- Resolved value / used track list details (`grid-template-*`):  
  https://www.w3.org/TR/css-grid-2/#resolved-track-list
- Subgrid model and gutter behavior:  
  https://www.w3.org/TR/css-grid-2/#subgrids

## Browser-Facing References

- MDN: Subgrid  
  https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_grid_layout/Subgrid
- MDN: `ResizeObserver`  
  https://developer.mozilla.org/en-US/docs/Web/API/ResizeObserver
- MDN: `MutationObserver`  
  https://developer.mozilla.org/en-US/docs/Web/API/MutationObserver

## Operational Notes

- Prefer resolved track sizes from computed style over guessing column widths.
- Treat subgrid columns as inherited track geometry from ancestor grid context.
- Render debug guides in one global overlay scene; do not render per nested grid shell.
