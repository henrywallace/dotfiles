" some read-line key-bindings
inoremap        <C-A> <C-O>^
inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"
nnoremap        <C-A> ^
nnoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"

inoremap <C-Z> <C-O><C-Z>

" save swp files to tmp
set dir=/tmp

" use par for formatting paragraph:wqs
set equalprg=par

" auto-reload vimrc, with airline: https://github.com/vim-airline/vim-airline/issues/312#issuecomment-68677841
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC | AirlineRefresh
    autocmd BufWritePost $MYVIMRC AirlineRefresh
augroup END " }

" show all matched highlights: http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
set hlsearch

" nicer split window: https://stackoverflow.com/a/9001540/2601179
set fillchars+=vert:\


" vim-plug configuration: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" auto set paste
Plug 'roxma/vim-paste-easy'

" dracula theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Sensible defaults for Vim
Plug 'tpope/vim-sensible'

" Guess indentation from current buffer
Plug 'ciaranm/detectindent'

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" improved status line
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1

" tree view of files
Plug 'scrooloose/nerdtree'
" toggle nerdtree: https://github.com/scrooloose/nerdtree
map <C-n> :NERDTreeToggle<CR> " another comment
" close vim if only nerdtree remaining
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" ignore certain files in nerdtree
let NERDTreeIgnore = ['\.pyc$', '#.*#', '^__pycache__$']
" show hidden files
let NERDTreeShowHidden=1

" Go language support
Plug 'fatih/vim-go'

" Python support
Plug 'python-mode/python-mode'

" Docker support
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}

" JSON support
Plug 'elzr/vim-json'

" Initialize plugin system
call plug#end()

" coloring
colorscheme dracula
" show line numbers
set number
" show line,column in status bar
set statusline+=%f\ %l\:%c
" allow buffers with unsaved changes
set hidden

" fzf shortcuts
noremap <c-p> :Files<CR>
" noremap <c-b> :Buffers<CR>


" Go customizations
let g:go_fmt_command = "goimports"
noremap ≥ :GoDef<CR>

" Python customizations
let g:pymode_folding = 0

" YAML customizations
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Trigger autoread on focus change
au FocusGained,BufEnter * :silent! !

" Use ripgrep for fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob !.git/*'
let $FZF_DEFAULT_OPTS = '--height=10 --reverse'
" Ripgrep support using fzf
" https://github.com/junegunn/fzf.vim#advanced-customization
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

