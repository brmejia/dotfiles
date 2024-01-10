return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    -- enabled = false,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = {
        -- ensure_installed = 'maintained', -- one of 'all', 'maintained' (parsers with maintainers), or a list of languages
        ensure_installed = {
            "python",
            "jsonc",
            "typescript",
            "json",
            "lua",
            "javascript",
            "toml",
            "regex",
            "jsdoc",
            -- "comment",
            "query",
            "verilog",
            "html",
            "htmldjango",
            "vue",
            "rust",
            "cpp",
            "bash",
            "clojure",
            "rst",
            "css",
            "yaml",
            "vim",
            "markdown",
            "markdown_inline",
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
        },

        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["aa"] = { query = "@parameter.outer", desc = "Select a argument/parameter" },
                    ["ia"] = { query = "@parameter.inner", desc = "Select inside a argument/parameter" },
                    ["af"] = { query = "@function.outer", desc = "Select a function" },
                    ["if"] = { query = "@function.inner", desc = "Select inside a function" },
                    ["ac"] = { query = "@class.outer", desc = "Select a struct/class" },
                    ["ic"] = { query = "@class.inner", desc = "Select inside a struct/class" },
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@parameter.inner"] = "v", -- charwise
                    ["@function.outer"] = "V", -- linewise
                    ["@function.inner"] = "V", -- linewise
                    ["@class.outer"] = "<c-v>", -- blockwise
                    ["@class.inner"] = "<c-v>", -- blockwise
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>sa"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>sA"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = { query = "@class.outer", desc = "Next class start" },
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
                -- Below will go to either the start or the end, whichever is closer.
                -- Use if you want more granular movements
                -- Make it even more gradual by adding multiple queries and regex.
                goto_next = {
                    ["]d"] = "@conditional.outer",
                },
                goto_previous = {
                    ["[d"] = "@conditional.outer",
                },
            },
        },
    },
    config = function(_, opts)
        local treesitter_config = require("nvim-treesitter.configs")

        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- Repeat movement with ; and , ensure ;
        -- goes forward and , goes backward regardless of the last direction
        vim.keymap.set({ "n", "x", "o" }, ";", function()
            ts_repeat_move.repeat_last_move_next()
            vim.cmd("norm! zz")
        end)
        vim.keymap.set({ "n", "x", "o" }, ",", function()
            ts_repeat_move.repeat_last_move_previous()
            vim.cmd("norm! zz")
        end)
        treesitter_config.setup(opts)
    end,
}

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
