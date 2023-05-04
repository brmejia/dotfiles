if not require "lib.utils".has_module("null-ls") then
    return
end

local null_ls = require "null-ls"

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.tags,
    },
})
