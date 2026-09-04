# Project Progress

This file tracks the completion status of each sprint.

| Sprint | Status | Description |
|--------|--------|-------------|
| Sprint 0.0 | ✅ Complete | Initial blueprint and project planning |
| Sprint 1.0 | ✅ Complete | Core FullStack Task Tracker MVP (Django DRF Backend + React Kanban Board + Native Drag & Drop + Theme Switcher) |
| Sprint 1.1 | ✅ Complete | Project Documentation (AGENTS.md, CLAUDE.md, README.md), Progressive Web App (PWA) setup, and Favicon/Brand Asset Integration |
| Sprint 1.2 | ✅ Complete | Retain AGENTS.md and CLAUDE.md in project root, configure Biome-JS linter/formatter (tabs, 4 spaces, no semi-colons, line width 160), and Python backend formatter |
| Sprint 1.3 | ✅ Complete | Fix all 27 Biome lint errors: a11y & keyboard accessibility (type="button", keyboard handlers, htmlFor/id, remove autoFocus), import sorting & code style (organizeImports, Number.parseInt, self-closing, noUselessSwitchCase), and React hook dependency corrections (useCallback for fetchTasks/handleSaveTask) — via Qwen3 1.7B sub-agents |
| Sprint 1.4 | ✅ Complete | Resolved backend Ruff diagnostics through import organization, intentional Django class metadata annotations, seed-command cleanup, and a migration-only lint policy |
| Sprint 2.0 | ✅ Complete | Implemented project CRUD, many-to-many task associations, project tags, and enabled-project filtering across the Django API and React Kanban board |
| Sprint 3.0 | ✅ Complete | Add backend users and user-backed task assignees, plus persisted task ordering when cards are dropped after a specific task |
| Sprint 3.1 | ✅ Complete | Configured Wouter routing with `/` and `/projects` routes, created dedicated projects management page with full CRUD, and refactored project controls to header-only toggle dropdown |
| Sprint 3.2 | ✅ Complete | Replace window.confirm with z-index-aware confirm modal (ConfirmDialog z-index 1100 > modal 1000, a11y focus trap), extract utils/hooks layer (apiClient, constants, taskHelpers, useClickOutside, useApi) with consumer refactors, and implement offline mutation queue (localStorage FIFO, sequential sync, OfflineBanner) |
| Sprint 3.3 | ✅ Complete | Corrected docs config paths to `client/biome.json` and `backend/pyproject.toml`, added 20–2000 ms random API latency via apiClient, and refactored `index.css` with design-system tokens plus inline-style removal |
| Sprint 3.4 | ✅ Complete | Comprehensive backend test coverage (User API, Task CRUD/validation, reordering logic, seed command) and persistent UI during task operations with real-time backend sync status indicator |

