" ==============================================================================
" FUNCTIONS

" Hide line numbers
function NoNumber() abort
    setlocal nonumber
    setlocal norelativenumber
endfunction

" Highlight columns exceeding 80
function ColumnWarning() abort
    highlight OverLength ctermbg=red ctermfg=white
    match OverLength /\%81v.\+/
endfunction

" Compile to HTML and open
function OpenPandocHTML() abort
    !pandoc -f markdown -t html % -o %:r.html
    !open %:r.html
endfunction

" ==============================================================================
" ESSENTIAL

" Map jk to escape
inoremap jk <esc>

" Detect filetype
filetype on

" Detect remote status
let g:remoteSession = ($SSH_CLIENT != "")

" ==============================================================================
" INTERFACE

setlocal ruler                  "Display line/column number, position, etc.
setlocal number                 "Show line numbers (combine with relativenumber)
setlocal relativenumber         "Show relative line numebrs (combine with number)
set shortmess=I                 "Disable startup message
set shortmess+=W                "Disable write message
set shortmess+=a                "Disable <Enter> message
set cmdheight=2                 "Avoid hit-enter prompts
set showmode                    "Show current mode in bottom window
let g:netrw_banner = 0          "Hide banner in file browser

" ==============================================================================
" INPUT

set backspace=indent,eol,start  "Allow backspace in insert mode
set clipboard=unnamed           "yank and pull to the system clipboard

" ==============================================================================
" DICTIONARY

nmap <silent> <Leader>d :!dict <cword> \| less <CR>

if has('mac')
    nmap <silent> <Leader>t :!open dict://<cword><CR><CR>
endif

" ==============================================================================
" PLUGINS

filetype plugin on

" Plugins
call plug#begin('~/.vim/plugged')       "Note the single quotes
Plug 'lervag/vimtex'                    "LaTeX support
Plug 'godlygeek/tabular'                "Markdown dependency
Plug 'gabrielelana/vim-markdown'        "Markdown support
Plug 'airblade/vim-gitgutter'           "Git diff in the gutter
Plug 'scrooloose/syntastic'             "Syntax checking
Plug 'chriskempson/base16-vim'          "Colorschemes
call plug#end()

" vimtex settings
let g:vimtex_compiler_latexmk = {'callback' : 0}

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let syntastic_mode_map = { 'passive_filetypes': ['html'] } "Leave Jekyll alone

" base16 settings
if $TERM =~ "iterm2" || $TERM =~ ".*256color"   "TODO Test 2nd condition
    let base16colorspace=256                    "Access 256 colorspace
endif

" ==============================================================================
" DISPLAY

" Reload changed files
set autoread

" Show whitespace
set list
set list listchars=tab:»·,trail:␣

" Color
colorscheme base16-tomorrow             "Depends on chriskempson/base16-vim
highlight LineNr ctermfg=lightgrey
highlight VertSplit ctermbg=lightgrey ctermfg=lightgrey
highlight StatusLine ctermbg=lightgrey ctermfg=lightgrey
highlight StatusLineNC ctermbg=lightgrey ctermfg=lightgrey

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

" ==============================================================================
" WRAPPING

set wrap            "Enable wrapping
set textwidth=0     "Column after which to break
set linebreak       "Wrap at column, not at border
set wrapmargin=0    "Distance from the window border to wrap

" ==============================================================================
" PYTHON

" Map F5 to execute
autocmd! FileType python map <F5> :!./%<CR>

" 80+ column warning
autocmd! FileType python call ColumnWarning()

" ==============================================================================
" R

" Map F5 to compile
autocmd! FileType r map <F5> :!Rscript %<CR>

" ==============================================================================
" HASKELL

" Map F5 to compile
autocmd! FileType haskell map <F5> :!ghci %<CR>

" ==============================================================================
" SHELL

" Map F5 to execute
autocmd! FileType sh,zsh map <F5> :!./%<CR>

" ==============================================================================
" PASS

" Start on (or create) the 2nd line and conceal the first line
autocmd! BufNewFile,BufRead */pass.*/* if line('$') == 1 | $put _ | endif
autocmd! BufNewFile,BufRead */pass.*/* 2
autocmd! BufNewFile,BufRead */pass.*/* syntax match Concealed '\%1l.*' conceal cchar=⚠️
autocmd! BufNewFile,BufRead */pass.*/* set conceallevel=1

" ==============================================================================
" PROSE

" Disable line numbers
autocmd! FileType latex,markdown,text,rst,html call NoNumber()

" Map F5 to toggle spell checking
autocmd! FileType latex,markdown,rst,html setlocal spell spelllang=en_us
autocmd! FileType latex,markdown,text,rst,html map <F5> :setlocal spell! spelllang=en_us<CR>

" Map F6 to open
autocmd! FileType html map <F6> :!open % <CR>
autocmd! FileType rst map <F6> :!rst2html.py % '%:r'.html<CR>
autocmd! FileType markdown map <F6> :call OpenPandocHTML()<CR><CR><CR>
