return {
    {
        "coffebar/neovim-project",
        lazy = false,
        priority = 100,
        opts = {
            projects = { -- define project roots
                "~/dev*/*",
                "~/dev*/serv*/*",
                "~/.dotfiles",
                "~/.config/*",
            },
            -- Path to store history and sessions
            datapath = vim.fn.stdpath("state"), -- ~/.local/share/nvim/
            picker = {
                type = "snacks", -- one of "telescope", "fzf-lua", or "snacks"
            },
        },
        init = function()
            -- enable saving the state of plugins in the session
            vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
        end,
        dependencies = {
            { "Shatur/neovim-session-manager" },
            { "nvim-lua/plenary.nvim" },
            -- -- optional picker
            -- { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
            -- optional picker
            -- { "ibhagwan/fzf-lua" },
            -- optional picker
            { "folke/snacks.nvim" },
        },
        keys = {
            {
                "<leader>fp",
                ":NeovimProjectHistory<CR>",
                desc = "Projects",
            },
        },
    },
}
