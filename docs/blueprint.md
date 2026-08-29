# Task Tracker — Blueprint

## Product Requirements Document

### Overview
Task Tracker is a full-stack task and todo management application featuring an interactive Kanban board layout. Built with a Django REST Framework backend and a React frontend (managed with pnpm), it allows users to organize tasks across configurable status stages using custom native drag-and-drop, filter/edit task details, and toggle between dark and light visual themes seamlessly.

### Goals & Objectives
- Provide a visual single-page Kanban board for real-time task status tracking.
- Enable smooth drag-and-drop task movements across status columns using native browser HTML5 drag-and-drop (zero third-party drag-and-drop dependencies).
- Support full CRUD operations for tasks (Title, Description, Status, Priority, Assignee).
- Allow users to create and delete projects and associate each task with zero or more projects.
- Allow users to filter the board by enabled projects while keeping unassigned tasks available when no project filter is active.
- Allow backend users to be created with a username and password and selected as task assignees.
- Preserve task order within each Kanban column when a card is dropped after a specific task.
- Deliver a modern UI experience supporting Light and Dark modes with persistent user preference.
- Provide a clean, robust backend API using Django REST Framework backed by SQLite.

### User Stories / Use Cases
- **As an Admin user**, I want to view all tasks categorized in status columns (To Do, In Progress, Review, Done) on a unified board view so that I can monitor project progress at a glance.
- **As an Admin user**, I want to drag a task card from one column and drop it into another column to update its status instantly.
- **As an Admin user**, I want to create a new task with a title, description, priority level (Low, Medium, High), and status, with assignee automatically defaulting to "Admin".
- **As an Admin user**, I want to edit existing task details or change status directly via an inline dropdown or modal editor.
- **As an Admin user**, I want to create and delete projects and assign tasks to zero or more projects.
- **As an Admin user**, I want each task card to show its projects as tags and toggle projects on or off to filter visible tasks.
- **As an Admin user**, I want to toggle between Light and Dark mode to comfortably view the application in different lighting environments.
- **As an Admin user**, I want to assign a task to one of the users available from the backend without managing users in the task board UI.
- **As an Admin user**, I want to drop a task after a specific card and have that placement remain after reload.

### Functional Requirements
1. **Backend (Django REST Framework + SQLite)**:
   - REST API endpoints for Tasks:
     - `GET /api/tasks/` — List all tasks.
     - `POST /api/tasks/` — Create a new task (assignee defaults to "Admin" if omitted).
     - `GET /api/tasks/{id}/` — Retrieve a single task.
     - `PUT/PATCH /api/tasks/{id}/` — Update task fields (e.g. status, priority, title, description).
     - `DELETE /api/tasks/{id}/` — Delete a task.
   - REST API endpoints for Projects:
     - `GET /api/projects/` — List all projects.
     - `POST /api/projects/` — Create a project.
     - `GET /api/projects/{id}/` — Retrieve a project and its task references.
     - `DELETE /api/projects/{id}/` — Delete a project without deleting its tasks.
   - Task Data Schema:
     - `id`: Auto-incrementing integer (Primary Key)
     - `title`: String (required, max 255 chars)
     - `description`: Text (optional/blank allowed)
     - `status`: String choice (`TODO`, `IN_PROGRESS`, `REVIEW`, `DONE`)
     - `priority`: String choice (`LOW`, `MEDIUM`, `HIGH`)
    - `assignee`: User relation (defaults to the Admin user when omitted)
    - `position`: Integer ordering value within the task's status column
     - `created_at`: DateTime (auto on create)
     - `updated_at`: DateTime (auto on update)
   - User Data Schema:
     - `id`: Auto-incrementing integer (Primary Key)
     - `username`: String (required, unique)
     - `password`: Write-only credential accepted at user creation
   - Project Data Schema:
     - `id`: Auto-incrementing integer (Primary Key)
     - `name`: String (required, unique, max 100 chars)
     - `created_at`: DateTime (auto on create)
     - `updated_at`: DateTime (auto on update)
   - Task-to-project relationship: Many-to-many. A task may have no projects or many projects. Deleting a task removes its relationship rows; deleting a project removes only its relationship rows and leaves the task intact.
   - CORS headers configuration to allow API communication with the React frontend server.

