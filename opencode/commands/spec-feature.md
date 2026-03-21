---
description: Redact a feature spec file and create a git worktree from a short idea
argument-hint: Short feature description
agent: plan
subtask: true
permissions:
  question: true
---

You are helping to spin up a new feature spec for this application, from a short idea provided in the user input below. Always adhere to any rules or requirements set out in any AGENTS.md/CLAUDE.md files when responding.

User input: $ARGUMENTS

## High level behavior

Your job will be to turn the user input above into:

- A safe git worktree with branch (`ft-<feature_slug>`)
- A detailed markdown spec file under the `.planning/specs` directory inside the worktree

Directory structure detection using `git worktree list`:

- If parent of bare repo is a **bare git repo**: worktree goes as sibling subdirectory (e.g. `../ft-feature-slug`)
- If standard structure: worktree goes as sibling with repo name prefix (e.g. `../<repo>_ft-feature-slug`)

Then save the spec file to disk and print a short summary of what you did.

## Step 1. Parse the arguments

From `$ARGUMENTS`, extract:

1. `feature_title`
   - A short, human readable title in Title Case.
   - Example: "Card Component for Dashboard Stats".

2. `feature_slug`
   - A git safe slug.
   - Rules:
     - Lowercase
     - Kebab-case
     - Only `a-z`, `0-9` and `-`
     - Replace spaces and punctuation with `-`
     - Collapse multiple `-` into one
     - Trim `-` from start and end
     - Maximum length 40 characters
     - **Strip trailing `-feature` or `-feat` if present** (e.g., "Card Feature" → `card`, not `card-feature`)
   - Example: `card-component` or `card-component-dashboard`.

3. `branch_name`
   - Format: `ft/<feature_slug>`
   - Example: `ft/card-component`.

If you cannot infer a sensible `feature_title` and `feature_slug`, ask the user to clarify instead of guessing.

## Step 2. Check for uncommitted changes and stash if needed

Check the current Git branch for any uncommitted, unstaged, or untracked files.

- If the working directory is clean, proceed to Step 3.
- If there are changes, stash them with a descriptive message:
  ```
  git stash push -m "WIP: feature spec for <feature_title>"
  ```

## Step 3. Detect directory structure

Use `git worktree list --porcelain` to understand the current structure. The goal is to determine:

1. **Are we in a worktree?** - Check if `gitdir` points to a file (worktree) vs directory (regular repo)
2. **Is the parent of gitdir a bare repo?** - Walk up the directory tree checking for bare repo
3. **Compute `WORKTREE_PATH`** based on structure:
   - If parent of bare repo is bare → `WORKTREE_PATH=<bare-parent>/ft-<feature_slug>`
   - Otherwise (standard) → `WORKTREE_PATH=<parent-of-gitroot>/<current-repo>_ft-<feature_slug>`

4. **Base branch**: detect automatically (prefer `main`, fallback to `master`)
5. **Collision handling**: If worktree path exists, append numeric suffix: `ft-card-component-01`
6. **Unusual case**: If structure is unclear, ask user where to create worktree

## Step 4. Confirm before proceeding (BLOCKING)

**STOP - Return this checkpoint immediately, do NOT proceed further until response.**

Then use the `question` tool to ask for confirmation. Present the details using the format from [#summary-format](#summary-format) with actual values filled in:

```
Ready to create worktree?

Worktree: <WORKTREE_PATH>
Branch: ft/<feature_slug>
Title: <feature_title>

Reply yes to create, or no to cancel.
```

- If user confirms (yes): proceed to Step 5
- If user declines (no): respond "Worktree creation cancelled" and **end task immediately**

## Step 5. Create the Git worktree

Create the worktree:

```
git worktree add -b ft/${feature_slug} "$WORKTREE_PATH" <base_branch>
```

## Step 6. Create symlinks for config files

After creating the worktree, symlink these files if they exist in the current working directory but not in new branch

| Source          | Target                         |
| --------------- | ------------------------------ |
| `AGENTS.md`     | `$WORKTREE_PATH/AGENTS.md`     |
| `CLAUDE.md`     | `$WORKTREE_PATH/CLAUDE.md`     |
| `opencode.json` | `$WORKTREE_PATH/opencode.json` |

## Step 7. Restore stashed changes

If you stashed changes in Step 2, restore them:

```
git stash pop
```

This restores your current working directory. The new worktree remains intact with its own state.

## Step 8. Draft the spec content

Create a markdown spec document that Plan mode can use directly and save it in the `.planning/specs` folder inside the worktree using the `feature_slug`. Use the exact structure as defined in the spec template file here: @~/.config/opencode/templates/spec.tpl.md. Do not add technical implementation details such as code examples.

## Step 9. Final output to the user

After the file is saved, respond with the summary as specified in [@summary-format](#summary-format).

Do not repeat the full spec in the chat output unless the user explicitly asks to see it. The main goal is to save the spec file and report where it lives and what worktree/branch to use.

## Summary Format

Use this exact format for user-facing output:

```
Worktree: <WORKTREE_PATH>
Branch: ft/<feature_slug>
Spec file: .planning/specs/<feature_slug>.md
Title: <feature_title>
```
