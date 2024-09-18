return {
    "folke/noice.nvim",
    -- enabled = false,
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- optional:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   if not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
    opts = {
        --cmdline = {
        --    enabled = true, -- enables the noice cmdline ui
        --    view = "cmdline_popup", -- view for rendering the cmdline. change to `cmdline` to get a classic cmdline at the bottom
        --    opts = {}, -- global options for the cmdline. see section on views
        --    ---@type table<string, cmdlineformat>
        --    format = {
        --        -- conceal: (default=true) this will hide the text in the cmdline that matches the pattern.
        --        -- view: (default is cmdline view)
        --        -- opts: any options passed to the view
        --        -- icon_hl_group: optional hl_group for the icon
        --        -- title: set to anything or empty string to hide
        --        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        --        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        --        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        --        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        --        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
        --        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
        --        input = {}, -- used by input()
        --        -- lua = false, -- to disable a format, set to `false`
        --    },
        --},
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **treesitter**
            override = {
                -- override the default lsp markdown formatter with noice
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                -- override the lsp markdown formatter with noice
                ["vim.lsp.util.stylize_markdown"] = true,
                -- override cmp documentation with noice (needs the other options to work)
                ["cmp.entry.get_documentation"] = true,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        routes = {
            -- Avoid written messages
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "[w]",
                },
                opts = { skip = true },
            },
            -- Avoid search messages. Noice by default uses virttext, this snippets also disables that.
            {
                filter = {
                    event = "msg_show",
                    kind = "search_count",
                },
                opts = { skip = true },
            },
            {
                view = "split",
                filter = {
                    event = "msg_show",
                    kind = "",
                },
                opts = { skip = true },
            },
            {
                view = "split",
                filter = { event = "notify", min_height = 2 },
            },
            {
                view = "mini",
                filter = {
                    error = true,
                },
            },
            {
                view = "mini",
                filter = {
                    warning = true,
                },
            },
            {
                view = "mini",
                filter = {
                    any = {
                        { event = "notify" },
                        { event = "lsp", kind = "message" },
                    },
                },
            },
        },
        views = {
            mini = {
                timeout = 6000,
                align = "message-left",
                position = {
                    row = -1,
                    col = "100%", -- right
                    -- col = 0, -- left
                },
                -- position = {
                --     row = -1,
                --     -- col = "100%",
                --     col = 0,
                -- },
            },
            -- confirm = {
            --     backend = "popup",
            --     relative = "editor",
            --     focusable = false,
            --     align = "center",
            --     enter = false,
            --     zindex = 60,
            --     format = { "{confirm}" },
            --     position = {
            --         row = "50%",
            --         col = "50%",
            --     },
            --     size = "auto",
            --     border = {
            --         style = "rounded",
            --         padding = { 1, 2 },
            --         text = {
            --             top = " confirm ",
            --         },
            --     },
            --     win_options = {
            --         winhighlight = {
            --             normal = "noiceconfirm",
            --             floatborder = "noiceconfirmborder",
            --         },
            --     },
            -- },
        },
        messages = {
            -- note: if you enable messages, then the cmdline is enabled automatically.
            -- this is a current neovim limitation.
            enabled = true, -- enables the noice messages ui
            view = "mini", -- default view for messages
            view_error = "mini", -- view for errors
            view_warn = "mini", -- view for warnings
            view_history = "messages", -- view for :messages
            view_search = "virtualtext", -- view for search count messages. set to `false` to disable
        },
    },
}
