return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        {
            "<leader>R",
            function()
                return require("refactoring").select_refactor()
            end,
            mode = { "n", "x" },
            desc = "Refactoring",
        },
    },
}
