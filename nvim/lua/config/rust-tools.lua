if not require "lib.utils".has_module("rust-tools") then
    return
end
require('rust-tools').setup({})
