local status_ok, cmp_nvim_lsp = pcall(require, "popui")
if not status_ok then
    vim.notify("popui not ready")
    return
end

vim.ui.select = require"popui.ui-overrider"
vim.ui.input = require"popui.input-overrider"

-- Available styles: "sharp" | "rounded" | "double"
vim.o.popui_border_style = "sharp"
