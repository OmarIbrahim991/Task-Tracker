# Feature 1: Django REST Framework Task API Backend

## Overview
Set up a robust Django project inside the `backend/` directory configured with Django REST Framework (DRF), `django-cors-headers`, SQLite database, and complete RESTful CRUD API endpoints for managing tasks.

## User Stories
- As a developer, I want a Django REST Framework backend running on SQLite so that the frontend can fetch, create, update, and delete tasks cleanly over HTTP REST endpoints.
- As an Admin user, I want new tasks created without specifying an assignee to default automatically to "Admin".

## Implementation Plan

### Backend Components
1. **Django Project Structure**:
   - Directory: `backend/`
   - Settings: `backend/core/settings.py` (CORS settings, REST framework settings, SQLite configuration).
   - Apps: `tasks` app inside backend.

2. **Database Schema & Models (`backend/tasks/models.py`)**:
   - `Task` model:
     - `title` (CharField, max 255)
     - `description` (TextField, blank=True, default='')
     - `status` (CharField, choices: `TODO`, `IN_PROGRESS`, `REVIEW`, `DONE`, default='TODO')
     - `priority` (CharField, choices: `LOW`, `MEDIUM`, `HIGH`, default='MEDIUM')
     - `assignee` (CharField, max 100, default='Admin')
     - `created_at` (DateTimeField, auto_now_add=True)
     - `updated_at` (DateTimeField, auto_now=True)

3. **Serializers (`backend/tasks/serializers.py`)**:
   - `TaskSerializer`: Standard `ModelSerializer` for the `Task` model validating choice fields and handling default assignee assignment.

4. **Views & Routing (`backend/tasks/views.py`, `backend/tasks/urls.py`, `backend/core/urls.py`)**:
   - `TaskViewSet`: ModelViewSet enabling list, create, retrieve, update, partial_update, delete.
   - Router registration mapping `/api/tasks/` to `TaskViewSet`.

5. **Initial Data Seeding**:
   - Command or seed script to populate realistic initial tasks across all 4 status columns (`TODO`, `IN_PROGRESS`, `REVIEW`, `DONE`) so the Kanban board immediately has sample data.

### Step-by-Step Implementation
1. Initialize Django project in `backend/` with `manage.py` and core settings package.
2. Create `tasks` app and register it in `INSTALLED_APPS` alongside `rest_framework` and `corsheaders`.
3. Configure `CORS_ALLOW_ALL_ORIGINS = True` (or explicit client localhost port) and add CORS middleware in `settings.py`.
4. Implement `Task` model in `tasks/models.py`.
5. Run migrations: `python manage.py makemigrations` and `python manage.py migrate`.
6. Implement `TaskSerializer` and `TaskViewSet`.
7. Configure URL routes under `/api/tasks/`.
8. Create a seed script/command or management utility to populate initial test tasks.

## Acceptance Criteria
- [ ] Django REST Framework server runs cleanly on `http://127.0.0.1:8000`.
- [ ] `GET /api/tasks/` returns a JSON array of all tasks.
- [ ] `POST /api/tasks/` creates a task and defaults `assignee` to "Admin" if not provided.
- [ ] `PATCH /api/tasks/{id}/` updates task fields (specifically `status` and `priority`).
- [ ] `DELETE /api/tasks/{id}/` removes the task.
- [ ] CORS is properly enabled for frontend API requests.

## Dependencies
- **Internal**: None (independent feature).
- **External**: Python 3.10+, Django, djangorestframework, django-cors-headers.
