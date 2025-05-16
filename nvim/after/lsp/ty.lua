local lsp = require("lib.lsp")

return {
    root_dir = lsp.get_server_root_dir_fn("ty", { { "pyproject.toml", "ruff.toml", ".ruff.toml" }, { ".git" } }),
    workspace_required = true,
}
