local setup_diagnostics = function()
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
                I = { ':lua vim.lsp.buf.implementation()<CR>', "Implementations" },

                -- buf_set_keymap(bufnr, 'n', '<leader>D', ':lua vim.lsp.buf.type_definition()<CR>')
                t = { ':lua vim.lsp.buf.type_definition()<CR>', "Type Definition" },
                -- t = { ':Trouble lsp_type_definitions<cr>', "Type Definition" },

                -- buf_set_keymap(bufnr, 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
                d = { ':lua vim.lsp.buf.definition()<CR>', "Go To Definition" },
                D = { ':lua vim.lsp.buf.declaration()<cr>', "Go To Declaration" },
                -- r = { ':lua require("fzf-lua").lsp_references({ jump_to_single_result = true })<cr>', "Go To Definition" },

                r = { ':Trouble lsp_references<cr>', "References" },
                -- buf_set_keymap(bufnr, 'n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
                R = { ':lua vim.lsp.buf.rename()<cr>', "Rename" },
                -- buf_set_keymap(bufnr, 'n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
                -- a = { ':FzfLua lsp_code_actions<cr>', "Code actions" },
                a = { ':lua vim.lsp.buf.code_action()<CR>', "Code actions" },

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
    buf_set_keymap(bufnr, { "n", "v" }, "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end)

    -- if client.server_capabilities.document_formatting then
    -- elseif client.server_capabilities.document_range_formatting then
    -- end

    if client.name == "rust_analyzer" then
        if require "lib.utils".has_module("rust-tools") then
            local rt = require "rust-tools"
            -- Hover actions
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end
    end
end

local on_attach = function(client, bufnr)
    vim.notify("Attached to " .. client.name)

    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client)

    local on_attach_lsp_group = vim.api.nvim_create_augroup("OnAttachLSPGroup", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = on_attach_lsp_group,
        pattern = "<buffer>",
        callback = function()
            vim.lsp.buf.format()
        end,
    })
end


return {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "rcarriga/nvim-notify",
        -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
        "simrat39/rust-tools.nvim",
        "folke/neodev.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
        -- add any global capabilities here
        capabilities = {},
        -- Automatically format on save
        autoformat = true,
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
            formatting_options = nil,
            timeout_ms = nil,
        },
        -- LSP Server Settings
        servers = {
            --
            -- Server configuration: https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
            --
            lua_ls = {
                -- mason = false, -- set to false if you don't want this server to be installed with mason
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim', 'use' }
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            },
            pylsp = {
                settings = {
                    configurationSources = { "flake8" },
                    plugins = {
                        pylint = { enabled = false },
                        black = {
                            enabled = true,
                            line_length = 88,
                        },
                        -- yapf = { enabled = false },
                        -- ["pylsp-mypy"] = {
                        --     enabled = true,
                        --     -- strict = true,
                        --     -- live_mode = true,
                        --     -- overrides = {
                        --     --     "--unknown_argument", "--config-file", "mypy_lsp.toml", true
                        --     -- }
                        -- },
                        -- rope = { enabled = true },
                        -- ["rope-autoimport"] = { enabled = true },
                        -- ["rope_autoimport"] = { enabled = true },
                        flake8 = { enabled = false },
                        pycodestyle = { enabled = false },
                        mccabe = { enabled = false },
                        pyflakes = { enabled = false },
                        autopep8 = { enabled = false },
                    },
                }
            },
            tailwindcss = {
                init_options = {
                    userLanguages = {
                        htmldjango = "django-html",
                        rust = "html",
                    },
                },
                settings = {
                    tailwindCSS = {
                        hovers = true,
                    }
                },

            },
            rust_analyzer = {
                -- mason = false,

                -- standalone file support
                -- setting it to false may improve startup time
                -- standalone = true,
                --
                settings = {
                    ["rust-analyzer"] = {
                        -- imports = {
                        --     granularity = {
                        --         group = "module",
                        --     },
                        --     prefix = "self",
                        -- },
                        checkOnSave = {
                            command = "clippy"
                            -- command = "check"
                        },
                        procMacro = {
                            enable = true
                        },
                    },
                },
            }
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
            -- example to setup with typescript.nvim
            -- tsserver = function(_, opts)
            --   require("typescript").setup({ server = opts })
            --   return true
            -- end,
            -- -- Specify * to use this function as a fallback for any server
            rust_analyzer = function(server_name, opts)
                print("custom setup" .. server_name)
                print(vim.inspect(opts))

                return true
            end,
            ["*"] = function(server, opts) end,
        },
    },
    config = function(_, opts)
        setup_diagnostics()

        local servers = opts.servers
        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities(),
            opts.capabilities or {}
        )

        local setup_server = function(server)
            local merged_opts = vim.tbl_deep_extend("keep",
                {
                    capabilities = vim.deepcopy(capabilities),
                    on_attach = on_attach
                },
                servers[server] or {}
            )
            require("lspconfig")[server].setup(merged_opts)
        end


        -- get all the servers that are available thourgh mason-lspconfig
        local have_mason, mlsp = pcall(require, "mason-lspconfig")
        local all_mslp_servers = {}
        if have_mason then
            all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
        end

        local ensure_installed = {} ---@type string[]
        for server, server_opts in pairs(servers) do
            if server_opts then
                server_opts = server_opts == true and {} or server_opts
                -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                    -- vim.notify("[ LSP ]" .. server)
                    setup_server(server)
                else
                    -- vim.notify("[MASON]" .. server)
                    ensure_installed[#ensure_installed + 1] = server
                end
            end
        end

        if have_mason and ensure_installed then
            mlsp.setup_handlers({ setup_server })
            mlsp.setup({ ensure_installed = ensure_installed })
        end
    end,
    --config___ = function()

    --    local lspconfig = require "lspconfig"

    --    -- local lsp_config = require "mesuca.plugins.lsp.config"
    --    -- vim.inspect(lsp_config)

    --    -- local on_attach = lsp_config.on_attach
    --    -- local capabilities = lsp_config.capabilities
    --    -- vim.inspect(on_attach)
    --    -- vim.inspect(capabilities)

    --    -- Use a loop to conveniently both setup defined servers
    --    -- and map buffer local keybindings when the language server attaches
    --    for server_name, server_opts in ipairs(opts.servers) do
    --        vim.notify(server_name)
    --        -- vim.notify("LSP Setup for " .. server_name)
    --        --
    --        -- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
    --        --
    --        local server_config = {
    --            -- on_attach = on_attach,
    --            -- capabilities = capabilities,
    --        }


    --    end


    --    -- require "config.lsp.mason-lspconfig"
    --    -- require "config.lsp.lsp-config"
    --end
}
