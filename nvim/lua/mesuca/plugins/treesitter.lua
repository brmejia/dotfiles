return {

    {
        "nvim-treesitter/nvim-treesitter",
        -- enabled = false,
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    -- Enable treesitter highlighting and disable regex syntax
                    pcall(vim.treesitter.start)
                    -- Enable treesitter-based indentation
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            local ensureInstalled = {
                "python",
                "typescript",
                "json",
                "lua",
                "javascript",
                "toml",
                "regex",
                "jsdoc",
                -- "comment",
                "query",
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
                "nu",
            }
            local alreadyInstalled = require("nvim-treesitter.config").get_installed()
            local parsersToInstall = vim.iter(ensureInstalled)
                :filter(function(parser)
                    return not vim.tbl_contains(alreadyInstalled, parser)
                end)
                :totable()
            require("nvim-treesitter").install(parsersToInstall)
        end,
        -- opts = {
        --     highlight = {
        --         enable = true,
        --     },
        --
        --     incremental_selection = {
        --         enable = true,
        --     },
        --
        --     indent = {
        --         enable = true,
        --     },
        -- },
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        -- enabled = false,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- enabled = false,
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "VeryLazy", -- Load the plugin
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true

            -- Or, disable per filetype (add as you like)
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        keys = function()
            -- local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
            local textobjects = require("nvim-treesitter-textobjects.select")

            -- Repeat movement with ; and , ensure ;
            -- goes forward and , goes backward regardless of the last direction
            return {
                {
                    "aa",
                    function()
                        textobjects.select_textobject("@parameter.outer", "textobjects")
                    end,
                    mode = { "x", "o" },
                    desc = "Select an argument/parameter",
                },
                {
                    "ia",
                    function()
                        textobjects.select_textobject("@parameter.inner", "textobjects")
                    end,
                    mode = { "x", "o" },
                    desc = "Select inside argument/parameter",
                },
                {
                    "am",
                    function()
                        textobjects.select_textobject("@function.outer", "textobjects")
                    end,
                    mode = { "x", "o" },
                    desc = "Select a function",
                },
                {
                    "im",
                    function()
                        textobjects.select_textobject("@function.inner", "textobjects")
                    end,
                    mode = { "x", "o" },
                    desc = "Select inside a function",
                },
                {
                    "ac",
                    function()
                        textobjects.select_textobject("@class.outer", "textobjects")
                    end,
                    mode = { "x", "o" },
                    desc = "Select a class",
                },
                {
                    "ic",
                    function()
                        textobjects.select_textobject("@class.inner", "textobjects")
                    end,
                    mode = { "x", "o" },
                    desc = "Select inside a class",
                },
                -- You can also use captures from other query groups like `locals.scm`
                {
                    "as",
                    function()
                        textobjects.select_textobject("@local.scope", "locals")
                    end,
                    mode = { "x", "o" },
                    desc = "Select an inner scope",
                },
                -- {
                --     ";",
                --     function()
                --         vim.notify("Repeat last move next", "info")
                --         ts_repeat_move.repeat_last_move_next()
                --     end,
                --     mode = { "n", "x", "o" },
                --     expr = true,
                --     desc = "Repeat last move next",
                -- },
                -- {
                --     ",",
                --     function()
                --         vim.notify("Repeat last move previous", "info")
                --         ts_repeat_move.repeat_last_move_previous()
                --         -- vim.cmd("norm! zz")
                --     end,
                --     mode = { "n", "x", "o" },
                --     desc = "Repeat last move previous",
                -- },

                -- {
                --     "f",
                --     mode = { "n", "x", "o" },
                --     function()
                --         local result = ts_repeat_move.builtin_f_expr()
                --         -- vim.cmd("norm! zz")
                --         return result
                --     end,
                --     desc = "Find char forward",
                -- },
                -- {
                --     "F",
                --     mode = { "n", "x", "o" },
                --     function()
                --         local result = ts_repeat_move.builtin_F_expr()
                --         -- vim.cmd("norm! zz")
                --         return result
                --     end,
                --     desc = "Find char backward",
                -- },
                -- {
                --     "t",
                --     mode = { "n", "x", "o" },
                --     function()
                --         local result = ts_repeat_move.builtin_t_expr()
                --         -- vim.cmd("norm! zz")
                --         return result
                --     end,
                --     desc = "Till char forward",
                -- },
                -- {
                --     "T",
                --     mode = { "n", "x", "o" },
                --     function()
                --         local result = ts_repeat_move.builtin_T_expr()
                --         -- vim.cmd("norm! zz")
                --         return result
                --     end,
                --     desc = "Till char backward",
                -- },
            }
        end,
        opts = {
            select = {
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

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
                    ["@class.outer"] = "V", -- blockwise
                    ["@class.inner"] = "V", -- blockwise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true of false
                include_surrounding_whitespace = false,
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>wa"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>wA"] = "@parameter.inner",
                },
            },
            -- move = {
            --     enable = true,
            --     set_jumps = true, -- whether to set jumps in the jumplist
            --     goto_next_start = {
            --         ["]m"] = "@function.outer",
            --         ["]]"] = { query = "@class.outer", desc = "Next class start" },
            --     },
            --     goto_next_end = {
            --         ["]M"] = "@function.outer",
            --         ["]["] = "@class.outer",
            --     },
            --     goto_previous_start = {
            --         ["[m"] = "@function.outer",
            --         ["[["] = "@class.outer",
            --     },
            --     goto_previous_end = {
            --         ["[M"] = "@function.outer",
            --         ["[]"] = "@class.outer",
            --     },
            --     -- Below will go to either the start or the end, whichever is closer.
            --     -- Use if you want more granular movements
            --     -- Make it even more gradual by adding multiple queries and regex.
            --     goto_next = {
            --         ["]d"] = "@conditional.outer",
            --     },
            --     goto_previous = {
            --         ["[d"] = "@conditional.outer",
            --     },
            -- },
        },
        -- config = function(_, opts)
        --     require("nvim-treesitter-textobjects").setup(opts)
        --
        --     -- local textobjects = require("nvim-treesitter-textobjects.select")
        --     -- -- -- keymaps
        --     -- -- -- You can use the capture groups defined in `textobjects.scm`
        --     -- vim.keymap.set({ "x", "o" }, "aa", function()
        --     --     textobjects.select_textobject("@parameter.outer", "textobjects")
        --     -- end, { desc = "Select an argument/parameter" })
        --     -- vim.keymap.set({ "x", "o" }, "ia", function()
        --     --     textobjects.select_textobject("@parameter.inner", "textobjects")
        --     -- end, { desc = "Select inside argument/parameter" })
        --     -- vim.keymap.set({ "x", "o" }, "am", function()
        --     --     textobjects.select_textobject("@function.outer", "textobjects")
        --     -- end, { desc = "Select a function" })
        --     -- vim.keymap.set({ "x", "o" }, "im", function()
        --     --     textobjects.select_textobject("@function.inner", "textobjects")
        --     -- end, { desc = "Select inside a function" })
        --     -- vim.keymap.set({ "x", "o" }, "ac", function()
        --     --     textobjects.select_textobject("@class.outer", "textobjects")
        --     -- end, { desc = "Select a class" })
        --     -- vim.keymap.set({ "x", "o" }, "ic", function()
        --     --     textobjects.select_textobject("@class.inner", "textobjects")
        --     -- end, { desc = "Select inside a class" })
        --     -- -- You can also use captures from other query groups like `locals.scm`
        --     -- vim.keymap.set({ "x", "o" }, "as", function()
        --     --     textobjects.select_textobject("@local.scope", "locals")
        --     -- end, { desc = "Select an inner scope" })
        -- end,
    },
}

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
