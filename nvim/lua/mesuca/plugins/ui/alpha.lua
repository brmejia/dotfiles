return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = function()
        return require("alpha.themes.startify").config
    end,
}
