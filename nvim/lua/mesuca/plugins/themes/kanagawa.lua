return {
    "rebelot/kanagawa.nvim",
    build = function(_)
        vim.notify("This is an error message", "error")
        vim.cmd("KanagawaCompile")
    end,
    opts = {
        -- compile = true,
        -- transparent = true,
        colors = {
            theme = {
                all = {
                    ui = {
                        bg_gutter = "none",
                    },
                },
            },
        },

        overrides = function(colors)
            local theme = colors.theme

            local makeDiagnosticColor = function(color)
                local c = require("kanagawa.lib.color")
                return { fg = color, bg = c(color):blend(theme.ui.bg, 0.98):to_hex() }
            end
            return {
                Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency,,
                PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
                PmenuSbar = { bg = theme.ui.bg_m1 },
                PmenuThumb = { bg = theme.ui.bg_p2 },
                BlinkCmpMenuBorder = { fg = colors.palette.dragonGray3, bg = "" },

                -- CursorLineNr = { fg = colors.palette.sakuraPink, bg = "none" },

                -- --
                -- -- Transparent Floating Windows
                -- -- This will make floating windows look nicer with default borders.
                -- NormalFloat = { bg = "none" },
                -- FloatBorder = { bg = "none" },
                -- FloatTitle = { bg = "none" },
                --
                -- -- Save an hlgroup with dark background and dimmed foreground
                -- -- so that you can use it where your still want darker windows.
                -- -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                --
                -- -- Popular plugins that open floats will link to NormalFloat by default;
                -- -- set their background accordingly if you wish to keep them dark and borderless
                -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                --
                -- Tint background of diagnostic messages with their foreground color
                DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
                DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
                DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
                DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
            }
        end,
    },
    config = function(_, opts)
        require("kanagawa").setup(opts)
        -- setup must be called before loading
        vim.cmd("colorscheme kanagawa")
    end,
}
