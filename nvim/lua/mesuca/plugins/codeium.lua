return {
    {
        "Exafunction/windsurf.nvim",
        -- enabled = false,
        -- event = "InsertEnter",
        event = "BufEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "hrsh7th/nvim-cmp",
        },
        opts = {
            enable_cmp_source = false,
            virtual_text = {
                enabled = true,
                -- -- These are the defaults
                --
                -- -- Set to true if you never want completions to be shown automatically.
                -- manual = false,
                -- -- A mapping of filetype to true or false, to enable virtual text.
                -- filetypes = {},
                -- -- Whether to enable virtual text of not for filetypes not specifically listed above.
                -- default_filetype_enabled = true,
                -- -- How long to wait (in ms) before requesting completions after typing stops.
                -- idle_delay = 75,
                -- -- Priority of the virtual text. This usually ensures that the completions appear on top of
                -- -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
                -- -- desired.
                -- virtual_text_priority = 65535,
                -- -- Set to false to disable all key bindings for managing completions.
                -- map_keys = true,
                -- -- The key to press when hitting the accept keybinding but no completion is showing.
                -- -- Defaults to \t normally or <c-n> when a popup is showing.
                -- accept_fallback = nil,
                -- -- Key bindings for managing completions in virtual text mode.
                key_bindings = {
                    -- -- Accept the current completion.
                    -- accept = "<Tab>",
                    -- -- Accept the next word.
                    -- accept_word = false,
                    -- -- Accept the next line.
                    -- accept_line = false,
                    -- -- Clear the virtual text.
                    -- clear = false,
                    -- Cycle to the next completion.
                    next = "<M-Right>",
                    -- Cycle to the previous completion.
                    prev = "<M-Left>",
                },
            },
        },
        config = function(_, opts)
            -- vim.g.codeium_manual = true

            vim.g.codeium_filetypes = {
                TelescopePrompt = false,
                ["neo-tree"] = false,
                harpoon = false,
                grapple = false,
            }

            -- vim.g.codeium_disable_bindings = true

            -- -- Change '<C-g>' here to any keycode you like.
            -- keymap("i", "<Right>", function()
            --     return vim.fn["codeium#Accept"]()
            -- end, { expr = true, silent = true })
            -- keymap("i", "<Left>", function()
            --     return vim.fn["codeium#Clear"]()
            -- end, { expr = true, silent = true })
            --
            -- keymap("i", "<C-n>", function()
            --     return vim.fn["codeium#CycleCompletions"](1)
            -- end, { expr = true, silent = true })
            -- keymap("i", "<C-p>", function()
            --     return vim.fn["codeium#CycleCompletions"](-1)
            -- end, { expr = true, silent = true })

            require("codeium").setup(opts)
        end,
    },
}
