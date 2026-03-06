---
description: Redact a feature spec file and create a git worktree from a short idea
argument-hint: Short feature description
agent: plan
subtask: true
---

You are helping to spin up a new feature spec for this application, from a short idea provided in the user input below. Always adhere to any rules or requirements set out in any AGENTS.md/CLAUDE.md files when responding.

User input: $ARGUMENTS

## High level behavior

Your job will be to turn the user input above into:

- A safe git worktree with branch (e.g. `../<repo>_ft-feature-slug` with branch `ft-feature-slug`)
- A detailed markdown spec file under the `.planning/specs` directory inside the worktree

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

## Step 3. Create a Git worktree

Create a new branch and worktree as a sibling of the current project directory.

```
# Get the parent directory and current repo name
PARENT_DIR=$(dirname "$PWD")
REPO_NAME=$(basename "$PWD")

# Worktree goes as sibling: ../repo_name_ft-feature_slug/
WORKTREE_PATH="../${REPO_NAME}_ft-${feature_slug}"

git worktree add -b ft/${feature_slug} "$WORKTREE_PATH" <base_branch>
```

- Base branch: detect automatically (prefer `main`, fallback to `master`)
- If the worktree path already exists, append a numeric suffix to both branch and worktree name: e.g. `ft-card-component-01`

## Step 4. Restore stashed changes

If you stashed changes in Step 2, restore them:

```
git stash pop
```

This restores your current working directory. The new worktree remains intact with its own state.

## Step 5. Draft the spec content

Create a markdown spec document that Plan mode can use directly and save it in the `.planning/specs` folder inside the worktree using the `feature_slug`. Use the exact structure as defined in the spec template file here: @~/.config/opencode/templates/spec.tpl.md. Do not add technical implementation details such as code examples.

## Step 6. Launch new opencode session in worktree

Open a new terminal with an opencode instance running in the worktree directory:

- Worktree path: `../${REPO_NAME}_ft-<feature_slug>`
- This new session will handle subsequent feature development

## Step 7. Final output to the user

After the file is saved, respond to the user with a short summary in this exact format:

Worktree: ../${REPO_NAME}\_ft-<feature_slug>
Branch: ft/<feature_slug>
Spec file: .planning/specs/<feature_slug>.md
Title: <feature_title>

Do not repeat the full spec in the chat output unless the user explicitly asks to see it. The main goal is to save the spec file and report where it lives and what worktree/branch to use.
