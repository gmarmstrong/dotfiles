call plug#begin('~/.local/share/nvim/plugged')
" General {{{
    " Color scheme
    Plug 'gruvbox-community/gruvbox'

    " Operations on brackets, parens, quotes in pair
    Plug 'jiangmiao/auto-pairs'

    " File icons all around vim
    Plug 'kyazdani42/nvim-web-devicons'

    " Available keybindings in popup
    Plug 'liuchengxu/vim-which-key'

    " Different level of parentheses in different colors
    Plug 'luochen1990/rainbow'

    " Tags of the current file
    Plug 'majutsushi/tagbar'

    " Useful start screen
    Plug 'mhinz/vim-startify'

    " Asynchronously run programs
    Plug 'neomake/neomake'

    " Fast color highlighter
    Plug 'norcalli/nvim-colorizer.lua'

    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " Nice and smooth scrolling
    Plug 'psliwka/vim-smoothie'

    " File system explorer
    Plug 'tpope/vim-vinegar'

    " Jump anywhere
    Plug 'phaazon/hop.nvim'

    " Comment functions
    Plug 'preservim/nerdcommenter'
    let NERDSpaceDelims = 1

    " Handy features for surroundings
    Plug 'tpope/vim-surround'

    " Lean status/tabline
    Plug 'hoob3rt/lualine.nvim'

    " Additional text objects
    Plug 'wellle/targets.vim'
"}}}

" Infrastructure {{{
    " Ansible
    Plug 'pearofducks/ansible-vim'

    " Docker
    Plug 'ekalinin/dockerfile.vim'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Packer
    Plug 'hashivim/vim-packer'

    " Terraform
    Plug 'hashivim/vim-terraform'
    Plug 'juliosueiras/vim-terraform-completion'
    let g:terraform_align=1
    let g:terraform_completion_keys = 1
    let g:terraform_fmt_on_save=1
"}}}

" Development {{{
    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }
    Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    let g:go_def_mode='gopls'
    let g:go_info_mode='gopls'

    " Javascript
    Plug 'pangloss/vim-javascript'     " JavaScript support
    Plug 'leafgarland/typescript-vim'  " TypeScript syntax
    Plug 'peitalin/vim-jsx-typescript' " JSX syntax
    Plug 'jparise/vim-graphql'         " GraphQL syntax
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
    autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
    autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

    " Prettier
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    " Python
    Plug 'psf/black', { 'branch': 'main' }
    autocmd BufWritePre *.py execute ':Black'
    Plug 'davidhalter/jedi-vim'
    Plug 'nvie/vim-flake8'
"}}}

call plug#end()
