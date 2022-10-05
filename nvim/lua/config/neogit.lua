if not require "lib.utils".has_module("neogit") then
    return
end

local neogit = require "neogit"

neogit.setup({})


if require "lib.utils".has_module("which-key") then

    local wk = require "which-key"
    local leader_mappings = {
        g = {
            name = "Git",
            S = { function()
                neogit.open()
            end, "Current buffer" },
            s = { function()
                neogit.open({ cwd = vim.fn.expand("%:p:h") })
            end, "Working directory" },
        },
    }

    local opts = { prefix = '<leader>', }
    wk.register(leader_mappings, opts)
end
