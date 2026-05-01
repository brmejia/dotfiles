---
name: smart-commit
description: Analyzes git diffs and creates conventional commits with semantic grouping. Use when user wants to commit changes, asks for commit help, or mentions committing.
---

# Smart Commit

Analyze git diffs and create semantic conventional commits with user approval.

## Workflow

1. **Gather context** - Run `git status` and `git diff` to understand changes. Use explore subagent to check for untracked files that should be staged.
2. **Show [Context Summary]** - Display focus area and relevant changes.
3. **Show [Proposed Commits]** - Group commits by topic with global commit numbers.
4. **Use Question tool** to select commits using global commit numbers:
   - **All**: creates all commits
   - **<N>**: creates only commit N
   - **Edit <N>**: revise commit N before proceeding
   - **Merge <N .. M>**: merge selected commits then **repeat step 4**
   - **Skip <N>**: skips commit N (marked as ✗ in summary)
   - **None**: cancels entirely

   **DO NOT create an answer for each commit**
   **DO NOT auto-commit** - wait for user approval showing detailed Proposed commits.
5. **Follow user instructions**
6. **Show [Summary]**

## Git Commit Rules

**NEVER chain git commands** (e.g., `git add . && git commit`). Always run them as separate bash calls.

### Conventional Commits

- `feat` – A new feature added to the application
- `fix` – A bug patch
- `docs` – Documentation-only changes
- `style` – Formatting, whitespace — no logic change
- `refactor` – Code change that neither fixes a bug nor adds a feature
- `perf` – A code change that improves performance
- `test` – Adding missing tests or correcting existing ones
- `build` – Changes affecting build system or external dependencies
- `ci` – Changes to CI configuration files and scripts
- `chore` – Maintenance tasks that don't modify src or test files
- `revert` – Reverts a previous commit
- `ops` – Affects infrastructure, deployment, monitoring, or CI/CD pipelines

### Format

```
<type>: <concise_description>

<optional body explaining why, not what>
```

Use present tense for subject line. Explain **why** something changed, not just **what**.

### Breaking Changes

- Use `!` in header (e.g., `feat(api)!:`)
- Optionally add `BREAKING CHANGE:` footer when impact needs detail

## Guidelines

### General

- Check semantic relevance: does the change relate to user input?
- Analyze SEMANTIC PURPOSE of changes, not just filenames
- Read diff hunks to understand what changed at code level
- Check for untracked files using explore subagent. Stage them if necessary

### Heuristics

- Infer optional commit **scope** from dominant paths/modules (e.g., `auth`, `api`, `ui`, `deps`)
- Detect potential breaking changes (removed/renamed public APIs, config schema changes, changed defaults/behaviors) and surface them clearly
- Warn if commit is "large" (many files or very large diff) and suggest splitting

## Templates

### Context Summary

```
Focus area: <user input or inferred>

Relevant changes:
- <file_or_change_1> => <one-line reason for inclusion>
- <file_or_change_2> => <one-line reason for inclusion>
- ...
```

### Topic Grouping

Group commits by semantic topic/context. Assign **global commit numbers** across all topics (1, 2, 3...).

```
Topic 1: <topic_name_1> (<N> commits)
1. <type>: <description>
2. <type>: <description>

Topic 2: <topic_name_2> (<N> commits)
3. <type>: <description>
4. <type>: <description>
```

### Proposed Commits

```
Topic 1: <topic_name_1> (<N> commits)

1. <type>: <description>
   Files:
   - path/to/file_a
   - path/to/file_b

2. <type>: <description>
   Files:
   - path/to/file_c

Topic 2: <topic_name_2> (<N> commits)

3. <type>: <description>
   Files:
   - path/to/file_d
```

### Summary

```
[✓] 1. <type>: <description>
[✓] 2. <type>: <description>
[ ] 3. <type>: <description> (skipped)
[✓] 4. <type>: <description>
```
