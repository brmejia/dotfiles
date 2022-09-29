-- local status_ok, onedark = pcall(require, 'onedark')
-- if not status_ok then
--     vim.notify("One dark is not ready yet")
--     return
-- end

require("onedark").setup {
    style = 'darker',

    -- toggle theme style ---
    toggle_style_key = '<leader>ts', -- Default keybinding to toggle
    toggle_style_list = {
        -- 'dark',
        'darker',
        'warmer',
        -- 'cool',
        -- 'deep',
        -- 'warm',
        -- 'light'
    }, -- List of styles to toggle between

    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = false, -- use background color for virtual text
    },
}


require("onedark").load()
