return {
    "L3MON4D3/LuaSnip",
    -- enabled = false,
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = { "InsertEnter", "CmdlineEnter" },
    keys = {
        {
            "<leader><leader>s",
            function()
                require("luasnip.loaders.from_lua").lazy_load({
                    paths = { "./lua/mesuca/plugins/luasnip/snippets/lua/" },
                })
            end,
            desc = "Reload LuaSnip [keymap]",
        },
        {
            "<C-l>",
            function()
                local ls = require("luasnip")
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end,
            mode = { "i", "s" },
            desc = "Expand or jump",
            silent = true,
        },
        {
            "<C-h>",
            function()
                local ls = require("luasnip")
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end,
            mode = { "i", "s" },
            desc = "Jump",
            silent = true,
        },
        {
            "<C-j>",
            function()
                local ls = require("luasnip")
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end,
            mode = "i",
            desc = "Next choice",
            silent = true,
        },
        {
            "<C-k>",
            function()
                local ls = require("luasnip")
                -- vim.notify("[LUASNIP] ls.choice_active() = " .. vim.inspect(ls.choice_active()))
                if ls.choice_active() then
                    ls.change_choice(-1)
                end
            end,
            mode = "i",
            desc = "Previous choice",
            silent = true,
        },
    },
    config = function()
        local ls = require("luasnip")

        ls.setup({
            updateevents = "TextChanged,TextChangedI",
        })

        -- Load snippets on plugin initialization
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { "./lua/mesuca/plugins/luasnip/snippets/lua/" },
        })
    end,
}
