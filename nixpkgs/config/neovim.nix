{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      # TODO tpope/vim-characterize
      {
        plugin = vimtex;
        config = ''
          let g:tex_flavor = 'latex'
          let g:vimtex_indent_on_ampersands = 0
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
        '';
      }
      { plugin = gitgutter; config = "let g:gitgutter_override_sign_column_highlight = 1"; }
      tagbar
      nerdtree
      fugitive
      surround
      repeat
      vim-markdown
      vim-nix
      goyo
    ];

    extraConfig = ''
      set background=light
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

      "call plug#begin()
      "Plug 'jamessan/vim-gnupg'
      ""Plug 'vim-pandoc/vim-pandoc'
      ""Plug 'vim-pandoc/vim-pandoc-syntax'
      "Plug 'tpope/vim-characterize'
      "Plug 'LukeSmithxyz/vimling'
      "call plug#end()

      let g:vim_markdown_folding_style_pythonic = 1

      "let g:pandoc#syntax#conceal#urls = 1
      "let g:pandoc#command#custom_open = "PandocXDGOpen"
      "let g:pandoc#folding#fdc = 0
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
