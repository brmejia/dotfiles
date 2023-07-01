return {
    "akinsho/bufferline.nvim",
    -- enabled = false,
    version = "*",
    dependencies = "kyazdani42/nvim-web-devicons",
    opts = {
        options = {
            offsets = {
                {
                    filetype = { "neo-tree", "NeoTree", "nvim-tree", "NvimTree" },
                    text = "  File Explorer",
                    highlight = "Directory",
                    text_align = "left",
                    padding = 1,
                    separator = false,
                },
            },
            tab_size = 0,
            max_name_length = 25,
            separator_style = "slant",
            show_tab_indicators = false,
            modified_icon = "",
            color_icons = true,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local icon = " "
                if level == "error" then
                    icon = " "
                elseif level == "warning" then
                    icon = " "
                elseif level == "info" then
                    icon = " "
                elseif level == "hint" then
                    icon = "󰌵 "
                else
                    vim.notify("Unknown diagnostics level " .. level)
                end
                return icon .. count
            end,
            diagnostics = "nvim_lsp",
        },
    },
}
