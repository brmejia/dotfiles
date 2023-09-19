return {
    "jose-elias-alvarez/null-ls.nvim",
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- ft = {"python",},
    opts = function()
        local null_ls = require("null-ls")
        local lsp_lib = require("lib.lsp")

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        local formatting = null_ls.builtins.formatting
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
        local completion = null_ls.builtins.completion
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        local diagnostics = null_ls.builtins.diagnostics

        null_ls.setup({
            on_attach = lsp_lib.on_attach,
            sources = {
                -- Lua
                formatting.stylua.with({
                    extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
                }),

                -- Typescript/Javascript - Web Dev
                formatting.prettier,

                completion.tags,
                -- Python
                -- diagnostics.mypy,
                -- diagnostics.ruff,
                formatting.black,
            },
        })
    end,
}
