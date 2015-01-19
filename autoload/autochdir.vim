function! autochdir#InitRules()
    augroup autochdir
    for rule in g:autochdir#rules
        exe 'au BufEnter,BufNewFile * if '.rule.' | call autochdir#Chdir(expand("<amatch>")) | endif'
    endfor

    for path_match in g:autochdir#path_matches
        exe 'au BufEnter,BufNewFile '.pmatch.' call autochdir#Chdir(expand("<amatch>"))'
    endfor
    augroup END
endfunction

function! autochdir#Chdir(file)
    if a:file == ""
        exe "lcd ".g:autochdir#home
        return
    endif
    try
        exe "lcd ".fnamemodify(a:file, ":h")
    catch /E499/
        return
    catch /E344/
        return
    catch /E472/ "might occur when using tpope's fugitive
        return
    endtry
endfunction

