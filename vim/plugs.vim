" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Configuración de Colorschemes

Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'
Plug 'tomasr/molokai'
Plug 'jacoborus/tender'
Plug 'w0ng/vim-hybrid'
Plug 'tomasiser/vim-code-dark'

" Configuración de plugins de utilidades
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' "FZF Vim Integration
Plug 'vim-syntastic/syntastic' " Syntax Highlight
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'Raimondi/delimitMate'
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'sickill/vim-pasta'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/argtextobj.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
" Plug 'severin-lemaignan/vim-minimap'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'yuttie/comfortable-motion.vim'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/indentLine'
" Plug 'tweekmonster/braceless.vim'
Plug 'terryma/vim-multiple-cursors'
" Copy Paste Support
" Tabs Movement
Plug 'pearofducks/ansible-vim'
" On-demand loading
" Copy Paste Support
" Tabs Movement

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'

" Initialize plugin system
call plug#end()

" Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
set t_Co=256

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" configure syntastic syntax checking to check on open as well as save
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_check_on_open=1

" Molokai Colorscheme
let g:molokai_original = 1
let g:rehash256 = 1

" Molokai Colorscheme
let g:molokai_original = 1
let g:rehash256 = 1

" " Tender Colorscheme
" " If you have vim >=8.0 or Neovim >= 0.1.5
" if (has("termguicolors"))
"  set termguicolors
" endif

