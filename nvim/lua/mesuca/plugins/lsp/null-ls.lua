return {
    -- "jose-elias-alvarez/null-ls.nvim", # for the credits
    "nvimtools/none-ls.nvim",
    -- enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- ft = {"python",},
    opts = function()
        local null_ls = require("null-ls")
        local lsp_lib = require("lib.lsp")

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        -- Use conform.nvim instead
        -- local formatting = null_ls.builtins.formatting

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
        local completion = null_ls.builtins.completion

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        local diagnostics = null_ls.builtins.diagnostics

        null_ls.setup({
            on_attach = lsp_lib.on_attach,
            sources = {
                -- Yaml
                diagnostics.vacuum,
                -- Typescript/Javascript - Web Dev
                -- completion.tags, -- html tags
            },
        })
    end,
}
