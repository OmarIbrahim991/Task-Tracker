# Feature 3: React Hook Dependency Corrections

## Overview
Fix all Biome `lint/correctness/useExhaustiveDependencies` diagnostics reported by `pnpm check`. The `KanbanBoard.jsx` and `TaskModal.jsx` components declare `useEffect` hooks whose dependency arrays either omit referenced functions or include unrelated values.

## User Stories
- As a developer, I want correct `useEffect` dependency arrays so hooks re-run with the right state and no stale closures cause bugs.

## Implementation Plan

### UI Components
- `client/src/components/KanbanBoard.jsx`
- `client/src/components/TaskModal.jsx`

### Data Model (Mock)
None — no data changes.

### Simulated Backend
None — no API changes.

### Step-by-Step Implementation
1. **`client/src/components/KanbanBoard.jsx`** — first effect (line 68):
   - The initial fetch effect `useEffect(() => { fetchTasks() }, [])` omits `fetchTasks`.
   - Fix: wrap `fetchTasks` in `useCallback` (with stable deps) so it can be safely included in the dependency array `[fetchTasks]`, or inline the fetch logic directly in the effect. Do NOT re-run the fetch on every render.
2. **`client/src/components/KanbanBoard.jsx`** — second effect (line 134):
   - `useEffect(() => { if (registerSaveHandler) registerSaveHandler(handleSaveTask) }, [tasks, useFallback, registerSaveHandler])` omits `handleSaveTask` and lists unnecessary deps `tasks` and `useFallback`.
   - Fix: wrap `handleSaveTask` in `useCallback` (depending on `tasks`, `useFallback`, and the API functions it uses) so it has a stable identity, then use dependency array `[registerSaveHandler, handleSaveTask]`. Remove `tasks` and `useFallback` from the array.
3. **`client/src/components/TaskModal.jsx`** — effect (line 14):
   - `useEffect(() => { ... setFormData(...) ... }, [taskToEdit, isOpen])` lists unnecessary dep `isOpen`.
   - Fix: remove `isOpen` from the dependency array; the effect should reset form state only when `taskToEdit` changes.

## Acceptance Criteria
- [ ] `pnpm check` reports 0 `lint/correctness/useExhaustiveDependencies` diagnostics.
- [ ] `KanbanBoard.jsx` effects use `useCallback`-stabilized handlers with accurate dependency arrays.
- [ ] Initial task fetch still runs exactly once on mount.
- [ ] `TaskModal.jsx` form resets correctly when `taskToEdit` changes and is unaffected by the `isOpen` toggle.

## Dependencies
- **Internal**: None — this feature is independent within this sprint.
- **External**: None.