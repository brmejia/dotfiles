function TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$#\r#
    call setpos('.', save_cursor)
endfunction

au BufWritePre ** call TrimEndLines()

