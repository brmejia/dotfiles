return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gs = require("gitsigns")

        gs.setup({
            signs = {
                add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change = {
                    hl = "GitSignsChange",
                    text = "▎",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn",
                },
                delete = {
                    hl = "GitSignsDelete",
                    text = "󰦺",
                    -- text = "_",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                },
                topdelete = {
                    hl = "GitSignsDelete",
                    text = "󰧆",
                    -- text = "‾",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                },
                changedelete = {
                    hl = "GitSignsChange",
                    text = "▎",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn",
                },
                untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            },
        })

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")
            local leader_mappings = {
                g = {
                    name = "Git",
                    B = { ":Gitsigns toggle_current_line_blame<cr>", "Toggle blame" },
                    H = { ":Gitsigns setqflist<cr>", "Hunk Quickfix" },
                    h = { ":Gitsigns preview_hunk<cr>", "Hunk preview" },
                    r = { ":Gitsigns reset_hunk<cr>", "Reset hunk" },
                    p = { ":Gitsigns prev_hunk<cr>zz", "Previous Hunk" },
                    n = { ":Gitsigns next_hunk<cr>zz", "Next Hunk" },
                },
            }

            local opts = { prefix = "<leader>" }
            wk.register(leader_mappings, opts)
        end
    end,
}
