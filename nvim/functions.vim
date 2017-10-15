function! TrimSpaces()
    let save_cursor = getpos(".")
    " Eliminar líneas en blanco al final del documento
    :silent! %s#\($\n\s*\)\+\%$#\r#
    " Eliminar espacios en blanco al final de las líneas
    :silent! %s#\s\+$##e
    call setpos('.', save_cursor)
endfunction

au BufWritePre ** call TrimSpaces()

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

