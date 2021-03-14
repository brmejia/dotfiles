" Leader Mappings
map <Leader>w :update<CR>
map <Leader>q :qall<CR>
map <Leader><Leader>r :source ~/.config/nvim/init.vim<CR>
" Git mappings
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Git<CR>
map <Leader>gp :Gpush<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

"============== Custom Mappings ===============
" Disable Ex Mode
no Q <Nop>
" Arrows movements
no <Up> <Nop>
no <Down> <Nop>
no <Left> :echoe "No! No! No! Utiliza h"<CR>
no <Right> :echoe "No! No! No! Utiliza l"<CR>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>
" Mappings to move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Tabs mapping
" nmap <C-Tab> :tabnext<CR>
" nmap <C-S-Tab> :tabprevious<CR>
" map <C-S-Tab> :tabprevious<CR>
" map <C-Tab> :tabnext<CR>
" imap <C-S-Tab> <ESC>:tabprevious<CR>
" imap <C-Tab> <ESC>:tabnext<CR>
" noremap <F7> :set expandtab!<CR>
" nmap <Leader>h :tabnew %:h<CR>

" gO to create a new line below cursor in normal mode
nmap g<C-O> o<ESC>k
" g<Ctrl+o> to create a new line above cursor (Ctrl to prevent collision with 'go' command)
nmap gO O<ESC>j

"I really hate that things don't auto-center
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" " Tab completion for insert mode
inoremap <S-Tab> <C-D>
"Allows to delete words backwards with Alt+Backspace
imap <A-BS> <C-W>

" Buffers
nmap <C-PageDown> :bn<CR>
nmap <C-PageUp> :bp<CR>
