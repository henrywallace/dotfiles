"" Plugins


" vim-plug: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

"" Misc
" Set paste off when pasting (typing at inhuman speeds).
Plug 'roxma/vim-paste-easy'
" Sensible defaults for Vim.
Plug 'tpope/vim-sensible'
" Fuzzy finder.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Configure vim based on the project
Plug 'editorconfig/editorconfig-vim'
" Comment things.
Plug 'scrooloose/nerdcommenter'
" You are the code.
Plug 'junegunn/goyo.vim'
" Sublime text had some great ideas.
Plug 'terryma/vim-multiple-cursors'

"" A e s t h e t i c s
Plug 'crusoexia/vim-monokai'
Plug 'dracula/vim', { 'as': 'dracula'}
Plug 'morhetz/gruvbox'
" improved status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" git annotations
Plug 'airblade/vim-gitgutter'

"" Linting
Plug 'w0rp/ale'

"" Syntax
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'kylef/apiblueprint.vim'
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-markdown'

call plug#end()


"" Mappings

" Allow SIGTSTP from within non-normal modes.
inoremap <c-z> <c-o><c-z>
vnoremap <c-z> <c-o><c-z>

" Read-line style beginning and end of line, within insert mode.
inoremap <c-e> <c-o><s-$>
inoremap <c-a> <c-o><s-^>

" Edit the word under the cursor.
nnoremap e ciw

nnoremap <leader>d :GoDef<cr>
nnoremap <leader>r :GoReferrers<cr>

" Window splitting.
nnoremap <c-v> :vsplit<cr><c-w><c-w>
nnoremap <c-h> :split<cr><c-w><c-w>

" Mappings for fzf.
nnoremap <c-l> :Lines<cr>
nnoremap <c-f> :GFiles<cr>
nnoremap <c-m> :Commands<cr>
nnoremap <c-p> :Buffers<cr>
nnoremap <c-r> :History<cr>
nnoremap <c-c> :Commands<cr>
nnoremap <space> :Rg<cr>

" Move line(s) up or down.
nnoremap <c-j> :m +1<cr>

nnoremap <c-k> :m -2<cr>
vnoremap <c-j> :m '>+1<cr>gv
vnoremap <c-k> :m '<-2<cr>gv

" Search for errors from ALE.
nnoremap <leader>n :ALENextWrap<cr>
nnoremap <leader>p :ALEPreviousWrap<cr>


"" Hooks

" Reload .vimrc on changes.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" Strip whitespaces on save: https://unix.stackexchange.com/a/75431/162041.
autocmd BufWritePre * :%s/\s\+$//e

" Highlight long lines: https://stackoverflow.com/a/10993757/2601179.
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=Red ctermfg=Black
  autocmd BufEnter * match OverLength /\%100v.*/
augroup END

"" Misc

" Show commands that are typed.
set showcmd

" Don't fold by default.
set nofoldenable

" use par for formatting paragraph.
set equalprg=par

" Show all matched highlights: http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches.
set hlsearch

" Nicer split window: https://stackoverflow.com/a/9001540/2601179.
set fillchars+=vert:\ |

" Show line numbers.
set number

" I'd rather lose changes than have to navigate the interactive swap prompts.
set nobackup
set noswapfile

" Enable syntax, don't override color settings: https://stackoverflow.com/a/33380495/2601179.
if !exists("g:syntax_on")
    syntax enable
endif

" A nice color scheme.
colorscheme gruvbox
set background=dark
set termguicolors

" No wrapping of lines.
set wrap!


"" ALE

" always keep gutter open to avoid bouncing
let g:ale_sign_column_always = 1
let g:ale_lint_on_enter = 1
" ale in status line
let g:airline#extensions#ale#enabled = 1
" setup for ALE customizations.
"let g:ale_linters = {}
"let g:ale_fixers = {}


let g:NERDSpaceDelims = 1


"" Languages

let g:go_fmt_command = "goimports"
" Highlight references in scope on cursor hover.
" let g:go_auto_sameids = 1
" " show type info on cursor hover.
" let g:go_auto_type_info = 1


"" fzf

let g:fzf_layout = { 'down': '~20%' }

