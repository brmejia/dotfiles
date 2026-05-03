---
name: spec-feature
description: Creates a git worktree and writes a feature spec markdown file from a short idea. Use when user wants to create a feature spec, spin up a planning worktree, or mentions "spec", "feature spec", or "plan a feature".
---

# Spec Feature

Turn a short feature idea into a git worktree with a detailed markdown spec file.

## Workflow

1. **Parse arguments** - Extract from user input:
   - `feature_title`: Title Case, human readable
   - `feature_slug`: lowercase, kebab-case, a-z/0-9/-, max 40 chars, strip trailing `-feature`/`-feat`
   - `branch_name_override`: Optional `--branch-name` argument value (empty if not provided)
   - `spec_path_override`: Optional `--spec-path` argument value (empty if not provided)
   - Compute defaults:
     - `branch_name = branch_name_override or "ft-<feature_slug>"`
      - `spec_path = spec_path_override or ".scratch/specs/<YYYY-MM-DD>-<feature_slug>.md"`
   - If unclear, ask user to clarify.

2. **Check for uncommitted changes**:
   - Run `git status --porcelain`
   - If dirty, stash: `git stash push -m "WIP: feature spec for <feature_title>"`
   - Track whether stash was created for later restore.

3. **Detect directory structure**:
   - Run `git worktree list --porcelain`
   - Check if `gitdir` points to file (worktree) vs directory (regular repo)
   - Walk up tree checking for bare repo
   - Compute `WORKTREE_PATH`:
     - Bare repo parent: `<bare-parent>/ft-<feature_slug>`
     - Standard: `<parent-of-gitroot>/<current-repo>_ft-<feature_slug>`
   - Base branch: prefer `main`, fallback `master`
   - Collision: append numeric suffix (`ft-card-component-01`)

4. **Confirm before proceeding (BLOCKING)**:
   - Use `question` tool with:
     ```
     Ready to create worktree?

     Worktree: <WORKTREE_PATH>
     Branch: <branch_name>
     Spec file: <spec_path>
     Title: <feature_title>

     Reply yes to create, or no to cancel.
     ```
   - If yes: proceed to step 5
   - If no: "Worktree creation cancelled" and end

5. **Create worktree**:
   - `git worktree add -b <branch_name> "$WORKTREE_PATH" <base_branch>`
   - Run each git command separately, never chain.

6. **Restore stash** if created in step 2:
   - `git stash pop`

7. **Draft spec file**:
   - Create `<spec_path>` inside the worktree
   - Use spec template structure: Meta, Summary, Context & Motivation, Goals, Out of Scope, Users & User Stories, Functional Requirements, Non-Functional Requirements, Data & Privacy, Security & Permissions, Dependencies & Constraints, Rollout & Backward Compatibility, Possible Edge Cases, Acceptance Criteria, Open Questions, Testing Guidelines
   - Fill in based on user's feature idea. No code examples.

8. **Output summary**:
   ```
   Worktree: <WORKTREE_PATH>
   Branch: <branch_name>
   Spec file: <spec_path>
   Title: <feature_title>
   ```

## Rules

- **NEVER chain git commands** - run each separately
- **Step 4 is BLOCKING** - do NOT proceed until user confirms via question tool
- **NEVER repeat full spec in chat** unless user explicitly asks
- If directory structure unclear, ask user where to create worktree
- Strip trailing `-feature` or `-feat` from slug

## Permission Hints

When a parent agent delegates to sub-agents, it MUST pre-approve read+write filesystem access for the worktree path before spawning child agents.

After computing `WORKTREE_PATH` in step 3, the parent agent should grant read+write access to:
```
$HOME/<repo-name>_<branch_name>/*
```

For example, if the repo is `.dotfiles` and the branch is `ft-add-dark-mode`, grant:
```
$HOME/.dotfiles_ft-add-dark-mode/*
```

Use `$HOME` (not `~`) in permission patterns — `~` is not expanded by most harness permission configs. Grant both read and write access so sub-agents can read spec files and write implementation code without interrupting permission prompts.
