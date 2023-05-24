return {
    { import = "mesuca.plugins.ui" },
    { import = "mesuca.plugins.themes" },

    "nvim-lua/plenary.nvim",

    -- UX / UI

    -- Search
    -- {
    --     "ibhagwan/fzf-lua",
    --     -- optional for icon support
    --     dependencies = { "kyazdani42/nvim-web-devicons" },
    --     config = lazy_config("config.fzf-lua"),
    -- },
    -- {
    --     "unblevable/quick-scope",
    --     config = lazy_config("config.quick-scope")
    -- },
    -- --  {
    -- --     "phaazon/hop.nvim",
    -- -- config = config("config.hop")

    -- -- }
    -- {
    --     "ThePrimeagen/harpoon",
    --     config = lazy_config("config.harpoon"),
    -- },

    -- Syntax Highlight
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     config = lazy_config "config.treesitter",
    --     build = ":TSUpdate"
    -- },
    { "nvim-treesitter/nvim-treesitter-context", },
    -- {
    --     'm-demare/hlargs.nvim',
    --     dependencies = { 'nvim-treesitter/nvim-treesitter' },
    --     config = lazy_config "config.hlargs",
    -- },
    -- {
    --     'kevinhwang91/nvim-ufo',
    --     dependencies = 'kevinhwang91/promise-async',
    --     config = lazy_config "config.nvim-ufo",
    -- },
    { "ron-rs/ron.vim" },
    -- -- Coding
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        opts = {},
    },
    {
        import = "mesuca.plugins.lsp"
    },
    -- {
    --     "jose-elias-alvarez/null-ls.nvim",
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --     },
    --     config = lazy_config "config.null-ls",

    -- },
    -- --  {
    -- --     -- No HTML support
    -- --     "ur4ltz/surround.nvim",
    -- --     config = require "config.surround"
    -- -- }
    "tpope/vim-commentary",
    "tpope/vim-repeat",
    -- --  "windwp/nvim-autopairs"
    -- {
    --     'TimUntersberger/neogit',
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --         'sindrets/diffview.nvim',
    --     },
    --     config = lazy_config "config.neogit",
    -- },

    -- -- Snippet engine
    -- --  "hrsh7th/vim-vsnip"
    -- {
    --     "L3MON4D3/LuaSnip",
    --     version = "1.*",
    --     config = lazy_config "config.luasnip",
    -- },

-- return {
--     "hrsh7th/nvim-cmp",
--     config = lazy_config 'config.nvim-cmp',
--     -- LSP completion source for nvim-cmp
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-nvim-lsp-signature-help",
--     -- Snippet completion source for nvim-cmp
    -- For vsnip rs.
--     "hrsh7th/cmp-vsnip",
--     -- For luasnip rs.
--     "saadparwaiz1/cmp_luasnip",
--     -- Other full completion sources
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-buffer",

    -- {import = "mesuca.plugins.lsp"}
-- },
    -- -- Completion framework
    -- -- Language Specific
    -- {
    --     "simrat39/rust-tools.nvim",
    --     config = lazy_config "config.rust-tools",
    --     dependencies = {
    --         "neovim/nvim-lspconfig",
    --     },
    -- },
    -- {
    --     "saecki/crates.nvim",
    --     dependencies = { 'nvim-lua/plenary.nvim' },
    --     config = lazy_config "config.crates",
    --     -- event = { "BufRead Cargo.toml" },
    --     -- ft = { "rust", "toml" },
    -- },

    -- Themes
    { "navarasu/onedark.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim" },

}
