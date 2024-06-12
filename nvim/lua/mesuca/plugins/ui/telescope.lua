return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        opts = function()
            local actions = require("telescope.actions")
            local actions_layout = require("telescope.actions.layout")

            local opts = {
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        vertical = { width = 0.99, height = 0.99 },
                        horizontal = { width = 0.99, height = 0.99 },
                    },
                    mappings = {
                        i = {
                            ["<C-Down>"] = "cycle_history_next",
                            ["<C-Up>"] = "cycle_history_prev",
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                            ["<C-a>"] = actions.smart_add_to_qflist + actions.open_qflist,
                            ["<M-p>"] = actions_layout.toggle_preview,
                        },
                        n = {
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                            ["<C-a>"] = actions.smart_add_to_qflist + actions.open_qflist,
                            ["<M-p>"] = actions_layout.toggle_preview,
                        },
                    },
                    history = {
                        path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
                        limit = 100,
                    },
                },

                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer,
                            },
                            n = {
                                ["d"] = actions.delete_buffer,
                            },
                        },
                    },
                }, -- other configuration values here
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            -- even more opts
                        }),
                    },
                },
            }

            if require("lib.utils").has_module("trouble") then
                local trouble = require("trouble")
                local open_with_trouble = require("trouble.sources.telescope").open

                -- or create your custom action
                local transform_mod = require("telescope.actions.mt").transform_mod
                local custom_actions = transform_mod({
                    trouble_toggle_quickfix = function(prompt_bufnr)
                        trouble.toggle("quickfix")
                    end,
                })

                local trouble_mappings = {
                    i = {
                        ["<C-q>"] = open_with_trouble,
                        ["<C-a>"] = actions.smart_add_to_qflist + custom_actions.trouble_toggle_quickfix,
                    },
                    n = {
                        ["<C-q>"] = open_with_trouble,
                        ["<C-a>"] = actions.smart_add_to_qflist + custom_actions.trouble_toggle_quickfix,
                    },
                }

                opts = vim.tbl_deep_extend("force", opts, {
                    -- defaults = { mappings = trouble_mappings },
                    pickers = {
                        find_files = {
                            mappings = trouble_mappings,
                        },
                        live_grep = {
                            mappings = trouble_mappings,
                        },
                        buffers = {
                            mappings = trouble_mappings,
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

            -- A history implementation that memorizes prompt input for a specific context.
            -- This means that each prompt input is associated with a calling picker and cwd.
            -- More info: https://github.com/nvim-telescope/telescope-smart-history.nvim
            require("telescope").load_extension("smart_history")
            -- It sets vim.ui.select to telescope.
            -- That means for example that neovim core stuff can fill the telescope picker.
            require("telescope").load_extension("ui-select")

            keymap("n", "<C-p>", tbuiltin.find_files, { desc = "Find files" })
            keymap("n", "<C-b>", tbuiltin.buffers, { desc = "Find buffers" })
            keymap("n", "<leader>fp", tbuiltin.find_files, { desc = "Find files" })
            keymap("n", "<leader>fb", tbuiltin.buffers, { desc = "Find buffers" })
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
