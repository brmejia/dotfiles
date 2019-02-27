Plug 'davidhalter/jedi-vim' " Completion for Python using jedi
"
" Configuración del plugin jedi-vim
"
" Disable jedi completions in order to use deoplete-jedi
let g:jedi#completions_enabled = 0


let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = "2"

let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>rn"
