" beginning of line, readline style
inoremap <c-a> <c-o>^
nnoremap <c-a> ^
" end of line, readline style
inoremap <expr> <c-e> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>c-e>":"\<Lt>End>"
nnoremap <expr> <c-e> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>c-e>":"\<Lt>End>"
" edit the word under the cursor, readline style
nnoremap e ciw
" undo, readline style
nnoremap <c-_> u
inoremap <c-_> <c-o>u
" cut until end of line, readline style
inoremap <c-k> <esc>Yddi
nnoremap <c-k> Ydd

" allow suspending vim from insert mode
inoremap <c-z> <c-o><c-z>

" no more folding!
set nofoldenable

" auto strip whitespaces on save: https://unix.stackexchange.com/a/75431/162041
autocmd BufWritePre * :%s/\s\+$//e

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
set fillchars+=vert:\ |

" vim-plug configuration: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" detect indent on files
Plug 'tpope/vim-sleuth'

" be able to do/undo make window full
Plug 'vim-scripts/ZoomWin'

" auto set paste off whenver typing (pasting) at inhuman speeds
Plug 'roxma/vim-paste-easy'

" dracula theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Sensible defaults for Vim
Plug 'tpope/vim-sensible'

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

" fzf shortcuts
nnoremap <C-F> :Files<CR>
inoremap <C-F> <C-O>:Files<CR>
nnoremap <C-B> :Buffers<CR>
inoremap <C-B> <C-O>:Buffers<CR>
nnoremap <C-R> :History:<CR>
inoremap <C-R> <C-O>:History:<CR>
nnoremap <C-X> :Commands<CR>
inoremap <C-X> <C-O>:Commands<CR>

" Go customizations
let g:go_fmt_command = "goimports"

" fzf files preview command with preview window
command! -bang -nargs=? -complete=dir Fiiles
  \ call fzf#vim#files('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
"command! -bang -nargs=? -complete=dir Files
"  \ call fzf#vim#files(<q-args>, fzf#vim#with_pre
let g:fzf_layout = { 'down': '~40%' }
