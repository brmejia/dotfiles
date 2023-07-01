return {
    "pmizio/typescript-tools.nvim",
    -- enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = function()
        local lsp_lib = require("lib.lsp")
        return {
            on_attach = function(client, bufnr)
                vim.notify_once("Disabling format for " .. client.name, vim.log.levels.WARN)

                -- client.resolved_capabilities.document_formatting = false
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false

                lsp_lib.set_lsp_keymaps(client, bufnr)
                lsp_lib.set_lsp_highlight_document(client)
            end,
        }
    end,
}
