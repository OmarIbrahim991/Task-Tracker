# Feature 1: Project Root Documentation & Workspace Guidelines

## Overview
Retain `AGENTS.md` (AI workspace guidelines and constraints) and `CLAUDE.md` (quick start & CLI commands) in the project root directory alongside `README.md`.

## User Stories
- As a developer or AI assistant, I want `AGENTS.md` and `CLAUDE.md` located directly in the project root directory for immediate visibility and CLI tool compatibility.

## Implementation Plan

### Step-by-Step Implementation
1. Keep `AGENTS.md` in project root directory.
2. Keep `CLAUDE.md` in project root directory.
3. Ensure root `AGENTS.md`, `CLAUDE.md`, and `.agents/skills/` are tracked together in git.

## Acceptance Criteria
- [ ] Root `AGENTS.md` exists and contains workspace agent guidelines.
- [ ] Root `CLAUDE.md` exists and contains CLI reference commands.

## Dependencies
- **Internal**: None (independent feature).
- **External**: Markdown documentation standard.
