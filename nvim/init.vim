" ==============================================================================
" VIM

set modeline

" ==============================================================================
" INTERFACE

set shortmess=I                                 "Disable startup message
set shortmess+=W                                "Disable write message
set shortmess+=a                                "Disable <Enter> message
set cmdheight=2                                 "Avoid hit-enter prompts
set noshowmode                                  "Don't show current mode
set noshowcmd                                   "Don't show partial commands
set wildmode=list                               "Improve :edit tab completion

" ==============================================================================
" INPUT

" Map jk to escape
inoremap jk <esc>

" Use X11 clipboard
set clipboard=unnamedplus

"Allow backspace in insert mode
set backspace=indent,eol,start

"Wrap at column, not at border
set linebreak

" ==============================================================================
" PLUGINS

" Plugins (note the single quotes)
call plug#begin()
Plug 'jamessan/vim-gnupg', {'commit': 'fa3a630'}    " GnuPG encryption support
Plug 'lervag/vimtex'                                " LaTeX support
Plug 'tpope/vim-fugitive'                           " Git wrapper
Plug 'airblade/vim-gitgutter'                       " Git diff
Plug 'chriskempson/base16-vim'                      " Base16 colors
Plug 'LnL7/vim-nix'                                 " Nix syntax
Plug 'majutsushi/tagbar'                            " Ctags sidebar
Plug 'junegunn/goyo.vim'                            " Distraction-free writing
Plug 'godlygeek/tabular'                            " Markdown dependency for tables
Plug 'cespare/vim-toml'                             " Markdown dependency for TOML (Hugo)
Plug 'elzr/vim-json'                                " Markdown dependency for JSON (Hugo)
Plug 'plasticboy/vim-markdown'                      " Markdown support
"Plug 'junegunn/vader.vim'                          " Vimscript testing
"Plug 'gmarmstrong/vim-muse', {'branch': 'master'}
"Plug 'gmarmstrong/vim-muse', {'branch': 'devel'}
call plug#end()

" vim-markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

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

" base16 settings
colorscheme base16-gruvbox-light-soft       "Color scheme

" ==============================================================================
" DISPLAY

" Show whitespace
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

set shiftwidth=4        "Set width of reindent operations (<< and >>)
set tabstop=4           "Tab characters appear 4 spaces wide
set expandtab           "Insert spaces instead of tabs
set breakindent         "Indent wrapped lines
