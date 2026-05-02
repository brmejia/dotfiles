---
name: worktree-for
description: Creates an isolated git worktree for planning or implementation. Accepts a planning context description or a GitLab issue number. Use when user wants to start work on an issue, create a planning workspace, isolate feature development, validate dependencies before starting, or generate a focused spec from issue context.
---

# Worktree For

Create isolated git worktrees driven by either a planning description or a GitLab issue number.

## Workflow

### Step 1: Parse input and detect mode

Extract the user input. Determine the mode:

- **Issue mode**: Input is a positive integer (e.g., `3`, `42`).
- **Planning mode**: Input is non-numeric text (a description).
- **Error**: Input is empty, zero, or negative integer. Report "Input required. Usage: /worktree-for <description-or-issue-number>" and exit.

Set variables:
- `mode`: `"issue"` or `"planning"`
- `context`: the raw input string
- `issue_number`: parsed integer (issue mode only)

### Step 2: Issue mode — dependency check

If `mode` is `"issue"`:

1. Invoke the `/check-issue-deps` skill with `issue_number`.
2. If the check reports open blockers: display the blocker list and exit with failure.
3. If the check reports success: proceed to Step 3.

If `mode` is `"planning"`: skip this step and proceed to Step 3.

### Step 3: PRD slug extraction (issue mode only)

If `mode` is `"issue"`:

1. Run `glab issue view <issue_number> -F json` to fetch the issue.
2. Parse the JSON response. Extract the `description` field (issue body).
3. Search the body for a `Parent: #N` reference.
4. If a parent reference is found:
   - Fetch the parent issue: `glab issue view <parent_number> -F json`
   - Extract the parent issue `title`.
   - Derive the slug: lowercase, replace spaces/special chars with hyphens, strip trailing `-feature` or `-feat`, truncate to 40 chars.
5. If no parent found: use `feature` as the fallback slug.

If `mode` is `"planning"`: derive the slug from the description text using the same rules (lowercase, hyphenate, strip trailing `-feature`/`-feat`, max 40 chars).

Set variable: `slug`

### Step 4: Branch naming

Compute the branch name:

- **Issue mode**: `<slug>-issue-<issue_number>` (e.g., `prd-to-issues-pipeline-issue-9`)
- **Planning mode**: `ft-<slug>`

Set variable: `branch_name`

### Step 5: Worktree path computation

1. Run `git worktree list --porcelain` to detect existing worktrees.
2. Determine if running inside a worktree or regular repo:
   - Check if `.git` is a file (worktree) or directory (regular repo).
   - If inside a worktree, follow the gitdir link to find the main repo.
3. Walk up the directory tree checking for a bare repo.
4. Compute the worktree path:
   - **Bare repo**: `<bare-parent>/<branch_name>`
   - **Standard repo**: `<parent-of-gitroot>/<repo-name>_<branch_name>`
     - `<repo-name>` is the basename of the git root directory.
5. Check for collision: if the computed path already exists, append a numeric suffix (`-01`, `-02`, etc.) until a unique path is found.

Set variable: `worktree_path`

Set variable: `spec_path` = `<worktree_path>/docs/specs/<slug>.md`

### Step 6: Handle uncommitted changes

1. Run `git status --porcelain`
2. If output is non-empty (dirty working tree):
   - Run `git stash push -m "WIP: worktree for <context>"`
   - Track that a stash was created (set `stash_created = true`)
3. If output is empty: set `stash_created = false`

### Step 7: BLOCKING user confirmation

Use the `question` tool with the following prompt:

```
Ready to create worktree?

Worktree: <worktree_path>
Branch: <branch_name>
Spec file: <spec_path>
Mode: <mode> (<planning|issue>)
Context: <context>

Reply yes to create, or no to cancel.
```

- If user confirms (yes): proceed to Step 8.
- If user declines (no):
  - Display "Worktree creation cancelled"
  - If `stash_created` is true: run `git stash pop` to restore changes
  - Exit.

### Step 8: Create worktree

1. Determine the base branch:
   - Run `git branch --list main` — if it exists, use `main`.
   - Otherwise, run `git branch --list master` — if it exists, use `master`.
   - If neither exists: report error "No main or master branch found", restore stash if created, and exit.
