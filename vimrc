" ==============================================================================
" FUNCTIONS

" Hide line numbers
function NoNumber()
    setlocal nonumber
endfunction

" Highlight columns exceeding 80
function ColumnWarning()
    highlight OverLength ctermbg=red ctermfg=white
    match OverLength /\%81v.\+/
endfunction

" Compile to HTML and open
function OpenPandocHTML()
    !pandoc -f markdown -t html % -o %:r.html
    !open %:r.html
endfunction

" Compile and open LaTeX
function OpenTeX()
    !pdflatex %
    !open %:r.pdf
endfunction

" ==============================================================================
" ESSENTIAL

" Map jk to escape
inoremap jk <esc>

" Be vim, not vi!
set nocompatible

" Detect filetype
filetype on

" ==============================================================================
" REMOTE

" Detect remote status
let g:remoteSession = ($SSH_CLIENT != "")

" ==============================================================================
" INTERFACE

set ruler                       "Display line/column number, position, etc.
set number                      "Show line numbers
set shortmess=I                 "Disable startup message
set shortmess+=W                "Disable write message
let g:netrw_banner = 0          "Hide banner in file browser

" ==============================================================================
" DISPLAY

" Reload changed files
set autoread

" Show whitespace
set list
set list listchars=tab:»·,trail:␣

" Color
syntax on
highlight LineNr ctermfg=lightgrey

" ==============================================================================
" INPUT

set backspace=indent,eol,start  "Allow backspace in insert mode
set showmode                    "Show current mode in bottom window
set clipboard=unnamed           "y(ank) and p(ull) copy to the system clipboard

" ==============================================================================
" DICTIONARY

nmap <silent> <Leader>d :!dict <cword> \| less <CR>
nmap <silent> <Leader>t :!open dict://<cword><CR><CR>

" ==============================================================================
" PLUGINS

filetype plugin on

" Plugins
call plug#begin('~/.vim/plugged')       "Note the single quotes
Plug 'lervag/vimtex'                    "LaTeX support
Plug 'enomsg/vim-haskellconcealplus'    "Conceal for Haskell
Plug 'ehamberg/vim-cute-python'         "Conceal for Python
Plug 'godlygeek/tabular'                "Markdown dependency
Plug 'gabrielelana/vim-markdown'        "Markdown support
call plug#end()

" vimtex settings
let g:vimtex_compiler_latexmk = {'callback' : 0}

" ==============================================================================
" INDENTATION

set autoindent          "Open (o and O) lines with appropriate indentation
set smartindent         "Be smart
set smarttab            "Be smart
set shiftwidth=4        "Set width of reindent operations (<< and >>)
set tabstop=4           "Tab characters appear 4 spaces wide
set expandtab           "Insert spaces instead of tabs
set breakindent         "Indent wrapped lines
filetype indent on      "Indent with filetype in mind

" Indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" ==============================================================================
" WRAPPING

set wrap            "Enable wrapping
set textwidth=0     "Column after which to break
set linebreak       "Wrap at column, not at border
set wrapmargin=0    "Distance from the window border to wrap

" ==============================================================================
" PYTHON

" Map F5 to compile
autocmd BufNewFile,BufRead *.py map <F5> :!python2 %<CR>
autocmd BufNewFile,BufRead *.py map <F5> :!python3 %<CR>

" 80+ column warning
autocmd BufNewFile,BufRead *.py call ColumnWarning()

" ==============================================================================
" R

" Map F5 to compile
autocmd FileType r map <F5> :!Rscript %<CR>

" ==============================================================================
" Haskell

" Map F5 to compile
autocmd BufNewFile,BufRead *.hs map <F5> :!ghci %<CR>

" ==============================================================================
" PROSE

" Disable line numbers
autocmd FileType latex,markdown,text,rst,html call NoNumber()

" Map F5 to toggle spell checking
autocmd FileType latex,markdown,text,rst,html set spell spelllang=en_us
autocmd FileType latex,markdown,text,rst,html map <F5> :set spell! spelllang=en_us<CR>

" Map F6 to open
autocmd FileType html map <F6> :!open % <CR>
autocmd FileType rst map <F6> :!rst2html.py % '%:r'.html<CR>
autocmd FileType markdown map <F6> :call OpenPandocHTML()<CR><CR><CR>
autocmd FileType tex map <F6> :call OpenTeX()<CR>
