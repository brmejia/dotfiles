local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")

    -- UX / UI
    use({
        "rcarriga/nvim-notify",
        config = require("config.notify"),
    })
    use({
        "alexghergh/nvim-tmux-navigation",
        config = require("config.nvim-tmux-navigation"),
    })
    use({
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = require("config.telescope"),
    })
    use({
        "nvim-telescope/telescope-ui-select.nvim",
        requires = { { "nvim-telescope/telescope.nvim" } },
    })
    use({ "nvim-lualine/lualine.nvim", config = require("config.lualine") })
    use({
        "goolord/alpha-nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = require("config.alpha"),
    })
    use({
        "folke/which-key.nvim",
        config = require("config.which-key"),
    })
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = require("config.trouble"),
    })
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        config = require("config.nvim-tree"),
    })
    -- use {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     branch = "v2.x",
    --     requires = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    --         "MunifTanjim/nui.nvim",
    --     },
    --     config = function()
    --         vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    --     end,
    -- }
    use({
        "kevinhwang91/nvim-hlslens",
        config = require("config.hlslens"),
    })
    use({
        "petertriho/nvim-scrollbar",
        requires = { "kevinhwang91/nvim-hlslens" },
        config = require("config.nvim-scrollbar"),
    })
    use({
        "lewis6991/gitsigns.nvim",
        config = require("config.gitsigns"),
    })
    use({
        "akinsho/bufferline.nvim",
        tag = "*",
        requires = "kyazdani42/nvim-web-devicons",
        config = require("config.bufferline"),
    })
    use({
        "stevearc/dressing.nvim",
        config = require("config.dressing"),
    })
    -- lazy.nvim
    use({
        "folke/noice.nvim",
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = require("config.noice"),
    })

    -- Search
    -- use { "ibhagwan/fzf-lua",
    --     -- optional for icon support
    --     requires = { "kyazdani42/nvim-web-devicons" },
    --     config = require("config.fzf-lua"),
    -- }
    use({
        "unblevable/quick-scope",
        config = require("config.quick-scope"),
    })
    -- use {
    --     "phaazon/hop.nvim",
    --     config = require("config.hop")

    -- }
    use({
        "ThePrimeagen/harpoon",
        config = require("config.harpoon"),
    })

    -- Syntax Highlight
    use({
        "nvim-treesitter/nvim-treesitter",
        config = require("config.treesitter"),
        run = ":TSUpdate",
    })
    use({
        "nvim-treesitter/nvim-treesitter-context",
    })
    use({
        "m-demare/hlargs.nvim",
        requires = { "nvim-treesitter/nvim-treesitter" },
        config = require("config.hlargs"),
    })
    use({
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
        config = require("config.nvim-ufo"),
    })
    use({
        "ron-rs/ron.vim",
    })

    -- Coding
    use({
        "williamboman/mason.nvim",
        config = require("config.mason"),
    })
    use({
        "williamboman/mason-lspconfig.nvim",
        config = require("config.lsp.mason-lspconfig"),
    })
    use({
        "neovim/nvim-lspconfig",
        config = require("config.lsp"),
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = require("config.null-ls"),
    })
    -- use {
    --     -- No HTML support
    --     "ur4ltz/surround.nvim",
    --     config = require "config.surround"
    -- }
    use("tpope/vim-commentary")
    use("tpope/vim-repeat")
    -- use "windwp/nvim-autopairs"
    use({
        "echasnovski/mini.nvim",
        config = require("config.mini-nvim"),
    })
    use({
        "TimUntersberger/neogit",
        requires = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        },
        config = require("config.neogit"),
    })

    -- Snippet engine
    -- use "hrsh7th/vim-vsnip"
    use({
        "L3MON4D3/LuaSnip",
        tag = "v<CurrentMajor>.*",
        config = require("config.luasnip"),
    })

    -- Completion framework
    use({
        "hrsh7th/nvim-cmp",
        config = require("config.nvim-cmp"),
        -- LSP completion source for nvim-cmp
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        -- Snippet completion source for nvim-cmp
        -- For vsnip users.
        "hrsh7th/cmp-vsnip",
        -- For luasnip users.
        "saadparwaiz1/cmp_luasnip",
        -- Other usefull completion sources
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
    })
    -- Language Specific
    use({
        "simrat39/rust-tools.nvim",
        config = require("config.rust-tools"),
        requires = {
            "neovim/nvim-lspconfig",
        },
    })
    use({
        "saecki/crates.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = require("config.crates"),
        -- event = { "BufRead Cargo.toml" },
        -- ft = { "rust", "toml" },
    })

    -- Themes
    use({ "navarasu/onedark.nvim" })
    use({ "rebelot/kanagawa.nvim" })
    use({ "folke/tokyonight.nvim" })
    use({ "catppuccin/nvim", as = "catppuccin" })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if Packer_bootstrap then
        require("packer").sync()
    end
end)
