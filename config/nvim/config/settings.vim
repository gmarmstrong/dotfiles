" General configuration {{{
    " Enable syntax highlighting
    syntax on

    " Highlight current line
    set cursorline

    " Set the sign column always on
    set signcolumn=yes

    " Show unseeing characters
    set list
    set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<

    " Silence the error bells
    set noerrorbells

    " Record more lines in history
    set history=5000

    " Keep editing buffer in the background
    set hidden

    " Keep history clean
    set noswapfile
    set nobackup
    set undodir=~/.vim/undodir
    set undofile
"}}}

" Set up smarter search behaviour {{{
    set nohlsearch  " Stop highlighting after a search
    set ignorecase  " Ignore case in all searches...
    set smartcase   " ...unless uppercase letters used
"}}}

" Text, tab and indent related configuration {{{
    " 1 tab == 4 spaces
    set shiftwidth=4
    set tabstop=4 softtabstop=4
    set expandtab

    " Indent and wrap lines
    set autoindent
    set smartindent
    set wrap
"}}}
