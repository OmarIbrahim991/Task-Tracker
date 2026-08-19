---
name: create-sprint
description: >-
  Use this skill when the user invokes /create_sprint. It handles two workflows:
  (1) When the user provides project requirements, generate a blueprint.md containing
  a Product Requirements Document and Technical Breakdown. (2) When the user provides
  no requirements or asks for a new sprint, generate a sprint folder with implementation
  plans for up to 3 independent features. All documents are placed under the docs/ folder.
---

# Create Sprint Skill

This skill manages project planning and sprint generation. It operates in two modes
depending on the user's input.

---

## File Structure

All generated documents live under `docs/` in the project root:

```
docs/
├── blueprint.md              # PRD + Technical Breakdown
├── progress.md               # Tracks completed sprints
└── Sprints/
    ├── Sprint-0.0/           # Initial planning sprint
    ├── Sprint-1.0/           # First implementation sprint
    │   └── feature-N-name.md # One file per feature (max 3)
    └── ...
```

---

## Sprint Versioning

| Scenario | Rule | Example |
|---|---|---|
| New features | Increment **left**, reset right to 0 | 1.0 → 2.0 |
| Modify existing sprint | Increment **right** | 1.0 → 1.1 |
| Modify blueprint | Increment **right** of Sprint 0 | 0.0 → 0.1 |
| Project initialization | Always Sprint 0.0 | 0.0 |

---

## Mode Detection

1. **Blueprint Mode** — No `docs/blueprint.md` exists and the user provides project
   requirements. → Generate blueprint + Sprint 0.0.
2. **Sprint Mode** — `docs/blueprint.md` exists. → Generate next sprint, a minor
   revision, or a blueprint modification (Sprint 0.X).

---

## Mode 1: Blueprint Generation

**Trigger**: No existing `docs/blueprint.md` + user provides requirements.

### Steps

1. Gather requirements from user input. Ask clarifying questions if vague.
2. Create `docs/blueprint.md` using the template in
   [blueprint-templates.md](./resources/blueprint-templates.md).
3. Create `docs/progress.md` using the progress template in the same resource file.
4. Create `docs/Sprints/Sprint-0.0/sprint-overview.md` using the Sprint 0.0 template
   in the same resource file.

---

## Mode 2: Sprint Generation

**Trigger**: `docs/blueprint.md` exists.

### Steps

1. **Read current state**: `docs/blueprint.md`, `docs/progress.md`, and existing
   sprint folders under `docs/Sprints/`.
2. **Determine version number** using the versioning rules above.
3. **Select up to 3 features** from the roadmap (skip completed items). All features
   in a sprint must be **independent** — implementable in parallel.
4. **Create** `docs/Sprints/Sprint-X.Y/` with one file per feature using the template
   in [feature-template.md](./resources/feature-template.md).
5. **Update** `docs/progress.md` with the new sprint entry (🔄 In Progress).
6. **Update** `docs/blueprint.md` if the roadmap was affected.

---

## Constraints

- **Max 3 features per sprint**. Fewer is fine.
- **Feature independence** — No feature depends on another in the same sprint.
- **Blueprint stays in sync** — Update it whenever the plan changes.
- **Progress tracking is mandatory** — Every sprint is logged in `docs/progress.md`.
- **Sprint 0.0 is always first**.
- **Be specific** — Feature files must include file paths, component names, data
  structures, and mock data examples.
- **UI-first by default** — Mock data and simulated backend unless user requests
  otherwise. Backend integration comes in later sprints.
