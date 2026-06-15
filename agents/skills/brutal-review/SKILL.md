---
name: brutal-review
description: Perform ruthless multi-perspective code review of staged/unstaged git diff or last commit. Launches four parallel subagents covering core logic, reliability, code quality, and performance. Use when user wants a code review, brutal review, review changes, or mentions reviewing code, PR review, pre-merge review.
---

# Brutal Review

Ruthless, in-depth, multi-perspective code review. Launches four specialist subagents in parallel to tear apart every line of changed code.

> **Execution**: Follow the workflow steps below immediately. Do not present a plan for user approval before starting.

> **Script paths**: Scripts referenced here are relative to this skill file (`scripts/`). Execute them directly as executables — no `bash` prefix. **Never use absolute paths** (`/home/…`, `/Users/…`); use `~`-relative paths instead.

## Quick Start

```bash
mktemp -d /tmp/brutal-review-XXXXXXXX
scripts/detect-changes.sh "$WORKDIR"
exit_code=$?
scripts/build-context-block.sh "$WORKDIR"
```

> **Note:** `mktemp` prints the created directory path to stdout — read it from the tool result and use it as `$WORKDIR` in subsequent steps. `build-context-block.sh` always writes to `$WORKDIR/context.md`; no need to capture its output.

- Exit codes: `0` = staged, `1` = unstaged, `2` = last commit, `3` = nothing to review, `4` = not a git repo, `5` = missing WORKDIR argument
- All files for a review session live inside `$WORKDIR/`: `diff.txt`, `type.txt`, `context.md`
- Each session gets its own `mktemp -d` directory — safe for concurrent reviews

## Workflow

### Session Setup

Before running any workflow steps, create a unique session directory:

```bash
mktemp -d /tmp/brutal-review-XXXXXXXX
```

> **Execute this exactly once per review session.** Read the path printed to stdout and keep it as `WORKDIR` for all subsequent steps. If already obtained in a previous turn, skip this command.

Files generated:
- `$WORKDIR/diff.txt` — full diff
- `$WORKDIR/type.txt` — change type
- `$WORKDIR/context.md` — enriched context for subagents

### Step 1: Detect Changes

```bash
scripts/detect-changes.sh "$WORKDIR"
exit_code=$?
```

The script writes `$WORKDIR/diff.txt` (full diff) and `$WORKDIR/type.txt` (change type). Check `exit_code`:
- `3` (nothing to review) or `4` (not a git repo) → inform the user and stop.
- `5` (missing WORKDIR) → bug in the agent's invocation, fix and retry.

### Step 2: Build Context File

```bash
scripts/build-context-block.sh "$WORKDIR"
```

The script reads `$WORKDIR/diff.txt` and use write tool to writes `$WORKDIR/context.md` containing the diff, modified files list, and commit log. **Verify** by reading `$WORKDIR/context.md` back with the Read tool.

### Step 3: Gather Additional Context

Before launching subagents, enrich the context by reading modified files in full and exploring callers of changed functions. Append relevant excerpts to `$WORKDIR/context.md` using the Write tool.

### Step 4: Launch Four Subagents in Parallel

Delegate IN PARALLEL each perspective to a subagent. Launch four in a single message (use Task tool with `subagent_type`):

| Subagent | Perspective |
|---|---|
| `brutal-core-logic` | Logic correctness, architecture, coupling, abstraction |
| `brutal-reliability` | Testing, error handling, edge cases, failure modes |
| `brutal-clean-campground` | Code quality, style, naming, documentation |
| `brutal-performance` | Allocations, hot paths, blocking ops, algorithmic complexity |

Each subagent reads `$WORKDIR/context.md` and reports findings categorized as **CRITICAL**, **MAJOR**, **MINOR**, or **NIT** with confidence scores (0-100).

### Step 5: Cleanup

```bash
rm -rf "$WORKDIR"
```

Single directory removal — cannot collide with other concurrent review sessions.

**Execute cleanup before presenting findings to the user.** This ensures the user sees the review results as the final output, not the cleanup confirmation.

### Step 6: Synthesize Findings

Combine findings from all four subagents and present to the user:
- Deduplicate overlapping issues
- Prioritize: CRITICAL > MAJOR > MINOR > NIT
- Renumber sequentially so each finding can be referenced unambiguously
- Filter out false positives and low-confidence findings
- Report synthesized findings: file, line, snippet, explanation, fix, confidence, severity

## Scripts

- [scripts/detect-changes.sh](scripts/detect-changes.sh) — Writes diff and change type to a session workdir
- [scripts/build-context-block.sh](scripts/build-context-block.sh) — Creates a context.md from the diff in the workdir

Both accept a `WORKDIR` argument. All output files share the same session directory, safe for concurrent reviews.
