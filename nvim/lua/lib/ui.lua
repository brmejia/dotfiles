local ui = {}

function ui.RefreshGuiFont()
    vim.opt.linespace = 2
    vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

function ui.ResizeGuiFont(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    ui.RefreshGuiFont()
end

function ui.ResetGuiFont()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    ui.RefreshGuiFont()
end

return ui


