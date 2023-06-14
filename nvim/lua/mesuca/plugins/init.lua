return {
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
    { "windwp/nvim-ts-autotag" },

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
