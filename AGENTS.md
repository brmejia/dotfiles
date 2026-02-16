# AGENTS.md - Agent Coding Guidelines

This is a **dotfiles configuration repository** with Neovim Lua configs, shell configs, and tool configurations.

## Project Structure

```
.dotfiles/
├── nvim/lua/           # Neovim plugins and config
│   ├── lib/            # Shared libs (lsp.lua, utils.lua, ui.lua)
│   ├── mesuca/plugins/# Plugin specs
│   ├── mappings.lua    # Keybindings
│   └── options.lua     # Neovim settings
├── opencode/           # Opencode agents & commands
├── cargo/              # Rust project configs
├── mise/               # Tool versions (config.toml)
├── fish/, nushell/, zshrc  # Shell configs
└── stylua.toml         # Lua formatter config
```

## Build/Lint/Test Commands

### Lua (stylua)
```bash
stylua nvim/lua/              # Format all
stylua --check nvim/lua/     # Check without modifying
stylua nvim/lua/lib/lsp.lua  # Single file
```

### Shell (shellcheck)
```bash
shellcheck zshrc fish/fishrc nushell/config.nu
```

### Rust (cargo)
```bash
cargo build
cargo test                  # All tests
cargo test <name>           # Single test
cargo test -- --nocapture   # With output
cargo clippy                # Lint
cargo fmt                   # Format
```

## Lua Code Style

**Formatting** (from stylua.toml):
- 120 columns, 4 spaces indent, Unix line endings
- Double quotes preferred, always use call parentheses

**Naming**:
- Functions/variables: `snake_case`
- Modules: `PascalCase` or `snake_case`
- Constants: `UPPER_SNAKE_CASE`
- Prefix private functions with `_`

**Imports**:
```lua
local vim = vim
local utils = require("lib.utils")
local lsp = require("lib.lsp")
```

**Error Handling**:
- `vim.notify(msg, vim.log.levels.WARN)` for warnings
- `vim.log.levels.ERROR` for errors
- Never use `assert()` in production
- Return `nil` on failure

## Shell Code Style

- Use `shellcheck` for validation
- Prefer POSIX syntax
- Use `set -euo pipefail` at script top
- Quote all expansions: `"$var"` not `$var`

## Neovim Plugin Patterns

```lua
-- nvim/lua/mesuca/plugins/category/plugin.lua
return {
    "owner/repo",
    event = "VeryLazy",
    keys = { ... },
    config = function()
        require("plugin_name").setup({ ... })
    end,
}
```

**Keybindings**:
```lua
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
```

## Opencode Agents

Located in `opencode/agents/`:
- `brutal-core-logic.md` - Architecture & correctness
- `brutal-reliability.md` - Testing & error handling
- `brutal-clean-campground.md` - Code quality
- `brutal-performance.md` - Performance

Slash command: `/brutal-review` (in `opencode/commands/brutal-review.md`)

## Common Tasks

**Add plugin**: Create `nvim/lua/mesuca/plugins/<cat>/<name>.lua`, run `:Lazy`

**Test Lua manually**:
```bash
# In Neovim
:luafile nvim/lua/lib/lsp.lua
:lua =require("lib.lsp").get_root_dir(...)
```

## Anti-Patterns

- **Lua**: Using `vim.cmd()` when Lua API exists
- **Lua**: `table.insert(t, #t + 1, x)` → use `table.insert(t, x)`
- **Lua**: Global functions without `local`
- **Shell**: Unquoted variables
- **Shell**: `grep | xarg` without `-0`/`-r`

## Version Control

Use conventional commits: `feat:`, `fix:`, `refactor:`, `chore:`

Do NOT commit secrets. Use `.gitignore`.
