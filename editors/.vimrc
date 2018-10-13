" Remap leader first, in case loading plugins defines using the leader.
let mapleader = ' '
nnoremap <space> <nop>


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
" Snippets snippets snippets.
Plug 'sirver/UltiSnips'

"" A e s t h e t i c s
Plug 'crusoexia/vim-monokai'
Plug 'dracula/vim', { 'as': 'dracula'}
Plug 'morhetz/gruvbox'
" improved status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" git annotations
Plug 'airblade/vim-gitgutter'
" folding arguments
Plug 'FooSoft/vim-argwrap'

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

nnoremap <leader>gd :vsplit<cr><c-w><c-w>:GoDef<cr>
nnoremap gr :GoReferrers<cr>

" Window movement.
nnoremap <c-v> :vsplit<cr><c-w><c-w>
nnoremap <c-h> :split<cr><c-w><c-w>
nnoremap <c-h> <c-w><left>
nnoremap <c-l> <c-w><right>
nnoremap <c-j> <c-w><down>
nnoremap <c-k> <c-w><up>

" Mappings for fzf.
nnoremap <c-g> :Rg<cr>
nnoremap <c-f> :GFiles<cr>
nnoremap <c-p> :BLines<cr>
nnoremap <c-x> :Commands<cr>
nnoremap <c-b> :Buffers<cr>
nnoremap <c-r> :History<cr>

" Navigation
nnoremap <s-j> 4j
nnoremap <s-k> 4k
nnoremap <tab> 8j
nnoremap <s-tab> 8k

" Move line(s) up or down.
nnoremap <c-down> :m +1<cr>
nnoremap <c-up> :m -2<cr>
vnoremap <c-down>:m '>+1<cr>gv
vnoremap <c-up> :m '<-2<cr>gv

" Search for errors from ALE.
nnoremap <leader>n :ALENextWrap<cr>zz
nnoremap <leader>p :ALEPreviousWrap<cr>zz

" Argument rewrapping.
nnoremap <leader>a :ArgWrap<cr>

" Fun times with buffers.
nnoremap <leader>b :bp<cr>
nnoremap <leader>q :bd<cr>

" Easier saving.
nnoremap <c-u> :update<cr>
inoremap <c-u> <c-o>:update<cr>

nnoremap <leader>c :NERDComToggleComment

inoremap <c-j> <c-o>j
inoremap <c-k> <c-o>k

"" Hooks

" Reload .vimrc on changes.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" Strip whitespaces on save: https://unix.stackexchange.com/a/75431/162041.
autocmd BufWritePre * :%s/\s\+$//e

" Highlight long lines: https://stackoverflow.com/a/10993757/2601179.
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=Red ctermfg=Black
  autocmd BufEnter * match OverLength /\%101v.*/
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


"" Misc

" Always keep gutter open to avoid bouncing.
let g:ale_sign_column_always = 1
" Ale in status line.
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_delay = 500

let g:go_fmt_command = 'goimports'

" Insert space after toggling comments.
let g:NERDSpaceDelims = 1

" Add trailing comma during argument rewrapping.
let g:argwrap_tail_comma = 1

" Decrease the height of the fzf search box.
let g:fzf_layout = { 'down': '~20%' }

" Markdown code fence highlighting.
let g:markdown_fenced_languages = ['go', 'py', 'sh']
