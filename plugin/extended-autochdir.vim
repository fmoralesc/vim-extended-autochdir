" vim set fdm=marker :

" Defaults: {{{1
if !exists('g:autochdir#path_matches')
    let g:autochdir#path_matches = []
endif

if !exists('g:autochdir#rules')
    let g:autochdir#rules = ["&ft != 'help'"]
endif

if !exists('g:autochdir#home')
    let g:autochdir#home = expand('~')
endif

" Init: {{{1
call autochdir#InitRules()
