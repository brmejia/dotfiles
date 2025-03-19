-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require("oil").get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

return {
    "stevearc/oil.nvim",
    enabled = true,
    -- Optional dependencies
    dependencies = {
        { "echasnovski/mini.icons", opts = {} },
    },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = function()
        local keymap = require("lib.utils").keymap

        keymap("n", "-", ":Oil<cr>", { desc = "Reveal file in current split" })

        return {
            default_file_explorer = true,
            delete_to_trash = true,
            win_options = {
                winbar = "%!v:lua.get_oil_winbar()",
            },
            -- Set to true to watch the filesystem for changes and reload oil
            watch_for_changes = true,
            -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
            -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
            -- Additionally, if it is a string that matches "actions.<name>",
            -- it will use the mapping at require("oil.actions").<name>
            -- Set to `false` to remove a keymap
            -- See :help oil-actions for a list of all available actions
            keymaps = {
                ["<leader>s"] = { "actions.select", opts = { horizontal = true } },
                ["<leader>v"] = { "actions.select", opts = { vertical = true } },
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-j>"] = false,
                ["<C-k>"] = false,
                ["<C-l>"] = false,
                ["<C-t>"] = false,
                ["<C-p>"] = false,
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["<esc>"] = { "actions.close", mode = "n" },
                ["gr"] = { "actions.refresh", mode = "n" },
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["g."] = { "actions.cd", mode = "n" },
                ["~"] = false,
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["gh"] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
                --
                -- ["-"] = function()
                --     require("oil.actions").parent.callback()
                --     local currdir = require("oil").get_current_dir()
                --     vim.notify("Up: " .. currdir, "info")
                --     vim.cmd.lcd(currdir)
                -- end,
                -- ["<CR>"] = function()
                --     require("oil").select(nil, function(err)
                --         if not err then
                --             local curdir = require("oil").get_current_dir()
                --             if curdir then
                --                 vim.notify("Down: " .. curdir, "info")
                --                 vim.cmd.lcd(curdir)
                --             end
                --         end
                --     end)
                -- end,
            },
        }
    end,
}
