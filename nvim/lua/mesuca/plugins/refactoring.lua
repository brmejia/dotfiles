return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local keymap = require("lib.utils").keymap
        local telescope = require("telescope")

        -- load refactoring Telescope extension
        telescope.load_extension("refactoring")

        keymap({ "n", "x" }, "<leader>rr", telescope.extensions.refactoring.refactors, { desc = "Refactoring" })

        require("refactoring").setup()
    end,
}
