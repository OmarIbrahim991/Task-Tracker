# Feature 2: Biome-JS Formatter and Linter Configuration for React Client

## Overview
Add and configure Biome-JS (`biome.json`) in the project root / client folder as the official formatter and linter for the React application. Configure Biome to use tabs for indentation (tab width 4 spaces), omit semicolons unless necessary, enforce trailing commas, and ensure files end with a newline.

## User Stories
- As a developer, I want Biome-JS configured for the frontend codebase so that all React components, JS files, and CSS follow consistent formatting and linting rules.

## Implementation Plan

### Configuration File (`biome.json`)
```json
{
  "$schema": "https://biomejs.dev/schemas/1.8.3/schema.json",
  "organizeImports": {
    "enabled": true
  },
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true
    }
  },
  "formatter": {
    "enabled": true,
    "formatWithErrors": false,
    "indentStyle": "tab",
    "indentWidth": 4,
    "lineEnding": "lf",
    "lineWidth": 160
  },
  "javascript": {
    "formatter": {
      "jsxQuoteStyle": "double",
      "quoteProperties": "asNeeded",
      "trailingCommas": "all",
      "semicolons": "asNeeded",
      "arrowParentheses": "always",
      "quoteStyle": "single"
    }
  },
  "json": {
    "formatter": {
      "trailingCommas": "none"
    }
  }
}
```

### Step-by-Step Implementation
1. Create `biome.json` in project root.
2. Add `"lint": "biome check ."` and `"format": "biome format --write ."` scripts to `client/package.json`.
3. Format existing `client/` files using Biome configuration rules.

## Acceptance Criteria
- [ ] `biome.json` exists with tab indentation (4 spaces equivalent), `semicolons: "asNeeded"`, `trailingCommas: "all"`, and `lineEnding: "lf"`.
- [ ] Frontend code in `client/` adheres to Biome formatting rules.

## Dependencies
- **Internal**: None (independent feature).
- **External**: Biome-JS linter/formatter schema.
