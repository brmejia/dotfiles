return {
    "folke/flash.nvim",
    -- enabled = false,
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        modes = {
            char = {
                enabled = true,
                -- Remove ; and , from flash's char mode
                -- keys = { "f", "F", "t", "T" }, -- Don't include ";" and ","
            },
            -- options used when flash is activated through
            -- a regular search with `/` or `?`
            search = {
                -- when `true`, flash will be activated during regular search by default.
                -- You can always toggle when searching with `require("flash").toggle()`
                enabled = false,
            },
        },
    },
  -- stylua: ignore
  keys = {
    { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<leader>fS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
