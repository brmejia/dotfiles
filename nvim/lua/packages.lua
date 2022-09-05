local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- UX / UI
    use {
        'rcarriga/nvim-notify',
        config = require 'config.notify'
    }
    use {
        "alexghergh/nvim-tmux-navigation",
        config = require 'config.nvim-tmux-navigation',
    }
    -- use 'feline-nvim/feline.nvim'
    use { 'nvim-lualine/lualine.nvim',
        config = require 'config.lualine',
    }
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require 'config.alpha',
    }
    use {
        'folke/which-key.nvim',
        config = require 'config.which-key',
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = require 'config.trouble',
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = require "config.nvim-tree",
    }
    use {
        'kevinhwang91/nvim-hlslens',
        config = require("config.hlslens")
    }
    use {
        "petertriho/nvim-scrollbar",
        requires = { 'kevinhwang91/nvim-hlslens' },
        config = require "config.nvim-scrollbar",
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = require "config.gitsigns",
    }
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = require("config.bufferline")
    }
    use {
        "stevearc/dressing.nvim",
        config = require "config.dressing",
    }

    -- Search
    -- use { 'junegunn/fzf' }
    -- use { 'junegunn/fzf.vim' }
    use { 'ibhagwan/fzf-lua',
        -- optional for icon support
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require("config.fzf-lua"),
    }
    use {
        'unblevable/quick-scope',
        config = require("config.quick-scope")
    }
    use {
        'phaazon/hop.nvim',
        config = require("config.hop")

    }
    -- Syntax Highlight
    use {
        'nvim-treesitter/nvim-treesitter',
        config = require 'config.treesitter',
        run = ':TSUpdate'
    }
    use {
        'nvim-treesitter/nvim-treesitter-context',
    }

    -- Coding
    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
        config = require "config.lsp",
    }
    -- use {
    --     -- No HTML support
    --     "ur4ltz/surround.nvim",
    --     config = require "config.surround"
    -- }
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    -- use "windwp/nvim-autopairs"
    use {
        'echasnovski/mini.nvim',
        config = require "config.mini-nvim",
    }

    -- Snippet engine
    use "hrsh7th/vim-vsnip"

    -- Completion framework
    use {
        "hrsh7th/nvim-cmp",
        config = require 'config.nvim-cmp',
        -- LSP completion source for nvim-cmp
        "hrsh7th/cmp-nvim-lsp",
        -- Snippet completion source for nvim-cmp
        "hrsh7th/cmp-vsnip",
        -- Other usefull completion sources
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
    }
    -- Language Specific
    use {
        'simrat39/rust-tools.nvim',
        config = require "config.rust-tools",
    }

    -- Themes
    use { 'navarasu/onedark.nvim' }
    use { "rebelot/kanagawa.nvim" }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if Packer_bootstrap then
        require('packer').sync()
    end
end)
