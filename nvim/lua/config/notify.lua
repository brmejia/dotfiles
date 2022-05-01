if not require "lib.utils".has_module("notify") then
    return
end

vim.notify = require('notify')
