" ==============================================================================
" VIM

set modeline

" ==============================================================================
" FUNCTIONS

" Highlight columns exceeding 80
function! ColumnWarning() abort
    highlight OverLength ctermbg=red ctermfg=white
    match OverLength /\%81v.\+/
endfunction

" Highlight columns exceeding 80
function! ColumnWarningPython() abort
    highlight OverLength ctermbg=red ctermfg=white
    match OverLength /\%80v.\+/
endfunction

" Compile Markdown to HTML and open
function! BrowserMarkdown() abort
    !pandoc -s -f markdown -t html "%" -o "%:r.html"
    !firefox "%:r.html"
endfunction

" Remove Markdown compiled HTML
function! CleanHTML() abort
    if (&filetype == 'markdown')
        !trash "%:r.html"
    endif
endfunction

" Enable spell checking and toggle with F5
function! SpellCheck() abort
    setlocal spell spelllang=en
    map <F5> :setlocal spell! spellang=en<CR>
endfunction

" ==============================================================================
" INTERFACE

setlocal ruler                                  "Display line/column number, position, etc.
setlocal nonumber                               "Show line numbers
set shortmess=I                                 "Disable startup message
set shortmess+=W                                "Disable write message
set shortmess+=a                                "Disable <Enter> message
set cmdheight=2                                 "Avoid hit-enter prompts
set noshowmode                                  "Don't show current mode
set noshowcmd                                   "Don't show partial commands
let g:netrw_banner = 0                          "Hide banner in file browser
set wildmode=longest,list,full                  "Improve :edit tab completion
set wildmenu                                    "Improve :edit tab completion

" ==============================================================================
" INPUT

" Map jk to escape
inoremap jk <esc>

" Better leader sequences
let mapleader="\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :wq<CR>

" Use X11 clipboard
set clipboard=unnamedplus

"Allow backspace in insert mode
set backspace=indent,eol,start

" ==============================================================================
" DICTIONARY

nnoremap <silent> <Leader>d :echo system("dict " . expand('<cword>'))<CR>

" ==============================================================================
" PLUGINS

" Plugins (note the single quotes)
call plug#begin()
Plug 'junegunn/goyo.vim'                                " Full-screen editor
Plug 'lervag/vimtex'                                    " LaTeX support
Plug 'godlygeek/tabular'                                " Markdown dependency
Plug 'gabrielelana/vim-markdown'                        " Markdown support
"Plug 'tpope/vim-fugitive'                               " git wrapper
"Plug 'tpope/vim-rhubarb'                                " hub fugitive extension
Plug 'airblade/vim-gitgutter'                           " Git diff in SignColumn
Plug 'chriskempson/base16-vim'                          " Colorschemes
"Plug 'gmarmstrong/vim-muse', {'branch': 'master'}       " Writing assistant
"Plug 'gmarmstrong/vim-muse', {'branch': 'devel'}        " Dev vim-muse
"Plug '$HOME/projects/vim-muse', {'branch': 'devel'}     " Local dev vim-muse
"Plug 'junegunn/vader.vim'                               " Vimscript test framework
"Plug 'majutsushi/tagbar'                                " Ctags browser
Plug 'LnL7/vim-nix'                                     " Nix syntax
call plug#end()

" goyo settings
map <leader>G :Goyo<CR>
let g:goyo_width = 85

" vim-markdown settings
let g:markdown_include_jekyll_support = 1
let g:markdown_enable_folding = 0
let g:markdown_enable_mappings = 1
let g:markdown_enable_spell_checking = 1
let g:markdown_enable_input_abbreviations = 1
let g:markdown_enable_conceal = 1

" vim-gitgutter settings
let g:gitgutter_override_sign_column_highlight = 1
if exists('&signcolumn')
    set signcolumn=yes
else
    let g:gitgutter_sign_column_always = 1
endif
set updatetime=100

" vimtex settings
let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

" base16 settings
if $TERM =~ ".*256color"
    set t_Co=256                                "Enable 256 colors
    let base16colorspace=256                    "Access 256 colorspace
    colorscheme base16-gruvbox-dark-hard        "Color scheme
endif

" ==============================================================================
" DISPLAY

" Reload changed files
set autoread

" Show whitespace
set list
set list listchars=tab:»·,trail:␣

" Color
highlight clear SignColumn
highlight clear LineNr
highlight clear GitGutterAdd
highlight clear GitGutterChange
highlight clear GitGutterDelete
highlight clear GitGutterChangeDelete

" ==============================================================================
" INDENTATION

set autoindent          "Open (o and O) lines with appropriate indentation
set smartindent         "Indent by filetype
set smarttab            "Use shiftwidth when inserting and deleting tabs
set shiftwidth=4        "Set width of reindent operations (<< and >>)
set tabstop=4           "Tab characters appear 4 spaces wide
set expandtab           "Insert spaces instead of tabs
set breakindent         "Indent wrapped lines

" ==============================================================================
" WRAPPING

set wrap            "Enable wrapping
set textwidth=0     "Column after which to break
set linebreak       "Wrap at column, not at border
set wrapmargin=0    "Distance from the window border to wrap

" ==============================================================================
" PASS

" https://lists.zx2c4.com/pipermail/password-store/2017-November/003122.html
" https://gmarmstrong.org/2017/11/09/using-pass-vim-conceal.html
augroup passconceal
    autocmd!

    " Create the second line if it does not already exist
    autocmd BufNewFile,BufRead */pass.*/* if line('$') == 1 | $put _ | endif

    " Jump to the second line
    autocmd BufNewFile,BufRead */pass.*/* 2

    " Conceal the first line with a unicode character
    autocmd BufNewFile,BufRead */pass.*/* syntax match Concealed '\%1l.*' conceal cchar=⚠️
    autocmd BufNewFile,BufRead */pass.*/* setlocal conceallevel=1

augroup END

" ==============================================================================
" TABS

" Don't spell-check guitar tablature
autocmd BufNewFile,BufRead */resources/tablature/* setlocal nospell