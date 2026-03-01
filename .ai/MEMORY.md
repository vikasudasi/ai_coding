# Agent Memory Log

> **AGENT INSTRUCTION:** This is a write-append log. NEVER delete entries.
> Add a new entry every time you make a significant architectural decision,
> discover a non-obvious bug, or identify a known system quirk.
> Format: `## [YYYY-MM-DD] Title`

---

## How to Use This File

- **Before starting:** Read the last 5 entries for recent context
- **After deciding:** Log *why* you made a non-obvious choice
- **After discovering a quirk:** Document it so future agents don't repeat the investigation
- **Log format:**
  ```
  ## [DATE] Short descriptive title
  **Context:** What were you trying to do?
  **Decision/Discovery:** What did you find or decide?
  **Alternatives considered:** What else did you evaluate?
  **Consequence:** What is the downstream impact?
  **Files affected:** List of files changed
  ```

---

## [YYYY-MM-DD] Project Initialized

**Context:** Boilerplate project structure created for AI-agent-optimized development.

**Decision/Discovery:** Adopted `.ai/` directory convention to concentrate all
agent-facing context in a single, predictable location. This avoids agents
having to search the codebase for rules and prior decisions.

**Alternatives considered:** Embedding rules in README.md — rejected because README
becomes too long and agents tend to deprioritize non-code files.

**Consequence:** All agents MUST read `.ai/RULES.md` before touching any file.
CI enforces this via the pre-commit hook structure.

**Files affected:** `.ai/RULES.md`, `.ai/ARCHITECTURE.md`, `.ai/MEMORY.md`, `STATE.md`

---

## [2025-03-01] Dev-only credentials in docker-compose and .env.example

**Context:** Boilerplate includes a default Postgres password in `docker-compose.yml` and `.env.example` for local development.

**Decision/Discovery:** The values (e.g. `POSTGRES_PASSWORD: apppassword`, `DATABASE_URL=...apppassword@db...`) are intentional for local/dev only. They are not production secrets.

**Alternatives considered:** Omitting defaults — rejected because they make clone-and-run possible. Using Docker secrets only — out of scope for the boilerplate.

**Consequence:** In production, use real secrets (e.g. env from a vault, Docker secrets). Do not commit production `.env` or override files containing real credentials.

**Files affected:** `.ai/MEMORY.md` (this entry)

---

<!-- Add new entries below this line, newest first -->
