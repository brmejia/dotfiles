return {
    "nvim-treesitter/nvim-treesitter",
    -- event = { 'BufReadPost' },
    enabled = true,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
        local treesitter_config = require 'nvim-treesitter.configs'

        return treesitter_config.setup({
            -- ensure_installed = 'maintained', -- one of 'all', 'maintained' (parsers with maintainers), or a list of languages
            ensure_installed = {
                'python',
                'jsonc',
                'typescript',
                'json',
                'lua',
                'javascript',
                'toml',
                'regex',
                'jsdoc',
                'comment',
                'query',
                'verilog',
                'html',
                'htmldjango',
                'vue',
                'rust',
                'cpp',
                'bash',
                'clojure',
                'rst',
                'css',
                'yaml',
                'vim',
                'markdown',
                'markdown_inline',
                "kdl",
                "ron",
            },

            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,

            },

            incremental_selection = {
                enable = true,
            },

            indent = {
                enable = true,
            }
        })
    end
}

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
