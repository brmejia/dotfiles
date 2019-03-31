Plug 'w0rp/ale'

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5

" How can I change the format for echo messages?
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {
\   "python": ["autopep8", "pylint"],
\}
