if not require "lib.utils".has_module("lspconfig") then
    return
end

local lspconfig = require "lspconfig"


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
    -- local buf_set_option = require('lib.utils').buf_set_option
    local buf_set_keymap = require('lib.utils').buf_keymap

    -- ?????????? https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/plugins/lspconfig.lua
    -- buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    --buf_set_keymap(bufnr, 'n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
    --buf_set_keymap(bufnr, 'n', '<leader>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')


    -- WhichKey Mappings
    if require "lib.utils".has_module("which-key") then

        local wk = require "which-key"
        local mappings = {
            l = {
                name = "LSP",
                i = { ":LspInfo<cr>", "Connected Language Servers" },
                k = { ":lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
                K = { ":lua vim.lsp.buf.hover()<cr>", "Hover Commands" },
                --buf_set_keymap(bufnr, 'n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>')
                w = { ':lua vim.lsp.buf.add_workspace_folder()<cr>', "Add Workspace Folder" },
                --buf_set_keymap(bufnr, 'n', '<leader>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>')
                W = { ':lua vim.lsp.buf.remove_workspace_folder()<cr>', "Remove Workspace Folder" },
                l = {
                    ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
                    "List Workspace Folders"
                },
                -- buf_set_keymap(bufnr, 'n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
                --buf_set_keymap(bufnr, 'n', '<leader>q', ':lua vim.lsp.diagnostic.set_loclist()<CR>')
                q = { ':Trouble loclist<cr>', "Loclist" },
                f = { ':Trouble quickfix<cr>', "Quickfix" },
                I = { ':FzfLua lsp_implementations<cr>', "Implementations" },

                -- buf_set_keymap(bufnr, 'n', '<leader>D', ':lua vim.lsp.buf.type_definition()<CR>')
                t = { ':FzfLua lsp_typedefs<cr>', "Type Definition" },
                -- t = { ':Trouble lsp_type_definitions<cr>', "Type Definition" },

                -- buf_set_keymap(bufnr, 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
                -- d = { ':FzfLua lsp_definitions<cr>', "Go To Definition" },
                d = { ':lua require("fzf-lua").lsp_definitions({ jump_to_single_result = true })<cr>', "Go To Definition" },
                -- D = { ':lua vim.lsp.buf.declaration()<cr>', "Go To Declaration" },

                -- r = { ':lua require("fzf-lua").lsp_references({ jump_to_single_result = true })<cr>', "Go To Definition" },
                r = { ':Trouble lsp_references<cr>', "References" },
                -- buf_set_keymap(bufnr, 'n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
                R = { ':lua vim.lsp.buf.rename()<cr>', "Rename" },
                -- buf_set_keymap(bufnr, 'n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
                a = { ':FzfLua lsp_code_actions<cr>', "Code actions" },

                -- buf_set_keymap(bufnr, 'n', '<leader>e', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
                e = { ':lua vim.diagnostic.open_float()<CR>', "Show Line Diagnostics" },

                x = { ':Trouble document_diagnostics<cr>', "Show Document Diagnostics" },
                X = { ':Trouble workspace_diagnostics<cr>', "Show Workspace Diagnostics" },

                -- buf_set_keymap(bufnr, 'n', ']d', ':lua vim.lsp.diagnostic.goto_next()<CR>')
                -- n = { ':Lspsaga diagnostic_jump_next<cr>', "Go To Next Diagnostic" },
                n = { ':lua vim.diagnostic.goto_next()<CR>', "Go To Next Diagnostic" },

                -- buf_set_keymap(bufnr, 'n', '[d', ':lua vim.lsp.diagnostic.goto_prev({border = "rounded"})<CR>')
                -- N = { ':Lspsaga diagnostic_jump_prev<cr>', "Go To Previous Diagnostic" }
                N = { ':lua vim.diagnostic.goto_prev({border = "rounded"})<CR>', "Go To Previous Diagnostic" }
            },
        }

        local opts = { prefix = '<leader>', buffer = bufnr }
        wk.register(mappings, opts)

    end

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap(bufnr, "n", "<leader>f", vim.lsp.buf.formatting)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap(bufnr, "n", "<leader>f", vim.lsp.buf.range_formatting)
    end

end

local on_attach = function(client, bufnr)
    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client)

    -- if client.name ~= "pylsp" then
    vim.api.nvim_exec([[
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        ]],
        false
    )
    -- end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
end


-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
    "sumneko_lua",
    "pylsp",
    "rust_analyzer",
    -- "tsserver",
}
for _, server_name in ipairs(servers) do
    -- vim.notify("LSP Setup for " .. server_name)
    local server_config = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
    -- lspconfig[server_name].setup({
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    -- })

    if server_name == "sumneko_lua" then
        server_config["settings"] = {
            Lua = {
                diagnostics = {
                    globals = { 'vim', 'use' }
                },
                --workspace = {
                -- Make the server aware of Neovim runtime files
                --library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
                --}
            }
        }
    elseif server_name == "pylsp" then
        server_config["settings"] = {
            pylsp = {
                configurationSources = { "flake8", "pycodestyle" },
                plugins = {
                    pylint = { enabled = true },
                    black = {
                        enabled = true,
                        line_length = 99,
                    },
                    ["pylsp-mypy"] = { enabled = true },
                    rope = { enabled = true },
                    -- yapf = { enabled = false },
                    -- autopep8 = { enabled = false },
                    pycodestyle = { enabled = false },
                    flake8 = { enabled = true },
                    -- pyflakes = { enabled = false },
                }
            }
        }
    end

    lspconfig[server_name].setup(server_config)
end
