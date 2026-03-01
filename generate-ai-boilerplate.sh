#!/usr/bin/env bash
# =============================================================================
# AI-Agent-Optimized Project Boilerplate Generator
# =============================================================================
# Usage: Run this in an EMPTY directory:
#   bash generate-ai-boilerplate.sh [project-name]
#
# What it creates:
#   .ai/           — Agent context (RULES, ARCHITECTURE, MEMORY)
#   STATE.md       — Agent state tracker with DoD checklist
#   .git-hooks/    — Pre-commit validation gate
#   tests/         — unit / integration / e2e directories
#   src/           — Application source placeholder
#   docs/          — Documentation placeholder
#   scripts/       — validate.sh health check
#   Dockerfile     — Universal base container
#   docker-compose.yml — Multi-service orchestration
#   .env.example   — Environment variable template
#   .gitignore     — Universal language-agnostic ignores
#   README.md      — Human + agent quickstart guide
# =============================================================================

set -euo pipefail

# --- Color output ---
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

ok()   { echo -e "  ${GREEN}✓${NC} $1"; }
info() { echo -e "  ${YELLOW}→${NC} $1"; }
hdr()  { echo -e "\n${CYAN}${BOLD}$1${NC}"; }

PROJECT_NAME="${1:-my-project}"
DATE=$(date +%Y-%m-%d)

echo -e "\n${BOLD}AI-Agent-Optimized Boilerplate Generator${NC}"
echo -e "Project: ${CYAN}${PROJECT_NAME}${NC}"
echo -e "Date:    ${DATE}\n"

# =============================================================================
# 1. DIRECTORY STRUCTURE
# =============================================================================
hdr "1/7  Creating directory structure..."

mkdir -p .ai .git-hooks tests/unit tests/integration tests/e2e src docs scripts

touch tests/unit/.gitkeep tests/integration/.gitkeep \
      tests/e2e/.gitkeep src/.gitkeep docs/.gitkeep

ok "Directories and placeholders created"

# =============================================================================
# 2. AGENT CONTEXT — .ai/
# =============================================================================
hdr "2/7  Writing agent context files (.ai/)..."

# --- RULES.md ---
cat > .ai/RULES.md << 'RULES_EOF'
# Agent Rules & Guardrails

> **AGENT INSTRUCTION:** You MUST read this file before writing any code.
> These rules are non-negotiable. Violations will cause CI to fail.

---

## 1. Absolute Prohibitions (NEVER DO)

- [ ] **No force pushes** to `main` or `develop` branches
- [ ] **No `--no-verify`** flags when committing — hooks exist for a reason
- [ ] **No secrets in code** — no API keys, tokens, passwords, or credentials ever committed
- [ ] **No commented-out code** in final commits — delete it or put it in a branch
- [ ] **No direct edits to generated files** — edit the source template instead
- [ ] **No `any` types** (TypeScript), **no `eval()`**, **no `exec()`** without explicit justification
- [ ] **No dependencies added** without updating lock files and documenting why in `MEMORY.md`
- [ ] **No skipping tests** — if a test is broken, fix it; don't delete or skip it

---

## 2. Code Style Mandates

- **Naming:** Use `snake_case` for files, `camelCase` for variables/functions, `PascalCase` for classes/types
- **Functions:** Max 40 lines per function. If longer, decompose it
- **Files:** Max 300 lines per file. If longer, split by responsibility
- **Comments:** Only explain *why*, never *what*. The code must be self-documenting
- **Commits:** Must follow Conventional Commits: `feat:`, `fix:`, `chore:`, `docs:`, `test:`, `refactor:`

---

## 3. Architecture Constraints

- **No circular dependencies** between modules
- **Separation of concerns:** I/O (DB, API, FS) must be isolated from business logic
- **One responsibility per module** — a file that does two things must be split
- **All external service calls** must go through an adapter/client layer, never called inline
- **Configuration** must come from environment variables, never hardcoded

---

## 4. Testing Requirements

- **Unit tests** required for all business logic functions
- **Integration tests** required for all external service interactions
- **Test file location:** Mirror the `src/` structure inside `tests/unit/`
- **Minimum coverage target:** 80% line coverage (configured in CI)
- **No test shall depend on execution order** — each test must be fully isolated

---

## 5. Security Rules

