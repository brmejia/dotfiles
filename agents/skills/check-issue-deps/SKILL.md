---
name: check-issue-deps
description: Validates that all blocker dependencies for a GitLab issue are resolved before implementation can proceed. Accepts an issue number and checks if all "Blocked by" references are closed. Use when user wants to verify an issue is ready to start, check dependency status before creating a worktree, or audit blocker resolution across multiple issues.
---

## Overview

Check whether all dependency blockers for a GitLab issue are closed. Use this skill when you need to validate that an issue is ready for implementation by confirming all its "Blocked by" dependencies have been resolved.

**Input**: A positive integer issue number (e.g., `3`, `42`)

**Output**: Success if no blockers or all closed; failure if any blockers remain open.

## Workflow

### Step 1: Validate input

Extract the issue number from the invocation. It must be a positive integer.

- If no issue number provided: report error "Issue number is required. Usage: /check-issue-deps <issue-number>" and exit.
- If non-integer, zero, or negative: report error "Issue number must be a positive integer, got: <input>" and exit.

### Step 2: Check glab availability

Run:
```bash
command -v glab >/dev/null 2>&1
```

- If glab is not found: report error "glab CLI is required but not installed. Install it first: https://gitlab.com/gitlab-org/cli" and exit.

### Step 3: Fetch the target issue

Run:
```bash
glab issue view <issue-number> -F json 2>&1
```

Capture both stdout and the exit code.

- Exit code 0: parse the JSON response.
- Exit code non-zero: examine stderr/stdout for the error type:
  - Contains "not found" or "404": report "Issue #<number> not found in this project" and exit.
  - Contains "auth" or "login" or "token": report "glab authentication error. Run 'glab auth login' to authenticate." and exit.
  - Contains "timeout" or "connection" or "network": report "Network error contacting GitLab. Check your connection and try again." and exit.
  - Other: report "Error fetching issue #<number>: <error message>" and exit.

From the JSON response, extract:
- `description` (the issue body text — glab uses `description` not `body`)
- `state` (the issue state)

### Step 4: Parse "Blocked by" section

Search the issue body for a `## Blocked by` heading. The section extends from that heading to the next `##` heading or end of body.

Extract the section content and find all issue references matching the pattern `#\d+`.

- If no `## Blocked by` heading found: treat as no blockers. Report success: "No blockers found - issue is ready to start" and exit.
- If section contains "None" or "none" with no `#\d+` references: treat as no blockers. Report success: "No blockers found - issue is ready to start" and exit.
- If `#\d+` references found: collect all unique issue numbers as blocker references.

### Step 5: Check each blocker's state

For each blocker issue number, run:
```bash
glab issue view <blocker-number> -F json 2>&1
```

- Exit code 0: parse JSON and extract `state` and `title`.
  - `state` == "closed": add to closed list.
  - `state` == "opened": add to open list.
- Exit code non-zero: the referenced issue does not exist. Report "Invalid blocker reference: #<number> does not exist" and exit.

### Step 6: Report results

**No blockers**:
```
No blockers found - issue is ready to start
```

**All blockers closed**:
```
All dependencies resolved for #<issue-number>:
- #<blocker1>: <title1>
- #<blocker2>: <title2>
```

**Open blockers remain**:
```
Dependencies not resolved for #<issue-number>:
Open blockers:
- #<blocker1>: <title1>
- #<blocker2>: <title2>
```
Exit with failure status.

## Error Handling

- **glab not installed**: Clear message with install link.
- **glab not authenticated**: Instruct user to run `glab auth login`.
- **Issue not found**: Report the missing issue number.
- **Invalid blocker reference**: Report which reference is invalid.
- **Network/timeout**: Suggest retrying.
- **Malformed body (no Blocked by header)**: Treat as no blockers.
- **Mixed content in Blocked by section**: Extract only `#\d+` patterns, ignore text.
