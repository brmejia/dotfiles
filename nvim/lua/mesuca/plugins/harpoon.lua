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
            excluded_filetypes = { "harpoon", "TelescopePrompt", "NvimTree", "neo-tree", "neo-tree-popup" },

            -- set marks specific to each git branch inside git repository
            mark_branch = true,
            menu = {
                width = math.floor((vim.api.nvim_win_get_width(0) / 5) * 4),
            },
        })

        local keymap = require("lib.utils").keymap

        keymap("n", "<leader>hh", harpoon_ui.toggle_quick_menu, { desc = "Harpoon Marks" })
        keymap("n", "<leader>hH", function()
            local telescope = require("telescope")
            telescope.load_extension("harpoon")
            telescope.extensions.harpoon.marks()
        end, { desc = "Telescoped Harpoon Marks" })
        keymap("n", "<leader>ha", harpoon_mark.add_file, { desc = "Add file to Harpoon" })
        keymap("n", "<leader>ht", function()
            harpoon_term.gotoTerminal(1)
        end, { desc = "Open Harpoon Terminal" })
        keymap("n", "<leader>hr", function()
            harpoon_ui.nav_file(1)
        end, { desc = "Open Harpoon file 1" })
        keymap("n", "<leader>he", function()
            harpoon_ui.nav_file(2)
        end, { desc = "Open Harpoon file 2" })
        keymap("n", "<leader>hw", function()
            harpoon_ui.nav_file(3)
        end, { desc = "Open Harpoon file 3" })
        keymap("n", "<leader>hq", function()
            harpoon_ui.nav_file(4)
        end, { desc = "Open Harpoon file 4" })
    end,
}
