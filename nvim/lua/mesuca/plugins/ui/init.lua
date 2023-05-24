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
    { "kyazdani42/nvim-web-devicons" },
    {
        "kevinhwang91/nvim-hlslens",
        -- config = lazy_config("config.hlslens")
    },
    {
        "petertriho/nvim-scrollbar",
        dependencies = { "kevinhwang91/nvim-hlslens" },
        -- config = lazy_config "config.nvim-scrollbar",
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "kyazdani42/nvim-web-devicons",
        -- config = lazy_config("config.bufferline")
    },
    -- {
    --     "stevearc/dressing.nvim",
    --     -- config = lazy_config "config.dressing",
    -- },
}
