require("config.themes.catppuccin")

vim.g.gui_font_default_size = 13
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "FuraCode Nerd Font, Medium"

RefreshGuiFont = function()
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
if require "lib.utils".has_module("which-key") then

    local wk = require "which-key"

    local mappings = {
        ["<C-->"] = { function() ResizeGuiFont(-1) end, "Decrease font size" },
        ["<C-+>"] = { function() ResizeGuiFont(1) end, "Increase font size" },
    }
    local nopts = { mode = "n", noremap = true, silent = true }
    wk.register(mappings, nopts)
    local iopts = { mode = "i", noremap = true, silent = true }
    wk.register(mappings, iopts)

end
-- local keymap = require "lib.utils".keymap
-- keymap({ "n", "i" }, "<C-->", function() ResizeGuiFont(-1) end)
-- keymap({ "n", "i" }, "<C-+>", function() ResizeGuiFont(1) end)
