if not require "lib.utils".has_module("telescope") then
    return
end

local telescope = require "telescope"


telescope.setup(
    {
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {
                    -- even more opts
                }

                -- pseudo code / specification for writing custom displays, like the one
                -- for "codeactions"
                -- specific_opts = {
                --   [kind] = {
                --     make_indexed = function(items) -> indexed_items, width,
                --     make_displayer = function(widths) -> displayer
                --     make_display = function(displayer) -> function(e)
                --     make_ordinal = function(e) -> string
                --   },
                --   -- for example to disable the custom builtin "codeactions" display
                --      do the following
                --   codeactions = false,
                -- }
            }
        }
    }
)
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")


if require "lib.utils".has_module("which-key") then
    local wk = require "which-key"
    local tbuiltin = require "telescope.builtin"

    local leader_mappings = {
        f = {
            name = "Search",
            b = { tbuiltin.buffers, "Buffers" },
            f = { tbuiltin.live_grep, "RipGrep" },
            p = { tbuiltin.find_files, "Files" },
            m = { tbuiltin.keymaps, "Keymaps" },
            h = { tbuiltin.help_tags, "Help Tags" },
        },
    }

    local opts = { prefix = '<leader>', }
    wk.register(leader_mappings, opts)


    local opts = { mode = "n", noremap = true, }
    wk.register({
        ["<C-p>"] = { tbuiltin.find_files, "Files" },
    }, opts)
end
