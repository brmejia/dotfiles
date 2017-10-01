" Configuración de Colorschemes

Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'
Plug 'tomasr/molokai'
Plug 'jacoborus/tender'
Plug 'w0ng/vim-hybrid'
Plug 'tomasiser/vim-code-dark'
Plug 'dracula/vim'

" Molokai Colorscheme
let g:molokai_original = 1
let g:rehash256 = 1

" Tender Colorscheme
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
