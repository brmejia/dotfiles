local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- lazy_config = function(plugin)
--     return function()
--         require(plugin)
--     end
-- end

-- local plugins = {
--     --     -- UX / UI
--     {
--         "rcarriga/nvim-notify",
--         config = lazy_config "config.notify"
--     },
--     {
--         "alexghergh/nvim-tmux-navigation",
--         config = lazy_config "config.nvim-tmux-navigation",
--     },
--     {
--         "nvim-lualine/lualine.nvim",
--         config = lazy_config "config.lualine",
--     },
--     {
--         "goolord/alpha-nvim",
--         event = "VimEnter",
--         dependencies = { "kyazdani42/nvim-web-devicons" },
--         config = lazy_config "config.alpha",
--     },
--     {
--         "folke/which-key.nvim",
--         config = lazy_config "config.which-key",
--     },
--     {
--         "folke/trouble.nvim",
--         dependencies = "kyazdani42/nvim-web-devicons",
--         config = lazy_config "config.trouble",
--     },
--     {
--         "kyazdani42/nvim-tree.lua",
--         dependencies = {
--             "kyazdani42/nvim-web-devicons", -- optional, for file icon
--         },
--         config = lazy_config "config.nvim-tree",
--     },
--     {
--         "kevinhwang91/nvim-hlslens",
--         config = lazy_config("config.hlslens")
--     },
--     {
--         "petertriho/nvim-scrollbar",
--         dependencies = { "kevinhwang91/nvim-hlslens" },
--         config = lazy_config "config.nvim-scrollbar",
--     },
--     {
--         "lewis6991/gitsigns.nvim",
--         config = lazy_config "config.gitsigns",
--     },
--     {
--         "akinsho/bufferline.nvim",
--         version = "*",
--         dependencies = "kyazdani42/nvim-web-devicons",
--         config = lazy_config("config.bufferline")
--     },
--     {
--         "stevearc/dressing.nvim",
--         config = lazy_config "config.dressing",
--     },

--     -- Search
--     {
--         "ibhagwan/fzf-lua",
--         -- optional for icon support
--         dependencies = { "kyazdani42/nvim-web-devicons" },
--         config = lazy_config("config.fzf-lua"),
--     },
--     {
--         "unblevable/quick-scope",
--         config = lazy_config("config.quick-scope")
--     },
--     --  {
--     --     "phaazon/hop.nvim",
--     -- config = config("config.hop")

--     -- }
--     {
--         "ThePrimeagen/harpoon",
--         config = lazy_config("config.harpoon"),
--     },

--     -- Syntax Highlight
--     {
--         "nvim-treesitter/nvim-treesitter",
--         config = lazy_config "config.treesitter",
--         build = ":TSUpdate"
--     },
--     {
--         "nvim-treesitter/nvim-treesitter-context",
--     },
--     {
--         'm-demare/hlargs.nvim',
--         dependencies = { 'nvim-treesitter/nvim-treesitter' },
--         config = lazy_config "config.hlargs",
--     },
--     {
--         'kevinhwang91/nvim-ufo',
--         dependencies = 'kevinhwang91/promise-async',
--         config = lazy_config "config.nvim-ufo",
--     },
--     {
--         "ron-rs/ron.vim"
--     },

--     -- Coding
--     {
--         "williamboman/mason.nvim",
--         config = lazy_config "config.mason",
--     },
--     {
--         "williamboman/mason-lspconfig.nvim",
--         config = lazy_config "config.lsp.mason-lspconfig",
--     },
--     {
--         "neovim/nvim-lspconfig",
--         config = lazy_config "config.lsp",
--     },
--     {
--         "jose-elias-alvarez/null-ls.nvim",
--         dependencies = {
--             'nvim-lua/plenary.nvim',
--         },
--         config = lazy_config "config.null-ls",

--     },
--     --  {
--     --     -- No HTML support
--     --     "ur4ltz/surround.nvim",
--     --     config = require "config.surround"
--     -- }
--     "tpope/vim-commentary",
--     "tpope/vim-repeat",
--     --  "windwp/nvim-autopairs"
--     {
--         "echasnovski/mini.nvim",
--         config = lazy_config "config.mini-nvim",
--     },
--     {
--         'TimUntersberger/neogit',
--         dependencies = {
--             'nvim-lua/plenary.nvim',
--             'sindrets/diffview.nvim',
--         },
--         config = lazy_config "config.neogit",
--     },

--     -- Snippet engine
--     --  "hrsh7th/vim-vsnip"
--     {
--         "L3MON4D3/LuaSnip",
--         version = "1.*",
--         config = lazy_config "config.luasnip",
--     },

--     -- Completion framework
--     {
--         "hrsh7th/nvim-cmp",
--         config = lazy_config 'config.nvim-cmp',
--         -- LSP completion source for nvim-cmp
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/cmp-nvim-lsp-signature-help",
--         -- Snippet completion source for nvim-cmp
--         -- For vsnip rs.
--         "hrsh7th/cmp-vsnip",
--         -- For luasnip rs.
--         "saadparwaiz1/cmp_luasnip",
--         -- Other full completion sources
--         "hrsh7th/cmp-path",
--         "hrsh7th/cmp-buffer",
--     },
--     -- Language Specific
--     {
--         "simrat39/rust-tools.nvim",
--         config = lazy_config "config.rust-tools",
--         dependencies = {
--             "neovim/nvim-lspconfig",
--         },
--     },
--     {
--         "saecki/crates.nvim",
--         dependencies = { 'nvim-lua/plenary.nvim' },
--         config = lazy_config "config.crates",
--         -- event = { "BufRead Cargo.toml" },
--         -- ft = { "rust", "toml" },
--     },

--     -- Themes
--     { "navarasu/onedark.nvim" },
--     { "rebelot/kanagawa.nvim" },
--     { "folke/tokyonight.nvim" },
--     {
--         "catppuccin/nvim",
--         name = "catppuccin",
--     },
-- }

-- local opts = {}


require("lazy").setup("mesuca.plugins")
-- require("lazy").setup(plugins)
