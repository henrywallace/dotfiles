" Remap leader first, in case loading plugins defines using the leader.

let mapleader = ' '
nnoremap <space> <nop>

" vim-plug: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" Miscellany
Plug 'FooSoft/vim-argwrap'            			" fold args
Plug 'airblade/vim-gitgutter'         			" git diff gutter
Plug 'tpope/vim-commentary'           			" toggle commen out oft lines
Plug 'tpope/vim-eunuch'               			" rename, mkdir, sudo, etc.
Plug 'google/vim-searchindex'         			" search match [1/n]
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	" fzf
Plug 'junegunn/fzf.vim'

" Language specific
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-markdown'

" A e s t h e t i c s
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

call plug#end()

" https://github.com/tmux/tmux/issues/1246
if (has("termguicolors"))
  set termguicolors
endif
" TODO: set this based on EDITOR_THEME
set background=dark
colorscheme challenger_deep

" Move between windows like hjkl, with ctrl modifier.
nnoremap <c-h> <c-w><left>
nnoremap <c-l> <c-w><right>
nnoremap <c-j> <c-w><down>
nnoremap <c-k> <c-w><up>
inoremap <c-h> <c-o><c-w><left>
inoremap <c-l> <c-o><c-w><right>
inoremap <c-j> <c-o><c-w><down>
inoremap <c-k> <c-o><c-w><up>

" Move up and down with jk keys.
nnoremap <s-j> <c-e>
nnoremap <s-k> <c-y>

" Reload .vimrc on changes.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" Edit arg or word under cursor.
nnoremap f ciw

" Show line numbers.
set number

" Enable spell checking during git commit.
autocmd FileType gitcommit setlocal spell

" Open godef into adjacent window.
nnoremap <leader>gd :vsplit<cr><c-w><c-w>:GoDef<cr>

" fzf mappings
nnoremap <c-g> :Rg<cr>
nnoremap <c-f> :BLines<cr>
nnoremap <c-r> :History<cr>

" Create new split windows faster.
" nnoremap <leader>b :bp<cr>
nnoremap <c-\> :vsplit<cr><c-w>w
inoremap <c-\> <esc>:vsplit<cr><c-w>w
