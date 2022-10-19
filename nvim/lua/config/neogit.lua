if not require "lib.utils".has_module("neogit") then
    return
end

local neogit = require "neogit"

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
        diffview = true
    },
    -- Setting any section to `false` will make the section not render at all
    sections = {
        untracked = {
            folded = true
        },
        unstaged = {
            folded = false
        },
        staged = {
            folded = false
        },
        stashes = {
            folded = true
        },
        unpulled = {
            folded = true
        },
        unmerged = {
            folded = false
        },
        recent = {
            folded = true
        },
    },
})


if require "lib.utils".has_module("which-key") then

    local wk = require "which-key"
    local leader_mappings = {
        g = {
            name = "Git",
            S = { function()
                neogit.open()
            end, "Current buffer" },
            s = { function()
                neogit.open({ cwd = vim.fn.expand("%:p:h") })
            end, "Working directory" },
        },
    }

    local opts = { prefix = '<leader>', }
    wk.register(leader_mappings, opts)
end
