return {
    "cbochs/grapple.nvim",
    -- enable = false,
    dependencies = {
        { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    opts = {
        scope = "git", -- can also try "git_branch"
    },
    keys = function()
        local grapple = require("grapple")

        return {
            -- Toggle quick menu (equivalent to harpoon UI)
            {
                "<leader>hh",
                function()
                    grapple.toggle_tags()
                end,
                desc = "Grapple quick menu",
            },

            -- Telescope integration
            {
                "<leader>hH",
                function()
                    local telescope = require("telescope")
                    telescope.load_extension("grapple")
                    telescope.extensions.grapple.tags()
                end,
                desc = "Telescoped Grapple Tags",
            },

            -- Add file to Grapple
            {
                "<leader>ha",
                function()
                    grapple.toggle()
                end,
                desc = "Add file to Grapple",
            },

            -- Note: Grapple doesn't have terminal support like Harpoon
            -- You could integrate with toggleterm or remove this binding

            -- Select files by index
            {
                "<leader>hr",
                function()
                    grapple.select({ index = 1 })
                end,
                desc = "Open Grapple file 1",
            },
            {
                "<leader>he",
                function()
                    grapple.select({ index = 2 })
                end,
                desc = "Open Grapple file 2",
            },
            {
                "<leader>hw",
                function()
                    grapple.select({ index = 3 })
                end,
                desc = "Open Grapple file 3",
            },
            {
                "<leader>hq",
                function()
                    grapple.select({ index = 4 })
                end,
                desc = "Open Grapple file 4",
            },
        }
    end,
}
