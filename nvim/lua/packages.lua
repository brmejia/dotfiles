local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- UX / UI
    use {
        'rcarriga/nvim-notify',
        config = require 'config.notify'
    }
    use { "alexghergh/nvim-tmux-navigation" }
    -- use 'feline-nvim/feline.nvim'
    use { 'nvim-lualine/lualine.nvim',
        config = require 'config.lualine',
    }
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }
    use {
        'folke/which-key.nvim',
        config = require 'config.which-key'
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        end
    }

    -- Search
    use { 'junegunn/fzf' }
    use { 'junegunn/fzf.vim' }

    -- Syntax Highlight
    use {
        'nvim-treesitter/nvim-treesitter',
        config = require 'config.treesitter',
        run = ':TSUpdate'
    }

    -- Coding
    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
        "tami5/lspsaga.nvim",
    }
    use {
        "ur4ltz/surround.nvim",
        config = require "config.surround"
    }
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    -- use "windwp/nvim-autopairs"
    use 'echasnovski/mini.nvim'

    -- Snippet engine
    use "hrsh7th/vim-vsnip"

    -- Completion framework
    use {
        "hrsh7th/nvim-cmp",
        -- LSP completion source for nvim-cmp
        "hrsh7th/cmp-nvim-lsp",
        -- Snippet completion source for nvim-cmp
        "hrsh7th/cmp-vsnip",
        -- Other usefull completion sources
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
    }
    -- Language Specific
    use { 'simrat39/rust-tools.nvim' }

    -- Themes
    use { 'navarasu/onedark.nvim' }

    -- use {
    --     'hood/popui.nvim' ,
    -- requires = { 'RishabhRD/popfix' },
    --     config = require "config.popui"
    -- }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
