return {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
    -- config = lazy_config "config.nvim-tree",
    config = function()
        -- disable netrw at the very start of your init.lua (strongly advised)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")
            local mappings = {
                ["<F1>"] = { ":NvimTreeToggle<cr>", "FileTree - Toggle" },
                t = { ":NvimTreeFindFileToggle<cr>", "FileTree - Find current file" },
            }

            local opts = { prefix = "<leader>" }
            wk.register(mappings, opts)
        end
        -- setup with all defaults
        -- each of these are documented in `:help nvim-tree.OPTION_NAME`
        require("nvim-tree").setup({ -- BEGIN_DEFAULT_OPTS
            sort_by = "name",
            view = {
                width = 50,
                hide_root_folder = false,
                side = "left",
                preserve_window_proportions = false,
                number = false,
                relativenumber = false,
                signcolumn = "yes",
            },
            diagnostics = {
                enable = true,
                show_on_dirs = false,
                icons = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                },
            },
        })
    end,
}
