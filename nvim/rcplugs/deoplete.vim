if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif


" Settings
let g:deoplete#enable_at_startup = 1

" Deoplete-jedi Settings
Plug 'zchee/deoplete-jedi' " asynchronous completion framework for neovim

" g:deoplete#sources#jedi#statement_length: Sets the maximum length of completion description text. If this is exceeded, a simple description is used instead. Default: 50

" g:deoplete#sources#jedi#enable_typeinfo: Enables type information of completions. If you disable it, you will get the faster results. Default: 1
" g:deoplete#sources#jedi#show_docstring: Shows docstring in preview window. Default: 0
" g:deoplete#sources#jedi#python_path: Set the Python interpreter path to use for the completion server. It defaults to "python", i.e. the first available python in $PATH. Note: This is different from Neovim's Python (:python) in general.
" g:deoplete#sources#jedi#extra_path: A list of extra paths to add to sys.path when performing completions.
" g:deoplete#sources#jedi#ignore_errors: Ignore jedi errors for completions. Default: 0
