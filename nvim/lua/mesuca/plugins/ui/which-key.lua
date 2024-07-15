return {
    "folke/which-key.nvim",
    config = function()
        local wk = require("which-key")

        wk.setup({
            plugins = {
                marks = false,
                registers = false,
                spelling = { enabled = false, suggestions = 20 },
                presets = {
                    operators = true,
                    motions = true,
                    text_objects = true,
                    windows = false,
                    nav = true,
                    z = true,
                    g = true,
                },
            },
        })

        local mappings = {
            { "<leader>q", ":q<cr>", desc = "Quit" },
            { "<leader>Q", ":wq<cr>", desc = "Save & Quit" },
            { "<leader>w", ":w<cr>", desc = "Save" },
            { "<leader>x", ":bdelete<cr>", desc = "Close buffer" },
            { "<leader>X", ":bufdo bdelete<cr>", desc = "Close all buffers" },
            -- E = {":e ~/.config/nvim/init.lua<cr>", "Edit config"},
            -- f = {":Telescope find_files<cr>", "Telescope Find Files"},
            -- r = {":Telescope live_grep<cr>", "Telescope Live Grep"},
            -- t = {
            --   t = {":ToggleTerm<cr>", "Split Below"},
            --   f = {toggle_float, "Floating Terminal"},
            --   l = {toggle_lazygit, "LazyGit"}
            -- },
            -- z = {
            --   name = "Focus",
            --   z = {":ZenMode<cr>", "Toggle Zen Mode"},
            --   t = {":Twilight<cr>", "Toggle Twilight"}
            -- }
        }

        local opts = { prefix = "<leader>" }
        wk.add(mappings, opts)
    end,
}
