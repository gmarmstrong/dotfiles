" ==============================================================================
" VIM

set modeline

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

" Use X11 clipboard
set clipboard=unnamedplus

"Allow backspace in insert mode
set backspace=indent,eol,start

" ==============================================================================
" PLUGINS

" Plugins (note the single quotes)
call plug#begin()
Plug 'junegunn/goyo.vim'                                " Full-screen editor
Plug 'jamessan/vim-gnupg', {'commit': 'fa3a630'}        " Edit encrypted files
Plug 'lervag/vimtex'                                    " LaTeX support
Plug 'godlygeek/tabular'                                " Markdown dependency
Plug 'gabrielelana/vim-markdown'                        " Markdown support
Plug 'tpope/vim-fugitive'                               " git wrapper
Plug 'airblade/vim-gitgutter'                           " Git diff in SignColumn
Plug 'chriskempson/base16-vim'                          " Colorschemes
"Plug 'gmarmstrong/vim-muse', {'branch': 'master'}       " Writing assistant
"Plug 'gmarmstrong/vim-muse', {'branch': 'devel'}        " Dev vim-muse
"Plug '$HOME/projects/vim-muse', {'branch': 'devel'}     " Local dev vim-muse
"Plug 'junegunn/vader.vim'                               " Vimscript test framework
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
colorscheme base16-default-light       "Color scheme

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
