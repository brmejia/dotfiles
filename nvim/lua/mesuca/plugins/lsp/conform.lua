return {
    "stevearc/conform.nvim",
    opts = {
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 700,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },

            -- Use a sub-list to run only the first available formatter
            javascript = { { "prettierd", "prettier" } },
            typescript = { { "prettierd", "prettier" } },
            yaml = { { "prettierd", "prettier" } },
        },
    },
}
