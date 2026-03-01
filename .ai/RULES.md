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
