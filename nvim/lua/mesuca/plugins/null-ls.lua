return {
    "jose-elias-alvarez/null-ls.nvim",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- ft = {"python",},
    opts = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
                }),
                null_ls.builtins.completion.tags,
                -- null_ls.builtins.diagnostics.mypy,
                -- null_ls.builtins.diagnostics.ruff,
                -- null_ls.builtins.formatting.black,
            },
        })
    end,
}
