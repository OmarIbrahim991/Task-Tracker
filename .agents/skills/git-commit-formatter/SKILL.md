---
name: git-commit-formatter
description: Formats git commit messages according to Conventional Commits specification. Use this when the user asks to commit changes or write a commit message.
---

# Git Commit Formatter Skill

When writing a git commit message, you MUST follow the Conventional Commits specification.

## Format
`<type>[optional scope]: <description>`

## Allowed Types
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **build**: Changes to dependencies, build system, or package configuration
- **chore**: Auxiliary tooling, CI, or maintenance tasks

## Sprint-Aware Scopes

When working within the sprint workflow (`/create_sprint`, `/generate_code`), use
these scope conventions:

| Context | Scope | Example |
|---------|-------|---------|
| Blueprint creation or update | `blueprint` | `docs(blueprint): add payment integration to roadmap` |
| Sprint planning docs | `sprint-X.Y` | `docs(sprint-2.0): add feature plans for dashboard` |
| Feature implementation | feature name | `feat(auth): implement login form with mock data` |
| Dependency installation | package name | `build(react-router): add routing dependency` |

## Commit Granularity

- **After `/create_sprint`**: One commit for all generated docs.
  - Type: `docs`, scope: `blueprint` or `sprint-X.Y`.
- **After `/generate_code`**: One commit **per feature**, not per file or per sprint.
  - Type: `feat` (or `fix` if the feature is a bugfix sprint).
  - Scope: the feature name.
- **Dependency installs**: Separate commit per dependency or batch.
  - Type: `build`.

## Instructions
1. Analyze the changes to determine the primary `type`.
2. Identify the `scope` — prefer sprint-aware scopes when applicable.
3. Write a concise `description` in imperative mood (e.g., "add feature" not "added feature").
4. For multi-file changes, add a **body** listing what was done (one line per item).
5. If there are breaking changes, add a footer starting with `BREAKING CHANGE:`.

## Examples

Single-line:
`docs(blueprint): define PRD and technical breakdown`
`docs(sprint-1.0): add feature plans for auth and dashboard`
`feat(auth): implement login form with mock data`
`build(axios): add HTTP client dependency`

Multi-line (after implementing a feature):
```
feat(dashboard): implement analytics dashboard

- add DashboardLayout component
- add StatCard and ChartPanel components
- add mock analytics data service
```
