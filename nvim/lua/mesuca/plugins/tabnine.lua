return {
    "codota/tabnine-nvim",
    enabled = false,
    build = "./dl_binaries.sh",
    opts = {
        disable_auto_comment = true,
        accept_keymap = "<Right>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        -- suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt", "neo-tree", "harpoon" },
    },
    config = function(_, opts)
        require("tabnine").setup(opts)
    end,
}
