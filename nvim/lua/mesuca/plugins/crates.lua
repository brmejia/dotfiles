return {
    "saecki/crates.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local crates = require("crates")
        crates.setup {
            null_ls = {
                enabled = true,
                name = "crates",
            },
        }


        if require "lib.utils".has_module("null-ls") then
            local cmp = require("cmp")

            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
                pattern = "Cargo.toml",
                callback = function()
                    cmp.setup.buffer({ sources = { { name = "crates" } } })
                end,
            })
        end
    end,
    -- event = { "BufRead Cargo.toml" },
    ft = { "rust", "toml" },
}
