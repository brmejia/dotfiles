Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
set t_Co=256
