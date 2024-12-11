function! autochdir#InitRules()
    augroup autochdir
    for rule in g:autochdir#rules
        exe 'au BufEnter,BufNewFile,BufWritePost * if '.rule.' | call autochdir#Chdir(expand("<amatch>")) | endif'
    endfor

    for path_match in g:autochdir#path_matches
        exe 'au BufEnter,BufNewFile,BufWritePost '.pmatch.' call autochdir#Chdir(expand("<amatch>"))'
    endfor
    augroup END
endfunction

function! autochdir#Chdir(file)
    if a:file == ""
        if g:autochdir#usehome == 1
            exe "lcd ".fnameescape(g:autochdir#home)
        else
            exe "lcd ".getcwd()
        endif
        return
    endif
    try
        exe "lcd ".fnameescape(fnamemodify(a:file, ":h"))
    catch /E499/ "empty filename
        exe "lcd ~"
    catch /E344/ "can't find directory in cdpath
        return
    catch /E472/ "might occur when using tpope's fugitive
        return
    endtry
endfunction

