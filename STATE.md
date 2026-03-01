# Agent State

> **AGENT INSTRUCTION:** Read this file FIRST at the start of every session.
> Update it LAST at the end of every session. This is your working memory
> between sessions. Keep it accurate and concise.

---

## Current Focus

```
[AGENT: Replace this block with a single sentence describing what you are
actively working on right now. Be specific about the file and function.]

Example: "Implementing the `validateUser()` function in `src/auth/validator.js`
to fix the token expiry logic described in issue #42."
```

**Status:** `IDLE` <!-- Options: IDLE | IN_PROGRESS | BLOCKED | REVIEW_NEEDED -->

**Branch:** `main` <!-- The git branch you are working on -->

**Last active:** `YYYY-MM-DD HH:MM UTC`

---

## Active Blockers

> List anything preventing forward progress. Empty = no blockers.

```
[AGENT: List blockers as bullet points. Include the specific question or
missing piece of information. If no blockers, write "None".]

Example:
- BLOCKED: Need clarification on rate-limiting strategy before implementing
  the API client in `src/adapters/api-client.js`. See ARCHITECTURE.md §5.
```

- None

---

## Definition of Done (DoD) Checklist

> This is the acceptance criteria for the current task. Do NOT mark a task
> complete until every checked item is satisfied.

### Current Task: [Task Name — replace me]

- [ ] All new functions have corresponding unit tests in `tests/unit/`
- [ ] All new external integrations have integration tests in `tests/integration/`
- [ ] Pre-commit hook passes locally (`bash .git-hooks/pre-commit`)
- [ ] `ARCHITECTURE.md` updated if any component was added or changed
- [ ] `MEMORY.md` updated with any non-obvious decisions made
- [ ] No `console.log` / `print` debug statements left in code
- [ ] All new environment variables documented in `ARCHITECTURE.md §8`
- [ ] Docker build succeeds: `docker-compose build`
- [ ] Code reviewed against `.ai/RULES.md` — no violations
- [ ] Conventional commit message written and commit made

---

## Recent Decisions (Session Log)

> Quick shorthand log for within-session decisions. Full details go in MEMORY.md.

| Time (UTC) | Decision | Rationale |
|------------|----------|-----------|
| —          | Project initialized | Boilerplate setup |

---

## Parking Lot

> Ideas and future work that came up but are OUT OF SCOPE for the current task.
> Do not act on these now. Review at the start of the next task.

- (empty)
