#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  render_plantuml.sh <file-or-dir> [--out-dir DIR] [--format png|svg] [--check-only]

Examples:
  render_plantuml.sh diagram.puml
  render_plantuml.sh diagrams/ --out-dir diagrams/png
  render_plantuml.sh diagram.puml --check-only
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

if ! command -v plantuml >/dev/null 2>&1; then
  echo "Error: plantuml CLI not found. Install with: brew install plantuml graphviz" >&2
  exit 1
fi

input=""
out_dir=""
format="png"
check_only="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --out-dir)
      out_dir="${2:-}"
      shift 2
      ;;
    --format)
      format="${2:-}"
      shift 2
      ;;
    --check-only)
      check_only="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ -z "$input" ]]; then
        input="$1"
        shift
      else
        echo "Error: unexpected argument '$1'" >&2
        usage
        exit 1
      fi
      ;;
  esac
done

if [[ -z "$input" ]]; then
  echo "Error: missing input path" >&2
  usage
  exit 1
fi

if [[ "$format" != "png" && "$format" != "svg" ]]; then
  echo "Error: unsupported format '$format' (use png or svg)" >&2
  exit 1
fi

declare -a files=()

if [[ -f "$input" ]]; then
  case "$input" in
    *.puml|*.plantuml) files+=("$input") ;;
    *)
      echo "Error: input file must end with .puml or .plantuml" >&2
      exit 1
      ;;
  esac
elif [[ -d "$input" ]]; then
  while IFS= read -r -d '' file; do
    files+=("$file")
  done < <(find "$input" -type f \( -name "*.puml" -o -name "*.plantuml" \) -print0 | sort -z)
else
  echo "Error: input path does not exist: $input" >&2
  exit 1
fi

if [[ ${#files[@]} -eq 0 ]]; then
  echo "Error: no .puml/.plantuml files found" >&2
  exit 1
fi

echo "Checking syntax for ${#files[@]} file(s)..."
plantuml -checkonly "${files[@]}"

if [[ "$check_only" == "true" ]]; then
  echo "Syntax check passed."
  exit 0
fi

cmd=(plantuml "-t${format}")
if [[ -n "$out_dir" ]]; then
  mkdir -p "$out_dir"
  cmd+=("-output" "$out_dir")
fi

echo "Rendering ${#files[@]} file(s) as ${format}..."
"${cmd[@]}" "${files[@]}"

if [[ -n "$out_dir" ]]; then
  echo "Wrote outputs to: $out_dir"
else
  echo "Wrote outputs next to source files."
fi
