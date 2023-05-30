return {
    "jose-elias-alvarez/null-ls.nvim",
    enabled = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = function ()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.completion.tags,
            },
        })
    end

}

