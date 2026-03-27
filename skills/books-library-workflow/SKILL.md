---
name: books-library-workflow
description: Use when maintaining `klinke.studio` book data in `apps/web/src/content/data/books/wishlist.csv` or `books.csv`, especially for wishlist additions, moving books from wishlist to library, resolving Amazon links, or preventing duplicates across both datasets.
---

# Books Library Workflow

## Overview

Repo-side workflow for book maintenance in `klinke.studio`. Default to CSV edits, not browser automation. Duplicate prevention is mandatory: never add a wishlist entry if the book is already in the wishlist or library, and when moving a book into the library, remove the wishlist row in the same diff.

Read [references/checklist.md](references/checklist.md) before execution if metadata is incomplete, the source is Amazon, or duplicate status is not obvious.

## Source Of Truth

- Wishlist: `apps/web/src/content/data/books/wishlist.csv`
  Format: `title;author;isbn;category`
- Library: `apps/web/src/content/data/books/books.csv`
  Format: `title;author;isbn;status;category;visible;scientific`
- Runtime parser: `apps/web/src/lib/books.ts`
- ISBN normalization check: root `bun run check-normalize-isbn` or `bun run normalize-isbn`

## Hard Rules

- Never add a wishlist row if the same book already exists in `wishlist.csv`.
- Never add a wishlist row if the same book already exists in `books.csv`.
- Match duplicates by normalized ISBN first; use normalized title-plus-author as fallback when ISBN is missing or ambiguous.
- Treat ISBN-10 and ISBN-13 as the same book when they normalize to the same edition.
- Do not guess missing metadata. Resolve title, author, and ISBN first.
- Do not keep the same book in both files after a move. Library add plus wishlist removal is one atomic change.
- Preserve alphabetical ordering by title in both files.
- Preserve existing category tokens when possible; prefer an existing category over inventing a near-duplicate label.
- Wishlist rows without ISBN are invalid in practice because `getAllWishlistBooks()` filters them out.
- For library moves, default to `status=unread`, `visible=visible`, empty `scientific` unless the book is clearly scientific and the repo already uses that flag for similar books.

## Workflow

### Add To Wishlist

1. Collect canonical metadata: `title`, `author`, `isbn`, `category`.
2. If input is an Amazon URL, resolve and canonicalize it first, then cross-check metadata outside Amazon before editing.
3. Run duplicate checks against both CSVs.
4. If the book already exists in the library, do not add it to the wishlist.
5. If the book already exists in the wishlist, do not add a second row.
6. Insert the row in alphabetical position.
7. Verify exact row presence and confirm no duplicate remained in either file.

### Move Wishlist Book To Library

1. Locate the canonical wishlist row first.
2. Reconfirm the book is not already present in `books.csv`.
3. Convert the row into library format with explicit defaults:
   `title;author;isbn;unread;category;visible;`
4. Insert the library row in alphabetical position.
5. Remove the wishlist row in the same patch.
6. Verify one library row remains and the wishlist row is gone.
7. If metadata changed during the move, state why in the final note.

## Always Check

- Amazon often points to the wrong variant: Kindle, audiobook, workbook, summary, box set, or another translation.
- Amazon query parameters are tracking noise. Resolve to the effective URL before trusting the path.
- Amazon `dp` identifiers are not guaranteed to be ISBNs. Treat them as hints, not truth.
- `cut -d';'` is unsafe for these CSVs because quoted semicolons can appear in titles.
- A title match with different ISBN can still be a real duplicate if one side uses ISBN-10 and the other ISBN-13.
- Author strings vary in punctuation, separators, accents, and ordering; ISBN is the primary key.
- Category drift is easy. Check current category usage before creating a new label.
- A stale wishlist duplicate may remain even when the library already has the book. Clean it up if the user intent is effectively a move or dedupe.
- Edition ambiguity matters. Different translations or materially different editions are not automatic duplicates.
- Do not add rows with placeholder author or ISBN values just to finish the task.

## Verification

- Minimum: duplicate-check evidence plus exact row add/remove verification with `rg` or CSV-aware inspection.
- If ISBN formatting changed or looks suspicious, run `bun run check-normalize-isbn`.
- Do not run full build or lint unless the user asks for it.
