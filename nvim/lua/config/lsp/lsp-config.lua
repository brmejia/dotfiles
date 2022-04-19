local lsp_config = {}

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
                hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
                hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow

                augroup lsp_document_highlight
                autocmd! * <buffer>
                " autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
end

local function lsp_keymaps(client, bufnr)
    -- Funtion aliases
    local buf_set_option = require('lib.utils').buf_set_option
    local buf_set_keymap = require('lib.utils').buf_keymap

    -- ?????????? https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/plugins/lspconfig.lua
    -- buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    --buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({border = "rounded"})<CR>')
    buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    --buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
    buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    --buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    --buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    --buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
    end

end

lsp_config.on_attach = function(client, bufnr)
    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client)
end


local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

lsp_config.capabilities = cmp_nvim_lsp.update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

-- if not status_ok then
-- local status_ok, nvim_lsp  = pcall(require, "lspconfig")
--   return
-- end
-- -- Use a loop to conveniently both setup defined servers
-- -- and map buffer local keybindings when the language server attaches
-- local servers = {
--     -- "pyright",
--     "sumneko_lua",
--     "pylsp",
--     "rust_analyzer",
--     -- "tsserver",
-- }
-- for _, lsp in ipairs(servers) do
--     vim.notify("LSP Setup for ".. lsp)
--     nvim_lsp[lsp].setup {
--         on_attach = on_attach,
--         capabilities = capabilities,
--     }
-- end

return lsp_config
