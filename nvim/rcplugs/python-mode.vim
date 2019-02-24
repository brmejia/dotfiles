
let g:pymode_python = 'python3'
" Breakpoints
let g:pymode_breakpoint = 0
let g:pymode_breakpoint_bind = '<leader>br'
" Code checking
let g:pymode_options_max_line_length = 88
let g:pymode_lint = 1
let g:pymode_lint_unmodified = 0
let g:pymode_lint_on_fly = 1

" Virtualenvs
let g:pymode_virtualenv = 1

" Code checking
let g:pymode_lint_ignore = ['E501']

let g:pymode_lint_todo_symbol = 'WW'
let g:pymode_lint_comment_symbol = 'CC'
let g:pymode_lint_visual_symbol = 'RR'
let g:pymode_lint_error_symbol = 'EE'
let g:pymode_lint_info_symbol = 'II'
let g:pymode_lint_pyflakes_symbol = 'FF'

" Autocomplete"
let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime', 'django']
