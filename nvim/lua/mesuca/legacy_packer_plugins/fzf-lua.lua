if not require("lib.utils").has_module("fzf-lua") then
    return
end

require("fzf-lua").setup({
    grep = {
        -- cmd = "rg",
    },
})

if require("lib.utils").has_module("which-key") then
    local wk = require("which-key")
    local leader_mappings = {
        { "<leader>f", mode="n", group = "Search" },
        { "<leader>fb", ":FzfLua buffers<cr>", desc = "Buffers" },
        { "<leader>ff", ":FzfLua grep_project<cr>", desc = "RipGrep" },
        { "<leader>fp", ":FzfLua files<cr>", desc = "Files" },
        { "<leader>fm", ":FzfLua keymaps<cr>", desc = "Keymaps" },
        { "<leader>fh", ":FzfLua help_tags<cr>", desc = "Help Tags" },
    }

    wk.add(leader_mappings)

    local opts = { mode = "n", noremap = true }
    wk.add({
        {["<C-p>"] ,  ":FzfLua files<cr>", desc="Files" },
    }, opts)
end
