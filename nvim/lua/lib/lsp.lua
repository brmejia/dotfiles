local lsp = {}

function lsp.setup_diagnostics()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn",  text = "" },
        { name = "DiagnosticSignHint",  text = "" },
        { name = "DiagnosticSignInfo",  text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local diagnostics_config = {
        -- disable virtual text
        virtual_text = true,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(diagnostics_config)

    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --     border = "rounded",
    -- })

    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    --     border = "rounded",
    -- })
end

local lsp_highlight_document = function(client)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
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

local lsp_keymaps = function(client, bufnr)
    -- Funtion aliases
    -- local buf_set_option = require('lib.utils').buf_set_option
    local buf_set_keymap = require("lib.utils").buf_keymap

    -- ?????????? https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/plugins/lspconfig.lua
    -- buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    --buf_set_keymap(bufnr, 'n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
    --buf_set_keymap(bufnr, 'n', '<leader>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

    -- WhichKey Mappings
    if require("lib.utils").has_module("which-key") then
        local wk = require("which-key")
        local mappings = {
            l = {
                name = "LSP",
                i = { ":LspInfo<cr>", "Connected Language Servers" },
                k = { ":lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
                K = { ":lua vim.lsp.buf.hover()<cr>", "Hover Commands" },
                --buf_set_keymap(bufnr, 'n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>')
                w = { ":lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace Folder" },
                --buf_set_keymap(bufnr, 'n', '<leader>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>')
                W = { ":lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace Folder" },
                l = {
                    ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
                    "List Workspace Folders",
                },
                -- buf_set_keymap(bufnr, 'n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
                --buf_set_keymap(bufnr, 'n', '<leader>q', ':lua vim.lsp.diagnostic.set_loclist()<CR>')
                q = { ":Trouble loclist<cr>", "Loclist" },
                f = { ":Trouble quickfix<cr>", "Quickfix" },
                I = { ":lua vim.lsp.buf.implementation()<CR>", "Implementations" },

                -- buf_set_keymap(bufnr, 'n', '<leader>D', ':lua vim.lsp.buf.type_definition()<CR>')
                t = { ":lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
                -- t = { ':Trouble lsp_type_definitions<cr>', "Type Definition" },

                -- buf_set_keymap(bufnr, 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
                d = { ":lua vim.lsp.buf.definition()<CR>", "Go To Definition" },
                D = { ":lua vim.lsp.buf.declaration()<cr>", "Go To Declaration" },
                -- r = { ':lua require("fzf-lua").lsp_references({ jump_to_single_result = true })<cr>', "Go To Definition" },

                r = { ":Trouble lsp_references<cr>", "References" },
                -- buf_set_keymap(bufnr, 'n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
                R = { ":lua vim.lsp.buf.rename()<cr>", "Rename" },
                -- buf_set_keymap(bufnr, 'n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
                -- a = { ':FzfLua lsp_code_actions<cr>', "Code actions" },
                a = { ":lua vim.lsp.buf.code_action()<CR>", "Code actions" },

                -- buf_set_keymap(bufnr, 'n', '<leader>e', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
                e = { ":lua vim.diagnostic.open_float()<CR>", "Show Line Diagnostics" },

                x = { ":Trouble document_diagnostics<cr>", "Show Document Diagnostics" },
                X = { ":Trouble workspace_diagnostics<cr>", "Show Workspace Diagnostics" },

                -- buf_set_keymap(bufnr, 'n', ']d', ':lua vim.lsp.diagnostic.goto_next()<CR>')
                -- n = { ':Lspsaga diagnostic_jump_next<cr>', "Go To Next Diagnostic" },
                n = { ":lua vim.diagnostic.goto_next()<CR>", "Go To Next Diagnostic" },

                -- buf_set_keymap(bufnr, 'n', '[d', ':lua vim.lsp.diagnostic.goto_prev({border = "rounded"})<CR>')
                -- N = { ':Lspsaga diagnostic_jump_prev<cr>', "Go To Previous Diagnostic" }
                N = { ':lua vim.diagnostic.goto_prev({border = "rounded"})<CR>', "Go To Previous Diagnostic" },
            },
        }

        local opts = { prefix = "<leader>", buffer = bufnr }
        wk.register(mappings, opts)
    end

    -- Set some keybinds conditional on server capabilities
    -- buf_set_keymap(bufnr, { "n", "v" }, "<leader>ff", function()
    --     vim.lsp.buf.format({ async = false })
    -- end)

    -- if client.server_capabilities.document_formatting then
    -- elseif client.server_capabilities.document_range_formatting then
    -- end

    if client.name == "rust_analyzer" then
        if require("lib.utils").has_module("rust-tools") then
            local rt = require("rust-tools")
            -- Hover actions
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end
    end
end

function lsp.on_attach(client, bufnr)
    vim.notify("Attached to " .. client.name)

    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client)

    if client.supports_method("textDocument/formatting") then
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                -- vim.lsp.buf.formatting_sync()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end

function lsp.get_capabilities(other)
    return vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        other or {}
    )
end

return lsp
