# Feature 2: React Kanban Board with Native HTML5 Drag and Drop

## Overview
Create the frontend application under the `client/` directory using React, Vite, and pnpm. Implement a single-page visual Kanban board with 4 status columns (`TODO`, `IN_PROGRESS`, `REVIEW`, `DONE`), native HTML5 Drag and Drop (without external drag-and-drop libraries), inline status change dropdowns, task creation/editing modals, and REST API integration with the Django backend.

## User Stories
- As an Admin user, I want to see all tasks categorized into columns by status so I can manage my work visually.
- As an Admin user, I want to drag a task card and drop it onto any status column to change its status instantly without reloading.
- As an Admin user, I want to create new tasks with title, description, priority, and status.
- As an Admin user, I want to edit or delete existing tasks.

## Implementation Plan

### UI Components
1. **`client/` Project Structure**:
   - Initialized via Vite (`pnpm create vite client --template react`).
   - Managed with `pnpm`.

2. **API Layer (`client/src/services/api.js`)**:
   - Modular REST client with methods: `getTasks()`, `createTask(data)`, `updateTask(id, data)`, `deleteTask(id)`.

3. **Kanban Board Container (`client/src/components/KanbanBoard.jsx`)**:
   - Holds task state, fetches data from DRF API on mount.
   - Renders 4 columns: To Do (`TODO`), In Progress (`IN_PROGRESS`), Review (`REVIEW`), Done (`DONE`).
   - Implements native drag handlers:
     - `handleDragStart(e, taskId)`: Sets `e.dataTransfer.setData('text/plain', taskId)` and applies dragging class.
     - `handleDragOver(e, status)`: Calls `e.preventDefault()` to allow dropping and highlights column target.
     - `handleDrop(e, targetStatus)`: Reads `taskId`, updates state optimistically, and dispatches `PATCH /api/tasks/{id}/` request to backend.

4. **Kanban Column Component (`client/src/components/KanbanColumn.jsx`)**:
   - Renders column header with badge showing task count.
   - Handles drop zone events (`onDragOver`, `onDragLeave`, `onDrop`).
   - Renders `TaskCard` list inside the column container.

5. **Task Card Component (`client/src/components/TaskCard.jsx`)**:
   - Attributes: `draggable={true}`, `onDragStart`.
   - Displays Title, Description snippet, Priority badge (Low/Medium/High), Assignee pill ("Admin"), and inline Status dropdown selector for quick manual switching.
   - Quick action buttons: Edit, Delete.

6. **Task Modal Component (`client/src/components/TaskModal.jsx`)**:
   - Reusable modal dialog for creating a new task or editing an existing task.
   - Form fields: Title (text), Description (textarea), Priority (dropdown: Low, Medium, High), Status (dropdown: To Do, In Progress, Review, Done), Assignee (text, default: "Admin").

### Step-by-Step Implementation
1. Initialize Vite React project in `client/` using `pnpm`.
2. Install minimal packages: `lucide-react` for icons.
3. Build API integration module `src/services/api.js`.
4. Create components (`KanbanBoard`, `KanbanColumn`, `TaskCard`, `TaskModal`).
5. Implement native HTML5 Drag and Drop handlers without 3rd party dnd dependencies.
6. Connect board state to backend API with optimistic state updates and error rollbacks.

## Acceptance Criteria
- [ ] React frontend runs cleanly on dev server using `pnpm dev`.
- [ ] Board renders 4 status columns (`TODO`, `IN_PROGRESS`, `REVIEW`, `DONE`).
- [ ] Task drag and drop works using native browser events without any 3rd party dnd library.
- [ ] Dropping a task into a column immediately updates its status on screen and sends a PATCH request to the backend.
- [ ] Task creation modal allows adding new tasks which persist to SQLite database.
- [ ] Inline status dropdown on task cards allows status changes without dragging.
- [ ] Assignee field defaults to "Admin".

## Dependencies
- **Internal**: Feature 1 (Backend REST API endpoints).
- **External**: React, Vite, pnpm, Lucide React (icons).
