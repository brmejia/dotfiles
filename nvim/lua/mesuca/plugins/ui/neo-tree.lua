return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    opts = {
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf", "harpoon" }, -- when opening files, do not use windows containing these filetypes or buftypes
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
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
            symlink_target = {
                enabled = true,
                required_width = 120, -- min width of window required to show this column
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
                    { "indent" },
                    { "icon" },
                    {
                        "container",
                        content = {
                            { "harpoon_index", zindex = 10, highlight = "NeoTreeGitAdded" }, --> This is what actually adds the component in where you want it
                            { "name", zindex = 10, use_git_status_color = true },
                            {
                                "symlink_target",
                                zindex = 10,
                                highlight = "NeoTreeSymbolicLinkTarget",
                            },
                            { "diagnostics", zindex = 10 },
                            { "clipboard", zindex = 10 },
                            { "bufnr", zindex = 10 },
                            { "modified", zindex = 20, align = "right" },
                            { "git_status", zindex = 10, align = "right" },
                            { "file_size", zindex = 10, align = "right" },
                            { "type", zindex = 10, align = "right" },
                            { "last_modified", zindex = 10, align = "right" },
                            { "created", zindex = 10, align = "right" },
                        },
                    },
                },
            },
        },
    },
    config = function(_, opts)
        local function on_move(data)
            Snacks.rename.on_rename_file(data.source, data.destination)
        end
        local events = require("neo-tree.events")
        opts.event_handlers = opts.event_handlers or {}
        vim.list_extend(opts.event_handlers, {
            { event = events.FILE_MOVED, handler = on_move },
            { event = events.FILE_RENAMED, handler = on_move },
        })
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
