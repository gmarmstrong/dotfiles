{ pkgs, config, ... }:

{
  # TODO Disable modeline.
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    extraConfig = ''
      set background=light
      set modeline
      set shortmess=IWa
      set cmdheight=2
      set noshowmode
      set noshowcmd
      set wildmode=list
      set clipboard=unnamedplus
      set backspace=indent,eol,start
      set linebreak
      set updatetime=100
      set shiftwidth=4
      set tabstop=4
      set expandtab
      set breakindent
      set list listchars=tab:»·,trail:␣
      set signcolumn=yes

      inoremap jk <esc>

      call plug#begin()
      Plug 'jamessan/vim-gnupg'
      Plug 'lervag/vimtex'
      Plug 'majutsushi/tagbar'
      Plug 'scrooloose/nerdtree'
      Plug 'airblade/vim-gitgutter'
      Plug 'chriskempson/base16-vim'
      Plug 'LnL7/vim-nix'
      Plug 'junegunn/goyo.vim'
      Plug 'junegunn/vim-plug'
      "Plug 'vim-pandoc/vim-pandoc'
      "Plug 'vim-pandoc/vim-pandoc-syntax'
      Plug 'plasticboy/vim-markdown'
      Plug 'tpope/vim-fugitive'
      Plug 'tpope/vim-characterize'
      Plug 'tpope/vim-surround'
      Plug 'tpope/vim-repeat'
      Plug 'LukeSmithxyz/vimling'
      call plug#end()

      let g:gitgutter_override_sign_column_highlight = 1
      let g:pandoc#syntax#conceal#urls = 1
      let g:pandoc#command#custom_open = "PandocXDGOpen"
      let g:pandoc#folding#fdc = 0
      let g:tex_flavor = 'latex'
      let g:vimtex_compiler_latexmk = {
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \ }
      "let g:vimtex_compiler_latexmk = {'callback' : 0}
      let g:vimtex_indent_on_ampersands = 0

      nm <leader><leader>i :call ToggleIPA()<CR>
      imap <leader><leader>i <esc>:call ToggleIPA()<CR>a

      function! PandocXDGOpen(file)
        return 'xdg-open ' . shellescape(expand(a:file,':p'))
      endfunction

      augroup pandoc
        autocmd! FileType pandoc noremap <F5> :Pandoc latex -o output.pdf<CR>
        autocmd FileType pandoc noremap <F6> :Pandoc! latex -o output.pdf<CR>
        autocmd FileType pandoc noremap <F7> :Pandoc html -s -o output.html<CR>
        autocmd FileType pandoc noremap <F8> :Pandoc! html -s -o output.html<CR>
      augroup end

      augroup nvim_term
        autocmd!
        autocmd TermOpen * startinsert
        autocmd TermClose * stopinsert
      augroup end

      highlight clear SignColumn
      highlight clear LineNr
      highlight clear GitGutterAdd
      highlight clear GitGutterChange
      highlight clear GitGutterDelete
      highlight clear GitGutterChangeDelete
    '';
  };
}
