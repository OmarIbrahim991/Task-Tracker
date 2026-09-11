---
name: create-sprint
description: >-
  Use this skill when the user invokes /create_sprint. It handles two workflows:
  (1) When the user provides project requirements, generate a blueprint.md containing
  a Product Requirements Document and Technical Breakdown. (2) When the user provides
  no requirements or asks for a new sprint, generate sprint folders with implementation
  plans for ALL remaining features. Features are batched into groups of up to 3 per
  sprint folder, creating consecutive sprints (e.g. Sprint 6.0, Sprint 6.1, Sprint 6.2)
  when there are more than 3 features. All documents are placed under the docs/ folder.
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
    ├── Sprint-1.0/           # First batch of features
    │   └── feature-N-name.md # One file per feature (up to 3 per sprint)
    ├── Sprint-1.1/           # Second batch (if >3 features)
    │   └── feature-N-name.md
    └── ...
```

---

## Sprint Versioning

| Scenario | Rule | Example |
|---|---|---|
| New features (first batch) | Increment **left**, reset right to 0 | 1.0 → 2.0 |
| Overflow batch (>3 features) | Same **left**, increment **right** | 6.0 → 6.1 → 6.2 |
| Modify existing sprint | Increment **right** after last batch | 1.2 → 1.3 |
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
2. **Determine base version number** using the versioning rules above. This is the
   `X.0` of the first batch.
3. **Collect ALL remaining features** from the roadmap (skip completed items).
4. **Batch features** into groups of up to 3, preserving roadmap order. Each batch
   becomes a consecutive sprint folder:
   - Batch 1 → `Sprint-X.0/`
   - Batch 2 → `Sprint-X.1/`
   - Batch 3 → `Sprint-X.2/`
   - …and so on until all features are covered.
5. **Within each batch**, all features must be **independent** — implementable in
   parallel with the other features in the same batch.
6. **Create** each `docs/Sprints/Sprint-X.Y/` folder with one file per feature using
   the template in [feature-template.md](./resources/feature-template.md).
7. **Update** `docs/progress.md` with entries for **every** new sprint folder
   (🔄 In Progress).
8. **Update** `docs/blueprint.md` if the roadmap was affected.

---

## Constraints

- **All features are planned** — Every remaining roadmap feature gets a document.
- **Up to 3 features per sprint folder** — When there are more than 3 features, split
  them across consecutive sprint folders (X.0, X.1, X.2, …).
- **Feature independence** — No feature depends on another in the same sprint batch.
- **Blueprint stays in sync** — Update it whenever the plan changes.
- **Progress tracking is mandatory** — Every sprint folder is logged in `docs/progress.md`.
- **Sprint 0.0 is always first**.
- **Be specific** — Feature files must include file paths, component names, data
  structures, and mock data examples.
- **UI-first by default** — Mock data and simulated backend unless user requests
  otherwise. Backend integration comes in later sprints.
