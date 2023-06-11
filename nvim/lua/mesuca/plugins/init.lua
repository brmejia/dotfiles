return {
    { import = "mesuca.plugins.themes" },
    { import = "mesuca.plugins.ui" },

    { "nvim-lua/plenary.nvim" },

    -- Syntax Highlight
    { "nvim-treesitter/nvim-treesitter-context" },
    { "ron-rs/ron.vim" },

    -- -- Coding
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        opts = {},
    },
    { "tpope/vim-commentary" },
    { "tpope/vim-repeat" },

    -- Themes
    { "navarasu/onedark.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim" },

    { import = "mesuca.plugins.lsp" },

    -- --  {
    -- --     -- No HTML support
    -- --     "ur4ltz/surround.nvim",
    -- --     config = require "config.surround"
    -- -- }
    -- UX / UI
    -- Search
    -- {
    --     "ibhagwan/fzf-lua",
    --     -- optional for icon support
    --     dependencies = { "kyazdani42/nvim-web-devicons" },
    --     config = lazy_config("config.fzf-lua"),
    -- },
    -- --  {
    -- --     "phaazon/hop.nvim",
    -- -- config = config("config.hop")

    -- -- }
}
