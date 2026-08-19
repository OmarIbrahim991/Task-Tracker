# Feature 3: Light/Dark Theme Switcher & UI Aesthetics

## Overview
Implement a comprehensive visual design system in standard Vanilla CSS featuring Light Mode and Dark Mode support with persistent state, custom CSS variables (tokens), smooth color transitions, modern card glassmorphism, priority color badges, responsive grid design, and interactive feedback.

## User Stories
- As an Admin user, I want a theme toggle button in the header so I can switch between Light mode and Dark mode.
- As an Admin user, I want my selected theme preference to be remembered across browser refreshes.
- As an Admin user, I want tasks and columns to have visual distinction (priority colors, drag highlight borders, drop targets) so the board feels dynamic and responsive.

## Implementation Plan

### UI System & Styling

1. **Theme Context / Provider (`client/src/context/ThemeContext.jsx`)**:
   - Manages active theme state (`'dark'` | `'light'`).
   - Initializes state from `localStorage` or `window.matchMedia('(prefers-color-scheme: dark)')`.
   - Syncs `data-theme="light"` or `data-theme="dark"` attribute on `document.documentElement`.
   - Exposes `toggleTheme()` to UI components.

2. **Design Tokens (`client/src/index.css`)**:
   - Define CSS custom variables for Light and Dark themes:
     - `--bg-primary`, `--bg-secondary`, `--bg-card`, `--bg-column`
     - `--text-primary`, `--text-secondary`, `--text-muted`
     - `--border-color`, `--border-hover`, `--focus-ring`
     - `--accent-color`, `--accent-hover`
     - `--priority-low-bg`, `--priority-low-fg`
     - `--priority-medium-bg`, `--priority-medium-fg`
     - `--priority-high-bg`, `--priority-high-fg`
     - `--shadow-sm`, `--shadow-md`, `--shadow-lg`
   - Smooth CSS transitions (`transition: background-color 0.25s ease, border-color 0.25s ease`).

3. **Navigation & Header (`client/src/components/Navbar.jsx`)**:
   - Displays App title, total task counts, "+ New Task" button, and the Theme Switcher toggle button (Sun/Moon icons).

4. **Visual Polish & Interactive Feedback**:
   - Column hover state during drag: highlighted border + subtle background tint when active drop target.
   - Card drag preview state: reduced opacity (`opacity: 0.5`) while dragging.
   - Priority badges:
     - Low: Emerald / Mint badge
     - Medium: Amber / Gold badge
     - High: Crimson / Rose badge
   - Card hover effect: subtle elevation (`transform: translateY(-2px)`, shadow lift).

### Step-by-Step Implementation
1. Create `ThemeContext.jsx` with `localStorage` persistence and `data-theme` DOM attribute binding.
2. Build `index.css` with dark/light theme tokens, layout reset, typography, and utility classes.
3. Build `Navbar.jsx` component with header actions, task counter, theme toggle, and "+ New Task" trigger.
4. Enhance `TaskCard`, `KanbanColumn`, and `TaskModal` with dynamic theme styles, priority badge indicators, and transition animations.

## Acceptance Criteria
- [ ] Theme switcher toggles between Light and Dark mode instantly.
- [ ] Theme selection persists in `localStorage` across page reloads.
- [ ] Visual styling uses curated HSL / CSS variables for high contrast in both themes.
- [ ] Priority tags (Low, Medium, High) have distinct, legible color codings.
- [ ] Drag-and-drop targets exhibit visual highlight indicators when hovered with a dragged item.
- [ ] Modal dialogs align with the active Light/Dark theme.

## Dependencies
- **Internal**: Feature 2 (React Frontend Structure).
- **External**: React, Lucide React (Sun / Moon icons).
