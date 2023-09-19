return {
    "simrat39/rust-tools.nvim",
    -- enabled = true,
    -- ft = "rust",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
    },
    opts = function()
        local lsp_lib = require("lib.lsp")
        return {
            -- all the opts to send to nvim-lspconfig
            -- these override the defaults set by rust-tools.nvim
            -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
            server = {
                on_attach = lsp_lib.on_attach,
                capabilities = lsp_lib.get_default_capabilities(),
                -- standalone file support
                -- setting it to false may improve startup time
                -- standalone = true,
                settings = {
                    ["rust-analyzer"] = {
                        -- imports = {
                        --     granularity = {
                        --         group = "module",
                        --     },
                        --     prefix = "self",
                        -- },
                        checkOnSave = {
                            command = "clippy",
                        },
                        procMacro = {
                            enable = true,
                        },
                    },
                },
            },
            tools = {
                -- These apply to the default RustSetInlayHints command
                inlay_hints = {
                    -- whether to align to the extreme right or not
                    right_align = false,
                    -- padding from the right if right_align is true
                    right_align_padding = 7,
                },
                -- options same as lsp hover / vim.lsp.util.open_floating_preview()
                hover_actions = {
                    -- the border that is used for the hover window
                    -- see vim.api.nvim_open_win()
                    border = {
                        { "╭", "FloatBorder" },
                        { "─", "FloatBorder" },
                        { "╮", "FloatBorder" },
                        { "│", "FloatBorder" },
                        { "╯", "FloatBorder" },
                        { "─", "FloatBorder" },
                        { "╰", "FloatBorder" },
                        { "│", "FloatBorder" },
                    },
                    -- Maximal width of the hover window. Nil means no max.
                    max_width = nil,
                    -- Maximal height of the hover window. Nil means no max.
                    max_height = nil,
                    -- whether the hover action window gets automatically focused
                    -- default: false
                    auto_focus = false,
                },
            },
        }
    end,
}
