if not require "lib.utils".has_module("bufferline") then
    return
end

vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        offsets = {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
        },
        diagnostics = "nvim_lsp",
    }
}

