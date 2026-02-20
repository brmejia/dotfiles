---
description: Create a commit message by analyzing git diffs
agent: plan
subtask: true
$ARGUMENTS:
  type: string
  description: Additional instruction sor optional focus areas (e.g., "persistence", "services configuration", "mise changes", "performance") to filter analysis
  required: false
---
# Mission

Use @explorer to prepare one or multiple commits by context

User input:
```
$ARGUMENTS
````

# Guidelines

## General
- Check semantic relevance: does the change implement/modify something related to user input?
- Analyze SEMANTIC PURPOSE of changes, not just filenames
- Read diff hunks to understand what changed at code level
- Check semantic relevance: does the change implement/modify something related to user input?
- Check for references to untracked files using @explorer subagent. Stage them if necessary

## Heuristics
- Infer an optional commit **scope** from dominant paths/modules (e.g., `auth`, `api`, `ui`, `deps`).
- Detect potential breaking changes (removed/renamed public APIs, config schema changes, changed defaults/behaviors) and surface them clearly.
- Warn if the proposed commit is “large” (e.g., many files or very large diff) and suggest splitting.

## Commit message

Use present tense for the subject line and explain "why" something has changed, not just "what" has changed.

### Follow Conventional Commits
- `feat` – A new feature added to the application
- `fix` – A bug patch
- `docs` – Documentation-only changes
- `style` – Formatting, missing semicolons, whitespace — no logic change
- `refactor` – Code change that neither fixes a bug nor adds a feature
- `perf` – A code change that improves performance
- `test` – Adding missing tests or correcting existing ones
- `build` – Changes affecting the build system or external dependencies (e.g. npm, gulp)
- `ci` – Changes to CI configuration files and scripts (e.g. GitHub Actions, CircleCI)
- `chore` – Maintenance tasks that don't modify src or test files
- `revert` – Reverts a previous commit
- `ops` – Affects infrastructure, deployment, monitoring, or CI/CD pipelines

<Optional body explaining *why* not *what*>

### Breaking changes
- Use `!` in the header when the change is breaking (e.g., `feat(api)!:`).
- Optionally add a `BREAKING CHANGE:` footer when the “why/impact” needs detail.

### Commit Message Format:

```
<type>: <concise_description>

<optional_body_list_explaining_why>
```

## Output

### 1. Context Summary
Display the focus area and the semantically relevant changes identified:

```
Focus area: <$ARGUMENTS>

Relevant changes:
- <file_or_change_1> => <one-line reason for inclusion>
- <file_or_change_2> => <one-line reason for inclusion>
- ...
```

### 2. Topic Grouping
Group commits by semantic topic/context. Assign **global commit numbers** across all topics (1, 2, 3...) for referencing.

```
Topic 1: <topic_name_1> (<N> commits)
1. <type>: <description>
2. <type>: <description>
3. <type>: <description>
4. <type>: <description>

Topic 2: <topic_name_2> (<N> commits)
5. <type>: <description>
6. <type>: <description>
...
```

### 3. Proposed Commits (by Topic)
For each topic, propose commits following Conventional Commits format.
Use **global commit numbers** (1, 2, 3...) for referencing.

## 4. Confirmation Request (single)

Show to the user about all proposed commits

```markdown
## Proposed Commits

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

Then ask full or partial confimation using **global commit numbers**:
- "yes": creates all commits
- "yes <N>": creates only commit N
- "no": cancels entirely
- "edit <N>": lets you revise commit N before proceeding
- "skip <N>": skips commit N (will be marked as ✗ in summary)

**DO NOT auto-commit** - wait for user approval showing detailed Proposed comits.

After confirmation, display the summary

```markdown
## Summary

✓ 1. <type>: <description>
✓ 2. <type>: <description>
✗ 3. <type>: <description> (skipped)
✓ 4. <type>: <description>
```
