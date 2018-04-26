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
Plug 'jamessan/vim-gnupg', {'commit': 'fa3a630'}
Plug 'lervag/vimtex'                                        " LaTeX support
Plug 'godlygeek/tabular'                                    " Markdown dependency
Plug 'gabrielelana/vim-markdown'                            " Markdown support
Plug 'tpope/vim-fugitive'                                   " Git wrapper
Plug 'airblade/vim-gitgutter'                               " Git diff
Plug 'chriskempson/base16-vim'
Plug 'LnL7/vim-nix'
Plug 'fatih/vim-go'
"Plug 'gmarmstrong/vim-muse', {'branch': 'master'}
"Plug 'gmarmstrong/vim-muse', {'branch': 'devel'}
"Plug 'junegunn/vader.vim'
call plug#end()

" vim-markdown settings
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

" base16 settings
colorscheme base16-default-light       "Color scheme

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
