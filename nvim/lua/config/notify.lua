if not require "lib.utils".has_module("notify") then
    return
end

local notify = require('notify')

vim.notify = notify

notify.setup({
    render = "compact",
    -- timeout = 7000,
})
