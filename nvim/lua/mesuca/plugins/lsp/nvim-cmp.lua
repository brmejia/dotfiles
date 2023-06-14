-- Setup nvim-cmp.
local kind_icons = require("lib.utils").kind_icons

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- LSP completion source for nvim-cmp
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        -- Snippet completion source for nvim-cmp
        -- -- For vsnip rs.
        -- "hrsh7th/cmp-vsnip",
        -- For luasnip rs.
        "saadparwaiz1/cmp_luasnip",
        -- Other full completion sources
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
    },
    opts = function()
        local cmp = require("cmp")
        return {
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = {
                -- ['<C-k>'] = cmp.mapping.select_prev_item(),
                -- ['<C-j>'] = cmp.mapping.select_next_item(),
                -- Add tab support
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({
                    -- behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            },
            -- LSP Sugestions formatting
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, item)
                    if kind_icons[item.kind] then
                        item.kind = string.format("%s", kind_icons[item.kind])
                        -- item.kind = kind_icons[item.kind] .. item.kind
                    end
                    -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                    item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snip]",
                        buffer = "[Buff]",
                        path = "[Path]",
                    })[entry.source.name]
                    return item
                end,
            },
            -- Enable LSP snippets
            snippet = {
                -- expand = function(args)
                --     vim.fn["vsnip#anonymous"](args.body) -- For vsnip users.
                -- end,

                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For luasnip users.
                end,
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp", keyword_length = 2 },
                { name = "nvim_lsp_signature_help" },
                -- { name = 'vsnip' }, -- For vsnip users.
                { name = "luasnip", keyword_length = 2 }, -- For luasnip users.
                { name = "path", keyword_length = 2 },
            }, {
                { name = "buffer", keyword_length = 3 },
            }),
        }
    end,
    config = function(_, opts)
        local cmp = require("cmp")
        cmp.setup(opts)

        -- Set configuration for specific filetype.
        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
                { name = "buffer" },
            }),
        })

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sourceh = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            sources = {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = {},
                    },
                },
            },
        })
    end,
}
