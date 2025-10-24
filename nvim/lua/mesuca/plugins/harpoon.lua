return {
    "ThePrimeagen/harpoon",
    enabled = false,
    dependencies = { "nvim-telescope/telescope.nvim" },
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        harpoon.setup({
            settings = {
                save_on_toggle = false,
                sync_on_ui_close = true,
                -- key = function()
                --     return vim.loop.cwd()
                -- end,
            },
        })

        local keymap = require("lib.utils").keymap

        keymap("n", "<leader>hh", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon qui" })
        keymap("n", "<leader>hH", function()
            local telescope = require("telescope")
            telescope.load_extension("harpoon")
            telescope.extensions.harpoon.marks()
        end, { desc = "Telescoped Harpoon Marks" })
        keymap("n", "<leader>ha", function()
            harpoon:list():add()
        end, { desc = "Add file to Harpoon" })
        keymap("n", "<leader>ht", function()
            harpoon.term.gotoTerminal(1)
        end, { desc = "Open Harpoon Terminal" })
        keymap("n", "<leader>hr", function()
            harpoon:list():select(1)
        end, { desc = "Open Harpoon file 1" })
        keymap("n", "<leader>he", function()
            harpoon:list():select(2)
        end, { desc = "Open Harpoon file 2" })
        keymap("n", "<leader>hw", function()
            harpoon:list():select(3)
        end, { desc = "Open Harpoon file 3" })
        keymap("n", "<leader>hq", function()
            harpoon:list():select(4)
        end, { desc = "Open Harpoon file 4" })
    end,
}
