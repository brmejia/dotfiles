if not require "lib.utils".has_module("bufferline") then
    return
end

local bufferline = require "bufferline"

vim.opt.termguicolors = true
bufferline.setup {
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "",
                highlight = "Directory",
                text_align = "left",
                padding = 1,
                separator = false,
            }

        },
        show_tab_indicators = true,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            if level == "error" then
                return " " .. count
            elseif level == "warning" then
                return " " .. count
            elseif level == "info" then
                return " " .. count
            elseif level == "hint" then
                return "💡" .. count
            else
                return ""
            end
        end,
        diagnostics = "nvim_lsp",
    }
}
