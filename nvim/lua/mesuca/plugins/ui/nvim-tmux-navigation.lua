return {
    "alexghergh/nvim-tmux-navigation",
    enabled = false, -- Disabled because I'm currently using zellij
    opts = {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
            left = "<C-h>",
            down = "<C-j>",
            up = "<C-k>",
            right = "<C-l>",
            last_active = "<C-\\>",
            next = "<C-Space>",
        },
    },
}
