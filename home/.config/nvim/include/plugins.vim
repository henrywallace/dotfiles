call plug#begin(stdpath('data') . '/plugged')

" Miscellany
Plug 'FooSoft/vim-argwrap'            			" fold args
Plug 'tpope/vim-commentary'           			" toggle commented lines
Plug 'tpope/vim-eunuch'               			" rename, mkdir, sudo, etc.
Plug 'google/vim-searchindex'         			" search match [1/n]
Plug 'editorconfig/editorconfig-vim'                    " filetype format config
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	" fzf
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors' 			" multiple-cusors
Plug 'zivyangll/git-blame.vim'                          " simple git blame
Plug 'djoshea/vim-autoread' 				" autoreload buffers changed on disk
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-sleuth'
Plug 'airblade/vim-gitgutter'
Plug 'haya14busa/incsearch.vim'                         " highlight all while incrementally searching
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Language specific
Plug 'rust-lang/rust.vim'                               " rust
Plug 'tpope/vim-markdown'                               " markdown
Plug 'cespare/vim-toml'   				" toml
Plug 'towolf/vim-helm'                                  " helm
Plug 'zsiciarz/caddy.vim'                               " caddy

" A e s t h e t i c s
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'olivertaylor/vacme'
Plug 'endel/vim-github-colorscheme'
Plug 'dracula/vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'liuchengxu/space-vim-dark'

call plug#end()