- **Input validation** at every external boundary (API endpoints, file reads, env vars)
- **Principle of least privilege** — no component requests more permissions than it needs
- **Dependencies:** Run `npm audit` / `pip-audit` / equivalent before any release
- **No dynamic query construction** from user input — use parameterized queries only

---

## 6. Agent-Specific Workflow

1. Read `STATE.md` before starting any work session
2. Update `STATE.md` → `## Current Focus` before making changes
3. Log any new architectural decision in `MEMORY.md`
4. Run pre-commit hooks locally before pushing: `bash .git-hooks/pre-commit`
5. Mark completed DoD items in `STATE.md` as you finish them
RULES_EOF
ok ".ai/RULES.md"

# --- ARCHITECTURE.md ---
cat > .ai/ARCHITECTURE.md << 'ARCH_EOF'
# System Architecture

> **AGENT INSTRUCTION:** Update this document whenever you add, remove, or
> significantly refactor a component. This is the single source of truth for
> system structure.

---

## 1. System Overview

```
[Replace with a one-paragraph description of what this system does and its
primary user-facing value proposition.]
```

---

## 2. Directory Map

```
project-root/
├── .ai/                  # Agent context — rules, architecture, memory
├── .git-hooks/           # Pre-commit validation scripts
├── src/                  # All application source code
│   ├── [domain-a]/       # Feature/domain module
│   └── [domain-b]/       # Feature/domain module
├── tests/
│   ├── unit/             # Pure function tests, no I/O
│   ├── integration/      # Tests that touch DBs, APIs, FS
│   └── e2e/              # End-to-end user-flow tests
├── docs/                 # Human-facing documentation
├── scripts/              # Operational and utility scripts
├── Dockerfile            # Containerized runtime definition
├── docker-compose.yml    # Multi-service orchestration
└── STATE.md              # Agent state tracker (current focus, blockers, DoD)
```

---

## 3. Component Map

> Replace each placeholder with your actual components.

| Component | Location | Responsibility | Depends On |
|-----------|----------|----------------|------------|
| `[ComponentA]` | `src/[domain-a]/` | [What it does] | [ComponentB] |
| `[ComponentB]` | `src/[domain-b]/` | [What it does] | None |
| `[AdapterX]`   | `src/adapters/`   | Wraps external service X | [ComponentA] |

---

## 4. Data Flow

```
[Describe the primary data flow as a text diagram or numbered steps]

Example:
1. Request arrives at [Entry Point]
2. [ComponentA] validates and parses input
3. [ComponentB] executes business logic against [Data Store]
4. [AdapterX] serializes and returns response
```

---

## 5. External Dependencies & Integrations

| Service/Library | Purpose | Config Location | Notes |
|-----------------|---------|-----------------|-------|
| `[ServiceA]`    | [Why]   | `ENV: SERVICE_A_URL` | [Any quirks] |

---

## 6. Data Models

```
[Entity: User]
- id: UUID (primary key)
- created_at: ISO 8601 timestamp
- [Add fields]
```

---

## 7. API Contracts

```
[Endpoint: POST /api/[resource]]
Request:  { "field": "type" }
Response: { "field": "type" }
Errors:   400 (validation), 401 (auth), 500 (internal)
```

---

## 8. Infrastructure

- **Runtime:** [e.g., Node 20, Python 3.12, Go 1.22]
- **Container:** Docker — see `Dockerfile` and `docker-compose.yml`
- **CI/CD:** [e.g., GitHub Actions — see `.github/workflows/`]
- **Environment Variables required:**
  ```
  APP_PORT=
  DATABASE_URL=
  [Add all required env vars]
  ```
ARCH_EOF
ok ".ai/ARCHITECTURE.md"

# --- MEMORY.md ---
cat > .ai/MEMORY.md << MEMORY_EOF
# Agent Memory Log

