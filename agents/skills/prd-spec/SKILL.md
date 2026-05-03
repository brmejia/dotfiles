---
name: prd-spec
description: Chain to-prd → spec-feature to create a PRD issue and planning worktree with spec file. Use when user wants to go from feature idea to PRD + spec in one step, start planning a new feature, create a spec-driven worktree, or bootstrap a feature with both tracking issue and isolated workspace.
---

# PRD Spec

Orchestrate `to-prd` and `spec-feature` to create a GitLab PRD issue and a planning worktree with a spec file from a single feature idea.

## Input

**feature_title** (required): Human-readable feature description.

If no feature title is provided, request it from the user before proceeding. The input must be a non-empty string. Report an error and exit if validation fails.

## Prerequisites

### 1. Check `glab` availability

Run:
```bash
command -v glab
```

If `glab` is not found, report:
```
glab CLI is required but not installed. Install it: https://gitlab.com/gitlab-org/cli
```
and exit.

## Slug Extraction

Derive a kebab-case `feature_slug` from `feature_title` using this algorithm:

1. Convert to lowercase
2. Replace non-alphanumeric characters (except `-`) with `-`
3. Collapse consecutive dashes to a single dash
4. Strip leading and trailing dashes
5. Remove trailing `-feature` or `-feat` suffix
6. Truncate to 40 characters
7. Strip trailing dash after truncation

**Fallback**: If the resulting slug is empty, use `unnamed`.

**Branch name format**: `ft-<slug>`

**Examples**:
- "Add Dark Mode" → `ft-add-dark-mode`
- "Implement User Auth Feature" → `ft-implement-user-auth`
- "New Dashboard" → `ft-new-dashboard`

## Workflow

### Step 1: Create PRD issue via `to-prd`

Invoke the `to-prd` skill using the `task` tool. Pass the feature idea as context.

**Important**: Do NOT modify the `to-prd` skill. It is an immutable upstream skill.

After `to-prd` completes, extract the created issue number and URL from the task output. The `to-prd` skill publishes the PRD to the GitLab issue tracker and reports the issue URL — parse this from the task result.

**Error handling**: If `to-prd` fails, report the error and halt. Do NOT proceed to Step 2.

### Step 2: Create planning worktree via `spec-feature`

Invoke the `spec-feature` skill using the `task` tool with:
- The original `feature_title`
- `--branch-name ft-<slug>` override (using the slug extracted above)

**Important**: Do NOT modify the `spec-feature` skill. It is an immutable upstream skill.

The `spec-feature` skill handles its own user confirmation for worktree creation (blocking question step).

**Error handling**: If `spec-feature` fails, report the error. The PRD issue created in Step 1 remains valid — no rollback is needed.

## Output

After both steps complete successfully, output a summary:

```
PRD Issue: <gitlab-issue-url>
Worktree: <worktree-path>
Branch: ft-<slug>
Spec file: .scratch/specs/<YYYY-MM-DD>-<slug>.md
```

## Error Handling

| Scenario | Behavior |
|---|---|
| `to-prd` skill not available | Report error, halt, suggest running `update-mpocock-skills` |
| `to-prd` fails | Report error, halt, do not invoke `spec-feature` |
| `spec-feature` skill not available | Report error, halt |
| `spec-feature` fails | Report error, PRD issue already created (no rollback) |
| `glab` not available | Report prerequisite error before any invocation |
| Slug extraction produces empty string | Fall back to `ft-unnamed` |
| Worktree branch collision | `spec-feature` handles with numeric suffix |

## References

- `agents/skills/to-prd/SKILL.md` — Upstream skill for PRD creation (immutable)
- `agents/skills/spec-feature/SKILL.md` — Upstream skill for spec generation (immutable)
- `docs/agents/issue-tracker.md` — `glab` CLI conventions
- `docs/agents/triage-labels.md` — Label vocabulary

## Permission Hints

Before invoking `spec-feature` in Step 2, the parent agent MUST pre-approve read+write filesystem access for the worktree path.

After computing the branch name and worktree path, grant read+write access to:
```
$HOME/<repo-name>_<branch_name>/*
```

Use `$HOME` (not `~`) in permission patterns.
