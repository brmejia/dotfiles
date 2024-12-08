return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gs = require("gitsigns")

        gs.setup({
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "󰦺" },
                topdelete = { text = "󰧆" },
                changedelete = { text = "▎" },
                untracked = { text = "┆" },
            },
        })

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")
            local leader_mappings = {
                { "<leader>g", group = "Git" },
                -- { "<leader>gB", ":Gitsigns toggle_current_line_blame<cr>", desc = "Toggle blame" },
                { "<leader>gH", ":Gitsigns setqflist<cr>", desc = "Hunk Quickfix" },
                { "<leader>gh", ":Gitsigns preview_hunk<cr>", desc = "Hunk preview" },
                { "<leader>gr", ":Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
                { "<leader>gp", ":Gitsigns prev_hunk<cr>zz", desc = "Previous Hunk" },
                { "<leader>gn", ":Gitsigns next_hunk<cr>zz", desc = "Next Hunk" },
            }

            wk.add(leader_mappings)
        end
    end,
}
