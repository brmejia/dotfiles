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
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
        use_popups_for_input = false, -- If false, inputs will use vim.ui.input() instead of custom floats.
        default_component_configs = {
            icon = {
                folder_empty = "󰜌",
                folder_empty_open = "󰜌",
            },
            git_status = {
                symbols = {
                    -- Change type
                    added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                    modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                    renamed = "",
                    unstaged = "󰄱",
                    staged = "󰱒",
                    untracked = "?",
                    modified = " ",
                    --# 󰩹 󰗨 ✘ 
                    deleted = "",
                },
            },
        },
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
        event_handlers = {
            -- Auto Close on Open File
            {
                event = "file_opened",
                handler = function(file_path)
                    require("neo-tree.command").execute({ action = "close" })
                end,
            },
        },
        filesystem = {
            components = {
                harpoon_index = function(config, node, state)
                    local Marked = require("harpoon.mark")
                    local path = node:get_id()
                    local succuss, index = pcall(Marked.get_index_of, path)
                    local numbers = { "𝟬", "𝟭", "𝟮", "𝟯", "𝟰", "𝟱", "𝟲", "𝟳", "𝟴", "𝟵" }
                    if succuss and index and index > 0 then
                        local idx = numbers[tonumber(index)] or index
                        return {
                            text = string.format("❮%s❯ 🡆 ", idx), -- <-- Add your favorite harpoon like arrow here
                            highlight = config.highlight or "NeoTreeDirectoryIcon",
                        }
                    else
                        return {}
                    end
                end,
            },
            renderers = {
                file = {
                    { "icon" },
                    { "harpoon_index", highlight = "NeoTreeGitAdded" }, --> This is what actually adds the component in where you want it
                    { "name", use_git_status_colors = true },
                    { "diagnostics" },
                    { "git_status", highlight = "NeoTreeDimText" },
                },
            },
        },
    },
    config = function(_, opts)
        require("neo-tree").setup(opts)

        local keymap = require("lib.utils").keymap

        keymap(
            "n",
            "<leader>r",
            ":Neotree reveal position=current toggle<cr>",
            { desc = "Reveal file in current split" }
        )
        keymap("n", "<leader>t", ":Neotree reveal toggle<cr>", { desc = "Reveal file" })
    end,
}
