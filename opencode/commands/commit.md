---
description: Create a commit message by analyzing git diffs
agent: plan
subtask: false
$ARGUMENTS:
  type: string
  description: Additional instruction sor optional focus areas (e.g., "persistence", "services configuration", "mise changes", "performance") to filter analysis
  required: false
---
# Mission

Follow git rules @~/.config/opencode/instructions/git-commit-rules.md

Use @explore to prepare one or multiple commits by context

User input:
```
$ARGUMENTS
```

# Workflow
1. Show to user [Context Summary]
2. Show to user[Proposed Commits]
3. Use **Question tool** to select commits using **global commit numbers**:
    - All: creates all commits
    - <N>: creates only commit N
    - Edit <N>: revise commit N before proceeding
    - Merge <N .. M>: merge selected commits then **repeat step 3**
    - Skip <N>: skips commit N (will be marked as ✗ in summary)
    - None: cancels entirely

    **DO NOT create an answer for each commit**
    **DO NOT auto-commit** - wait for user approval showing detailed Proposed commits.
4. Follow user instructions
5. Show to user [Summary]

# Guidelines

## General
- Check semantic relevance: does the change implement/modify something related to user input?
- Analyze SEMANTIC PURPOSE of changes, not just filenames
- Read diff hunks to understand what changed at code level
- Check semantic relevance: does the change implement/modify something related to user input?
- Check for references to untracked files using @explore subagent. Stage them if necessary

## Heuristics

- Infer an optional commit **scope** from dominant paths/modules (e.g., `auth`, `api`, `ui`, `deps`).
- Detect potential breaking changes (removed/renamed public APIs, config schema changes, changed defaults/behaviors) and surface them clearly.
- Warn if the proposed commit is "large" (e.g., many files or very large diff) and suggest splitting.

## Templates

### Context Summary

Display the focus area and the semantically relevant changes identified:

```
Focus area: <$ARGUMENTS>

Relevant changes:
- <file_or_change_1> => <one-line reason for inclusion>
- <file_or_change_2> => <one-line reason for inclusion>
- ...
```

### Topic Grouping

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

### Proposed Commits (by Topic)

For each topic, propose commits following Conventional Commits format.
Use **global commit numbers** (1, 2, 3...) for referencing.

```
Topic 1: <topic_name_1> (<N> commits)

1. <type>: <description>
   Files:
   - path/to/file_a
   - path/to/file_b

2. <type>: <description>
   Files:
   - path/to/file_c

Topic 2: <topic_name_2> (<N> commits) 3. <type>: <description>
Files: - path/to/file_d
```

### Summary
```
[✓] 1. <type>: <description>
[✓] 2. <type>: <description>
[ ] 3. <type>: <description> (skipped)
[✓] 4. <type>: <description>
```
