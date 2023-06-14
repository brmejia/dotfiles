vim.g.gui_font_default_size = 14
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "FiraCode Nerd Font,Medium"

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_transparency = 1
    vim.g.neovide_remember_window_size = true
end

RefreshGuiFont = function()
    vim.opt.linespace = 2
    vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    RefreshGuiFont()
end

ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps
if require("lib.utils").has_module("which-key") then
    local wk = require("which-key")

    local mappings = {
        ["<C-->"] = {
            function()
                ResizeGuiFont(-1)
            end,
            "Decrease font size",
        },
        ["<C-+>"] = {
            function()
                ResizeGuiFont(1)
            end,
            "Increase font size",
        },
    }
    local nopts = { mode = "n", noremap = true, silent = true }
    wk.register(mappings, nopts)
    local iopts = { mode = "i", noremap = true, silent = true }
    wk.register(mappings, iopts)
end
-- local keymap = require "lib.utils".keymap
-- keymap({ "n", "i" }, "<C-->", function() ResizeGuiFont(-1) end)
-- keymap({ "n", "i" }, "<C-+>", function() ResizeGuiFont(1) end)
--
--

return {
    {import = (...) },
    -- Themes
    { "navarasu/onedark.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "folke/tokyonight.nvim" },
}
