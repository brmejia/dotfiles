return {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "rcarriga/nvim-notify",
        -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
        -- "simrat39/rust-tools.nvim",
        "folke/neodev.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
        -- add any global capabilities here
        -- capabilities = {},
        -- format = {
        --     formatting_options = nil,
        --     timeout_ms = nil,
        -- },
        -- LSP Server Settings
        servers = {
            --
            -- Server configuration: https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
            --
            lua_ls = {
                -- mason = false, -- set to false if you don't want this server to be installed with mason
                settings = {
                    Lua = {
                        format = {
                            enable = false, -- Replaced by null_ls stylua plugin
                        },
                        diagnostics = {
                            globals = { "vim", "use" },
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
            ruff_lsp = {
                settings = {
                    -- Any extra CLI arguments for `ruff` go here.
                    args = {},
                },
            },
            pyright = {
                root_dir = function(fname)
                    local root_files = {
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "Pipfile",
                        "requirements.txt",
                        "pyrightconfig.json",
                        -- ".git",
                    }
                    local util = require("lspconfig").util
                    local root_path = util.root_pattern(unpack(root_files))(fname)
                    vim.notify("Pyright root path: " .. root_path, vim.log.levels.DEBUG)
                    return root_path
                end,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            },
            -- pylsp = {
            --     settings = {
            --         pylsp = {
            --             --             configurationSources = { "flake8" },
            --             plugins = {
            --                 pylint = { enabled = false },
            --                 black = {
            --                     enabled = false,
            --                     line_length = 88,
            --                 },
            --                 yapf = { enabled = false },
            --                 -- ["pylsp-mypy"] = {
            --                 --     enabled = true,
            --                 --     -- strict = true,
            --                 --     -- live_mode = true,
            --                 --     -- overrides = {
            --                 --     --     "--unknown_argument", "--config-file", "mypy_lsp.toml", true
            --                 --     -- }
            --                 -- },
            --                 rope = { enabled = false },
            --                 ["rope-autoimport"] = { enabled = false },
            --                 flake8 = { enabled = false },
            --                 pycodestyle = { enabled = false },
            --                 mccabe = { enabled = false },
            --                 pyflakes = { enabled = false },
            --                 autopep8 = { enabled = false },
            --             },
            --         },
            --     },
            -- },
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
                    },
                },
            },
            --rust_analyzer = {
            --    -- mason = false,

            --    -- standalone file support
            --    -- setting it to false may improve startup time
            --    -- standalone = true,
            --    --
            --    settings = {
            --        ["rust-analyzer"] = {
            --            -- imports = {
            --            --     granularity = {
            --            --         group = "module",
            --            --     },
            --            --     prefix = "self",
            --            -- },
            --            checkOnSave = {
            --                command = "clippy",
            --                -- command = "check"
            --            },
            --            procMacro = {
            --                enable = true,
            --            },
            --        },
            --    },
            --},
        },
        ---- you can do any additional lsp server setup here
        ---- return true if you don't want this server to be setup with lspconfig
        -----@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        --setup = {
        --    rust_analyzer = function(server_name, opts)
        --        print("custom setup" .. server_name)
        --        print(vim.inspect(opts))
        --        return true
        --    end,
        --    ["*"] = function(server, opts) end,
        --},
    },
    config = function(_, opts)
        local lsp_lib = require("lib.lsp")

        lsp_lib.setup_diagnostics()

        local servers = opts.servers

        local setup_server = function(server)
            local merged_opts = vim.tbl_deep_extend("keep", {
                capabilities = lsp_lib.get_capabilities(opts.capabilities),
                on_attach = lsp_lib.on_attach,
            }, servers[server] or {})
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
}
