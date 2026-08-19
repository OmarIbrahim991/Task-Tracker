# Feature 2: Progressive Web App (PWA) & Service Worker Integration

## Overview
Transform the React frontend application into a Progressive Web App (PWA) by configuring a Web App Manifest (`manifest.webmanifest`), registering a Service Worker (`sw.js`) for offline static asset caching, and updating mobile/desktop meta tags in `index.html`.

## User Stories
- As a user, I want to install Task Tracker as a standalone web application on desktop and mobile devices.
- As a user, I want the web app shell to load even when offline or experiencing unstable network connectivity.

## Implementation Plan

### Frontend Files
1. **Web App Manifest (`client/public/manifest.webmanifest`)**:
   - `name`: "Task Tracker — Kanban Manager"
   - `short_name`: "TaskTracker"
   - `description`: "Full-stack visual task & todo management app with native drag and drop"
   - `theme_color`: "#0f172a"
   - `background_color`: "#0f172a"
   - `display`: "standalone"
   - `start_url`: "/"
   - `icons`: Array referencing `favicon-180.png`, `favicon-512.png`, `favicon-32.png`, `favicon.svg`.

2. **Service Worker (`client/public/sw.js`)**:
   - Cache static assets (`/`, `/index.html`, `/src/main.jsx`, `/src/index.css`, `/favicon.svg`, icons).
   - Cache-first strategy for app shell assets with network fallback.

3. **Service Worker Registration (`client/src/registerServiceWorker.js`)**:
   - Helper function to register `/sw.js` in production and localhost dev environments.

4. **HTML Meta Tags (`client/index.html`)**:
   - `<link rel="manifest" href="/manifest.webmanifest" />`
   - `<meta name="theme-color" content="#0f172a" />`
   - `<meta name="apple-mobile-web-app-capable" content="yes" />`
   - `<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />`

### Step-by-Step Implementation
1. Create `client/public/manifest.webmanifest`.
2. Create `client/public/sw.js`.
3. Create `client/src/registerServiceWorker.js` and import it into `client/src/main.jsx`.
4. Update `client/index.html` with PWA meta tags and manifest link.

## Acceptance Criteria
- [ ] `manifest.webmanifest` exists in `client/public/` with standalone app metadata and icon array.
- [ ] `sw.js` exists in `client/public/` and handles static asset caching.
- [ ] Service worker registers cleanly on application boot.
- [ ] `index.html` contains theme-color, manifest link, and mobile web app meta tags.

## Dependencies
- **Internal**: Feature 3 (Favicon and Brand Assets).
- **External**: Browser Service Worker & PWA APIs.
