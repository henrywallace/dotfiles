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
Plug 'editorconfig/editorconfig-vim'                    " filetype format config
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	" fzf
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " language server
Plug 'dense-analysis/ale'                               " linting

" Language specific
Plug 'fatih/vim-go'                                     " go
Plug 'rust-lang/rust.vim'                               " rust
Plug 'tpope/vim-markdown'                               " markdown

" A e s t h e t i c s
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'olivertaylor/vacme'

call plug#end()

"
" Theme settings
"

" https://github.com/tmux/tmux/issues/1246
if (has("termguicolors"))
  set termguicolors
endif
" TODO: set this based on EDITOR_THEME
set background=dark
colorscheme challenger_deep
" set background=light
" colorscheme vacme

" Only do this if current theme is challenger_deep
highlight SignColumn ctermbg=232 guibg=#100E23

"
" Generic key-bindings
"

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

" Read-line style beginning and end of line, within insert mode.
inoremap <c-e> <c-o><s-$>
inoremap <c-a> <c-o><s-^>

" Edit arg or word under cursor.
nnoremap f ciw

" Faster saving.
nnoremap <leader>j :wa<cr>

" Create new split windows faster.
" nnoremap <leader>b :bp<cr>
nnoremap <c-\> :vsplit<cr><c-w>w
inoremap <c-\> <esc>:vsplit<cr><c-w>w

" Move cursor to bottom after yanking.
" https://stackoverflow.com/a/3806683/2601179
vmap y y`]

" Move line(s) up or down.
nnoremap <c-down> :m +1<cr>
nnoremap <c-up> :m -2<cr>
vnoremap <c-down>:m '>+1<cr>gv
vnoremap <c-up> :m '<-2<cr>gv

"
" Generic settings
"

" Primary motivated by git gutter, and coc
" https://github.com/airblade/vim-gitgutter
" https://github.com/neoclide/coc.nvim
set updatetime=300

" Reload .vimrc on changes.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" Strip whitespaces on save.
" https://unix.stackexchange.com/a/75431/162041.
autocmd BufWritePre * :%s/\s\+$//e

" Open a file in the same location as it was opened last time.
" https://stackoverflow.com/a/774599/2601179
if has("autocmd") && &filetype != 'gitcommit'
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" I am inordinately annoyed by previously saved file dialogs.
set nobackup
set noswapfile
set nowritebackup

" Show line numbers.
set number

" Enable spell checking during git commit.
autocmd FileType gitcommit setlocal spell

" Continue comment sections on return, and format numbered lists.
" https://stackoverflow.com/a/22577860/2601179
set formatoptions+=cron

" Don't allow double spaces after sentences with rewrapping.
" https://stackoverflow.com/a/4760477/2528719
set nojoinspaces

" No wrapping of lines.
set wrap!

"
" Plugin Settings
"

" vim-go
"
" Import on save, instead of just gofmt.
let g:go_fmt_command='goimports'
" Prevent annoying popup loc list on errors
" https://github.com/fatih/vim-go/issues/1682
let g:go_fmt_fail_silently = 1
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" coc improvements
"
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" In addition to c-n, and c-p to cycle through completion options, also use
" <tab>, and to trigger completion.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nnoremap <leader>gd :vsplit<cr><c-w><c-w><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next-error)

" ALE linter
" nnoremap <leader>n :ALENextWrap<cr>zz
" let g:ale_enabled = 1
" let g:ale_list_window_size = 6
" let g:ale_sign_error = '✘'

" Argument rewrapping, and add trailing commas.
nnoremap <leader>a :ArgWrap<cr>
let g:argwrap_tail_comma = 1

" fzf mappings
nnoremap <c-g> :Rg<cr>
nnoremap <c-f> :BLines<cr>
nnoremap <c-r> :History<cr>
nnoremap <c-p> :Files<cr>

" Markdown code fence syntax highlighting.
let g:markdown_fenced_languages = ['go', 'sh', 'py=python']
