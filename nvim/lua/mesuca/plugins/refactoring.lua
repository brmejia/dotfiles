return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local keymap = require("lib.utils").keymap

        keymap({ "n", "x" }, "<leader>R", require("refactoring").select_refactor, { desc = "Refactoring" })

        require("refactoring").setup()
    end,
}
