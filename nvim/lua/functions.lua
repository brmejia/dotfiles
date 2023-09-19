vim.cmd([[

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>


]])

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local mesuca_group = augroup("MesucaGroup", { clear = true })

-- Don't auto commenting new lines
-- autocmd('BufEnter', {
--     pattern = '',
--     command = 'set fo-=c fo-=r fo-=o'
-- })

autocmd("TextYankPost", {
    group = mesuca_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 100,
        })
    end,
})

return {
    user_cmdgroup = mesuca_group,
}
