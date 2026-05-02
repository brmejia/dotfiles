---
name: prd-to-issues
description: Break a PRD + optional spec into child issues with dependency tracking. Use when user wants to convert a PRD into implementation issues, decompose a large feature into tracked tasks, create dependency-ordered issue chains, or publish child issues from a planning spec.
---

# PRD to Issues

Orchestrate PRD fetching, spec reading, and delegation to `to-issues` for creating dependency-tracked child GitLab issues.

## Prerequisites

- `glab` CLI installed and authenticated (see `docs/agents/issue-tracker.md`)
- Upstream `to-issues` skill available at `agents/skills/to-issues/SKILL.md`
- Triage label vocabulary from `docs/agents/triage-labels.md`

## Workflow

### 1. Parse inputs

Accept the following from user input:

- **PRD issue number** (required): A GitLab issue number referencing the PRD
- **`--spec-path`** (optional): Path to a spec file to include as additional context

If the PRD issue number is missing, request it from the user before proceeding.

If `--spec-path` is provided, verify the file exists and is readable. If not, report the error and halt.

### 2. Check prerequisites

Verify `glab` is available:

```bash
command -v glab
```

If `glab` is not installed or not in PATH, report that `glab` is a required prerequisite and halt.

### 3. Fetch PRD content

Run `glab issue view <number> --comments` to fetch the full PRD issue body and comments.

If the command fails (issue not found, network error, etc.), propagate the error and halt without invoking `to-issues`.

### 4. Read spec file (if provided)

If `--spec-path` was provided, read the file content using the `read` tool.

If the file is missing or unreadable, report the error and halt.

### 5. Build combined context

Combine the PRD content and spec content (if provided) into a single context block:

```
## PRD Content

<full issue body and comments from glab>

## Spec Content (if provided)

<spec file content>
```

If no spec path was provided, the context consists solely of the PRD content.

### 6. Verify upstream skill

Verify that the `to-issues` skill exists at `agents/skills/to-issues/SKILL.md`. If not found, report that the upstream skill is missing and setup is required, then halt.

### 7. Delegate to to-issues

With the combined context ready, invoke the upstream `to-issues` workflow. Instruct the agent to:

1. Follow the `to-issues` skill process with the combined context
2. Go through the quiz/approval step with the user before publishing
3. Publish issues in **dependency order** (blockers first) so that `Blocked by` fields can reference real issue identifiers
4. Apply the `needs-triage` label to each child issue (see `docs/agents/triage-labels.md` for label vocabulary)
5. Use the GitLab issue template format from `to-issues` for `Blocked by` fields:

```markdown
## Blocked by

- A reference to the blocking ticket (if any)

Or "None - can start immediately" if no blockers.
```

Do NOT modify the `to-issues` skill file. This skill is a thin orchestrator that prepares context and delegates.

## References

- `docs/agents/issue-tracker.md` — `glab` CLI conventions
- `docs/agents/triage-labels.md` — Label vocabulary
- `agents/skills/to-issues/SKILL.md` — Upstream skill (immutable)
