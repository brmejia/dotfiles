---
name: git-guardrails
description: Install hooks that block dangerous git commands (push, reset --hard, clean -f, branch -D, checkout ., restore .). Use when user wants git safety hooks, block destructive git operations, or set up git guardrails for OpenCode or Claude Code.
---

# Git Guardrails

Install a hook/plugin that intercepts and blocks dangerous git commands before execution.

## What Gets Blocked

- `git push` (all variants including `--force`)
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

## Workflow

### 1. Ask which tool

Ask the user: **OpenCode** or **Claude Code**?

### 2. Ask scope

- **OpenCode**: this project (`opencode.json`) or all projects (`~/.config/opencode/opencode.json`)?
- **Claude Code**: this project (`.claude/settings.json`) or all projects (`~/.claude/settings.json`)?

### 3. Install

#### OpenCode

Copy [scripts/opencode-plugin.ts](scripts/opencode-plugin.ts) to the target:

- **Project**: `opencode/plugins/git-guardrails.ts`
- **Global**: `~/.config/opencode/plugins/git-guardrails.ts`

Register in the corresponding `opencode.json`:

```json
{
  "plugin": ["./plugins/git-guardrails.ts"]
}
```

For global, use the full path: `~/.config/opencode/plugins/git-guardrails.ts`.

If `plugin` already exists, append — don't overwrite.

#### Claude Code

Copy [scripts/claude-hook.sh](scripts/claude-hook.sh) to the target:

- **Project**: `.claude/hooks/block-dangerous-git.sh`
- **Global**: `~/.claude/hooks/block-dangerous-git.sh`

Make executable: `chmod +x <path>`

Add to the corresponding settings file:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

For global, use `"command": "~/.claude/hooks/block-dangerous-git.sh"`.

Merge into existing `hooks.PreToolUse` — don't overwrite other hooks.

### 4. Ask about customization

Ask if the user wants to add or remove patterns from the blocked list.

### 5. Verify

**OpenCode**: run `echo '{"tool":"bash","args":{"command":"git push origin main"}}'` through the plugin logic manually or check the plugin loads without errors.

**Claude Code**:

```bash
echo '{"tool_input":{"command":"git push origin main"}}' | <path-to-script>
```

Should exit code 2 with a BLOCKED message on stderr.
