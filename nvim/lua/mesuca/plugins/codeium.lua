local keymap = require("lib.utils").keymap

return {
    {
        "Exafunction/codeium.nvim",
        -- enabled = false,
        -- event = "InsertEnter",
        event = "BufEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "hrsh7th/nvim-cmp",
        },
        config = function()
            -- vim.g.codeium_manual = true

            vim.g.codeium_filetypes = {
                TelescopePrompt = false,
                ["neo-tree"] = false,
                harpoon = false,
                grapple = false,
            }

            -- vim.g.codeium_disable_bindings = true

            -- -- Change '<C-g>' here to any keycode you like.
            -- keymap("i", "<Right>", function()
            --     return vim.fn["codeium#Accept"]()
            -- end, { expr = true, silent = true })
            -- keymap("i", "<Left>", function()
            --     return vim.fn["codeium#Clear"]()
            -- end, { expr = true, silent = true })
            --
            -- keymap("i", "<C-n>", function()
            --     return vim.fn["codeium#CycleCompletions"](1)
            -- end, { expr = true, silent = true })
            -- keymap("i", "<C-p>", function()
            --     return vim.fn["codeium#CycleCompletions"](-1)
            -- end, { expr = true, silent = true })

            require("codeium").setup({})
        end,
    },
}
