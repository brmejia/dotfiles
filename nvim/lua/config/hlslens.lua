if not require "lib.utils".has_module("hlslens") then
    return
end

local hlslens = require "hlslens"

vim.opt.hlsearch = true

hlslens.setup(
    {
        calm_down = true,
        nearest_only = true,
    }
)
