if not require "lib.utils".has_module("fzf-lua") then
    return
end

require 'fzf-lua'.setup {
    grep = {
        -- cmd = "rg",
    }
}


if require "lib.utils".has_module("which-key") then

    local wk = require "which-key"
    local leader_mappings = {
        f = {
            name = "Search",
            b = { ":FzfLua buffers<cr>", "Buffers" },
            f = { ":FzfLua grep_project<cr>", "RipGrep" },
            p = { ":FzfLua files<cr>", "Files" },
            m = { ":FzfLua keymaps<cr>", "Keymaps" },
        },
    }

    local opts = { prefix = '<leader>', }
    wk.register(leader_mappings, opts)


    local opts = { mode = "n", noremap = true, }
    wk.register({
        ["<C-p>"] = { ":FzfLua files<cr>", "Files" },
    }, opts)

end
