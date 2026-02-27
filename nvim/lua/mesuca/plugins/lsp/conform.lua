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
                stdin = false,
                args = { "--format", "$FILENAME" },
            },
            biome = {
                -- Append the flag to the default command
                prepend_args = { "format", "--format-with-errors", "true" },
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
            javascript = { "oxfmt", stop_after_first = true },
            javascriptreact = { "oxfmt", stop_after_first = true },
            typescript = { "oxfmt", stop_after_first = true },
            typescriptreact = { "oxfmt", stop_after_first = true },
            json = { "oxfmt", stop_after_first = true },
            vue = { "oxfmt", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            css = { "biome", "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
            groovy = { "npm-groovy-lint" },
        },
    },
}
