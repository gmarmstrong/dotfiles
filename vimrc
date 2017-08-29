" Be vim, not vi!
set nocompatible

" Detect remote status
let g:remoteSession = ($SSH_CLIENT != "")

" ================ General settings ===============

set number                      "Show line numbers
set backspace=indent,eol,start  "Allow backspace in insert mode
set showmode                    "Show current mode in bottom window
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set clipboard=unnamed           "y(ank) and p(ull) copy to the system clipboard
set shortmess=I                 "Disable startup message.
if has("gui_running")
    set guifont=Anonymous Pro:h14
endif

" Map jk to escape
inoremap jk <esc>

" ================ Plugin settings ================

" Plugins
call plug#begin('~/.vim/plugged')   "Note the single quotes
Plug 'junegunn/goyo.vim'            "Distraction-free writing
Plug 'lervag/vimtex'                "LaTeX support
Plug 'vim-syntastic/syntastic'      "Syntax checking
Plug 'scrooloose/nerdtree'          "Tree explorer
Plug 'Xuyuanp/nerdtree-git-plugin'  "Git support for NERDTree
call plug#end()

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" =============== Show whitespace ============

set list
set list listchars=tab:»·,trail:␣

" ================ Persistent Undo ================

" Store undo history across sessions.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
    set undofile
endif

" ================ Indentation ====================

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

" ================ Word wrapping ==================

"Word wrapping.
set wrap
set linebreak
"Prevent automatic linebreaks in newly entered text
set textwidth=0
set wrapmargin=0

" ================ Filetype functions =============

" *.py: F5 --> python2
autocmd BufNewFile,BufRead *.py map <F5> :!python2 %<CR>

" *.py: F6 --> python3
autocmd BufNewFile,BufRead *.py map <F6> :!python3 %<CR>

" *.rst: F5 --> rst2html.py
autocmd BufNewFile,BufRead *.rst map <F5> :!rst2html.py % docdev/'%:r'.html<CR>

" *.txt, *.tex, *.html: F5 --> spell checking
autocmd BufNewFile,BufRead *.txt map <F5> :set spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.tex map <F5> :set spell! spelllang=en_us<CR>
autocmd BufNewFile,BufRead *.html map <F5> :set spell! spelllang=en_us<CR>

" *.tex: F6 --> pdflatex
autocmd BufNewFile,BufRead *.tex map <F6> :!pdflatex %<CR>

" *.tex: F7 --> pdflatex and biber
autocmd BufNewFile,BufRead *.tex map <F7> :!pdflatex % && biber %:r && pdflatex % && pdflatex %<CR>

" *.R: F6 --> Rscript
autocmd BufNewFile,BufRead *.R map <F6> :!Rscript %<CR>

" *.html: F6 --> open
autocmd BufNewFile,BufRead *.html map <F6> :!open %<CR>

" *.hs: F6 --> ghci
autocmd BufNewFile,BufRead *.hs map <F6> :!ghci %<CR>

" *.md: F5 --> pandoc
autocmd BufNewFile,BufRead *.md map <F5> :!pandoc % -o %:r.html<CR>

" ================ Color settings =================

syntax on
colorscheme Tomorrow
" " Set color scheme based on remote status
" if g:remoteSession
"     colorscheme Tomorrow-Night
" else
"     colorscheme Tomorrow
" endif

highlight LineNr ctermfg=grey
