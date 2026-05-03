# PRD-to-Issues Pipeline Flow

This document describes the full PRD pipeline — a set of composable skills that chain together to take an idea from PRD through implementation.

## Pipeline Overview

```
/prd-spec → /prd-to-issues → /plan-and-implement-issues
```

Each skill is a discrete step that can be invoked independently, but together they form a coherent workflow from product requirements to implemented code.

## Prerequisites

- **Git**: Version control for worktree management
- **glab**: GitLab CLI, installed and authenticated (see `docs/agents/issue-tracker.md`)
- **opencode**: The agent runtime with skills support
- **Upstream skills**: `to-prd`, `to-issues`, `spec-feature` available in `agents/skills/`

## Spec File Conventions

Spec files are generated during planning (via `/prd-spec`, `/spec-feature`, or `/worktree-for`) and stored in a temporary hidden directory:

```
.scratch/specs/<YYYY-MM-DD>-<slug>.md
```

- **Location**: `.scratch/specs/` — hidden, temporary directory (ignored by `.gitignore`)
- **Date prefix**: `YYYY-MM-DD` — creation date for chronological ordering
- **Slug**: lowercase, kebab-case, max 40 characters
- Example: `.scratch/specs/2026-05-03-dark-mode.md`

This directory exists inside each worktree and is not committed.

## Skills

### `/prd-spec`

Creates a PRD (Product Requirements Document) as a GitLab issue from a short idea or feature description.

**Inputs:**
- Feature idea or description (from user conversation)

**Outputs:**
- A GitLab issue containing the PRD with user stories, acceptance criteria, and scope
- A spec file at `.scratch/specs/<YYYY-MM-DD>-<slug>.md` inside the created worktree

**Invocation:**
```
/prd-spec <feature description>
```

---

### `/prd-to-issues`

Breaks a PRD + optional spec into child GitLab issues with dependency tracking.

**Inputs:**
- PRD issue number (required): GitLab issue number referencing the PRD
- `--spec-path` (optional): Path to a spec file (typically `.scratch/specs/<YYYY-MM-DD>-<slug>.md`) to include as additional context

**Outputs:**
- Child issues created with:
  - `Blocked by` fields referencing dependency relationships (markdown)
  - Native issue links in the Issue Tracker (bi-directional relationships)
  - `needs-triage` label applied to each issue
  - Vertical slice descriptions with acceptance criteria
  - `ISSUE_MAP` mapping each slice to its issue identifier

**How it works:**
1. Fetches PRD content via `glab issue view <number>`
2. Reads spec file if `--spec-path` is provided
3. Builds combined context (PRD + spec)
4. Delegates to the upstream `to-issues` skill
5. Instructs `to-issues` to return issue IDs via `ISSUE_MAP` format
6. Issues are published in dependency order (blockers first)
7. After publication, creates native issue links via the Issue Tracker API:
   - Probes for `blocks` link support (Premium tier) — falls back to `relates_to` on Free tier
   - Creates bi-directional links for each dependency pair
   - Reports linking summary (count, type, failures)

**Invocation:**
```
/prd-to-issues <issue-number> --spec-path <path>
```

---

### `/check-issue-deps`

Validates issue dependencies before implementation begins.

**Inputs:**
- Issue number or list of issues to check

**Outputs:**
- Validation report showing dependency graph and any issues (missing blockers, circular dependencies, etc.)

**Invocation:**
```
/check-issue-deps <issue-number>
```

---

### `/worktree-for`

Creates a git worktree for a specific issue, isolating implementation work.

**Inputs:**
- Issue number

**Outputs:**
- A git worktree directory named after the issue, branched from the appropriate base

**Invocation:**
```
/worktree-for <issue-number>
```

---

### `/plan-and-implement-issues`

Batch orchestrator: takes a list of independent issue IDs, generates OpenSpec plans in parallel, and implements them in parallel within the same worktree.

