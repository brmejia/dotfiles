vim.g.gui_font_default_size = 9
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "FiraCode Nerd Font Med"

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    -- vim.g.neovide_floating_blur_amount_x = 2.0
    -- vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_transparency = 1
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_scroll_animation_length = 0.15
    -- Sets how long the scroll animation takes to complete, measured in seconds.
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animation_length = 0.08
    -- vim.g.neovide_cursor_trail_size = 0.8
    -- railgun, torpedo, sonicboom, wireframe
    -- vim.g.neovide_cursor_vfx_mode = ""
    -- vim.g.neovide_cursor_vfx_particle_lifetime = 0.8
end

-- Call function on startup to set default value
local ui = require("lib.ui")
ui.ResetGuiFont()

return {
    -- Themes
    { "navarasu/onedark.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "folke/tokyonight.nvim" },
}
