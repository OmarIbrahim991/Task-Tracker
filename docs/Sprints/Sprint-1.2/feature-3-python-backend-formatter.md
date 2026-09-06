# Feature 3: Python Backend Formatter & Linter Configuration (`pyproject.toml`)

## Overview
Configure Python code formatting and linting for the Django backend by creating a `pyproject.toml` configuration file in `backend/` or project root. Configure Black/Ruff standards: 4 spaces per indentation level, trailing commas enabled, and files ending with a newline.

## User Stories
- As a developer, I want a standard `pyproject.toml` file for the Django backend so that Python files are formatted consistently across all tools (Ruff, Black, Flake8).

## Implementation Plan

### Configuration File (`pyproject.toml`)
```toml
[tool.ruff]
line-length = 160
target-version = "py310"

[tool.ruff.format]
indent-style = "space"
quote-style = "single"
skip-magic-trailing-comma = false
line-ending = "lf"

[tool.black]
line-length = 160
target-version = ['py310']
skip-string-normalization = false
```

### Step-by-Step Implementation
1. Create `pyproject.toml` in project root.
2. Format Python files in `backend/` according to the 4-space, trailing-comma, LF newline standard.

## Acceptance Criteria
- [ ] `pyproject.toml` exists in project root configuring Python formatting rules (4 spaces, trailing commas, LF line endings).
- [ ] Backend code in `backend/` adheres to Python formatting standards.

## Dependencies
- **Internal**: None (independent feature).
- **External**: Python formatting tools (Ruff / Black / PEP 8).