2. **Frontend (React + Vite + Wouter + pnpm)**:
   - Single global Kanban board view displaying 4 status columns:
     - 📝 To Do (`TODO`)
     - ⚡ In Progress (`IN_PROGRESS`)
     - 🔍 Review (`REVIEW`)
     - ✅ Done (`DONE`)
   - Native HTML5 Drag and Drop implementation:
     - `draggable={true}` on task cards
     - `onDragStart`, `onDragOver`, `onDragLeave`, `onDrop` events without 3rd party drag libraries.
     - Dynamic drop indicator styling when dragging over columns.
   - Task Creation & Editing:
     - Quick task creation modal / form.
     - Status dropdown on task card and modal for direct status changing.
     - Priority badges (Low: Blue/Green, Medium: Amber/Yellow, High: Red/Rose).
     - Project management controls for creating and deleting projects.
     - Project filter toggles that show tasks matching enabled projects; task cards display one tag per associated project.
     - Assignee dropdown populated from the backend user list; no user creation or user-management controls in the frontend.
   - Task ordering:
     - Native drag-and-drop supports dropping before/after a target task as well as into an empty column.
     - The selected position is persisted through the task API and returned in task list responses.
   - Theme System:
     - Light Mode & Dark Mode toggle button.
     - Persists theme choice in `localStorage`.
     - Smooth background and card transition animations.

### Non-Functional Requirements
- **Performance**: Instant UI updates on drag-and-drop using optimistic updates with REST API synchronization.
- **Usability**: High contrast visual badges, clear drag hover indicators, intuitive modal interface.
- **Code Quality**: Clean separation of concerns between components, services, and backend layers.

### Constraints & Assumptions
  - **Authentication**: Login/authentication remains bypassed for MVP; user records are used for task assignment only.
  - **Scope**: Single board view with project labels, filtering, user-backed assignees, and persisted task ordering. User creation is backend/API-only.
- **Package Manager**: Frontend must use `pnpm`.
- **Drag & Drop**: STRICTLY NO third-party libraries (e.g., `react-beautiful-dnd`, `@hello-pangea/dnd`, `dnd-kit`). Must use standard HTML5 drag & drop events.

---

## Technical Breakdown

### Architecture Overview
The application follows a decoupled Client-Server architecture:
- **Frontend Client (`client/`)**: Built with React (latest), Vite, Wouter (routing), and pnpm. Communicates with the backend over HTTP/REST using standard JSON payloads.
- **Backend API (`backend/`)**: Built with Python, Django 5+, and Django REST Framework. Uses SQLite for persistence and `django-cors-headers` to enable cross-origin requests from the React client.

```
+------------------------------------+          REST APIs (JSON)          +--------------------------------------+
|           React Client             | <================================> |         Django REST API              |
|        (Vite + pnpm + CSS)         |    GET/POST/PUT/PATCH/DELETE       |     (DRF + SQLite Database)          |
|                                    |                                    |                                      |
| - Kanban Board (Native D&D)        |                                    | - Task Model & Serializers           |
| - Light / Dark Theme Switcher      |                                    | - TaskViewSet & REST Endpoints       |
| - Task Creation & Edit Modal       |                                    | - CORS Middleware Configuration      |
+------------------------------------+                                    +--------------------------------------+
```

### Technology Stack
- **Backend**:
  - Python 3.10+
  - Django 5.x
  - Django REST Framework (DRF) 3.15+
  - `django-cors-headers`
  - SQLite (default embedded DB)
