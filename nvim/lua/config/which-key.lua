if not require "lib.utils".has_module("which-key") then
    return
end

local wk = require "which-key"

wk.setup {
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
            g = true
        }
    }
}


local mappings = {
    q = { ":q<cr>", "Quit" },
    Q = { ":wq<cr>", "Save & Quit" },
    w = { ":w<cr>", "Save" },
    x = { ":bdelete<cr>", "Close buffer" },
    X = { ":bufdo bdelete<cr>", "Close all buffers" },
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

local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
