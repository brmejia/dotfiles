return {
    "brneor/gitui.nvim",
    config = function()
        local gitui = require("gitui")

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")
            local leader_mappings = {
                g = {
                    name = "Git",
                    u = {
                        function()
                            gitui.gitui()
                        end,
                        "Working directory",
                    },
                    U = {
                        function()
                            gitui.gituiconfig()
                        end,
                        "GitUI Config file",
                    },
                },
            }

            local opts = { prefix = "<leader>" }
            wk.register(leader_mappings, opts)
        end
    end,
}