- **Frontend**:
  - React 18/19 (latest)
  - Vite (build tool & dev server)
  - `pnpm` (package manager)
  - Wouter (routing)
  - Lucide React (icons)
  - Vanilla CSS with CSS Custom Properties (Theme Design System)

### Data Model
```python
class Task(models.Model):
    STATUS_CHOICES = [
        ('TODO', 'To Do'),
        ('IN_PROGRESS', 'In Progress'),
        ('REVIEW', 'Review'),
        ('DONE', 'Done'),
    ]

    PRIORITY_CHOICES = [
        ('LOW', 'Low'),
        ('MEDIUM', 'Medium'),
        ('HIGH', 'High'),
    ]

    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, default='')
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='TODO')
    priority = models.CharField(max_length=10, choices=PRIORITY_CHOICES, default='MEDIUM')
    assignee = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.PROTECT, default=admin_user_id)
    position = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
```

### API Design
| Endpoint | Method | Description | Sample Payload |
|---|---|---|---|
| `/api/users/` | GET | List safe user summaries for assignee selection | `[ { "id": 1, "username": "Admin" } ]` |
| `/api/users/` | POST | Create a user with a username and password | `{ "username": "maya", "password": "..." }` |
| `/api/tasks/` | GET | List all tasks | `[ { "id": 1, "title": "Setup DRF", ... } ]` |
| `/api/tasks/` | POST | Create a new task | `{ "title": "Fix bug", "description": "...", "status": "TODO", "priority": "HIGH", "assignee": 2 }` |
| `/api/tasks/{id}/` | GET | Retrieve task details | `{ "id": 1, ... }` |
| `/api/tasks/{id}/` | PUT/PATCH | Update task fields or placement | `{ "status": "IN_PROGRESS", "after_task_id": 12 }` |
| `/api/tasks/{id}/` | DELETE | Delete task | HTTP 204 No Content |

---

## Implementation Roadmap

### Sprint Plan Overview

| Sprint | Focus Area | Features |
|--------|-----------|----------|
| Sprint 0.0 | Planning & Architecture | PRD, Technical Breakdown, Sprint Roadmap |
| Sprint 1.0 | Core MVP FullStack App | Feature 1: Django REST Framework Task API backend<br>Feature 2: React Kanban Board with Native D&D<br>Feature 3: Light/Dark Theme Switcher & UI Polish |
| Sprint 1.1 | Documentation, PWA & Branding | Feature 1: Project documentation (AGENTS.md, CLAUDE.md, README.md)<br>Feature 2: Progressive Web App (PWA) & Service Worker<br>Feature 3: Favicon update & Brand asset integration |
| Sprint 1.2 | Formatter & Tooling Setup | Feature 1: Retain AGENTS.md and CLAUDE.md in project root<br>Feature 2: Biome-JS linter/formatter config for React client<br>Feature 3: Python pyproject.toml formatter config for Django backend |
| Sprint 1.3 | Lint Error Resolution | Feature 1: Accessibility & keyboard navigation fixes<br>Feature 2: Import organization & code style cleanup<br>Feature 3: React hook dependency corrections |
| Sprint 1.4 | Backend Ruff Error Resolution | Feature 1: Backend import organization<br>Feature 2: Django class attribute lint corrections<br>Feature 3: Seed command and migration lint policy cleanup |
| Sprint 2.0 | Project Resources & Task Filtering | Feature 1: Django Projects API and task many-to-many relationship<br>Feature 2: React project management, task tags, and project filtering |
| Sprint 3.0 | Users, Assignees & Persisted Ordering | Feature 1: Backend users and frontend assignee selection<br>Feature 2: Persisted Kanban task ordering and precise drop placement |
| Sprint 3.1 | Project Resources & Client routing| Feature 1: Configure wouter<br>Feature 2: Adding projects route and refactor project toggle |

### Implementation Strategy
- Features are designed to be independent and modular.
- Backend (`backend/`) and Frontend (`client/`) are structured cleanly under their respective folders.
