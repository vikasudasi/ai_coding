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

> Define your core entities here so agents never invent schema inconsistently.

```
[Entity: User]
- id: UUID (primary key)
- created_at: ISO 8601 timestamp
- [Add fields]

[Entity: ...]
```

---

## 7. API Contracts

> Agents must match these contracts exactly. Do not add fields not listed here.

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
