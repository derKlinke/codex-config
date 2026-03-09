#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM_DIR="$BASE_DIR/references/upstream"
MIRROR_DIR="$UPSTREAM_DIR/supabase-docs-markdown"
MANIFEST="$UPSTREAM_DIR/supabase-docs-manifest.md"

mkdir -p "$UPSTREAM_DIR"
TMP_DIR="$(mktemp -d)"
SRC_DIR="$TMP_DIR/supabase-docs-src"
trap 'rm -rf "$TMP_DIR"' EXIT

git clone --depth=1 --filter=blob:none --sparse https://github.com/supabase/supabase.git "$SRC_DIR" >/dev/null
(
  cd "$SRC_DIR"
  git sparse-checkout set apps/docs/content
)

rm -rf "$MIRROR_DIR"
mkdir -p "$MIRROR_DIR"

SOURCE_CONTENT="$SRC_DIR/apps/docs/content"
while IFS= read -r -d '' file; do
  rel="${file#${SOURCE_CONTENT}/}"
  if [[ "$rel" == *.mdx ]]; then
    out_rel="${rel%.mdx}.md"
  else
    out_rel="$rel"
  fi
  out="$MIRROR_DIR/$out_rel"
  mkdir -p "$(dirname "$out")"
  cp "$file" "$out"
done < <(find "$SOURCE_CONTENT" -type f \( -name '*.md' -o -name '*.mdx' \) -print0)

commit="$(cd "$SRC_DIR" && git rev-parse --short HEAD)"
date_utc="$(date -u '+%Y-%m-%d %H:%M:%S UTC')"
count="$(find "$MIRROR_DIR" -type f -name '*.md' | wc -l | tr -d ' ')"
size="$(du -sh "$MIRROR_DIR" | awk '{print $1}')"

cat > "$MANIFEST" <<MANIFEST
# Supabase Docs Snapshot

- Source repo: https://github.com/supabase/supabase
- Source branch: \`master\`
- Source commit: \`$commit\`
- Snapshot created (UTC): \`$date_utc\`
- Snapshot root: \`$MIRROR_DIR\`
- Markdown files exported: \`$count\`
- Snapshot size: \`$size\`

## Export rules

- Input: all \`.md\` and \`.mdx\` files under \`apps/docs/content\`.
- Output: markdown mirror under \`supabase-docs-markdown\`.
- Conversion: \`.mdx\` extension normalized to \`.md\`; file content preserved verbatim.
- Non-markdown assets (images, videos, TOML, JSON, code examples outside md/mdx) excluded.
MANIFEST

echo "Synced Supabase docs snapshot: commit=$commit files=$count size=$size"
