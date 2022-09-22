local status_ok, ts = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

ts.setup {
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
        'vue',
        'rust',
        'cpp',
        'bash',
        'clojure',
        'rst',
        'css',
        'yaml',
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
}

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
