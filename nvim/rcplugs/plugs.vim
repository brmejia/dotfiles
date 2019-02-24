" Instalación de vim-plug si es necesario
" check whether vim-plug is installed and install it if necessary
let plugpath = fnamemodify(expand('<sfile>:p:h'), ':h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

" Configuración de plugins de utilidades
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' "FZF Vim Integration
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround' " Defines surrounding objects and actions ysa csa{(
Plug 'tpope/vim-repeat' "The . command will work with ds, cs, and yss
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine' " display the indention levels with thin vertical lines
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/argtextobj.vim' " Add argument object to nvim
Plug 'tpope/vim-fugitive' " Git module
Plug 'airblade/vim-gitgutter'
Plug 'tweekmonster/braceless.vim'
Plug 'mhinz/vim-startify'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'itchyny/vim-cursorword' " Underline word under cursor
Plug 'sickill/vim-pasta'

" Plug 'severin-lemaignan/vim-minimap'
" Plug 'yuttie/comfortable-motion.vim' " Smooth scrolling

"
" Copy Paste Support
"
Plug 'christoomey/vim-system-copy'
Plug 'terryma/vim-multiple-cursors'

"
" Syntax - Language Plugins
"
Plug 'vim-syntastic/syntastic' " Syntax Highlight
Plug 'pearofducks/ansible-vim'
Plug 'python-mode/python-mode', { 'branch': 'develop', 'for': 'python' }
Plug 'ambv/black'
Plug 'zchee/deoplete-jedi' " asynchronous completion framework for neovim

"
" Text Completion - Snippets
"

Plug 'Valloric/YouCompleteMe'
Plug 'davidhalter/jedi-vim' " Completion for Python using jedi
Plug 'ervandew/supertab'
Plug 'Raimondi/delimitMate' " provides insert mode auto-completion for quotes, parens, brackets, etc
Plug 'jiangmiao/auto-pairs' " insert or delete brackets, parens, quotes in pair

" Snippets engine
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Snippets are separated from the engine. Add this if you want them:
