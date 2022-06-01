-- if not require"lib.utils".has_module("quickscope") then
--     return
-- end

vim.cmd([[
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
]])
