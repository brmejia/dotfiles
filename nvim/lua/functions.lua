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

autocmd({ "BufWritePre" }, {
    group = mesuca_group,
    pattern = "*",
    callback = function()
        if not require("lib.utils").has_module("mini.trailspace") then
            vim.notify("mini.trailspace is not installed")
            return
        end

        require("mini.trailspace").trim()
    end,
})
