local local_config = function()
    local catppuccin = require("catppuccin")
    -- local cp = require("catppuccin.palettes").get_palette() -- fetch colors from g:catppuccin_flavour palette


    local setup_opts = {
        transparent_background = false,
        term_colors = false,
        -- compile = {
        --     enabled = false,
        --     path = vim.fn.stdpath("cache") .. "/catppuccin",
        -- },
        dim_inactive = {
            enabled = true,
            shade = "dark",
            percentage = 0.1,
        },
        styles = {
            comments = { "italic" },
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        integrations = {
            -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "undercurl" },
                    -- hints = { "underdot" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    -- information = { "underdot" },
                    information = { "underline" },
                },

            },
            mini = {
                enabled = true
            },
        },
        color_overrides = {},
        highlight_overrides = {},
    }


    if require "lib.utils".has_module("onedark.palette") then
        local onedark_palette = require("onedark.palette").darker

        setup_opts["color_overrides"] = {
            -- all = {
            --     text = onedark_colors.fg,
            -- },
            mocha = {
                base = onedark_palette.bg0,
                mantle = onedark_palette.bg_d,
                crust = onedark_palette.bg1,

                -- surface0 = "#4e5463",
                surface0 = onedark_palette.bg2,
                surface1 = onedark_palette.bg3, -- Folds, relative numbers
                -- surface2 = palette.bg4,
            }
        }
    end

    setup_opts["custom_highlights"] = {
        LineNr = { fg = "#565676" },
        Folded = { bg = "#282c34" },
    }

    vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

    catppuccin.setup(setup_opts)

    vim.cmd [[colorscheme catppuccin]]
end


return {
    "catppuccin/nvim",
    dependencies = {
        { "navarasu/onedark.nvim" },
    },
    name = "catppuccin",
    config = local_config
}
