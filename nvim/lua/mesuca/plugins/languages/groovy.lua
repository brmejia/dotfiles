local autocmd = vim.api.nvim_create_autocmd

local mesuca_group = require("functions").user_cmdgroup

autocmd("BufRead", {
    group = mesuca_group,
    pattern = "Jenkinsfile",
    callback = function()
        vim.bo.filetype = "groovy"
    end,
})

return {}
