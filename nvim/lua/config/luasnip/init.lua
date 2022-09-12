if not require "lib.utils".has_module("luasnip") then
    return
end

local ls = require "luasnip"

ls.config.set_config({
    update_events = 'TextChanged,TextChangedI',
})


if require "lib.utils".has_module("which-key") then

    local wk = require "which-key"

    local double_leader_mappings = {
        s = { ":source ~/.dotfiles/nvim/lua/config/luasnip/init.lua<cr>", "Reload LuaSnip" },
    }

    local double_leader_opts = { prefix = '<leader><leader>', }
    wk.register(double_leader_mappings, double_leader_opts)

end

require("luasnip.loaders.from_lua").load({
    paths = "./lua/config/luasnip/snippets",
})
