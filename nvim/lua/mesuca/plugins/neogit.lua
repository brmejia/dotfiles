return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
    },
    -- enabled = false,
    config = function()
        if not require("lib.utils").has_module("neogit") then
            return
        end

        local neogit = require("neogit")

        neogit.setup({
            integrations = {
                -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
                -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
                --
                -- Requires you to have `sindrets/diffview.nvim` installed.
                -- use {
                --   'TimUntersberger/neogit',
                --   requires = {
                --     'nvim-lua/plenary.nvim',
                --     'sindrets/diffview.nvim'
                --   }
                -- }
                --
                diffview = true,
            },
            signs = {
                -- { CLOSED, OPENED }
                section = { "", "" },
                item = { "", "" },
                hunk = { "", "" },
            },
            -- Setting any section to `false` will make the section not render at all
            sections = {
                untracked = {
                    folded = true,
                },
                unstaged = {
                    folded = false,
                },
                staged = {
                    folded = false,
                },
                stashes = {
                    folded = true,
                },
                unpulled_upstream = {
                    hidden = false,
                    folded = true,
                },
                unmerged_upstream = {
                    hidden = false,
                    folded = false,
                },
                recent = {
                    folded = true,
                },
            },
        })

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")
            local leader_mappings = {
                { "<leader>g", group = "Git" },
                {
                    "<leader>gS",
                    function()
                        neogit.open()
                    end,
                    desc = "Current buffer",
                },
                {
                    "<leader>gs",
                    function()
                        neogit.open({ cwd = vim.fn.expand("%:p:h") })
                    end,
                    desc = "Working directory",
                },
            }

            wk.add(leader_mappings)
        end
    end,
}
