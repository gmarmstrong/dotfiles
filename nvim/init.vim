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
Plug 'vim-pandoc/vim-pandoc'                        " Pandoc support
Plug 'vim-pandoc/vim-pandoc-syntax'                 " Pandoc syntax highlighting
"Plug 'junegunn/vader.vim'                          " Vimscript testing
"Plug 'gmarmstrong/vim-muse', {'branch': 'master'}
"Plug 'gmarmstrong/vim-muse', {'branch': 'devel'}
call plug#end()

" vim-pandoc settings
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#command#custom_open = "PandocXDGOpen"
function! PandocXDGOpen(file)
    return 'xdg-open ' . shellescape(expand(a:file,':p'))
endfunction
augroup pandoc
    autocmd! FileType pandoc noremap <F5> <esc>:Pandoc latex -o output.pdf<CR>
    autocmd FileType pandoc noremap <F6> <esc>:Pandoc! latex -o output.pdf<CR>
augroup end

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
