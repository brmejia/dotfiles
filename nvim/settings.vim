" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 80 characters is
set textwidth=120
set colorcolumn=+1

" Numbers
set number                  " show line numbers
set relativenumber          " show relative line numbers

" Set this to change between relative or absolute numbers on focus
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" Section User Interface {{{
" To enable mode shapes, 'Cursor' highlight, and blinking: >
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff200-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

syntax on
let g:one_allow_italics = 1 " I love italic for comments
set background=dark " for the dark version
colorscheme one         " Set the colorscheme
" let g:airline_theme='one'
if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

" make the highlighting of tabs and other non-text less annoying
" highlight SpecialKey ctermbg=none ctermfg=darkgray
" highlight NonText ctermbg=none ctermfg=darkgray

" By default timeoutlen is 1000 ms
set timeoutlen=500

set updatetime=200
" supertab.vimFiles
set nobackup      " Make a backup before overwriting a file
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=1000
set ruler         " show the cursor position all the time
set autowrite     " Automatically :write before running commands

set wrap                    " turn on line wrapping
set wrapmargin=8            " wrap lines when coming within n characters from side
set linebreak               " set soft wrapping
set showbreak=↪             " show ellipsis at breaking


" Display invisible characters
set list
set listchars=tab:»·,trail:·,nbsp:·,extends:❯,precedes:❮

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" make backspace behave in a sane manner
set backspace=2   " Backspace deletes like most programs in insert mode

" Tab control
set expandtab             " insert tabs rather than spaces for <Tab>
set smarttab                " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4               " the visible width of tabs
set softtabstop=4           " edit as if the tabs are 4 characters wide
set shiftwidth=4            " number of spaces to use for indent and unindent
set shiftround              " round indent to a multiple of 'shiftwidth'
set completeopt+=longest
set fileformat=unix

" Python TAB
au BufNewFile,BufRead *.py
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4 |
            \ set expandtab |
            \ set fileformat=unix

" YAML TAB
au BufNewFile,BufRead *.yaml
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 |
            \ set textwidth=80

"To make a fully educated decision as to how to set things up, you'll need to read Vim docs on tabstop, shiftwidth, softtabstop and expandtab. The most interesting bit is found under expandtab (:help 'expandtab): Full Stack Development
au BufNewFile,BufRead *.js, *.html, *.css, *.less
" autocmd Filetype css, js, html, css, less
            \ set tabstop=2
            \ set softtabstop=2
            \ set shiftwidth=2

" code folding settings
set foldmethod=indent       " fold based on indent
set foldnestmax=10          " deepest fold is 10 levels
set nofoldenable            " don't fold by default
set foldlevel=1

set clipboard=unnamed

set laststatus=2            " show the satus line all the time
set so=7                    " set 7 lines to the cursors - when moving vertical
set wildmenu                " enhanced command line completion
set hidden                  " current buffer can be put into background
set showcmd                 " show incomplete commands
" set noshowmode              " don't show which mode disabled for PowerLine
set wildmode=list:longest   " complete files like a shell
set scrolloff=8             " lines of text around cursor
set shell=$SHELL
set cmdheight=1             " command bar height
set title                   " set terminal title

" Searching
set ignorecase              " case insensitive searching
set smartcase               " case-sensitive if expresson contains a capital letter
set nohlsearch                " highlight search results
set incsearch               " set incremental search, like modern browsers
set lazyredraw            " don't redraw while executing macros

set magic                   " Set magic on, for regex

set showmatch               " show matching braces
set mat=1                   " how many tenths of a second to blink

" error bells
" set noerrorbells
set visualbell
" set t_vb=

if has('mouse')
    set mouse=a
    " set ttymouse=xterm2
endif

" }}}
