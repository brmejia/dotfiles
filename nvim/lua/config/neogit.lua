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
            s = { function()
                neogit.open()
            end, "Status" },
        },
    }

    local opts = { prefix = '<leader>', }
    wk.register(leader_mappings, opts)
end
