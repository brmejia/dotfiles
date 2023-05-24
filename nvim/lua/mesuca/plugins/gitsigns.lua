local local_config = function()
if not require "lib.utils".has_module("gitsigns") then
    return
end

local gs = require "gitsigns"

gs.setup({

    signs = {
        add          = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change       = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete       = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete    = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        untracked    = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    },
})

if require "lib.utils".has_module("which-key") then

    local wk = require "which-key"
    local leader_mappings = {
        g = {
            name = "Git",
            B = { ":Gitsigns toggle_current_line_blame<cr>", "Toggle blame" },
            H = { ":Gitsigns setqflist<cr>", "Hunk Quickfix" },
            h = { ":Gitsigns preview_hunk<cr>", "Hunk preview" },
            r = { ":Gitsigns reset_hunk<cr>", "Reset hunk" },
            p = { ":Gitsigns prev_hunk<cr>zz", "Previous Hunk" },
            n = { ":Gitsigns next_hunk<cr>zz", "Next Hunk" },
        }
    }

    local opts = { prefix = '<leader>', }
    wk.register(leader_mappings, opts)
end

-- -- Actions
--     map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
--     map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
--     map('n', '<leader>hS', gs.stage_buffer)
--     map('n', '<leader>hu', gs.undo_stage_hunk)
--     map('n', '<leader>hR', gs.reset_buffer)
--     map('n', '<leader>hp', gs.preview_hunk)
--     map('n', '<leader>hb', function() gs.blame_line{full=true} end)
--     map('n', '<leader>tb', gs.toggle_current_line_blame)
--     map('n', '<leader>hd', gs.diffthis)
--     map('n', '<leader>hD', function() gs.diffthis('~') end)
--     map('n', '<leader>td', gs.toggle_deleted)
--
end

return {
    "lewis6991/gitsigns.nvim",
    config = local_config,
}
