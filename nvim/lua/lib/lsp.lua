local lsp = {}

function lsp.get_root_dir(buff_path, root_markers)
    local root_dir = nil
    for _, root_markers_group in pairs(root_markers) do
        local root_paths = vim.fs.find(root_markers_group, {
            upward = true,
            path = buff_path,
        })
        local root_path = root_paths[1]
        if root_path == nil then
            -- vim.notify(
            --     string.format(
            --         "No root dir found:\nroot_paths: %s\nroot_markers_group: %s",
            --         vim.inspect(root_paths),
            --         vim.inspect(root_markers_group)
            --     ),
            --     vim.log.levels.TRACE
            -- )
            goto continue
        end

        root_dir = vim.fn.fnamemodify(root_path, ":h")
        if root_dir ~= "." and root_dir ~= "" and root_dir ~= nil then
            -- vim.notify(
            --     string.format(
            --         "Root dir found:\nbuff_path: %s\nroot_markers_group: %s\nroot_path: %s\nroot_dir: %s",
            --         vim.inspect(buff_path),
            --         vim.inspect(root_markers_group),
            --         vim.inspect(root_path),
            --         vim.inspect(root_dir)
            --     ),
            --     vim.log.levels.DEBUG
            -- )
            return root_dir
        end
        ::continue::
    end
    -- local msg = string.format("Not root found for %s", file_path)
    -- vim.notify(msg, vim.log.levels.WARN)
    return nil
end

function lsp.get_server_root_dir_fn(server_name, root_markers)
    local server_root_dir_fn = function(bufnr, on_dir)
        local buf_info = vim.fn.getbufinfo(bufnr)[1]
        local buff_path = buf_info["name"]
        local root_dir = lsp.get_root_dir(buff_path, root_markers)
        if root_dir == nil then
            local msg = string.format("Not root found for %s", buff_path)
            vim.notify(msg, vim.log.levels.WARN)
            return nil
        end
        -- local msg = string.format("[%s] Root dir for %s:\nroot_dir: %s", server_name, buff_path, root_dir)
        -- vim.notify(msg, vim.log.levels.DEBUG)
        on_dir(root_dir)
        return root_dir
    end
    return server_root_dir_fn
end

function lsp.setup_diagnostics()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "󰌵" },
        { name = "DiagnosticSignInfo", text = "" },
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

