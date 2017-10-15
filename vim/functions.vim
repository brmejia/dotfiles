function! TrimSpaces()
    let save_cursor = getpos(".")
    " Eliminar líneas en blanco al final del documento
    :silent! %s#\($\n\s*\)\+\%$#\r#
    " Eliminar espacios en blanco al final de las líneas
    :silent! %s#\s\+$##e
    call setpos('.', save_cursor)
endfunction

au BufWritePre ** call TrimSpaces()

