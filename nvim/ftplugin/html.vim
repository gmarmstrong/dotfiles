" Disable line numbers
setlocal nonumber

" Enable word completion
setlocal complete+=kspell

" Map F5 to toggle spell checking
call SpellCheck()

" Map F6 to open, but only if HTML: this ftplugin is also loaded for Markdown
if (&filetype == 'html')
    map <F6> :!firefox "%" <CR>
endif