return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        opts = function()
            local actions = require("telescope.actions")

            local opts = {
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        vertical = { width = 0.95, height = 0.95 },
                        horizontal = { width = 0.95, height = 0.95 },
                    },
                    mappings = {
                        i = {
                            ["<C-Down>"] = "cycle_history_next",
                            ["<C-Up>"] = "cycle_history_prev",
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        },
                        n = {
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        },
                    },
                    history = {
                        path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
                        limit = 100,
                    },
                },
                -- other configuration values here
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            -- even more opts
                        }),
                    },
                },
            }

            if require("lib.utils").has_module("trouble") then
                local trouble = require("trouble.providers.telescope")
                opts = vim.tbl_deep_extend("force", opts, {
                    defaults = {
                        mappings = {
                            i = { ["<C-q>"] = trouble.smart_open_with_trouble },
                            n = { ["<C-q>"] = trouble.smart_open_with_trouble },
                        },
                    },
                })
            end

            return opts
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)

            local keymap = require("lib.utils").keymap
            local tbuiltin = require("telescope.builtin")

            keymap("n", "<C-p>", tbuiltin.find_files, { desc = "Find files" })
            keymap("n", "<leader>fp", tbuiltin.find_files, { desc = "Find files" })
            keymap("n", "<leader>ff", tbuiltin.live_grep, { desc = "RipGrep" })
            keymap("n", "<leader>fh", tbuiltin.help_tags, { desc = "Help Tags" })
            keymap("n", "<leader>fm", tbuiltin.keymaps, { desc = "Keymaps" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function(_, opts)
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "nvim-telescope/telescope-smart-history.nvim",
        dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
        config = function(_, opts)
            require("telescope").load_extension("smart_history")
        end,
    },
}
