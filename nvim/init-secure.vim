" PRIVACY
set nobackup
set nowritebackup
set noundofile
set noswapfile
set viminfo=""
set noshelltemp
set history=0
set nomodeline
set secure

" Nice things
set shortmess=I                 "Disable startup message
set shortmess+=W                "Disable write message
set shortmess+=a                "Disable <Enter> message
set cmdheight=2                 "Avoid hit-enter prompts
let g:netrw_banner = 0          "Hide banner in file browser

" Map jk to escape
inoremap jk <esc>

"Allow backspace in insert mode
set backspace=indent,eol,start

" Show whitespace
set list
set list listchars=tab:»·,trail:␣

" Indentation
set autoindent          "Open (o and O) lines with appropriate indentation
set smartindent         "Indent by filetype
set smarttab            "Use shiftwidth when inserting and deleting tabs
set shiftwidth=4        "Set width of reindent operations (<< and >>)
set tabstop=4           "Tab characters appear 4 spaces wide
set expandtab           "Insert spaces instead of tabs
set breakindent         "Indent wrapped lines

" Wrapping
set wrap            "Enable wrapping
set textwidth=0     "Column after which to break
set linebreak       "Wrap at column, not at border
set wrapmargin=0    "Distance from the window border to wrap

" Source gnupg.vim
source $HOME/.config/nvim/gnupg.vim