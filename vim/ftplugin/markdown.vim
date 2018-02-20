" Disable line numbers
setlocal nonumber

" Enable word completion
setlocal complete+=kspell

" Map F5 to toggle spell checking
call SpellCheck()

" Map F6 to open
map <F6> :call BrowserMarkdown()<CR><CR><CR>

" Map F7 to clean
map <F7> :call CleanHTML()<CR><CR><CR>

" TODO Map F8 to render with GitHub's Markdown API
" https://developer.github.com/v3/markdown/
