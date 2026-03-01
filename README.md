# Project Name

> **One-sentence description of what this project does.**

---

## Agent Quickstart

If you are an AI agent, read these files in order before touching any code:

1. `.ai/RULES.md` — Non-negotiable guardrails and style rules
2. `STATE.md` — Current task focus, blockers, and Definition of Done
3. `.ai/ARCHITECTURE.md` — System map and component contracts
4. `.ai/MEMORY.md` — Prior decisions and known quirks

Then install hooks: `bash .git-hooks/install-hooks.sh`

---

## Human Quickstart

```bash
# 1. Clone and set up hooks
git clone <repo-url> && cd <repo>
bash .git-hooks/install-hooks.sh

# 2. Configure environment
cp .env.example .env
# Edit .env with your real values

# 3. Start the full stack in Docker
#    (App container runs a placeholder CMD until you replace it in the Dockerfile.)
docker-compose up --build

# 4. Run validation suite
docker-compose run --rm app bash scripts/validate.sh
# or locally (fast mode, skips Docker):
bash scripts/validate.sh --fast
```

---

## Project Structure

```
project-root/
├── .ai/                  # Agent context (rules, architecture, memory)
│   ├── RULES.md          # Strict guardrails and banned practices
│   ├── ARCHITECTURE.md   # System map, data flow, API contracts
│   └── MEMORY.md         # Decision log and known quirks
├── .git-hooks/           # Git hook scripts
│   ├── pre-commit        # Checks: secrets, debug artifacts, tests, Docker, STATE.md
│   ├── commit-msg        # Validates Conventional Commits format
│   └── install-hooks.sh  # Symlinks hooks into .git/hooks/
├── src/                  # Application source code
├── tests/
│   ├── unit/             # Pure function tests (no I/O)
│   ├── integration/      # Tests touching external services
│   └── e2e/              # End-to-end flow tests
├── docs/                 # Human-facing documentation
├── scripts/
│   └── validate.sh       # Full project health check script
├── Dockerfile            # Container runtime definition
├── docker-compose.yml    # Multi-service orchestration
├── .env.example          # Environment variable template
├── STATE.md              # Agent state tracker
└── .gitignore
```

---

## Key Commands

| Command | Description |
|---------|-------------|
| `docker-compose up --build` | Start full stack |
| `docker-compose run --rm app bash scripts/validate.sh` | Run all checks |
| `bash scripts/validate.sh --fast` | Run checks (skip Docker build) |
| `bash .git-hooks/pre-commit` | Run pre-commit checks manually |
| `bash .git-hooks/install-hooks.sh` | Install git hooks |
