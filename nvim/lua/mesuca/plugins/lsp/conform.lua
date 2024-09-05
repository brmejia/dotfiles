return {
    "stevearc/conform.nvim",
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
        },
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = {
                -- "ruff_fix",
                "ruff_organize_imports",
            },

            -- Use a sub-list to run only the first available formatter
            javascript = { { "prettierd", "prettier" } },
            typescript = { { "prettierd", "prettier" } },
            json = { { "prettierd", "prettier" } },
            yaml = { { "prettierd", "prettier" } },
            groovy = { { "npm-groovy-lint" } },
        },
    },
}
