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
" Commenting
Plug 'tpope/vim-commentary'
" You are the code.
Plug 'junegunn/goyo.vim'
" Sublime text had some great ideas.
Plug 'terryma/vim-multiple-cursors'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Helper for GitHub
Plug 'tpope/vim-rhubarb'

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

"" Autocomplete
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" for Go
Plug 'zchee/deoplete-go', { 'do': 'make' }
" for Python (hopefully better than rope)
Plug 'zchee/deoplete-jedi'
" for Rust
Plug 'sebastianmarkow/deoplete-rust'
" for JS (flow-based)
" Plug 'wokalski/autocomplete-flow'
Plug 'carlitux/deoplete-ternjs'


"" Syntax
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'flowtype/vim-flow'
Plug 'kylef/apiblueprint.vim'
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}
Plug 'pangloss/vim-javascript'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'python-mode/python-mode'
Plug 'tpope/vim-markdown'

call plug#end()

" allow buffers with unsaved changes
set hidden

" I proclaim it to be incorrect to put two spaces after a sentence
" ref: https://stackoverflow.com/a/4760477/2528719
set nojoinspaces


" Edit this config file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>



" hidden characters
nmap <leader>l :set list!<CR>


"" Deoplete
" Use deoplete for auto-completion.
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" deoplete Go customizations, boosting rank
call deoplete#custom#source('go', 'rank', 1000)
" JS Customizations
let g:deoplete#sources#ternjs#types = 1


" Disable rope because is is horrendously slow with big projects
let g:pymode_rope = 0
let g:pymode_rope_autoimport = 0
let g:pymode_rope_lookup_project = 0


let g:ale_linters = {}
let g:ale_fixers = {}


" JS customizations
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:javascript_plugin_flow = 1
" disable flow checking, using ale instead
let g:flow#enable = 0
let g:flow#showquickfix = 0
" Only use desired plugins for JS, avoids unwanted use of jshint.
let g:ale_linters = {'javascript': ['eslint', 'flow']}



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
nnoremap gi :GoImplements<cr>

" Window movement.
" nnoremap <c-v> :vsplit<cr><c-w><c-w>
" nnoremap <c-h> :split<cr><c-w><c-w>
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
nnoremap <s-j> 8j
nnoremap <s-k> 8k

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

" inoremap <c-j> <c-o>j
" inoremap <c-k> <c-o>k
" inoremap <c-h> <c-o>h
" inoremap <c-l> <c-o>l

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

" https://github.com/scrooloose/nerdcommenter#post-installation
filetype plugin on

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
