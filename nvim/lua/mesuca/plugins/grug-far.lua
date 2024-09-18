return {
    "MagicDuck/grug-far.nvim",
    enabled = false,
    opts = {
        -- ... options, see Configuration section below ...
        -- ... there are no required options atm...
        -- ... engine = 'ripgrep' is default, but 'astgrep' can be specified...
        engine = "astgrep",
    },
    config = function(opts)
        local keymap = require("lib.utils").keymap

        keymap("n", "<leader>sR", function()
            require("grug-far").grug_far({ engine = "astgrep" })
        end, { desc = "AST Grep" })

        require("grug-far").setup(opts)
    end,
}
