" Disable line numbers
setlocal nonumber

" Enable word completion
setlocal complete+=kspell

" Map F5 to toggle spell checking
call SpellCheck()

" Map F6 to open
autocmd FileType rst map <F6> :!rst2html.py "%" "%:r.html"<CR>
