#!/usr/bin/env bash
# =============================================================================
# Hook Installer — Links .git-hooks/ into .git/hooks/
# Usage: bash .git-hooks/install-hooks.sh
# =============================================================================
set -euo pipefail

HOOKS_SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOKS_TARGET_DIR="$(git rev-parse --show-toplevel)/.git/hooks"

echo "Installing git hooks from: $HOOKS_SOURCE_DIR"
echo "Target directory:          $HOOKS_TARGET_DIR"
echo ""

for hook_file in "$HOOKS_SOURCE_DIR"/*; do
  hook_name="$(basename "$hook_file")"
  # Skip this installer script itself
  if [ "$hook_name" = "install-hooks.sh" ]; then continue; fi

  target="$HOOKS_TARGET_DIR/$hook_name"

  # Backup existing hook if not a symlink we created
  if [ -f "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "${target}.bak"
    echo "[BACKED UP] Existing $hook_name → ${hook_name}.bak"
  fi

  ln -sf "$hook_file" "$target"
  chmod +x "$hook_file"
  echo "[INSTALLED] $hook_name → .git/hooks/$hook_name"
done

echo ""
echo "All hooks installed. Run 'bash .git-hooks/pre-commit' to test manually."
