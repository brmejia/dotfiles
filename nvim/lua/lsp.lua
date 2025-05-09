vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        local lsp = require("lib.lsp")
        lsp.on_attach(client, ev.buf)
    end,
})

vim.lsp.enable({
    "lua_ls",
    -- "rust-analyzer", --- Disabled because rustaceanvim activates it
    "volar",
    "ruff",
    "pyright",
    "tailwindcss",
    "ltex",
    "tinymist",
    "ansiblels",
    "taplo",
    "groovyls",
})
