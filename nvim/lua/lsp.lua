local lsp = require("lib.lsp")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        lsp.on_attach(client, ev.buf)
    end,
})

lsp.setup_diagnostics()

vim.lsp.enable({
    "lua_ls",
    -- "rust_analyzer", --- Disabled because rustaceanvim activates it
    -- "vue_ls",
    "oxfmt",
    "oxlint",
    "ruff",
    "ty",
    -- "pyright", -- This is replaced by ty lsp
    -- "basedpyright", -- This is replaced by ty lsp
    "tailwindcss",
    "ltex",
    "tinymist",
    "ansiblels",
    "taplo",
    "groovyls",
    "regal",
})
