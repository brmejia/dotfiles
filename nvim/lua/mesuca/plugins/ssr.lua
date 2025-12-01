return {
    "cshuaimin/ssr.nvim",
    -- Calling setup is optional.
    config = function()
        require("ssr").setup({
            border = "rounded",
            min_width = 80,
            min_height = 8,
            max_width = 150,
            max_height = 25,
            -- keymaps = {
            --     close = "q",
            --     next_match = "n",
            --     prev_match = "N",
            --     replace_confirm = "<cr>",
            --     replace_all = "<leader><cr>",
            -- },
        })

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")
            local leader_mappings = {
                {
                    "<leader>r",
                    function()
                        require("ssr").open()
                    end,
                    desc = "Structural Search/Replace",
                },
            }

            local opts = { mode = "x" }
            wk.add(leader_mappings, opts)
        end
    end,
}
