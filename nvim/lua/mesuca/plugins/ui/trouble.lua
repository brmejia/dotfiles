---@class trouble.Mode: trouble.Config,trouble.Section.spec
---@field desc? string
---@field sections? string[]
---
return {
    "folke/trouble.nvim",
    -- enabled = false,
    cmd = "Trouble",
    ---@class trouble.Config
    ---@field mode? string
    ---@field config? fun(opts:trouble.Config)
    ---@field formatters? table<string,trouble.Formatter> custom formatters
    ---@field filters? table<string, trouble.FilterFn> custom filters
    ---@field sorters? table<string, trouble.SorterFn> custom sorters
    ---@field modes? table<string, trouble.Mode>
    opts = {
        auto_close = true, -- auto close when there are no items
        follow = false, -- Follow the current item
        modes = {
            -- Create a new mode that shows only the most severe diagnostics.
            -- Once those are resolved, less severe diagnostics will be shown.
            diagnostics_cascade = {
                desc = "Diagnostics Cascade",
                mode = "diagnostics", -- inherit from diagnostics mode
                filter = function(items)
                    local severity = vim.diagnostic.severity.HINT
                    for _, item in ipairs(items) do
                        severity = math.min(severity, item.severity)
                    end
                    return vim.tbl_filter(function(item)
                        return item.severity == severity
                    end, items)
                end,
            },
            -- more advanced example that extends the lsp_document_symbols
            custom_lsp_symbols = {
                desc = "Trouble Symbols",
                mode = "lsp_document_symbols",
                focus = false,
                win = { position = "right", size = { width = 0.3 } },
                filter = {
                    -- remove Package since luals uses it for control flow structures
                    ["not"] = {
                        any = {
                            { ft = "lua", kind = "Package" },
                        },
                    },
                    any = {
                        -- The symbol kind for Impl blocks in Rust is Object
                        { ft = "rust", kind = "Object" },
                        -- all symbol kinds for help / markdown files
                        ft = { "help", "markdown" },
                        -- -- default set of symbol kinds
                        kind = {
                            "Class",
                            "Constructor",
                            "Enum",
                            "Field",
                            "Function",
                            "Interface",
                            "Method",
                            "Module",
                            "Namespace",
                            "Package",
                            "Property",
                            "Struct",
                            "Trait",
                        },
                    },
                },
            },
        },
    },
}
