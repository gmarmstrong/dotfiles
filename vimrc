" === General settings ===

" Be vim, not vi!
set nocompatible

" Detect remote status
let g:remoteSession = ($SSH_CLIENT != "")

" Map jk to escape
inoremap jk <esc>

set ruler                       "Display line/column number, position, etc.
set number                      "Show line numbers
set backspace=indent,eol,start  "Allow backspace in insert mode
set showmode                    "Show current mode in bottom window
set autoread                    "Reload files changed outside vim
set clipboard=unnamed           "y(ank) and p(ull) copy to the system clipboard
set shortmess=I                 "Disable startup message
set shortmess+=W                "Disable write message

" === Plugin settings ===

" Plugins
call plug#begin('~/.vim/plugged')       "Note the single quotes
Plug 'lervag/vimtex'                    "LaTeX support
Plug 'discoloda/c-conceal'              "Conceal for C
Plug 'enomsg/vim-haskellconcealplus'    "Conceal for Haskell
Plug 'ehamberg/vim-cute-python'         "Conceal for Python
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
call plug#end()

" netrw settings
let g:netrw_banner = 0

" vim-markdown settings
let g:vim_markdown_folding_disabled = 1

" === Show whitespace ===

set list
set list listchars=tab:»·,trail:␣

" === Indentation ===

set autoindent          "Open (o and O) lines with appropriate indentation
set smartindent         "Be smart
set smarttab            "Be smart
set shiftwidth=4        "Set width of reindent operations (<< and >>)
set tabstop=4           "Tab characters appear 4 spaces wide
set expandtab           "Insert spaces instead of tabs
set breakindent         "Indent wrapped lines

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" Enable file type detection
filetype on
filetype plugin on
filetype indent on

" === Word wrapping ===

"Word wrapping.
set wrap
set linebreak
"Prevent automatic linebreaks in newly entered text
set textwidth=0
set wrapmargin=0

" === Filetype functions ===

" *.py: F5 --> python2
autocmd BufNewFile,BufRead *.py map <F5> :!python2 %<CR>

" *.py: F6 --> python3
autocmd BufNewFile,BufRead *.py map <F6> :!python3 %<CR>

" *.py: 80 column limit
autocmd BufNewFile,BufRead *.py highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd BufNewFile,BufRead *.py match OverLength /\%81v.\+/

" *.rst: F5 --> rst2html.py
autocmd BufNewFile,BufRead *.rst map <F5> :!rst2html.py % docdev/'%:r'.html<CR>

" *.txt, *.tex, *.html, *.md, *.markdown : F5 --> spell checking
autocmd BufNewFile,BufRead *.txt map <F5> :set spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.tex map <F5> :set spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.html map <F5> :set spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.md map <F5> :set spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.markdown map <F5> :set spell! spelllang=en_us<CR>

" *.tex: F6 --> pdflatex
autocmd BufNewFile,BufRead *.tex map <F6> :!pdflatex %<CR>

" *.tex: F7 --> biber
autocmd BufNewFile,BufRead *.tex map <F7> :!biber %:r<CR>

" *.R: F6 --> Rscript
autocmd BufNewFile,BufRead *.R map <F6> :!Rscript %<CR>

" *.html, *.md: F6 --> open
autocmd BufNewFile,BufRead *.html map <F6> :!open %<CR>
autocmd BufNewFile,BufRead *.md map <F6> :!open %<CR>

" *.hs: F6 --> ghci
autocmd BufNewFile,BufRead *.hs map <F6> :!ghci %<CR>

" === Color settings ===

syntax on
highlight LineNr ctermfg=lightgrey
