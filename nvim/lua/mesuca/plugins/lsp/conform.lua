return {
    "stevearc/conform.nvim",
    -- enabled = false,
    opts = {
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 700,
            lsp_fallback = false,
        },
        formatters = {
            ["npm-groovy-lint"] = {
                command = "npm-groovy-lint",
                -- A list of strings, or a function that returns a list of strings
                -- Return a single string instead of a list to run the command in a shell
                -- args = { "--format", "-" },
                stdin = false,
                args = { "--format", "$FILENAME" },
            },
            biome = {
                --- When inherit = true, add these additional arguments to the end of the command.
                -- This can also be a function, like args
                append_args = { "--indent-style", "space" },
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = {
                -- "ruff_fix",
                "ruff_organize_imports",
            },

            -- Use a sub-list to run only the first available formatter
            javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
            typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
            json = { "biome", "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            css = { "biome", "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
            groovy = { "npm-groovy-lint" },
        },
    },
}
