function! autochdir#InitRules()
    for rule in g:autochdir#rules
        exe 'au BufEnter * if '.rule.' | call autochdir#Chdir() | endif'
    endfor

    for path_match in g:autochdir#path_matches
        exe 'au BufEnter '.pmatch.' call autochdir#Chdir()'
    endfor

    exe "au BufLeave * cd ".g:autochdir#home
endfunction

function! autochdir#Chdir()
    try
        lcd %:h
    catch /E499/
        return
    catch /E344/
        return
    catch /E472/ "might occur when using tpope's fugitive
        return
    endtry
endfunction

