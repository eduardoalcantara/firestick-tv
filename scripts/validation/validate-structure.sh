#!/usr/bin/env bash
# validate-structure.sh — confere a árvore mínima listada em min-tree.txt
set -euo pipefail

clear_screen() {
  if [[ -t 1 ]] && command -v clear >/dev/null 2>&1; then
    clear
  fi
}

find_repo_root() {
  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/spec-root.md" && -f "$dir/rules.md" ]]; then
      printf '%s\n' "$dir"
      return 0
    fi
    dir="$(dirname "$dir")"
  done
  return 1
}

usage() {
  cat <<'EOF'
Uso: validate-structure.sh [--help]

Valida arquivos e pastas da única lista: scripts/validation/min-tree.txt

Opções:
  --help    Mostra esta ajuda
EOF
}

main() {
  if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
    usage
    exit 0
  fi

  clear_screen

  local root
  if ! root="$(find_repo_root)"; then
    echo "FAIL: raiz do repositório não encontrada (marcadores: spec-root.md + rules.md)" >&2
    exit 1
  fi

  local list="$root/scripts/validation/min-tree.txt"
  if [[ ! -f "$list" ]]; then
    echo "FAIL: lista ausente: scripts/validation/min-tree.txt" >&2
    exit 1
  fi

  echo "validate-structure.sh — validar árvore mínima (min-tree.txt)"
  echo "Raiz: $root"
  echo

  local missing=0 total=0 line rel
  while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"
    [[ -z "$line" || "$line" == \#* ]] && continue
    total=$((total + 1))
    if [[ "$line" == */ ]]; then
      rel="${line%/}"
      if [[ -d "$root/$rel" ]]; then
        echo "OK   dir   $line"
      else
        echo "FAIL dir   $line"
        missing=$((missing + 1))
      fi
    else
      if [[ -f "$root/$line" ]]; then
        echo "OK   file  $line"
      else
        echo "FAIL file  $line"
        missing=$((missing + 1))
      fi
    fi
  done <"$list"

  echo
  if [[ "$missing" -eq 0 ]]; then
    echo "OK: estrutura mínima completa ($total itens)."
    exit 0
  fi

  echo "FAIL: $missing item(ns) ausente(s)." >&2
  exit 1
}

main "$@"
