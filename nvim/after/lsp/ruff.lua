local lsp = require("lib.lsp")

return {
    root_dir = lsp.get_server_root_dir_fn("ruff", { { "pyproject.toml", "ruff.toml", ".ruff.toml" }, { ".git" } }),
    workspace_required = true,
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
            -- Line lenght should be defined on pyproject.toml
            -- lineLength = 88,
            format = {
                -- Preview mode enables a collection of unstable features such
                -- as new lint rules and fixes, formatter style changes,
                -- interface updates, and more. Warnings about deprecated features
                -- may turn into errors when using preview mode.
                preview = false,
            },
        },
    },
}
