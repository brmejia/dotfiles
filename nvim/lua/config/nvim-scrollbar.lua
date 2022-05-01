if not require"lib.utils".has_module("scrollbar") then
    return
end

require("scrollbar").setup({
    handlers = {
        diagnostic = true,
        search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
    },
})
