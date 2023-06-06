return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            if not require("lib.utils").has_module("lualine") then
                return
            end

            local lualine = require("lualine")

            local hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end

            local diagnostics = {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn" },
                symbols = { error = " ", warn = " " },
                colored = true,
                update_in_insert = true,
                always_visible = true,
            }

            local diff = {
                "diff",
                colored = true,
                symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
                cond = hide_in_width,
            }

            local mode = {
                "mode",
                fmt = function(str)
                    return " <<" .. str .. ">> "
                end,
            }

            local filetype = {
                "filetype",
                icons_enabled = true,
                -- icon = nil,
            }

            local branch = {
                "branch",
                icons_enabled = true,
                icon = "",
            }

            local location = {
                "location",
                padding = 0,
            }

            -- cool function for progress
            local progress = function()
                local current_line = vim.fn.line(".")
                local total_lines = vim.fn.line("$")
                local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
                local line_ratio = current_line / total_lines
                local index = math.ceil(line_ratio * #chars)
                return chars[index]
            end

            local spaces = function()
                return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
            end

            local status_command = function()
                if not require("lib.utils").has_module("noice") then
                    return
                end

                local noice = require("noice")
                return {
                    noice.api.status.command.get,
                    cond = noice.api.status.command.has,
                    color = { fg = "#ff9e64" },
                }
            end

            local status_mode = function()
                if not require("lib.utils").has_module("noice") then
                    return
                end

                local noice = require("noice")
                return {
                    noice.api.status.mode.get,
                    cond = noice.api.status.mode.has,
                    color = { fg = "#ff2222" },
                    opt = {
                        replace = true,
                    },
                }
            end

            lualine.setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    -- component_separators = '|',
                    component_separators = { left = "", right = "▎" },
                    -- section_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "neo-tree", "neo-tree-popup" },
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = { mode },
                    lualine_b = { branch },
                    lualine_c = { diagnostics, filetype, "filename" },
                    lualine_x = {
                        status_command(),
                        status_mode(),
                        -- {
                        --     require("noice").api.status.command.get,
                        --     cond = require("noice").api.status.command.has,
                        --     color = { fg = "#ff9e64" },
                        -- },
                        -- {
                        --     require("noice").api.status.mode.get,
                        --     cond = require("noice").api.status.mode.has,
                        --     color = { fg = "#ff2222" },
                        --     opt = {
                        --         replace = true,
                        --     },
                        -- },
                        diff,
                        spaces,
                        "encoding",
                        "fileformat",
                    },
                    lualine_y = { location },
                    lualine_z = { progress },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { filetype, "filename" },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                extensions = {},
            })
        end,
    },
}
