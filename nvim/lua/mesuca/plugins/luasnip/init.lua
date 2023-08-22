return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local ls = require("luasnip")

        ls.config.set_config({
            update_events = "TextChanged,TextChangedI",
        })

        function lazy_load_snippets()
            require("luasnip.loaders.from_lua").lazy_load({
                paths = { "./lua/mesuca/plugins/luasnip/snippets/lua/" },
            })
            require("luasnip.loaders.from_vscode").lazy_load()
        end

        if require("lib.utils").has_module("which-key") then
            local wk = require("which-key")

            local double_leader_mappings = {
                -- s = { ":source ~/.dotfiles/nvim/lua/config/luasnip/init.lua<cr>", "Reload LuaSnip" },
                s = { lazy_load_snippets, "Reload LuaSnip" },
            }

            local double_leader_opts = { prefix = "<leader><leader>" }
            wk.register(double_leader_mappings, double_leader_opts)
        end

        -- Shorten function name
        local keymap = require("lib.utils").keymap

        keymap({ "i", "s" }, "<C-l>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, {
            silent = true,
        })
        keymap({ "i", "s" }, "<C-h>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, {
            silent = true,
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

        lazy_load_snippets()
    end,
}
