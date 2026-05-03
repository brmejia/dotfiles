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
5. Use the issue template format from `to-issues` for `Blocked by` fields:

```markdown
## Blocked by

- A reference to the blocking ticket (if any)

Or "None - can start immediately" if no blockers.
```

6. After publishing all issues, report each slice with its created issue identifier in this format:
   ```
   ISSUE_MAP: <slice-title> -> #<issue-id>
   ```

Do NOT modify the `to-issues` skill file. This skill is a thin orchestrator that prepares context and delegates.

### 8. Link dependencies in the Issue Tracker

After `to-issues` publishes all issues, create native issue links for each dependency relationship via the Issue Tracker API. Links are bi-directional — both issues show the relationship in the Issue Tracker interface.

#### 8a. Parse issue IDs

Extract the slice-to-ID mapping from `to-issues` output. Look for `ISSUE_MAP:` lines.

If parsing fails (no `ISSUE_MAP:` found), fall back to parsing issue URLs, issue references (`#N`), or querying the Issue Tracker for recently created issues. Cross-reference titles with slice titles.

#### 8b. Determine project/namespace identifier

Use the Issue Tracker CLI to find the current project/namespace ID required for API calls:

```bash
glab api "projects/:fullpath" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])"
```

Set variable: `namespace_id`

#### 8c. Probe for blocking link_type availability

Attempt to create a blocking link with the first dependency pair:

```bash
glab api --method POST "projects/<namespace_id>/issues/<blocked_id>/links?target_project_id=<namespace_id>&target_issue_iid=<blocker_id>&link_type=blocks"
```

- **HTTP 201 (Created)**: `link_type = "blocks"` — blocking relationships are available.
- **HTTP 403 (Forbidden) or 422**: `link_type = "relates_to"` — fallback to non-blocking relationship.

Cache `link_type` for all subsequent links in this session. Do NOT probe again.

#### 8d. Create links

For each dependency where slice A blocks slice B (B depends on A):

```bash
glab api --method POST "projects/<namespace_id>/issues/<B_id>/links?target_project_id=<namespace_id>&target_issue_iid=<A_id>&link_type=<link_type>"
```

Key rules:
- The issue in the URL path is the BLOCKED issue (the one waiting for the dependency).
- `target_issue_iid` is the BLOCKER (the one that must complete first).
- Links are bi-directional.
- If one link fails, continue with the rest. Collect failures.

#### 8e. Report linking summary

```
Native links created: <count>
Link type used: <blocks|relates_to>
```

If any links failed, list them:

```
Failed links:
  - #<B_id> -> #<A_id>: <error message>
```

## References

- `docs/agents/issue-tracker.md` — `glab` CLI conventions
- `docs/agents/triage-labels.md` — Label vocabulary
- `agents/skills/to-issues/SKILL.md` — Upstream skill (immutable)

## Permission Hints

When delegating to `to-issues` which may spawn sub-agents for implementation, the parent agent MUST pre-approve read+write filesystem access for any worktree paths that will be created.

After worktree paths are computed, grant read+write access to:
```
$HOME/<repo-name>_<branch_name>/*
```

Use `$HOME` (not `~`) in permission patterns.
