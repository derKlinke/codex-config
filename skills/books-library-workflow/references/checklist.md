# Books Checklist

## Canonical Paths

- Wishlist: `apps/web/src/content/data/books/wishlist.csv`
- Library: `apps/web/src/content/data/books/books.csv`
- Parser behavior: `apps/web/src/lib/books.ts`

## Safe Duplicate Check

Use a CSV-aware script, not `cut`.

```bash
python3 - <<'PY'
import csv
import re
from pathlib import Path

WISHLIST = Path("apps/web/src/content/data/books/wishlist.csv")
LIBRARY = Path("apps/web/src/content/data/books/books.csv")
TARGET_TITLE = "REPLACE_ME"
TARGET_AUTHOR = "REPLACE_ME"
TARGET_ISBN = "REPLACE_ME"

def clean(text):
    return re.sub(r"\s+", " ", text.strip().casefold())

def isbn_candidates(value):
    raw = re.sub(r"[^0-9Xx]", "", value or "").upper()
    out = set()
    if len(raw) == 10:
        body = "978" + raw[:-1]
        total = sum(int(d) * (1 if i % 2 == 0 else 3) for i, d in enumerate(body))
        out.add(body + str((10 - total % 10) % 10))
        out.add(raw)
    elif len(raw) == 13:
        out.add(raw)
    return out

target_title = clean(TARGET_TITLE)
target_author = clean(TARGET_AUTHOR)
target_isbns = isbn_candidates(TARGET_ISBN)

def scan(path, isbn_index):
    with path.open(encoding="utf-8", newline="") as f:
        for line_no, row in enumerate(csv.reader(f, delimiter=";"), 1):
            if not row:
                continue
            row_isbns = isbn_candidates(row[isbn_index] if len(row) > isbn_index else "")
            title = clean(row[0] if len(row) > 0 else "")
            author = clean(row[1] if len(row) > 1 else "")
            isbn_hit = bool(target_isbns and row_isbns & target_isbns)
            text_hit = title == target_title and author == target_author
            if isbn_hit or text_hit:
                print(path, line_no, row)

scan(WISHLIST, 2)
scan(LIBRARY, 2)
PY
```

## Amazon Intake

1. Resolve shortlinks and tracking URLs first.

```bash
curl -Ls -o /dev/null -w '%{url_effective}\n' 'https://amzn.eu/d/069vOj6M'
```

2. Keep the effective URL, not the original shortlink or query-heavy referral URL.
3. Confirm this is the intended edition:
   - physical book, not Kindle/audiobook
   - correct language/translation
   - not a workbook/summary/boxed set unless requested
4. Treat the Amazon `dp` segment as a candidate identifier only. It can be an ASIN, not an ISBN.
5. Extract candidate metadata from the product page, then verify it externally.
6. Prefer ISBN-based confirmation through Open Library first. If Open Library is incomplete, use Google Books by ISBN or by title-plus-author.
7. Do not trust Amazon alone for category choice.

## Category Choice

- Reuse the existing label if a close match exists.
- Wishlist currently concentrates around:
  `Art & Design`, `Fiction`, `Science`, `Mathematics`, `Programming`, `Finance`, `Biography`, `Philosophy`
- Library currently concentrates around:
  `Fiction`, `Classics`, `Science Fiction`, `Culture`, `Mathematics`, `Art & Design`, `Biography`, `Programming`
- If the candidate category is new or ambiguous, inspect nearby books and choose the closest established token.

## Move Defaults

When moving a wishlist row into the library, default to:

```text
status     unread
visible    visible
scientific empty
```

Only set `scientific` when the book clearly belongs with other scientific/library entries that already use that flag.

## Fast Verification

- Search exact title and ISBN after editing.
- Confirm the book exists in only one file unless the user explicitly wants both.
- If the ISBN was added or rewritten, run:

```bash
bun run check-normalize-isbn
```
