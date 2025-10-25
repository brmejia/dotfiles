return {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufRead Cargo.toml" },
    ft = { "rust", "toml" },
    opts = {
        lsp = {
            enabled = true,
            actions = true,
            completion = true,
            hover = true,
        },
        completion = {
            -- blink = {
            --     -- Use default configuration for blink
            -- },
            -- cmp = {
            --     -- cmp is used on stable branch
            --     enabled = False,
            -- },
        },
    },
}
