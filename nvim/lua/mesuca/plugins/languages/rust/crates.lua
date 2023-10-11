return {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
        local crates = require("crates")

        if require("lib.utils").has_module("null-ls") then
            opts = vim.tbl_extend("keep", opts, {
                null_ls = {
                    enabled = true,
                    name = "crates",
                },
            })
        else
            vim.notify("Crates.nvim code actions require the package null-ls", vim.log.levels.WARN)
        end

        if require("lib.utils").has_module("cmp") then
            local cmp = require("cmp")

            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
                pattern = "Cargo.toml",
                callback = function()
                    local srcs = vim.tbl_deep_extend(
                        "keep",
                        cmp.config.sources(),
                        { sources = { { name = "crates", keyword_length = 0 } } }
                    )
                    cmp.setup.buffer(srcs)
                end,
            })

            opts = vim.tbl_extend("keep", opts, {
                src = {
                    cmp = {
                        enabled = true,
                    },
                },
            })
        end
        crates.setup(opts)
    end,
    -- event = { "BufRead Cargo.toml" },
    ft = { "rust", "toml" },
}
