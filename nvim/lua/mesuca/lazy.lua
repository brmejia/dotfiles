local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins_module = "mesuca.plugins"
require("lazy").setup({
    spec = {
        { import = plugins_module },
        { import = plugins_module .. ".languages" },
        { import = plugins_module .. ".languages.rust" },
        { import = plugins_module .. ".languages.typescript" },
        { import = plugins_module .. ".languages.typst" },
        { import = plugins_module .. ".lsp" },
        { import = plugins_module .. ".dap" },
        { import = plugins_module .. ".themes" },
        { import = plugins_module .. ".ui" },
    },
    -- install = { colorscheme = { "kanagawa" } },
})
