return {
    "folke/noice.nvim",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                -- override the default lsp markdown formatter with Noice
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                -- override the lsp markdown formatter with Noice
                ["vim.lsp.util.stylize_markdown"] = true,
                -- override cmp documentation with Noice (needs the other options to work)
                ["cmp.entry.get_documentation"] = true,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = true, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        routes = {
            {
                view = "hover",
                filter = { event = "msg_showmode" },
                opts = {
                    -- timeout = false,
                    -- border = {
                    --     padding = { 0, 0 },
                    --     -- style = "rounded",
                    --     style = "single",
                    -- },
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
        },
    },
}
