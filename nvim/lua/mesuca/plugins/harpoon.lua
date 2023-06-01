return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-telescope/telescope.nvim" },
    -- enabled = false,
    config = function()
        local harpoon = require("harpoon")
        local harpoon_ui = require("harpoon.ui")
        local harpoon_mark = require("harpoon.mark")
        local harpoon_term = require("harpoon.term")

        harpoon.setup({
            -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
            save_on_toggle = false,

            -- saves the harpoon file upon every change. disabling is unrecommended.
            save_on_change = true,

            -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
            enter_on_sendcmd = false,

            -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
            tmux_autoclose_windows = false,

            -- filetypes that you want to prevent from adding to the harpoon list menu.
            excluded_filetypes = { "harpoon", "TelescopePrompt", "NvimTree" },

            -- set marks specific to each git branch inside git repository
            mark_branch = true,
            menu = {
                width = math.floor(3 * vim.api.nvim_win_get_width(0) / 5),
            },
        })

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")
            local leader_mappings = {
                h = {
                    name = "Harpoon",
                    h = {
                        function()
                            local telescope = require("telescope")
                            telescope.load_extension("harpoon")
                            telescope.extensions.harpoon.marks()
                        end,
                        "Marks Menu",
                    },
                    a = {
                        function()
                            harpoon_mark.add_file()
                        end,
                        "Add file",
                    },
                    t = {
                        function()
                            harpoon_term.gotoTerminal(1)
                        end,
                        "Terminal 1",
                    },

                    r = {
                        function()
                            harpoon_ui.nav_file(1)
                        end,
                        "Nav to file 1",
                    },
                    e = {
                        function()
                            harpoon_ui.nav_file(2)
                        end,
                        "Nav to file 2",
                    },
                    w = {
                        function()
                            harpoon_ui.nav_file(3)
                        end,
                        "Nav to file 3",
                    },
                    q = {
                        function()
                            harpoon_ui.nav_file(4)
                        end,
                        "Nav to file 4",
                    },
                },
            }

            local opts = { prefix = "<leader>" }
            wk.register(leader_mappings, opts)
        end
    end,
}