function lsp.set_lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        -- Find how to set highlight group fg and bg colors from theme
        vim.api.nvim_exec(
            [[
                hi LspReferenceRead cterm=bold
                hi LspReferenceText cterm=bold
                hi LspReferenceWrite cterm=bold

                augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorMoved <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
end

function lsp.set_lsp_keymaps(client, bufnr)
    -- Funtion aliases
    -- local buf_set_option = require('lib.utils').buf_set_option
    local keymap = require("lib.utils").keymap
    local buf_keymap = require("lib.utils").buf_keymap

    -- ?????????? https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/plugins/lspconfig.lua
    -- buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Buffer Mappings.
    buf_keymap(bufnr, "n", "<C-k>", vim.lsp.buf.signature_help)
    buf_keymap(bufnr, "n", "K", vim.lsp.buf.hover)

    -- WhichKey Mappings
    if require("lib.utils").has_module("which-key") then
        local wk = require("which-key")
        local mappings = {
            { "<leader>l", group = "LSP" },
            { "<leader>li", ":LspInfo<cr>", desc = "Connected Language Servers" },
            { "<leader>lk", ":lua vim.lsp.buf.signature_help()<cr>", desc = "Signature Help" },
            { "<leader>lK", ":lua vim.lsp.buf.hover()<cr>", desc = "Hover Commands" },
            --buf_set_keymap(bufnr, 'n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>')
            { "<leader>lw", ":lua vim.lsp.buf.add_workspace_folder()<cr>", desc = "Add Workspace Folder" },
            --buf_set_keymap(bufnr, 'n', '<leader>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>')
            { "<leader>lW", ":lua vim.lsp.buf.remove_workspace_folder()<cr>", desc = "Remove Workspace Folder" },
            {
                "<leader>ll",
                ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
                desc = "List Workspace Folders",
            },
            -- buf_set_keymap(bufnr, 'n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
            --buf_set_keymap(bufnr, 'n', '<leader>q', ':lua vim.lsp.diagnostic.set_loclist()<CR>')
            { "<leader>lq", ":Trouble loclist<cr>", desc = "Loclist" },
            { "<leader>lf", ":Trouble quickfix<cr>", desc = "Quickfix" },
            { "<leader>lI", ":Trouble lsp_implementations<CR>", desc = "Implementations" },

            -- buf_set_keymap(bufnr, 'n', '<leader>D', ':lua vim.lsp.buf.type_definition()<CR>')
            { "<leader>lt", ":lua vim.lsp.buf.type_definition()<CR>", desc = "Type Definition" },
            -- t = { ':Trouble lsp_type_definitions<cr>', "Type Definition" },

            -- buf_set_keymap(bufnr, 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
            { "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", desc = "Go To Definition" },
            { "<leader>lD", ":lua vim.lsp.buf.declaration()<cr>", desc = "Go To Declaration" },
            -- r = { ':lua require("fzf-lua").lsp_references({ jump_to_single_result = true })<cr>', "Go To Definition" },

            { "<leader>lr", ":Trouble lsp_references<cr>", desc = "References" },
            -- buf_set_keymap(bufnr, 'n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
            { "<leader>lR", ":lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
            -- buf_set_keymap(bufnr, 'n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
            -- a = { ':FzfLua lsp_code_actions<cr>', "Code actions" },
            { "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", desc = "Code actions" },

            -- buf_set_keymap(bufnr, 'n', '<leader>e', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
            { "<leader>le", ":lua vim.diagnostic.open_float()<CR>", desc = "Show Line Diagnostics" },

            {
                "<leader>lx",
                ":Trouble diagnostics_cascade toggle filter.buf=0<cr>",
                desc = "Show Document Diagnostics",
            },
            { "<leader>lX", ":Trouble diagnostics_cascade toggle<cr>", desc = "Show Workspace Diagnostics" },

            -- buf_set_keymap(bufnr, 'n', ']d', ':lua vim.lsp.diagnostic.goto_next()<CR>')
            -- n = { ':Lspsaga diagnostic_jump_next<cr>', "Go To Next Diagnostic" },
            { "<leader>ln", ":lua vim.diagnostic.goto_next()<CR>", desc = "Go To Next Diagnostic" },

            -- buf_set_keymap(bufnr, 'n', '[d', ':lua vim.lsp.diagnostic.goto_prev({border = "rounded"})<CR>')
            -- N = { ':Lspsaga diagnostic_jump_prev<cr>', "Go To Previous Diagnostic" }
            {
                "<leader>lN",
                ':lua vim.diagnostic.goto_prev(border = "rounded")<CR>',
                desc = "Go To Previous Diagnostic",
            },
            {
                "<leader>lh",
                function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end,
                desc = "Toggle Inlay Hints",
            },
            { "<leader>ls", ":Trouble custom_lsp_symbols<cr>", desc = "LSP Symbols" },
        }

        local opts = { buffer = bufnr }
        wk.add(mappings, opts)
    end

    if client.name == "rust_analyzer" then
        if require("lib.utils").has_module("rust-tools") then
            local rt = require("rust-tools")
            -- Hover actions

            buf_keymap(bufnr, "n", "K", rt.hover_actions.hover_actions)
            -- Code action groups
            buf_keymap(bufnr, "n", "<leader>a", rt.code_action_group.code_action_group)
        end
    end

    if client.name == "ruff" then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end
end

function lsp.set_lsp_document_formatting(client, bufnr)
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
        -- else
        --     vim.notify_once(client.name .. " doesn't support formatting", vim.log.levels.WARN)
    end

    if client.supports_method("textDocument/rangeFormatting") then
        vim.keymap.set("x", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })
        -- else
        --     vim.notify_once(client.name .. " doesn't support rangeFormatting", vim.log.levels.WARN)
    end
end

function lsp.on_attach(client, bufnr)
    vim.notify("Attached to " .. client.name, vim.log.levels.INFO)

    lsp.set_lsp_keymaps(client, bufnr)
    lsp.set_lsp_highlight_document(client)
    lsp.set_lsp_document_formatting(client, bufnr)
end

function lsp.get_default_capabilities(other)
    local original_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)
    return capabilities
end

return lsp
