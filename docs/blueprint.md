# Task Tracker — Blueprint

## Product Requirements Document

### Overview
Task Tracker is a full-stack task and todo management application featuring an interactive Kanban board layout. Built with a Django REST Framework backend and a React frontend (managed with pnpm), it allows users to organize tasks across configurable status stages using custom native drag-and-drop, filter/edit task details, and toggle between dark and light visual themes seamlessly.

### Goals & Objectives
- Provide a visual single-page Kanban board for real-time task status tracking.
- Enable smooth drag-and-drop task movements across status columns using native browser HTML5 drag-and-drop (zero third-party drag-and-drop dependencies).
- Support full CRUD operations for tasks (Title, Description, Status, Priority, Assignee).
- Deliver a modern UI experience supporting Light and Dark modes with persistent user preference.
- Provide a clean, robust backend API using Django REST Framework backed by SQLite.

### User Stories / Use Cases
- **As an Admin user**, I want to view all tasks categorized in status columns (To Do, In Progress, Review, Done) on a unified board view so that I can monitor project progress at a glance.
- **As an Admin user**, I want to drag a task card from one column and drop it into another column to update its status instantly.
- **As an Admin user**, I want to create a new task with a title, description, priority level (Low, Medium, High), and status, with assignee automatically defaulting to "Admin".
- **As an Admin user**, I want to edit existing task details or change status directly via an inline dropdown or modal editor.
- **As an Admin user**, I want to toggle between Light and Dark mode to comfortably view the application in different lighting environments.

### Functional Requirements
1. **Backend (Django REST Framework + SQLite)**:
   - REST API endpoints for Tasks:
     - `GET /api/tasks/` — List all tasks.
     - `POST /api/tasks/` — Create a new task (assignee defaults to "Admin" if omitted).
     - `GET /api/tasks/{id}/` — Retrieve a single task.
     - `PUT/PATCH /api/tasks/{id}/` — Update task fields (e.g. status, priority, title, description).
     - `DELETE /api/tasks/{id}/` — Delete a task.
   - Task Data Schema:
     - `id`: Auto-incrementing integer (Primary Key)
     - `title`: String (required, max 255 chars)
     - `description`: Text (optional/blank allowed)
     - `status`: String choice (`TODO`, `IN_PROGRESS`, `REVIEW`, `DONE`)
     - `priority`: String choice (`LOW`, `MEDIUM`, `HIGH`)
     - `assignee`: String (defaults to "Admin")
     - `created_at`: DateTime (auto on create)
     - `updated_at`: DateTime (auto on update)
   - CORS headers configuration to allow API communication with the React frontend server.

2. **Frontend (React + Vite + pnpm)**:
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
   - Theme System:
     - Light Mode & Dark Mode toggle button.
     - Persists theme choice in `localStorage`.
     - Smooth background and card transition animations.

### Non-Functional Requirements
- **Performance**: Instant UI updates on drag-and-drop using optimistic updates with REST API synchronization.
- **Usability**: High contrast visual badges, clear drag hover indicators, intuitive modal interface.
- **Code Quality**: Clean separation of concerns between components, services, and backend layers.

### Constraints & Assumptions
- **Authentication**: Bypassed for MVP. All operations treat the user as "Admin".
- **Scope**: Single board view; no multi-project isolation or user management models required initially.
- **Package Manager**: Frontend must use `pnpm`.
- **Drag & Drop**: STRICTLY NO third-party libraries (e.g., `react-beautiful-dnd`, `@hello-pangea/dnd`, `dnd-kit`). Must use standard HTML5 drag & drop events.

---

## Technical Breakdown

### Architecture Overview
The application follows a decoupled Client-Server architecture:
- **Frontend Client (`client/`)**: Built with React (latest), Vite, and pnpm. Communicates with the backend over HTTP/REST using standard JSON payloads.
- **Backend API (`backend/`)**: Built with Python, Django 5+, and Django REST Framework. Uses SQLite for persistence and `django-cors-headers` to enable cross-origin requests from the React client.

```
+------------------------------------+          REST APIs (JSON)          +--------------------------------------+
|           React Client             | <================================> |         Django REST API              |
|        (Vite + pnpm + CSS)         |    GET/POST/PUT/PATCH/DELETE       |     (DRF + SQLite Database)            |
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
    assignee = models.CharField(max_length=100, default='Admin')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
```

### API Design
| Endpoint | Method | Description | Sample Payload |
|---|---|---|---|
| `/api/tasks/` | GET | List all tasks | `[ { "id": 1, "title": "Setup DRF", ... } ]` |
| `/api/tasks/` | POST | Create new task | `{ "title": "Fix bug", "description": "...", "status": "TODO", "priority": "HIGH" }` |
| `/api/tasks/{id}/` | GET | Retrieve task details | `{ "id": 1, ... }` |
| `/api/tasks/{id}/` | PUT/PATCH | Update task fields | `{ "status": "IN_PROGRESS" }` |
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

### Implementation Strategy
- Features are designed to be independent and modular.
- Backend (`backend/`) and Frontend (`client/`) are structured cleanly under their respective folders.