> **AGENT INSTRUCTION:** This is a write-append log. NEVER delete entries.
> Add a new entry every time you make a significant architectural decision,
> discover a non-obvious bug, or identify a known system quirk.
> Format: \`## [YYYY-MM-DD] Title\`

---

## How to Use This File

- **Before starting:** Read the last 5 entries for recent context
- **After deciding:** Log *why* you made a non-obvious choice
- **After discovering a quirk:** Document it so future agents don't repeat the investigation
- **Log format:**
  \`\`\`
  ## [DATE] Short descriptive title
  **Context:** What were you trying to do?
  **Decision/Discovery:** What did you find or decide?
  **Alternatives considered:** What else did you evaluate?
  **Consequence:** What is the downstream impact?
  **Files affected:** List of files changed
  \`\`\`

---

## [${DATE}] Project Initialized

**Context:** Boilerplate project structure created for AI-agent-optimized development.

**Decision/Discovery:** Adopted \`.ai/\` directory convention to concentrate all
agent-facing context in a single, predictable location. This avoids agents
having to search the codebase for rules and prior decisions.

**Alternatives considered:** Embedding rules in README.md — rejected because README
becomes too long and agents tend to deprioritize non-code files.

**Consequence:** All agents MUST read \`.ai/RULES.md\` before touching any file.
CI enforces this via the pre-commit hook structure.

**Files affected:** \`.ai/RULES.md\`, \`.ai/ARCHITECTURE.md\`, \`.ai/MEMORY.md\`, \`STATE.md\`

---

<!-- Add new entries below this line, newest first -->
MEMORY_EOF
ok ".ai/MEMORY.md"

# =============================================================================
# 3. STATE.md
# =============================================================================
hdr "3/7  Writing STATE.md..."

cat > STATE.md << STATE_EOF
# Agent State

> **AGENT INSTRUCTION:** Read this file FIRST at the start of every session.
> Update it LAST at the end of every session. This is your working memory
> between sessions. Keep it accurate and concise.

---

## Current Focus

\`\`\`
[AGENT: Replace this block with a single sentence describing what you are
actively working on right now. Be specific about the file and function.]
\`\`\`

**Status:** \`IDLE\` <!-- Options: IDLE | IN_PROGRESS | BLOCKED | REVIEW_NEEDED -->

**Branch:** \`main\`

**Last active:** \`${DATE}\`

---

## Active Blockers

- None

---

## Definition of Done (DoD) Checklist

### Current Task: [Task Name — replace me]

- [ ] All new functions have corresponding unit tests in \`tests/unit/\`
- [ ] All new external integrations have integration tests in \`tests/integration/\`
- [ ] Pre-commit hook passes locally (\`bash .git-hooks/pre-commit\`)
- [ ] \`ARCHITECTURE.md\` updated if any component was added or changed
- [ ] \`MEMORY.md\` updated with any non-obvious decisions made
- [ ] No \`console.log\` / \`print\` debug statements left in code
- [ ] All new environment variables documented in \`ARCHITECTURE.md §8\`
- [ ] Docker build succeeds: \`docker-compose build\`
- [ ] Code reviewed against \`.ai/RULES.md\` — no violations
- [ ] Conventional commit message written and commit made

---

## Recent Decisions (Session Log)

| Time (UTC) | Decision | Rationale |
|------------|----------|-----------|
| ${DATE} | Project initialized | Boilerplate setup |

---

## Parking Lot

- (empty)
STATE_EOF
ok "STATE.md"

# =============================================================================
# 4. GIT HOOKS
# =============================================================================
hdr "4/7  Writing .git-hooks/..."

cat > .git-hooks/pre-commit << 'HOOK_EOF'
#!/usr/bin/env bash
# Pre-Commit Hook — Deterministic Validation Gate
# Install: bash .git-hooks/install-hooks.sh
# Run manually: bash .git-hooks/pre-commit

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
PASS="${GREEN}[PASS]${NC}"; FAIL="${RED}[FAIL]${NC}"; WARN="${YELLOW}[WARN]${NC}"
INFO="${YELLOW}[INFO]${NC}"; ERRORS=0

log_pass() { echo -e "${PASS} $1"; }
log_fail() { echo -e "${FAIL} $1"; ERRORS=$((ERRORS + 1)); }
log_warn() { echo -e "${WARN} $1"; }
log_info() { echo -e "${INFO} $1"; }

echo ""; echo "===== Pre-Commit Validation Gate ====="; echo ""

# CHECK 1: Secrets scan
log_info "Scanning for hardcoded secrets..."
SECRET_PATTERNS=('password\s*=\s*["'"'"'][^"'"'"']{4,}' 'api_key\s*=\s*["'"'"'][^"'"'"']{8,}'
  'secret\s*=\s*["'"'"'][^"'"'"']{8,}' 'AWS_SECRET_ACCESS_KEY' 'BEGIN RSA PRIVATE' 'BEGIN OPENSSH PRIVATE')
STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null || true)
SECRET_FOUND=0
for pat in "${SECRET_PATTERNS[@]}"; do
  if echo "$STAGED_FILES" | xargs -I{} git show ":{}" 2>/dev/null | grep -qiE "$pat" 2>/dev/null; then
    log_fail "Potential secret matched: '$pat'"; SECRET_FOUND=1
  fi
done
[ "$SECRET_FOUND" -eq 0 ] && log_pass "No hardcoded secrets detected"

# CHECK 2: Debug artifacts
log_info "Checking for debug artifacts..."
DEBUG_PATTERNS=('console\.log\(' 'debugger;' 'binding\.pry' 'import pdb' 'pdb\.set_trace')
DEBUG_FOUND=0
for pat in "${DEBUG_PATTERNS[@]}"; do
  MATCHES=$(echo "$STAGED_FILES" | xargs grep -lE "$pat" 2>/dev/null || true)
  if [ -n "$MATCHES" ]; then log_warn "Debug '$pat' in: $MATCHES"; DEBUG_FOUND=1; fi
done
[ "$DEBUG_FOUND" -eq 0 ] && log_pass "No debug artifacts found"

# CHECK 3: Conventional Commits
log_info "Checking commit message format..."
COMMIT_MSG_FILE=".git/COMMIT_EDITMSG"
CC_PATTERN='^(feat|fix|docs|style|refactor|test|chore|ci|perf|build|revert)(\(.+\))?: .{1,100}$'
if [ -f "$COMMIT_MSG_FILE" ]; then
  MSG=$(head -1 "$COMMIT_MSG_FILE")
  if echo "$MSG" | grep -qE "$CC_PATTERN"; then
    log_pass "Commit message follows Conventional Commits"
  else
    log_fail "Bad commit message: '$MSG' (expected: 'type(scope): description')"
  fi
fi

# CHECK 4: Run tests (auto-detect runner)
log_info "Running test suite..."
if command -v pytest &>/dev/null; then
  pytest tests/unit/ -q --tb=short 2>&1 && log_pass "pytest passed" || log_fail "pytest FAILED"
elif command -v npm &>/dev/null && [ -f package.json ]; then
  npm test --silent 2>&1 && log_pass "npm test passed" || log_fail "npm test FAILED"
elif command -v go &>/dev/null && [ -f go.mod ]; then
  go test ./... 2>&1 && log_pass "go test passed" || log_fail "go test FAILED"
else
  log_warn "No recognized test runner — skipping tests"
fi

# CHECK 5: STATE.md consistency
log_info "Checking STATE.md status..."
CODE_CHANGES=$(echo "$STAGED_FILES" | grep -v '\.md$' | grep -v '^\.ai/' || true)
if [ -n "$CODE_CHANGES" ] && [ -f STATE.md ]; then
  grep -q 'Status.*IDLE' STATE.md 2>/dev/null \
    && log_warn "STATE.md is IDLE but code changes detected — update your state" \
    || log_pass "STATE.md status consistent"
fi

echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo -e "${RED}BLOCKED: $ERRORS check(s) failed. Fix before committing.${NC}"; echo ""; exit 1
else
  echo -e "${GREEN}All checks passed.${NC}"; echo ""; exit 0
fi
HOOK_EOF

cat > .git-hooks/install-hooks.sh << 'INSTALL_EOF'
#!/usr/bin/env bash
# Usage: bash .git-hooks/install-hooks.sh
set -euo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TGT="$(git rev-parse --show-toplevel)/.git/hooks"
echo "Installing hooks: $SRC → $TGT"
for f in "$SRC"/*; do
  name="$(basename "$f")"
  [ "$name" = "install-hooks.sh" ] && continue
  [ -f "$TGT/$name" ] && [ ! -L "$TGT/$name" ] && mv "$TGT/$name" "$TGT/${name}.bak" && echo "[backed up] ${name}.bak"
  ln -sf "$f" "$TGT/$name" && chmod +x "$f"
  echo "[installed] $name"
done
echo "Done. Run 'bash .git-hooks/pre-commit' to test."
INSTALL_EOF

chmod +x .git-hooks/pre-commit .git-hooks/install-hooks.sh
ok ".git-hooks/pre-commit"
ok ".git-hooks/install-hooks.sh"

# =============================================================================
# 5. VALIDATE SCRIPT
# =============================================================================
hdr "5/7  Writing scripts/validate.sh..."

cat > scripts/validate.sh << 'VAL_EOF'
#!/usr/bin/env bash
# Full project health check. Usage: bash scripts/validate.sh [--fast]
set -euo pipefail
FAST=false; [[ "${1:-}" == "--fast" ]] && FAST=true
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
ERRORS=0
ok()   { echo -e "${GREEN}[OK]${NC}   $1"; }
fail() { echo -e "${RED}[FAIL]${NC} $1"; ERRORS=$((ERRORS + 1)); }
info() { echo -e "${YELLOW}[INFO]${NC} $1"; }
echo ""; echo "=== Project Validation ==="; echo ""

info "Running tests..."
if   command -v pytest &>/dev/null;                       then pytest tests/ -q && ok "pytest"     || fail "pytest"; \
elif command -v npm &>/dev/null && [ -f package.json ];   then npm test --silent && ok "npm test"  || fail "npm test"; \
elif command -v go  &>/dev/null && [ -f go.mod ];         then go test ./... && ok "go test"       || fail "go test"; \
else info "No test runner found"; fi

if [ "$FAST" = false ] && [ -f Dockerfile ] && command -v docker &>/dev/null; then
  info "Building Docker image..."
  docker-compose build --quiet && ok "docker-compose build" || fail "docker-compose build"
fi

info "Checking agent context files..."
[ -f STATE.md ]             && ok "STATE.md"             || fail "STATE.md MISSING"
[ -f .ai/RULES.md ]         && ok ".ai/RULES.md"         || fail ".ai/RULES.md MISSING"
[ -f .ai/ARCHITECTURE.md ]  && ok ".ai/ARCHITECTURE.md"  || fail ".ai/ARCHITECTURE.md MISSING"
[ -f .ai/MEMORY.md ]        && ok ".ai/MEMORY.md"        || fail ".ai/MEMORY.md MISSING"

echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo -e "${RED}=== FAILED: $ERRORS issue(s) ===${NC}"; exit 1
else
  echo -e "${GREEN}=== All checks passed ===${NC}"; exit 0
fi
VAL_EOF

chmod +x scripts/validate.sh
ok "scripts/validate.sh"

# =============================================================================
# 6. DOCKER
# =============================================================================
hdr "6/7  Writing Dockerfile and docker-compose.yml..."

cat > Dockerfile << 'DOCKER_EOF'
# =============================================================================
# Dockerfile — Universal Language-Agnostic Base
# Replace FROM image and CMD with your runtime's equivalent.
# Agent: Always COPY dependency manifests BEFORE source (layer cache).
# =============================================================================

FROM ubuntu:24.04 AS base
LABEL description="Replace with your project description"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates bash git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# COPY [dependency-manifest] ./    ← copy manifest first for cache efficiency
# RUN  [install-dependencies]

COPY . .

# RUN [build-command]              ← compiled languages only

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

RUN useradd -r -u 1001 -g root appuser
USER appuser

CMD ["bash", "-c", "echo 'Replace this CMD with your start command'"]
DOCKER_EOF
ok "Dockerfile"

cat > docker-compose.yml << 'COMPOSE_EOF'
# =============================================================================
# docker-compose.yml — Multi-Service Orchestration
# Usage:
#   docker-compose up --build
#   docker-compose run --rm app bash scripts/validate.sh
#   docker-compose --profile test run test
# =============================================================================

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    image: project-app:local
    volumes:
      - .:/app
      - /app/node_modules
    env_file: [.env.example]
    environment:
      - APP_PORT=8080
    ports:
      - "8080:8080"
    depends_on:
      db:
        condition: service_healthy
    networks: [app-network]

  db:
    image: postgres:16-alpine
    container_name: project-db
    restart: unless-stopped
    environment:
      POSTGRES_DB: appdb
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD: apppassword
    volumes: [db-data:/var/lib/postgresql/data]
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U appuser -d appdb"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks: [app-network]

  test:
    build: { context: ., dockerfile: Dockerfile }
    volumes: [.:/app]
    environment: [APP_ENV=test]
    command: ["bash", "scripts/validate.sh"]
    depends_on:
      db:
        condition: service_healthy
    networks: [app-network]
    profiles: [test]

volumes:
  db-data: { driver: local }

networks:
  app-network: { driver: bridge }
COMPOSE_EOF
ok "docker-compose.yml"

# =============================================================================
# 7. SUPPORT FILES
# =============================================================================
hdr "7/7  Writing support files..."

cat > .env.example << 'ENV_EOF'
# Copy to .env — NEVER commit .env
# Agent: Document new vars here AND in ARCHITECTURE.md §8

APP_PORT=8080
APP_ENV=development
LOG_LEVEL=debug

DATABASE_URL=postgresql://appuser:apppassword@db:5432/appdb
DATABASE_POOL_SIZE=10

# EXTERNAL_API_URL=https://api.example.com
# EXTERNAL_API_KEY=replace-me
# JWT_SECRET=replace-with-a-long-random-string
ENV_EOF
ok ".env.example"

cat > .gitignore << 'IGNORE_EOF'
# Secrets
.env
.env.local
*.pem
*.key
secrets/
# OS / Editor
.DS_Store
.idea/
.vscode/
*.swp
*~
# Node.js
node_modules/
dist/
build/
coverage/
.next/
.cache/
# Python
__pycache__/
*.py[cod]
*.egg-info/
.venv/
venv/
.pytest_cache/
.coverage
htmlcov/
# Go
*.exe
/bin/
*.test
# Rust
target/
# Java
*.class
*.jar
target/
# Docker
docker-compose.override.yml
# Logs
logs/
*.log
# Temp
tmp/
*.tmp
*.bak
IGNORE_EOF
ok ".gitignore"

cat > README.md << README_EOF
# ${PROJECT_NAME}

> One-sentence description of what this project does.

---

## Agent Quickstart

Read in order before touching code:
1. \`.ai/RULES.md\` — Non-negotiable guardrails
2. \`STATE.md\` — Current focus and Definition of Done
3. \`.ai/ARCHITECTURE.md\` — System map and contracts
4. \`.ai/MEMORY.md\` — Prior decisions and quirks

Then: \`bash .git-hooks/install-hooks.sh\`

---

## Human Quickstart

\`\`\`bash
bash .git-hooks/install-hooks.sh    # Install pre-commit hooks
cp .env.example .env                # Configure environment
docker-compose up --build           # Start full stack
bash scripts/validate.sh --fast     # Run validation (local)
\`\`\`

---

## Project Structure

\`\`\`
.ai/                — Agent context (RULES, ARCHITECTURE, MEMORY)
.git-hooks/         — Pre-commit validation gate
src/                — Application source
tests/unit/         — Pure function tests
tests/integration/  — External service tests
tests/e2e/          — End-to-end flow tests
scripts/            — Operational scripts
Dockerfile          — Container runtime
docker-compose.yml  — Multi-service orchestration
STATE.md            — Agent state tracker
\`\`\`

---

## Key Commands

| Command | Description |
|---------|-------------|
| \`docker-compose up --build\` | Start full stack |
| \`docker-compose run --rm app bash scripts/validate.sh\` | Run all checks |
| \`bash scripts/validate.sh --fast\` | Local checks (skip Docker) |
| \`bash .git-hooks/pre-commit\` | Run pre-commit gate manually |
README_EOF
ok "README.md"

# =============================================================================
# FINAL SUMMARY
# =============================================================================
echo -e "\n${BOLD}${GREEN}========================================${NC}"
echo -e "${BOLD}${GREEN}  Boilerplate generated successfully!${NC}"
echo -e "${BOLD}${GREEN}========================================${NC}"
echo ""
echo -e "  Project: ${CYAN}${PROJECT_NAME}${NC}"
echo ""
echo -e "  ${BOLD}Next steps:${NC}"
echo -e "  1. git init && git add . && git commit -m 'chore: initialize ai-agent boilerplate'"
echo -e "  2. bash .git-hooks/install-hooks.sh"
echo -e "  3. cp .env.example .env  &&  edit .env with real values"
echo -e "  4. Fill in the placeholders in .ai/ARCHITECTURE.md"
echo -e "  5. docker-compose up --build"
echo ""
echo -e "  ${BOLD}File tree created:${NC}"
tree -a --noreport -I '.git' . 2>/dev/null || find . -not -path './.git/*' | sort | sed 's|[^/]*/|  |g'
echo ""
