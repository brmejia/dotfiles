return {
    "nvim-neo-tree/neo-tree.nvim",
    -- enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    opts = {
        -- If a user has a sources list it will replace this one.
        -- Only sources listed here will be loaded.
        -- You can also add an external source by adding it's name to this list.
        -- The name used here must be the same name you would use in a require() call.
        sources = {
            "filesystem",
            -- "buffers",
            -- "git_status",
            -- "document_symbols",
        },
        enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
        use_popups_for_input = false, -- If false, inputs will use vim.ui.input() instead of custom floats.
        default_component_configs = {
            icon = {
                folder_empty = "󰜌",
                folder_empty_open = "󰜌",
            },
            git_status = {
                symbols = {
                    renamed = "󰁕",
                    unstaged = "󰄱",
                    staged = "󰱒",
                },
            },
        },
        -- document_symbols = {
        --     kinds = {
        --         File = { icon = "󰈙", hl = "Tag" },
        --         Namespace = { icon = "󰌗", hl = "Include" },
        --         Package = { icon = "󰏖", hl = "Label" },
        --         Class = { icon = "󰌗", hl = "Include" },
        --         Property = { icon = "󰆧", hl = "@property" },
        --         Enum = { icon = "󰒻", hl = "@number" },
        --         Function = { icon = "󰊕", hl = "Function" },
        --         String = { icon = "󰀬", hl = "String" },
        --         Number = { icon = "󰎠", hl = "Number" },
        --         Array = { icon = "󰅪", hl = "Type" },
        --         Object = { icon = "󰅩", hl = "Type" },
        --         Key = { icon = "󰌋", hl = "" },
        --         Struct = { icon = "󰌗", hl = "Type" },
        --         Operator = { icon = "󰆕", hl = "Operator" },
        --         TypeParameter = { icon = "󰊄", hl = "Type" },
        --         StaticMethod = { icon = "󰠄 ", hl = "Function" },
        --     },
        -- },
        -- Add this section only if you've configured source selector.
        source_selector = {
            winbar = false, -- toggle to show selector on winbar
            statusline = false, -- toggle to show selector on statusline
            sources = {
                { source = "filesystem", display_name = " 󰉓 Files " },
                { source = "git_status", display_name = " 󰊢 Git " },
            },
        },
        ---- Other options ...
        --event_handlers = {
        --    {
        --        event = "file_opened",
        --        handler = function(file_path)
        --            vim.notify("file_opened" .. file_path)
        --            nt = require("neo-tree")
        --            --auto close
        --            nt.close_all()
        --        end,
        --    },
        --},
    },
    config = function(_, opts)
        require("neo-tree").setup(opts)

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")
            local mappings = {
                T = { ":NeoTreeRevealInSplitToggle<cr>", "Reveal current file in split" },
                t = { ":Neotree reveal toggle<cr>", "Reveal current file" },
            }

            local wk_opts = { prefix = "<leader>" }
            wk.register(mappings, wk_opts)
        end
    end,
}
