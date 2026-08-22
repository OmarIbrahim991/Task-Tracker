# Feature 2: Import Organization & Code Style Cleanup

## Overview
Fix all Biome `organizeImports`, `lint/style`, and `lint/complexity` diagnostics reported by `pnpm check`. Imports must be sorted alphabetically, empty JSX elements must be self-closing, globals must use the `Number` namespace, and redundant switch cases must be removed.

## User Stories
- As a developer, I want a consistent, sorted import order across all React files so the codebase follows Biome's organization rules.

## Implementation Plan

### UI Components
- `client/vite.config.js`
- `client/src/App.jsx`
- `client/src/components/Navbar.jsx`
- `client/src/components/KanbanBoard.jsx`
- `client/src/components/KanbanColumn.jsx`
- `client/src/components/TaskCard.jsx`
- `client/src/components/TaskModal.jsx`

### Data Model (Mock)
None — no data changes.

### Simulated Backend
None — no API changes.

### Step-by-Step Implementation
1. **Sort imports** (alphabetically, per Biome `organizeImports`) in:
   - `client/vite.config.js` — `react` must come before `vite` (`@vitejs/plugin-react` before `vite`).
   - `client/src/App.jsx` — order: `KanbanBoard`, `Navbar`, `TaskModal`, `ThemeProvider`.
   - `client/src/components/Navbar.jsx` — order: `react`, then `lucide-react`, then `../context/ThemeContext`.
   - `client/src/components/KanbanBoard.jsx` — order: `react`, then `../services/api`, then `./KanbanColumn`.
   - `client/src/components/TaskCard.jsx` — order: `react`, then `lucide-react` (icons sorted: `Edit2`, `Trash2`, `User`).
   - `client/src/components/TaskModal.jsx` — order: `react`, then `lucide-react`.
   - Optionally run `pnpm exec biome check --write` to auto-fix all import sorting.
2. **`client/src/components/KanbanColumn.jsx`**:
   - Line 33: self-close the empty `<span className="column-dot" ...></span>` → `.../>`.
   - Line 23: replace `parseInt(taskIdStr, 10)` with `Number.parseInt(taskIdStr, 10)`.
3. **`client/src/components/TaskCard.jsx`** — remove the useless `case 'LOW':` clause (lines 27-29) since `default` already returns `'badge-priority-low'`.

## Acceptance Criteria
- [ ] `pnpm check` reports 0 `organizeImports` diagnostics.
- [ ] `pnpm check` reports 0 `lint/style/*` and `lint/complexity/*` diagnostics.
- [ ] All JSX elements without children are self-closing.
- [ ] `Number.parseInt` used instead of the global `parseInt`.

## Dependencies
- **Internal**: None — this feature is independent within this sprint.
- **External**: None.