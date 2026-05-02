---
name: implement
description: Thin wrapper over /worktree-for for issue-driven implementation. Delegates all core logic to /worktree-for. Use when user wants to quickly start implementing a specific issue, create an implementation worktree from an issue number, or begin coding with dependency validation and auto-generated spec.
---

# Implement

Thin wrapper over `/worktree-for` for issue-driven implementation workflows.

## Workflow

### Step 1: Parse input

Extract the user input. It must be a single positive integer (a GitLab issue number).

- If input is a positive integer: proceed to Step 2.
- If input is missing, non-integer, zero, or negative: report error "Issue number required. Usage: /implement <issue-number>" and exit.

Set variable: `issue_number`

### Step 2: Verify `/worktree-for` skill exists

Check that the `/worktree-for` skill is available at `opencode/skills/worktree-for/SKILL.md`.

- If the file does not exist: report error "/worktree-for skill not found. Install it before using /implement." and exit.
- If the file exists: proceed to Step 3.

### Step 3: Delegate to `/worktree-for`

Invoke the `/worktree-for` skill with the following context:

- Mode: `issue`
- Issue number: `issue_number`
- Context description: "Implementation for issue #<issue_number>"

All core logic (dependency checking, worktree creation, spec generation) is handled by `/worktree-for`.

### Step 4: Propagate output

Display the output summary produced by `/worktree-for`. Do not modify or add to it.

## Error Handling

All errors from `/worktree-for` are propagated to the user without modification. This includes:

- Dependency check failures (open blockers)
- Git errors (worktree creation failures, missing branches)
- User cancellation at confirmation step
- Missing glab CLI

## Rules

- **This is a thin wrapper** — no worktree logic, no spec generation, no git commands.
- **Do NOT duplicate `/worktree-for` logic** — all behavior changes go in `/worktree-for`, not here.
- **All errors are propagated** — no additional error handling is needed beyond passing through `/worktree-for` results.

## Permission Hints

Since `/implement` delegates to `/worktree-for`, the parent agent MUST pre-approve read+write filesystem access for the worktree path before spawning child agents.

After `/worktree-for` computes the `worktree_path`, the parent agent should grant read+write access to:
```
$HOME/<repo-name>_<branch_name>/*
```

Use `$HOME` (not `~`) in permission patterns. Grant both read and write access so sub-agents can read spec files and write implementation code without interrupting permission prompts.
