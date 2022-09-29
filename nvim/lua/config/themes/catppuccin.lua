if not require("lib.utils").has_module("catppuccin") then
    return
end

local catppuccin = require("catppuccin")


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
                hints = { "underdot" },
                warnings = { "underline" },
                information = { "underdot" },
            },
        },
        mini = {
            enabled = true
        },
    },
    color_overrides = {},
    highlight_overries = {},
}


if require "lib.utils".has_module("onedark.palette") then

    local palette = require("onedark.palette").darker

    setup_opts["color_overrides"] = {
        -- all = {
        --     text = onedark_colors.fg,
        -- },
        mocha = {
            base = palette.bg0,
            mantle = palette.bg_d,
            crust = palette.bg1,
        }
    }
end

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

catppuccin.setup(setup_opts)

vim.cmd [[colorscheme catppuccin]]
