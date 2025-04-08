local kind_icons = require("lib.utils").kind_icons
return {
    {

        "saghen/blink.cmp",
        -- enabled = false,
        -- optional: provides snippets for the snippet source
        dependencies = {
            {
                -- add blink.compat
                "saghen/blink.compat",
                -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
                version = "*",
                -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
                lazy = true,
                -- make sure to set opts so that lazy.nvim calls blink.compat's setup
                opts = {},
            },
            "rafamadriz/friendly-snippets",
            "Exafunction/codeium.nvim",
        },

        -- use a release tag to download pre-built binaries
        version = "1.*",
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = "enter" },

            signature = {
                enabled = false,
            },
            completion = {
                list = { selection = { preselect = true, auto_insert = false } },
                ghost_text = { enabled = true },
                menu = {
                    border = "rounded",
                    draw = {
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    local icon = ctx.kind_icon

                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    else
                                        if kind_icons[ctx.kind] then
                                            icon = kind_icons[ctx.kind]
                                        end
                                    end

                                    return icon .. ctx.icon_gap
                                end,

                                -- Optionally, use the highlight groups from nvim-web-devicons
                                -- You can also add the same function for `kind.highlight` if you want to
                                -- keep the highlight groups in sync with the icons.
                                highlight = function(ctx)
                                    local hl = ctx.kind_hl
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            hl = dev_hl
                                        end
                                    end
                                    return hl
                                end,
                            },
                        },
                    },
                },
                documentation = { auto_show = true, window = { border = "rounded" } },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            --
            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "codeium",
                    "buffer",
                },
                providers = {
                    codeium = {
                        name = "codeium",
                        module = "blink.compat.source",
                        async = true,
                        transform_items = function(ctx, items)
                            for _, item in ipairs(items) do
                                item.kind_icon = kind_icons.Codeium
                                item.kind_name = "Codeium"
                            end
                            return items
                        end,
                    },
                },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
