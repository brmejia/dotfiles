return {
    "L3MON4D3/LuaSnip",
    -- enabled = false,
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local ls = require("luasnip")

        ls.setup({
            updateevents = "TextChanged,TextChangedI",
        })

        function lazy_load_snippets()
            require("luasnip.loaders.from_lua").lazy_load({
                -- Paths relative to neovim config directory
                paths = { "./lua/mesuca/plugins/luasnip/snippets/lua/" },
            })
        end

        -- Shorten function name
        local keymap = require("lib.utils").keymap

        keymap("n", "<leader><leader>s", lazy_load_snippets, { desc = "Reload LuaSnip [keymap]" })
        keymap({ "i", "s" }, "<C-l>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, {
            desc = "Expand or jump",
            silent = true,
        })
        keymap({ "i", "s" }, "<C-h>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, {
            desc = "Jump",
            silent = true,
        })
        keymap({ "i" }, "<C-j>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {
            desc = "Next choice",
        })
        keymap({ "i" }, "<C-k>", function()
            if ls.choice_active() then
                ls.change_choice(-1)
            end
        end, {
            desc = "Previous choice",
        })

        lazy_load_snippets()
    end,
}
