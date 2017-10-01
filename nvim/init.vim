" Vimrc
"
" This file contains the minimal settings to set the foundation, with the
" majority of the configuration and settings living in files spread between
" vim/rcfiles and vim/rcplugins

" Need to set the leader before defining any leader mappings
"
let mapleader = "\<Space>"
let $RC_ROOT='~/.config/nvim'

function! s:SourceConfigFilesIn(directory)
    let directory_splat = $RC_ROOT.'/' . a:directory . '/*'
    for config_file in split(glob(directory_splat), '\n')
        if filereadable(config_file)
            execute 'source' config_file
        endif
    endfor
endfunction

call plug#begin($RC_ROOT.'/plugs')
source $RC_ROOT/rcplugs/themes.vim
source $RC_ROOT/rcplugs/airline.vim
source $RC_ROOT/rcplugs/plugs.vim
source $RC_ROOT/rcplugs/nerdtree.vim
call plug#end()

call s:SourceConfigFilesIn('rcfiles')

" Include mappings file
source $RC_ROOT/functions.vim
source $RC_ROOT/mappings.vim
source $RC_ROOT/settings.vim