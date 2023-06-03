local kind_icons = require("lib.utils").kind_icons

return {
    "simrat39/symbols-outline.nvim",
    opts = {
        auto_close = false,
        keymaps = {
            -- These keymaps can be a string or a table for multiple keys
            close = { "<Esc>", "q" },
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = "a",
            fold = { "h", "<Tab>" },
            unfold = { "l", "<Tab>" },
            fold_all = "W",
            unfold_all = "E",
            fold_reset = "R",
        },
        symbols = {
            Array = { icon = kind_icons.Array, hl = "@constant" },
            Boolean = { icon = kind_icons.Boolean, hl = "@boolean" },
            Class = { icon = kind_icons.Class, hl = "@type" },
            Component = { icon = kind_icons.Component, hl = "@function" },
            Constant = { icon = kind_icons.Constant, hl = "@constant" },
            Constructor = { icon = kind_icons.Constructor, hl = "@constructor" },
            Enum = { icon = kind_icons.Enum, hl = "@type" },
            EnumMember = { icon = kind_icons.EnumMember, hl = "@field" },
            Event = { icon = kind_icons.Event, hl = "@type" },
            Field = { icon = kind_icons.Field, hl = "@field" },
            File = { icon = kind_icons.File, hl = "@text.uri" },
            Fragment = { icon = kind_icons.Fragment, hl = "@constant" },
            Function = { icon = kind_icons.Function, hl = "@function" },
            Interface = { icon = kind_icons.Interface, hl = "@type" },
            Key = { icon = kind_icons.Keyword, hl = "@type" },
            Method = { icon = kind_icons.Method, hl = "@method" },
            Module = { icon = kind_icons.Module, hl = "@namespace" },
            Namespace = { icon = kind_icons.Namespace, hl = "@namespace" },
            Null = { icon = kind_icons.Null, hl = "@type" },
            Number = { icon = kind_icons.Number, hl = "@number" },
            Object = { icon = kind_icons.Object, hl = "@type" },
            Operator = { icon = kind_icons.Operator, hl = "@operator" },
            Package = { icon = kind_icons.Package, hl = "@namespace" },
            Property = { icon = kind_icons.Property, hl = "@method" },
            String = { icon = kind_icons.String, hl = "@string" },
            Struct = { icon = kind_icons.Struct, hl = "@type" },
            TypeParameter = { icon = kind_icons.TypeParameter, hl = "@parameter" },
            Variable = { icon = kind_icons.Variable, hl = "@constant" },
        },
    },
    config = function(_, opts)
        require("symbols-outline").setup(opts)

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")
            local leader_mappings = {
                s = {
                    function()
                        require("symbols-outline").toggle_outline()
                    end,
                    "Toggle Symbols Outline",
                },
            }

            local opts = { prefix = "<leader>" }
            wk.register(leader_mappings, opts)
        end
    end,
}
