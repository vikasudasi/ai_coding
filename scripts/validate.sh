#!/usr/bin/env bash
# =============================================================================
# Validate Script — Full project health check
# Usage: bash scripts/validate.sh [--fast]
# Options:
#   --fast    Skip Docker build and long-running checks
# =============================================================================
set -euo pipefail

FAST_MODE=false
[[ "${1:-}" == "--fast" ]] && FAST_MODE=true

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
ERRORS=0

ok()   { echo -e "${GREEN}[OK]${NC}   $1"; }
fail() { echo -e "${RED}[FAIL]${NC} $1"; ERRORS=$((ERRORS + 1)); }
info() { echo -e "${YELLOW}[INFO]${NC} $1"; }

echo ""; echo "=== Project Validation ==="; echo ""

# --- Test suite ---
info "Running tests..."
if command -v pytest &>/dev/null;           then pytest tests/ -q && ok "pytest" || fail "pytest"; \
elif command -v npm &>/dev/null && [ -f package.json ]; then npm test --silent && ok "npm test" || fail "npm test"; \
elif command -v go  &>/dev/null && [ -f go.mod ];       then go test ./... && ok "go test" || fail "go test"; \
else info "No test runner found — skipping"; fi

# --- Docker ---
if [ "$FAST_MODE" = false ] && [ -f Dockerfile ] && command -v docker &>/dev/null; then
  info "Building Docker image..."
  docker-compose build --quiet && ok "docker-compose build" || fail "docker-compose build"
fi

# --- State consistency ---
info "Checking STATE.md..."
[ -f STATE.md ] && ok "STATE.md exists" || fail "STATE.md missing"

# --- Agent context files ---
for f in .ai/RULES.md .ai/ARCHITECTURE.md .ai/MEMORY.md; do
  [ -f "$f" ] && ok "$f exists" || fail "$f MISSING"
done

echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo -e "${RED}=== FAILED: $ERRORS issue(s) found ===${NC}"; exit 1
else
  echo -e "${GREEN}=== All checks passed ===${NC}"; exit 0
fi
