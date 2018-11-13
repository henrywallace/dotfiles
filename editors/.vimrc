" Remap leader first, in case loading plugins defines using the leader.
let mapleader = ' '
nnoremap <space> <nop>


"" Plugins

" vim-plug: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

"" Misc
" Heuristically set buffer options
Plug 'tpope/vim-sleuth'
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
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'zchee/deoplete-jedi'
Plug 'sebastianmarkow/deoplete-rust'
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
inoremap <c-h> <c-o><c-w><left>
inoremap <c-l> <c-o><c-w><right>
inoremap <c-j> <c-o><c-w><down>
inoremap <c-k> <c-o><c-w><up>

nnoremap <c-l> <c-w><right>
nnoremap <c-j> <c-w><down>
nnoremap <c-k> <c-w><up>

" Mappings for fzf.
nnoremap <c-g> :Rg<cr>
nnoremap <c-f> :Files<cr>
nnoremap <c-p> :BLines<cr>
nnoremap <c-x> :Commands<cr>
nnoremap <c-b> :Buffers<cr>
nnoremap <c-r> :History<cr>
nnoremap <c-c> :BCommits<cr>

" Move line(s) up or down.
nnoremap <c-down> :m +1<cr>
nnoremap <c-up> :m -2<cr>
vnoremap <c-down>:m '>+1<cr>gv
vnoremap <c-up> :m '<-2<cr>gv

inoremap <c-k> <esc>Dai

" Search for errors from ALE.
nnoremap <leader>n :ALENextWrap<cr>zz
nnoremap <leader>p :ALEPreviousWrap<cr>zz

" Argument rewrapping.
nnoremap <leader>a :ArgWrap<cr>

" Fun times with buffers.
nnoremap <leader>b :bp<cr>
nnoremap <c-\> :vsplit<cr><c-w>w
inoremap <c-\> <esc>:vsplit<cr><c-w>w
nnoremap <c-i> :split<cr><c-w>w
inoremap <c-i> <esc>:split<cr><c-w>w

" Easier saving. Note that :update differs from :w in that we only write if
" the file has in fact changed.
nnoremap <leader>s :update<cr>


"" Hooks

" Reload .vimrc on changes.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" Strip whitespaces on save: https://unix.stackexchange.com/a/75431/162041.
autocmd BufWritePre * :%s/\s\+$//e

" " Highlight long lines: https://stackoverflow.com/a/10993757/2601179.
" augroup vimrc_autocmds
"   autocmd BufEnter * highlight OverLength ctermbg=Red ctermfg=Black
"   autocmd BufEnter * match OverLength /\%101v.*/
" augroup END


"" Misc

" Show commands that are typed.
set showcmd

" Don't fold by default.
set nofoldenable

" use par for formatting paragraph.
" set equalprg=par

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

" Don't allow double spaces after sentences with rewrapping:
" https://stackoverflow.com/a/4760477/2528719
set nojoinspaces

" A nice color scheme.
colorscheme gruvbox
set background=dark
set termguicolors

" No wrapping of lines.
set wrap!

let g:ale_open_list = 0
let g:ale_lint_on_enter = 1
let g:ale_sign_column_always = 0
let g:ale_lint_delay = 500

let g:go_fmt_command = 'goimports'

" Add trailing comma during argument rewrapping.
let g:argwrap_tail_comma = 1

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" Decrease the height of the fzf search box.
let g:fzf_layout = { 'down': '~20%' }
" Customize fzf colors to match color scheme.
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Markdown code fence highlighting.
let g:markdown_fenced_languages = ['go', 'sh', 'python']

" Allow buffers with unsaved changes
set hidden

" Edit this config file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" hidden characters
nmap <leader>l :set list!<CR>

" close popup window after completion
" https://github.com/Shougo/deoplete.nvim/issues/115#issuecomment-170237485
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

call deoplete#custom#option('auto_complete_delay', 512)

" Use deoplete for auto-completion.
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" JS Customizations
let g:deoplete#sources#ternjs#types = 1

" Disable rope because it is so freaking slow; come on.
let g:pymode_rope = 0
let g:pymode_rope_autoimport = 0
let g:pymode_rope_lookup_project = 0

silent! py3 pass

let g:ale_linters = {}
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:javascript_plugin_flow = 1
let g:flow#enable = 0
let g:flow#showquickfix = 0
let g:ale_linters = {'javascript': ['eslint', 'flow']}

