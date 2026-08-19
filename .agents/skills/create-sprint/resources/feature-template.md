# Feature File Template

Each feature in a sprint gets its own markdown file. Use this template for every
feature file created under `docs/Sprints/Sprint-X.Y/`.

**File naming convention**: `feature-N-short-name.md`
- Example: `feature-1-user-authentication.md`, `feature-2-dashboard-layout.md`

---

```markdown
# Feature: [Feature Name]

## Overview
[What this feature does and why it matters]

## User Stories
[Relevant user stories from the blueprint]

## Implementation Plan

### UI Components
[List of UI components to build, with descriptions]

### Data Model (Mock)
[Mock data structures and sample data to use during UI-first development]

### Simulated Backend
[Description of simulated API responses, mock services, or stub functions]

### Step-by-Step Implementation
1. [Step 1 — be specific about files to create/modify]
2. [Step 2]
3. [Step 3]
...

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Dependencies
- **Internal**: [None — this feature is independent within this sprint]
- **External**: [Any external libraries or services needed]
```

---

## Progress Entry Template

When adding a new sprint to `docs/progress.md`, use:

```markdown
| Sprint X.Y | 🔄 In Progress | [Brief description of sprint focus] |
```