2. Run `git worktree add -b <branch_name> <worktree_path> <base_branch>`
3. If the command fails:
   - Report the error.
   - Restore stash if `stash_created` is true.
   - Exit with failure.

### Step 9: Restore stash

If `stash_created` is true:

1. Run `git stash pop`
2. If the command fails: warn the user "Stash pop failed — your changes are still in the stash" but do not block.

### Step 10: Generate spec file

Create the `docs/specs/` directory inside the worktree if it does not exist.

If the spec file path already exists, append a numeric suffix to the filename (e.g., `<slug>-01.md`, `<slug>-02.md`).

**Issue mode — Focused spec**:

Create the spec file at `spec_path` with the following sections, populated based on the issue context:

```markdown
# Spec: <issue context>

## Non-Functional Requirements

<derive from issue context>

## Security & Permissions

<derive from issue context>

## Possible Edge Cases

<derive from issue context>

## Testing Guidelines

<derive from issue context>
```

**Planning mode — Full spec**:

Create the spec file at `spec_path` with the following sections, populated based on the description context:

```markdown
# Spec: <description context>

## Meta

- **Feature**: <title>
- **Slug**: <slug>
- **Date**: <current date>
- **Status**: Draft

## Summary

<one-paragraph summary>

## Context & Motivation

<why this is needed>

## Goals

- <goal 1>
- <goal 2>

## Out of Scope

- <out of scope item 1>

## Users & User Stories

- As a <user>, I want <action> so that <benefit>

## Functional Requirements

- <requirement 1>
- <requirement 2>

## Non-Functional Requirements

<performance, reliability, etc.>

## Data & Privacy

<data considerations>

## Security & Permissions

<security considerations>

## Dependencies & Constraints

<external dependencies>

## Rollout & Backward Compatibility

<rollout strategy>

## Possible Edge Cases

<edge cases>

## Acceptance Criteria

- <criterion 1>
- <criterion 2>

## Open Questions

- <question 1>

## Testing Guidelines

<testing approach>
```

### Step 11: Output summary

Display a formatted summary:

```
Worktree: <worktree_path>
Branch: <branch_name>
Spec file: <spec_path>
Mode: <mode>
Context: <context>
```

## Error Handling

| Scenario | Behavior |
|---|---|
| glab not installed | Error: "glab CLI is required but not installed. Install it: https://gitlab.com/gitlab-org/cli" and exit. |
| Issue not found | Error: "Issue #<number> not found" and exit. |
| Dependencies not met | List open blockers from `/check-issue-deps` and exit with failure. |
| Worktree creation fails | Restore stash if created, exit with error message. |
| User declines confirmation | "Worktree creation cancelled", restore stash if created, exit. |
| Non-integer input for issue mode | Error: "Input required. Usage: /worktree-for <description-or-issue-number>" and exit. |
| No main or master branch | Error: "No main or master branch found", restore stash, exit. |

## Rules

- **NEVER chain git commands** — run each git operation individually, never use `&&` or `;` to chain them.
- **Step 7 (confirmation) is BLOCKING** — do NOT create the worktree until the user explicitly confirms via the `question` tool.
- **NEVER repeat full spec in chat** unless the user explicitly asks for it.
- **Restore stash on any failure path** — if a stash was created in Step 6, always restore it before exiting on error or cancellation.
- Run each git command separately and check its result before proceeding.

## Permission Hints

When a parent agent delegates to sub-agents, it MUST pre-approve read+write filesystem access for the worktree path before spawning child agents.

After computing `worktree_path` in Step 5, the parent agent should grant read+write access to:
```
$HOME/<repo-name>_<branch_name>/*
```

For example, if the repo is `.dotfiles` and the branch is `ft-add-dark-mode`, grant:
```
$HOME/.dotfiles_ft-add-dark-mode/*
```

Use `$HOME` (not `~`) in permission patterns — `~` is not expanded by most harness permission configs. Grant both read and write access so sub-agents can read spec files and write implementation code without interrupting permission prompts.
