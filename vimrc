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
Plug 'enomsg/vim-haskellconcealplus'    "Conceal for Haskell
Plug 'ehamberg/vim-cute-python'         "Conceal for Python
Plug 'godlygeek/tabular'                "Markdown dependency
Plug 'plasticboy/vim-markdown'          "Markdown support
Plug 'junegunn/goyo.vim'                "Distractionless writing
call plug#end()

" netrw settings
let g:netrw_banner = 0

" vim-markdown settings
let g:vim_markdown_folding_disabled = 1

" goyo.vim settings
map <leader>f :Goyo <bar> highlight StatusLineNC ctermfg=white<CR>

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
set textwidth=80
set wrapmargin=0

" === Filetype functions ===

" *.py: F5 --> python2
autocmd BufNewFile,BufRead *.py map <F5> :!python2 %<CR>

" *.py: F6 --> python3
autocmd BufNewFile,BufRead *.py map <F6> :!python3 %<CR>

" *.txt, *.md: 79 column wrap
autocmd BufNewFile,BufRead *.txt set wrapmargin=79
autocmd BufNewFile,BufRead *.md set textwidth=79
autocmd BufNewFile,BufRead *.markdown set textwidth=79

" *.py, *.tex: 80 column limit
autocmd BufNewFile,BufRead *.py highlight OverLength ctermbg=red ctermfg=white
autocmd BufNewFile,BufRead *.py match OverLength /\%81v.\+/
autocmd BufNewFile,BufRead *.tex highlight OverLength ctermbg=red ctermfg=white
autocmd BufNewFile,BufRead *.tex match OverLength /\%81v.\+/

" *.rst: F5 --> rst2html.py
"autocmd BufNewFile,BufRead *.rst map <F5> :!rst2html.py % docdev/'%:r'.html<CR>
autocmd BufNewFile,BufRead *.rst map <F5> :!rst2html.py % '%:r'.html<CR>

" *.txt, *.tex, *.html, *.md, *.markdown : F5 --> spell checking
autocmd BufNewFile,BufRead *.txt map <F5> :set spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.tex map <F5> :set spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.html map <F5> :set spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.md map <F5> :set spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.markdown map <F5> :set spell! spelllang=en_us<CR>

" *.tex: F6 --> pdflatex
autocmd BufNewFile,BufRead *.tex map <F6> :!pdflatex %<CR>

" *.R: F6 --> Rscript
autocmd BufNewFile,BufRead *.R map <F6> :!Rscript %<CR>

" *.html, *.md: F6 --> open
autocmd BufNewFile,BufRead *.html map <F6> :!open %<CR>
" autocmd BufNewFile,BufRead *.md map <F6> :!open %<CR>

" *.hs: F6 --> ghci
autocmd BufNewFile,BufRead *.hs map <F6> :!ghci %<CR>

" *.md, *.txt: no line numbers or tildes
autocmd BufNewFile,BufRead *.md set nonumber
autocmd BufNewFile,BufRead *.markdown set nonumber
autocmd BufNewFile,BufRead *.txt set nonumber
autocmd BufNewFile,BufRead *.md highlight EndOfBuffer ctermfg=white ctermbg=white
autocmd BufNewFile,BufRead *.markdown highlight EndOfBuffer ctermfg=white ctermbg=white
autocmd BufNewFile,BufRead *.txt highlight EndOfBuffer ctermfg=white ctermbg=white

" === Color settings ===

syntax on
highlight LineNr ctermfg=lightgrey
