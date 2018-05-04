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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' "FZF Vim Integration
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'sickill/vim-pasta'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/argtextobj.vim'
Plug 'tpope/vim-fugitive'
" Plug 'severin-lemaignan/vim-minimap'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'yuttie/comfortable-motion.vim'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'tweekmonster/braceless.vim'
Plug 'majutsushi/tagbar'

"
" Copy Paste Support
"
Plug 'christoomey/vim-system-copy'
Plug 'terryma/vim-multiple-cursors'

"
" Syntax - Language Plugins
"
"Plug 'vim-syntastic/syntastic' " Syntax Highlight
Plug 'pearofducks/ansible-vim'
Plug 'python-mode/python-mode', { 'branch': 'develop', 'for': 'python' }
Plug 'davidhalter/jedi-vim'

"
" Text Completion - Snippets
"
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/vim-cursorword'
" Snippets engine
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
