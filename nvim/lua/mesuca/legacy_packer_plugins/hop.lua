if not require("lib.utils").has_module("hop") then
    return
end

-- you can configure Hop the way you like here; see :h hop-config
require("hop").setup({
    keys = "etovxqpdygfblzhckisuran",
})

-- if require "lib.utils".has_module("which-key") then

--     local wk = require "which-key"
--     local leader_mappings = {
--         h = {
--             name = "Hop!",
--             h = { ":HopWord <cr>", "Words" },
--             w = { ":HopWord <cr>", "Words" },
--             c = { ":HopChar1 <cr>", "Chars" },
--             p = { ":HopPattern <cr>", "Pattern" },
--         },
--     }

--     local opts = { prefix = '<leader>', }
--     wk.register(leader_mappings, opts)

-- end
