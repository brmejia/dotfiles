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


-- Call function on startup to set default value
local ui = require("lib.ui")
ui.ResetGuiFont()

return {
    { import = (...) },
    -- Themes
    { "navarasu/onedark.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "folke/tokyonight.nvim" },
}
