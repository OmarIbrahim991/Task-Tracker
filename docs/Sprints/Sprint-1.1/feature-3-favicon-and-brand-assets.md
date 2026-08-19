# Feature 3: Favicon Update & Brand Asset Integration

## Overview
Extract custom brand favicon assets from `C:\Users\Omar\Downloads\files.zip` into `client/public/` and link them in `client/index.html` to establish custom visual branding for browser tabs, mobile bookmarks, and PWA launch icons.

## User Stories
- As a user, I want to see a custom branded favicon in my browser tab and mobile bookmarks instead of default placeholder icons.

## Implementation Plan

### Files to Extract & Copy
From `C:\Users\Omar\Downloads\files.zip` (extracted into scratch folder):
- `favicon.ico` -> `client/public/favicon.ico`
- `favicon.svg` -> `client/public/favicon.svg`
- `favicon-32.png` -> `client/public/favicon-32.png`
- `favicon-180.png` -> `client/public/favicon-180.png` (Apple touch icon)
- `favicon-512.png` -> `client/public/favicon-512.png` (PWA 512x512 icon)

### HTML Link Updates (`client/index.html`)
- `<link rel="icon" type="image/x-icon" href="/favicon.ico" />`
- `<link rel="icon" type="image/svg+xml" href="/favicon.svg" />`
- `<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32.png" />`
- `<link rel="apple-touch-icon" sizes="180x180" href="/favicon-180.png" />`

### Step-by-Step Implementation
1. Copy icon files (`favicon.ico`, `favicon.svg`, `favicon-32.png`, `favicon-180.png`, `favicon-512.png`) to `client/public/`.
2. Update `client/index.html` favicon links.

## Acceptance Criteria
- [ ] Brand icon files exist in `client/public/`.
- [ ] `client/index.html` references the new ICO, SVG, PNG, and Apple touch icon paths.
- [ ] Browser tabs display the custom Task Tracker favicon logo.

## Dependencies
- **Internal**: None (independent feature).
- **External**: Icons provided in `C:\Users\Omar\Downloads\files.zip`.
