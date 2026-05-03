---
name: plan-and-implement-issues
description: Takes a list of independent issue IDs, verifies they have no open blockers, generates OpenSpec plans for each in parallel, and implements them in parallel within the same worktree. Use when user wants to batch-implement multiple independent issues at once, or mentions "plan and implement issues", "batch implement issues", or "implementar varios issues".
---

# Plan and Implement Issues

Orchestrate planning and implementation for a batch of independent issues. Operates entirely within the current worktree — no branches or worktrees are created.

## Arguments

```
/plan-and-implement-issues <issue-id-1> <issue-id-2> ... <issue-id-N>
```

One or more positive integers representing issue IDs in the Issue Tracker.

## Prerequisites

- `glab` CLI installed and authenticated (see `docs/agents/issue-tracker.md`)
- OpenSpec CLI installed (`openspec` available in PATH)
- `check-issue-deps` skill available at `agents/skills/check-issue-deps/SKILL.md`
- `openspec-propose` skill available at `.opencode/skills/openspec-propose/SKILL.md`
- `openspec-apply-change` skill available at `.opencode/skills/openspec-apply-change/SKILL.md`

## Workflow

### Step 1: Parse and validate IDs

Extract all issue IDs from the invocation. Each must be a positive integer.

- If no IDs provided, or any ID is not a positive integer: error `Usage: /plan-and-implement-issues <issue-id-1> <issue-id-2> ...` and halt.

### Step 2: Fetch issue information

For each issue ID, fetch its details:

```bash
glab issue view <id> -F json
```

Parse the JSON response. Extract:
- `title`: issue title
- `description`: full issue body

If any issue is not found (404) or the command fails: report which ID failed and halt.

Store the mapping: `issue_id → { title, body }`.

### Step 3: Verify independence

Invoke `/check-issue-deps` for each issue ID.

If **any** issue has open blockers: report which issues are blocked and by which dependencies, then halt. All issues in the batch must have no open blockers — the orchestrator assumes issues are independent and can coexist in the same worktree without conflicts.

If all issues pass: proceed to Step 4.

### Step 4: Generate plans in parallel

For each issue, spawn a sub-agent using the `task` tool with `subagent_type="general"`. Each sub-agent receives:

```
Use the openspec-propose skill with the following issue context:

Title: <title>
Body: <body>
Issue ID: #<id>

Generate the proposal, design, and tasks artifacts.
```

Spawn all sub-agents concurrently. Wait for **all** to complete.

If any sub-agent fails: report which issue failed and halt.

Collect the output from each sub-agent. For each issue, record:
- The OpenSpec change name generated
- Paths to the created artifacts (`openspec/changes/<name>/`)

### Step 5: User validation (BLOCKING)

Display a summary of all generated plans:

```
Generated plans:

Issue #<id-A>:
  Change: <change-name-A>
  Artifacts:
    - openspec/changes/<name-A>/proposal.md
    - openspec/changes/<name-A>/design.md
    - openspec/changes/<name-A>/tasks.md

Issue #<id-B>:
  Change: <change-name-B>
  Artifacts:
    ...
```

Use the `question` tool with options:

```
Proceed with implementation?

  Yes, implement         — run all implementation plans
  No, I need to modify   — pause for manual edits to the generated files
  Cancel                 — stop without implementing
```

- **Yes, implement**: proceed to Step 6.
- **No, I need to modify**: pause and wait for the user. When the user indicates they are done editing, return to this step (re-display the summary).
- **Cancel**: report `Implementation cancelled. Plans remain in openspec/changes/.` and halt.

### Step 6: Implement plans in parallel

For each issue, spawn a sub-agent using the `task` tool with `subagent_type="general"`:

```
Use the openspec-apply-change skill to implement the change for issue #<id>.
The change name is: <change-name>
```

Spawn all sub-agents concurrently. Wait for **all** to complete.

If any sub-agent fails: report which issue failed and at what step, then halt.

### Step 7: Report summary

```
Implementation complete:

  #<id-A>: plan ✓ | impl ✓
  #<id-B>: plan ✓ | impl ✓
  #<id-C>: plan ✓ | impl ✓

Total: N issues planned and implemented
```

## Error Handling

| Scenario | Behavior |
|----------|----------|
| Missing OpenSpec CLI | Error: `openspec CLI is required but not found. Install it first.` and halt |
| Missing glab | Error: `glab CLI is required` and halt |
| Invalid or missing IDs | Error with usage instructions and halt |
| Issue not found (404) | Error listing the missing ID and halt |
| Any issue has open blockers | List all blocked issues with their blockers and halt |
| Plan generation fails for any issue | Report which issue, halt |
| User cancels at validation | Halt gracefully, plans preserved |
| Implementation fails for any issue | Report which issue, halt |

## Rules

- **Halt on first failure**: if any step fails for any issue, stop everything. No partial progress.
- **Same worktree only**: this skill does not create branches or worktrees. All changes happen in the current directory.
- **Independence is strict**: all issues must have zero open blockers. Interdependent issues are rejected.
- **Parallel sub-agents**: Steps 4 and 6 use concurrent `task()` calls, not sequential.
- **BLOCKING validation**: Step 5 requires explicit user confirmation via the `question` tool.
