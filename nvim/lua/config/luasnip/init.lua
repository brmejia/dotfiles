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
		s = { ":source ~/.dotfiles/nvim/lua/config/luasnip/init.lua", "Reload LuaSnip" },
	}

	local double_leader_opts = { prefix = '<leader><leader>', }
	wk.register(double_leader_mappings, double_leader_opts)

end

-- Shorten function name
local keymap = require "lib.utils".keymap

keymap({ "i", "s" }, "<C-l>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, {
	silent = true
})
keymap({ "i", "s" }, "<C-h>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, {
	silent = true
})
keymap({ "i" }, "<C-j>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
keymap({ "i" }, "<C-k>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

require("luasnip.loaders.from_lua").load({
	paths = "./lua/config/luasnip/snippets",
})


-- local onedark = require("onedark")

-- vim.notify(onedark.colors.bg)
