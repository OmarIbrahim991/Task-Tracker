---
name: generate-code
description: >-
  Use this skill when the user invokes /generate_code. It implements the features
  from the current active sprint by spawning parallel sub-agents — one per feature.
  Each sub-agent reads its feature file and generates all necessary code files
  individually (no scaffolding scripts). Dependencies must not be installed
  automatically; the agent asks the user if any are needed.
---

# Generate Code Skill

Implements the current sprint's features in parallel using sub-agents. Each feature
file in the sprint folder becomes an independent implementation task.

---

## Prerequisites

Before starting, verify the following exist:

1. `docs/blueprint.md` — The project blueprint.
2. `docs/progress.md` — With at least one sprint marked 🔄 In Progress.
3. A sprint folder under `docs/Sprints/` with feature files to implement.

If any are missing, inform the user and suggest running `/create_sprint` first.

---

## Execution Steps

### 1. Identify the Active Sprint

- Read `docs/progress.md` and find the sprint marked **🔄 In Progress**.
- If multiple sprints are in progress, ask the user which one to implement.
- If none are in progress, ask the user which sprint to start.
- Locate the sprint folder: `docs/Sprints/Sprint-X.Y/`.

### 2. Discover Formatter Configs

Before generating any code, scan the project root for formatter/linter config files.
Read and respect their settings (tabs vs spaces, semicolons, quotes, trailing commas,
print width, etc.). Common files to look for:

- `.prettierrc`, `.prettierrc.json`, `.prettierrc.js`, `prettier.config.js`
- `.eslintrc`, `.eslintrc.json`, `eslint.config.js`
- `.editorconfig`
- `biome.json`, `biome.jsonc`
- `deno.json`, `deno.jsonc`
- `.rustfmt.toml`, `rustfmt.toml`
- `pyproject.toml` (for Black, Ruff, etc.)
- `tsconfig.json` (for relevant TS settings)

Collect the relevant formatting rules into a brief summary to pass to each sub-agent.

### 3. Collect Context for Sub-Agents

Prepare a shared context bundle that every sub-agent receives:

- **Blueprint summary**: Key architecture decisions, tech stack, and data model from
  `docs/blueprint.md`.
- **Formatter rules**: The formatting summary from step 2.
- **File header**: The header comment template from
  [file-header-template.md](./resources/file-header-template.md) — every generated
  file must include this.
- **Existing code structure**: A listing of the current project file tree (excluding
  `node_modules`, `.git`, `docs/`, and other non-source directories) so sub-agents
  know what already exists and can import from it.
- **Coding rules**: The rules listed in the [Coding Standards](#coding-standards)
  section below.

### 4. Spawn Parallel Sub-Agents

For **each feature file** in the sprint folder (e.g., `feature-1-auth.md`,
`feature-2-dashboard.md`):

- Spawn a **sub-agent** with:
  - The feature file content as its primary task.
  - The shared context bundle from step 3.
  - Instructions from [sub-agent-instructions.md](./resources/sub-agent-instructions.md).
- All sub-agents run **in parallel** since sprint features are independent by design.

### 5. Review & Reconcile

After all sub-agents complete:

- Check for any **conflicts** (two features creating/modifying the same file).
  If conflicts exist, resolve them manually or ask the user.
- Check for any **missing dependencies** that sub-agents flagged. Present them to the
  user as a single consolidated list and ask for approval before proceeding.
- Verify that the generated code follows the formatter config by running the project's
  formatter if available (e.g., `npx prettier --check`), but do **not** install any
  new tools to do this.

### 6. Update Progress

- Update `docs/progress.md`: change the sprint status from 🔄 to ✅ Complete with a
  brief description of what was implemented.

---

## Coding Standards

All sub-agents must follow these rules when generating code:

- **YAGNI** — Only write code that is needed right now. No speculative abstractions,
  unused utilities, or premature generalizations.
- **Brief comments** — Comments should be rare and short. Only comment on *why*, never
  on *what*. Self-documenting code is preferred.
- **No scaffolding scripts** — Every file must be created individually via the file
  creation tool. Never use `npx create-*`, `npm init`, `yo`, or similar generators.
- **No dependency installation** — Do not run `npm install`, `pip install`, `cargo add`,
  or any equivalent. If a dependency is needed that is not already installed, **stop and
  ask the user** to install it. List the exact package name and why it's needed.
- **Follow formatter configs** — Match the project's existing style: indentation (tabs
  vs spaces), semicolons, quote style, trailing commas, line width, etc.
- **Consistent with existing code** — Match the patterns, naming conventions, and
  directory structure already present in the project.
