" some read-line key-bindings
inoremap        <C-A> <C-O>^
inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"
nnoremap        <C-A> ^
nnoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"

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

" better commenting
Plug 'scrooloose/nerdcommenter'

" auto set paste
Plug 'roxma/vim-paste-easy'

" dracula theme
Plug 'dracula/vim', { 'as': 'dracula' }

" git inline support
Plug 'airblade/vim-gitgutter'

" git wrapper
Plug 'tpope/vim-fugitive'

" Sensible defaults for Vim
Plug 'tpope/vim-sensible'

" Configure vim based on the project
Plug 'editorconfig/editorconfig-vim'

" Guess indentation from current buffer
Plug 'ciaranm/detectindent'

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Async linting while I type, fixing on save when I want
Plug 'w0rp/ale'

" sensible buffer close
Plug 'qpkorr/vim-bufkill'

" improved status line
Plug 'vim-airline/vim-airline'

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
" tree view + git
Plug 'Xuyuanp/nerdtree-git-plugin'
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

" JS customizations
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5 --jsx-bracket-same-line'

" JSON
let g:ale_fixers['json'] = ['prettier']

" Python customizations
let g:pymode_folding = 0
" let g:ale_linters['python'] = ['flake8']

let g:ale_sign_error = '!'
let g:ale_sign_warning = '.'

" YAML customizations
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" sh/bash customizations
let g:ale_sh_shellcheck_options = '-x'

" Copy and paste using system clipboard
vnoremap <C-c> "*y

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

