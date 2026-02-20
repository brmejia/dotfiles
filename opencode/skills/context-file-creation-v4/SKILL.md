---
name: context-file-creation-v4
description: Create and manage context files using /tmp (no symlinks)
---

## Overview

Simple context file creation using `/tmp/opencode-context/` with direct file paths.

**Use this skill** when:
- Passing git diffs or large content to subagents
- Need reliable, simple file sharing between main agent and subagents
- No symlink complexity needed

## Usage

```bash
# Step 1: Create context file
CONTEXT_FILE=$(bash create_context.sh)

# Step 2: Write content (stdin or string)
echo "$DIFF" | bash write_content.sh "$CONTEXT_FILE" -
# Or: bash write_content.sh "$CONTEXT_FILE" "string content"

# Step 3: Subagents read the actual /tmp path
# Pass: /tmp/opencode-context/context-XXXXXXXX.md

# Step 4: Cleanup
bash cleanup.sh "$CONTEXT_FILE"
```

## Key Differences from v3

| Aspect | v3 | v4 |
|--------|-----|-----|
| Symlinks | Yes | No |
| Path complexity | Higher | Lower |
| Failure points | More | Fewer |

## Example: Git Diff Context

```bash
CONTEXT_FILE=$(bash create_context.sh)
git diff HEAD | bash write_content.sh "$CONTEXT_FILE" -

# Subagent prompt:
# "Read the file at: /tmp/opencode-context/context-XXXXXXXX.md"

bash cleanup.sh "$CONTEXT_FILE"
```
