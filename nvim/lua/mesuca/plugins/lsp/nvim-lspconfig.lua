local lsp = require("lib.lsp")
return {
    "neovim/nvim-lspconfig",
    -- enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "rcarriga/nvim-notify",
        -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
        -- "simrat39/rust-tools.nvim",
        "folke/neodev.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- "hrsh7th/cmp-nvim-lsp",
    },
    opts = function()
        local volar_config = require("mesuca.plugins.lsp.server_configs.volar")

        return {
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
                ruff = {
                    init_options = {
                        settings = {
                            -- Any extra CLI arguments for `ruff` go here.
                            args = {},
                            -- Line lenght should be defined on pyproject.toml
                            -- lineLength = 88,
                            format = {
                                -- Preview mode enables a collection of unstable features such
                                -- as new lint rules and fixes, formatter style changes,
                                -- interface updates, and more. Warnings about deprecated features
                                -- may turn into errors when using preview mode.
                                preview = false,
                            },
                        },
                    },
                },
                pyright = {
                    root_dir = lsp.get_server_root_dir_fn("Pyright", {
                        {
                            "pyproject.toml",
                            "setup.py",
                            "setup.cfg",
                            "Pipfile",
                            "requirements.txt",
                            "requirements.lock",
                            "requirements-dev.lock",
                            "pyrightconfig.json",
                            -- ".git",
                        },
                        { "*.py" },
                    }),
                    settings = {
                        pyright = {
                            -- Using Ruff's import organizer
                            disableOrganizeImports = true,
                        },
                        python = {
                            analysis = {
                                -- Ignore all files for analysis to exclusively use Ruff for linting
                                -- ignore = { "*" },
                                -- typeCheckingMode ["off", "basic", "standard", "strict"]
                                typeCheckingMode = "standard",
                            },
                        },
                    },
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
                        },
                    },
                },
                ltex = {
                    cmd = { "ltex-ls" },
                    filetypes = { "markdown", "text", "typst" },
                    flags = { debounce_text_changes = 5000 },
                    settings = {
                        ltex = {
                            checkFrequency = "save",
                            additionalrules = { motherTongue = "es", enablepickyrules = true },
                            language = "auto",
                        },
                    },
                },
                tinymist = {
                    -- cmd = { "tinymist-linux-x64" },
                    --- todo: these configuration from lspconfig maybe broken
                    single_file_support = true,
                    root_dir = function()
                        return vim.fn.getcwd()
                    end,
                    --- See [Tinymist Server Configuration](https://github.com/Myriad-Dreamin/tinymist/blob/main/Configuration.md) for references.
                    settings = {},
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
                ansiblels = {},
                volar = volar_config,
                taplo = {},
                groovyls = {
                    filetypes = { "groovy", "Jenkinsfile" },
                    cmd = { "java", "-jar", "/opt/groovyls/build/libs/groovyls-all.jar" },
                },
            },
        }
    end,
    config = function(_, opts)
        local lsp_lib = require("lib.lsp")
        local lspconfig = require("lspconfig")

        lsp_lib.setup_diagnostics()

        local servers = opts.servers

        local default_server_handler = function(server_name)
            local default_server_options = {
                capabilities = lsp_lib.get_default_capabilities(opts.capabilities or {}),
                on_attach = lsp_lib.on_attach,
            }
            local merged_opts = vim.tbl_deep_extend("force", default_server_options, servers[server_name] or {})

            lspconfig[server_name].setup(merged_opts)
        end

        local have_mason_lspconfig, mlsp = pcall(require, "mason-lspconfig")

        mlsp.setup_handlers({ default_server_handler })
        local to_setup_manually = {} ---@type string[]
        if have_mason_lspconfig then
            local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            -- vim.notify(vim.inspect(all_mslp_servers))

            local to_setup_with_mason = {} ---@type string[]
            for server_name, _ in pairs(servers) do
                if vim.tbl_contains(all_mslp_servers, server_name) then
                    to_setup_with_mason[#to_setup_with_mason + 1] = server_name
                else
                    to_setup_manually[#to_setup_manually + 1] = server_name
                end
            end
            mlsp.setup({ automatic_installation = true, ensure_installed = to_setup_with_mason })
        end
        if to_setup_manually then
            local mr = require("mason-registry")
            for _, server_name in pairs(to_setup_manually) do
                local p = mr.get_package(server_name)
                if p:is_installed() then
                    default_server_handler(server_name)
                end
            end
        end
    end,
}
