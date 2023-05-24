return {
    {
        "alexghergh/nvim-tmux-navigation",
        opts = {
            disable_when_zoomed = true, -- defaults to false
            keybindings = {
                left = "<C-h>",
                down = "<C-j>",
                up = "<C-k>",
                right = "<C-l>",
                last_active = "<C-\\>",
                next = "<C-Space>",
            }
        }
    },
    -- {
    --     "goolord/alpha-nvim",
    --     event = "VimEnter",
    --     dependencies = { "kyazdani42/nvim-web-devicons" },
    --     config = lazy_config "config.alpha",
    -- },
    -- {
    --     "folke/which-key.nvim",
    --     config = lazy_config "config.which-key",
    -- },
    -- {
    --     "folke/trouble.nvim",
    --     dependencies = "kyazdani42/nvim-web-devicons",
    --     config = lazy_config "config.trouble",
    -- },
    -- {
    --     "kyazdani42/nvim-tree.lua",
    --     dependencies = {
    --         "kyazdani42/nvim-web-devicons", -- optional, for file icon
    --     },
    --     config = lazy_config "config.nvim-tree",
    -- },
    -- {
    --     "kevinhwang91/nvim-hlslens",
    --     config = lazy_config("config.hlslens")
    -- },
    -- {
    --     "petertriho/nvim-scrollbar",
    --     dependencies = { "kevinhwang91/nvim-hlslens" },
    --     config = lazy_config "config.nvim-scrollbar",
    -- },
    -- {
    --     "lewis6991/gitsigns.nvim",
    --     config = lazy_config "config.gitsigns",
    -- },
    -- {
    --     "akinsho/bufferline.nvim",
    --     version = "*",
    --     dependencies = "kyazdani42/nvim-web-devicons",
    --     config = lazy_config("config.bufferline")
    -- },
    -- {
    --     "stevearc/dressing.nvim",
    --     config = lazy_config "config.dressing",
    -- },
}
