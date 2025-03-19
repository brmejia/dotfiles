local autocmd = vim.api.nvim_create_autocmd

local mesuca_group = require("functions").user_cmdgroup

autocmd({
    "BufNewFile",
    "BufRead",
}, {
    group = mesuca_group,
    pattern = "*.typ",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "typst")
    end,
})

return {
    {
        "chomosuke/typst-preview.nvim",
        -- lazy = false, -- or ft = 'typst'
        ft = "typst", -- or ft = 'typst'
        version = "1.*",
        build = function()
            require("typst-preview").update()
        end,
        opts = {
            -- Setting this to 'always' will invert black and white in the preview
            -- Setting this to 'auto' will invert depending if the browser has enable
            -- dark mode
            -- Setting this to '{"rest": "<option>","image": "<option>"}' will apply
            -- your choice of color inversion to images and everything else
            -- separately. Only works with the tinymist binary.
            invert_colors = "auto",
        },
    },
}