**Inputs:**
- One or more issue IDs (positive integers)

**Outputs:**
- OpenSpec plans (proposal, design, tasks) for each issue
- Implementation of all plans via `openspec-apply-change`

**How it works:**
1. Fetches title and body for each issue via `glab issue view`
2. Validates all issues have no open blockers via `/check-issue-deps`
3. Spawns parallel sub-agents with `openspec-propose` for each issue
4. Presents generated plans for user validation (BLOCKING)
5. Spawns parallel sub-agents with `openspec-apply-change` for implementation

**Invocation:**
```
/plan-and-implement-issues <issue-id-1> <issue-id-2> ... <issue-id-N>
```

**Constraints:**
- All issues must be independent (no open blockers). Interdependent issues are rejected.
- Operates entirely in the current worktree — no branches or worktrees are created.

---

## Skill Composition Flow

The skills compose into a pipeline where each step feeds into the next:

1. **`/prd-spec`** creates the PRD issue — this is the starting point
2. **`/prd-to-issues`** reads the PRD (and optional spec) and breaks it into child issues with dependency tracking. Creates both markdown `Blocked by` references and native issue links in the Issue Tracker. Returns `ISSUE_MAP` for downstream consumption.
3. **`/check-issue-deps`** validates the dependency graph before work begins (invoked automatically by `/plan-and-implement-issues` and `/worktree-for`)
4. **`/worktree-for`** sets up an isolated worktree for a specific child issue (for complex issues that need their own branch)
5. **`/plan-and-implement-issues`** batch-processes multiple independent issues: generates OpenSpec plans in parallel, lets the user review them, then implements all in parallel within the same worktree

### Batch parallel path (recommended for independent issues)

```
/prd-spec → /prd-to-issues → ISSUE_MAP
                                  │
                                  ▼
                    /plan-and-implement-issues <id-A> <id-B> <id-C>
                         │
                    ┌────┴────┐
                    ▼         ▼
              plan + impl  plan + impl
              (parallel)   (parallel)
```

### Individual issue path (for complex issues needing isolated worktrees)

```
/prd-spec → /prd-to-issues → ISSUE_MAP
                                  │
                    ┌─────────────┼─────────────┐
                    ▼             ▼             ▼
              /worktree-for  /worktree-for  /worktree-for
                    │             │             │
                    ▼             ▼             ▼
              plan + impl   plan + impl   plan + impl
              (via plan-    (via plan-    (via plan-
               and-impl)     and-impl)     and-impl)
```

### Dependency Chain

```
PRD Issue (#N)
  └── Child Issue A (no blockers) → plan-and-implement-issues → done
  └── Child Issue B (blocked by A) → wait for A → plan-and-implement-issues
  └── Child Issue C (blocked by A) → wait for A → plan-and-implement-issues
```

## Triage Labels

All child issues created by `/prd-to-issues` receive the `needs-triage` label. See `docs/agents/triage-labels.md` for the full label vocabulary:

| Label | Meaning |
|-------|---------|
| `needs-triage` | Maintainer needs to evaluate this issue |
| `needs-info` | Waiting on reporter for more information |
| `ready-for-agent` | Fully specified, ready for an AFK agent |
| `ready-for-human` | Requires human implementation |
| `wontfix` | Will not be actioned |

## References

- `docs/agents/issue-tracker.md` — `glab` CLI conventions and issue linking API
- `docs/agents/triage-labels.md` — Label vocabulary
- `agents/skills/prd-to-issues/SKILL.md` — `/prd-to-issues` skill implementation
- `agents/skills/to-issues/SKILL.md` — Upstream `to-issues` skill (immutable)
- `agents/skills/spec-feature/SKILL.md` — `/spec-feature` skill implementation
- `agents/skills/worktree-for/SKILL.md` — `/worktree-for` skill implementation
- `agents/skills/plan-and-implement-issues/SKILL.md` — `/plan-and-implement-issues` batch orchestrator
