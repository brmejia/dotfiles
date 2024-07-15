return {
    "brneor/gitui.nvim",
    config = function()
        local gitui = require("gitui")

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")
            local leader_mappings = {
                { "<leader>g", group = "Git" },
                {
                    "<leader>u",
                    function()
                        gitui.gitui()
                    end,
                    desc = "Working directory",
                },
                {
                    "<leader>U",
                    function()
                        gitui.gituiconfig()
                    end,
                    desc = "GitUI Config file",
                },
            }

            local opts = { prefix = "<leader>" }
            wk.add(leader_mappings, opts)
        end
    end,
}
