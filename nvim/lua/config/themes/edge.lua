-- local status_ok, edge = pcall(require, 'edge')
-- if not status_ok then
--     return
-- end


vim.cmd [[
try
  colorscheme edge
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

