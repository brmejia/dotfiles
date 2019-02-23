" Leader Mappings
map <Leader>w :update<CR>
map <Leader>q :qall<CR>
map <Leader><Leader>r :source ~/.config/nvim/init.vim<CR>
" Git mappings
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gp :Gpush<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" vim-test mappings
"nnoremap <silent> <Leader>t :TestFile<CR>
"nnoremap <silent> <Leader>s :TestNearest<CR>
"nnoremap <silent> <Leader>l :TestLast<CR>
"nnoremap <silent> <Leader>a :TestSuite<CR>
"nnoremap <silent> <leader>gt :TestVisit<CR>

" nnoremap <Leader>r :RunInInteractiveShell<space>
" " Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>

"============== Custom Mappings ===============
" Disable Ex Mode
no Q <Nop>
" Arrows movements
no <Up> ddkP
no <Down> ddp
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

" Tabs mapping
nmap <C-Tab> :tabnext<CR>
nmap <C-S-Tab> :tabprevious<CR>
map <C-S-Tab> :tabprevious<CR>
map <C-Tab> :tabnext<CR>
imap <C-S-Tab> <ESC>:tabprevious<CR>
imap <C-Tab> <ESC>:tabnext<CR>
noremap <F7> :set expandtab!<CR>
nmap <Leader>h :tabnew %:h<CR>

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

" " Tab completion
" for insert mode
inoremap <S-Tab> <C-D>
imap <A-BS> <C-W>

" Commenting Remaps
nmap cm gc

" ACK.vim Mappings
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
