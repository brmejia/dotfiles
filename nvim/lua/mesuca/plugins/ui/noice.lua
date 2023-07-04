local default_msg_position = {
    row = -1,
    -- col = "100%",
    col = 0,
}

return {
    "folke/noice.nvim",
    -- enabled = false,
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
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = true,            -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        routes = {
            {
                view = "hover",
                filter = { event = "msg_showmode" },
                opts = {
                    -- timeout = false,
                    border = {
                        padding = { 0, 0 },
                        style = "rounded",
                    },
                    -- relative = "cursor",
                    -- position = {
                    --     row = 2,
                    --     col = -10,
                    -- },
                    -- relative = {
                    --     type = "editor",
                    --     -- zero-indexed
                    --     position = {
                    --         row = "50%",
                    --         col = "50%",
                    --     },
                    -- },
                },
            },
            {
                view = "split",
                filter = { min_height = 4 },
            },
            {
                view = "mini",
                filter = {
                    error = true,
                },
                opts = {
                    timeout = 15000,
                    align = "message-left",
                    position = default_msg_position,
                },
            },
            {
                view = "mini",
                filter = {
                    warning = true,
                },
                opts = {
                    timeout = 10000,
                    align = "message-left",
                    position = default_msg_position,
                },
            },
            {
                view = "mini",
                filter = {
                    any = {
                        { event = "notify" },
                        { event = "lsp",   kind = "message" },
                    },
                },
                opts = {
                    timeout = 5000,
                    align = "message-left",
                    position = default_msg_position,
                },
            },
        },
        views = {
            mini = {
                opts = {
                    align = "message-left",
                    position = default_msg_position,
                    -- position = {
                    --     row = -1,
                    --     -- col = "100%",
                    --     col = 0,
                    -- },
                },
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
            enabled = true,              -- enables the noice messages ui
            view = "mini",               -- default view for messages
            view_error = "mini",         -- view for errors
            view_warn = "mini",          -- view for warnings
            view_history = "messages",   -- view for :messages
            view_search = "virtualtext", -- view for search count messages. set to `false` to disable
        },
    },
}
