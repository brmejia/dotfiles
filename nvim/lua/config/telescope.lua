if not require "lib.utils".has_module("telescope") then
    return
end

local telescope = require "telescope"


telescope.setup()


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
