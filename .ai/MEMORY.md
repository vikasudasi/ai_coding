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

<!-- Add new entries below this line, newest first -->
