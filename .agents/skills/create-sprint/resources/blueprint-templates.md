# Blueprint Template

Use this template when creating `docs/blueprint.md`.

```markdown
# [Project Name] — Blueprint

## Product Requirements Document

### Overview
[High-level description of the product, its purpose, and target audience]

### Goals & Objectives
[Bullet list of what the product aims to achieve]

### User Stories / Use Cases
[Key user stories in "As a [role], I want [feature], so that [benefit]" format]

### Functional Requirements
[Detailed list of features and behaviors the product must have]

### Non-Functional Requirements
[Performance, security, scalability, accessibility requirements]

### Constraints & Assumptions
[Known limitations, technology constraints, assumptions made]

---

## Technical Breakdown

### Architecture Overview
[High-level architecture: frontend, backend, database, APIs, etc.]

### Technology Stack
[Languages, frameworks, libraries, tools, and services]

### Data Model
[Key entities, relationships, and data flow]

### API Design
[Key endpoints or interfaces — keep high-level]

### Third-Party Integrations
[External services, APIs, or libraries required]

---

## Implementation Roadmap

### Sprint Plan Overview
[Break the full implementation into ordered sprints. Each sprint should
 contain at most 3 features. Order by dependency and priority.]

| Sprint | Focus Area | Features |
|--------|-----------|----------|
| Sprint 1.0 | [Area] | [Feature 1], [Feature 2], [Feature 3] |
| Sprint 2.0 | [Area] | [Feature 4], [Feature 5] |
| ... | ... | ... |

### Implementation Strategy
- Default approach: **UI-first** with mock data and simulated backend.
- Backend integration follows in later sprints unless the user specifies otherwise.
```

---

# Progress Template

Use this template when creating `docs/progress.md`.

```markdown
# Project Progress

This file tracks the completion status of each sprint.

| Sprint | Status | Description |
|--------|--------|-------------|
| Sprint 0.0 | ✅ Complete | Initial blueprint and project planning |
```

---

# Sprint 0.0 Overview Template

Use this template for `docs/Sprints/Sprint-0.0/sprint-overview.md`.

```markdown
# Sprint 0.0 — Project Initialization

## Objective
Establish the product requirements, technical architecture, and implementation roadmap.

## Deliverables
- [x] Product Requirements Document (`docs/blueprint.md`)
- [x] Technical Breakdown (`docs/blueprint.md`)
- [x] Implementation Roadmap (`docs/blueprint.md`)
- [x] Progress tracking (`docs/progress.md`)

## Notes
This sprint represents the planning phase. Implementation begins in Sprint 1.0.
```
