#!/usr/bin/env bash
# Show which git-tracked dotfiles differ from their $HOME counterpart,
# and which home files don't exist in the repo yet.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

echo "Repo: $REPO_DIR"
echo "Home: $HOME"
echo

git ls-files -z | while IFS= read -r -d '' file; do
  home_file="$HOME/$file"

  if [[ ! -e "$home_file" ]]; then
    echo "MISSING in home: $file"
    continue
  fi

  if [[ -L "$home_file" ]]; then
    continue
  fi

  if ! diff -q "$file" "$home_file" >/dev/null 2>&1; then
    echo "DIFF: $file"
  fi
done
