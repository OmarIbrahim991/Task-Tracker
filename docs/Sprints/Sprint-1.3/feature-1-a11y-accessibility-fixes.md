# Feature 1: Accessibility & Keyboard Navigation Fixes

## Overview
Fix all Biome `lint/a11y` diagnostics reported by `pnpm check`. These include missing explicit `type` props on buttons, click events without corresponding keyboard handlers, form labels not associated with their controls, and the `autoFocus` attribute.

## User Stories
- As a user, I want every button to behave predictably inside forms so that pressing Enter doesn't accidentally submit a page.
- As a keyboard-only user, I want every clickable element to be operable via the keyboard so that the board is fully navigable.

## Implementation Plan

### UI Components
- `client/src/components/Navbar.jsx`
- `client/src/components/TaskCard.jsx`
- `client/src/components/TaskModal.jsx`

### Data Model (Mock)
None — no data changes. Pure markup/event-handler fixes.

### Simulated Backend
None — no API changes.

### Step-by-Step Implementation
1. **`client/src/components/Navbar.jsx`** — add `type="button"` to:
   - Theme toggle button (line 18, `className="btn btn-icon"`).
   - "New Task" button (line 21, `className="btn btn-primary"`).
2. **`client/src/components/TaskCard.jsx`**:
   - Add `type="button"` to the Edit button (line 38, `className="btn btn-icon"`).
   - Add `type="button"` to the Delete button (line 49, `className="btn btn-danger-ghost"`).
   - Replace `onClick={(e) => e.stopPropagation()}` on the status `<select>` (line 73) with a keyboard-safe alternative — use `onKeyDown={(e) => e.stopPropagation()}` (and `onKeyUp`) so the `onClick` requirement is satisfied without breaking dropdown interaction.
3. **`client/src/components/TaskModal.jsx`**:
   - Modal overlay (line 44): add `role="presentation"` is not enough — add `onKeyDown` handler (e.g. `onKeyDown={(e) => e.key === 'Escape' && onClose()}`) alongside `onClick={onClose}`.
   - Modal container (line 45): keep `onClick` stopPropagation but add a matching `onKeyDown` stopPropagation handler.
   - Close button (line 48): add `type="button"`.
   - Associate labels with controls using `htmlFor` + matching `id`:
     - "Task Title *" (line 56) → input `id="task-title"`.
     - "Description" (line 69) → textarea `id="task-description"`.
     - "Status" (line 80) → select `id="task-status"`.
     - "Priority" (line 90) → select `id="task-priority"`.
     - "Assignee" (line 104) → input `id="task-assignee"`.
   - Remove the `autoFocus` attribute (line 64) from the title input.

## Acceptance Criteria
- [ ] `pnpm check` reports 0 `lint/a11y/*` diagnostics.
- [ ] Every `<button>` in the three components has an explicit `type` prop.
- [ ] Every `<label>` in `TaskModal.jsx` is associated with its control via `htmlFor`/`id`.
- [ ] Clickable elements with `onClick` have corresponding keyboard event handlers.
- [ ] `autoFocus` removed from the task title input.

## Dependencies
- **Internal**: None — this feature is independent within this sprint.
- **External**: None.