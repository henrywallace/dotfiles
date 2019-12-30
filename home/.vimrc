
" Remap leader first, in case loading plugins defines using the leader.
let mapleader = ' '
nnoremap <space> <nop>

" vim-plug: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'FooSoft/vim-argwrap'            " fold arguments
Plug 'airblade/vim-gitgutter'         " git diff gutter
Plug 'editorconfig/editorconfig-vim'  " configure vim based on the project
Plug 'majutsushi/tagbar'              " ctags sidebar
Plug 'roxma/vim-paste-easy'           " set paste off when pasting (typing at inhuman speeds)
Plug 'terryma/vim-multiple-cursors'   " multi-cursor ftw
Plug 'tpope/vim-commentary'           " toggle comment lines
Plug 'tpope/vim-eunuch'               " sudo write, rename file, mkdir, etc.
Plug 'tpope/vim-fugitive'             " git wrapper
Plug 'tpope/vim-sensible'             " sensible defaults for Vim.
Plug 'tpope/vim-sleuth'               " heuristically set buffer options
Plug 'dense-analysis/ale'             " linting
Plug 'zivyangll/git-blame.vim'        " unintrusive git blame line
Plug 'wellle/targets.vim'
Plug 'google/vim-searchindex'         " show which search match number out of
Plug 'jszakmeister/vim-togglecursor'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" A e s t h e t i c s
Plug 'dracula/vim', { 'as': 'dracula'}
Plug 'morhetz/gruvbox'
Plug 'neutaaaaan/blaaark'
Plug 'arcticicestudio/nord-vim'
Plug 'challenger-deep-theme/vim'

" Syntax
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'flowtype/vim-flow'
Plug 'kylef/apiblueprint.vim'
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-markdown'
Plug 'isobit/vim-caddyfile'

call plug#end()

" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
" https://superuser.com/a/588243/577047
if &term =~ '256color'
    set t_ut=
endif

" Format rust files on save.
let g:rustfmt_autosave = 1

" Allow SIGTSTP from within non-normal modes.
inoremap <c-z> <c-o><c-z>
vnoremap <c-z> <c-o><c-z>

" Read-line style beginning and end of line, within insert mode.
inoremap <c-e> <c-o><s-$>
inoremap <c-a> <c-o><s-^>

" Open godef into adjacent window.
nnoremap <leader>gd :vsplit<cr><c-w><c-w>:GoDef<cr>

" TODO: renable, once gopls-referrers doesn't always fail, or when
" guru-referrers doesn't take 1 hour to finish.
" nnoremap gr :GoReferrers<cr>

" Move between windows like hjkl, with ctrl modifier.
nnoremap <c-h> <c-w><left>
nnoremap <c-l> <c-w><right>
nnoremap <c-j> <c-w><down>
nnoremap <c-k> <c-w><up>
inoremap <c-h> <c-o><c-w><left>
inoremap <c-l> <c-o><c-w><right>
inoremap <c-j> <c-o><c-w><down>
inoremap <c-k> <c-o><c-w><up>

" Create new split windows faster.
" nnoremap <leader>b :bp<cr>
nnoremap <c-\> :vsplit<cr><c-w>w
inoremap <c-\> <esc>:vsplit<cr><c-w>w

" Less intrusive git blame on status line, nicer than Gblame.
nnoremap <leader>b :GitBlame<cr>

" fzf mappings
nnoremap <c-g> :Rg<cr>
nnoremap <c-f> :BLines<cr>
nnoremap <c-p> :Files<cr>
nnoremap <c-b> :Buffers<cr>
nnoremap <c-r> :History<cr>
nnoremap <c-c> :Commands<cr>

" Edit arg or word under cursor.
nnoremap f ciw
nnoremap F BcE

" reformat paragraph?
" TODO: Make this is as good as emac's meta-Q
nnoremap Q <s-{><s-v><s-}>gq<c-o><c-o>

" Don't allow double spaces after sentences with rewrapping.
" https://stackoverflow.com/a/4760477/2528719
set nojoinspaces

" Close buffer without closing buffer.
" https://stackoverflow.com/questions/4465095/vim-delete-buffer-without-losing-the-split-window
" TODO: Make this work. It would be dope.
" nnoremap <leader>q bp\|bd #

" Continue comment sections on return, and format numbered lists.
" https://stackoverflow.com/a/22577860/2601179
set formatoptions+=cron

" Move line(s) up or down.
nnoremap <c-down> :m +1<cr>
nnoremap <c-up> :m -2<cr>
vnoremap <c-down>:m '>+1<cr>gv
vnoremap <c-up> :m '<-2<cr>gv

" Search for errors from ALE.
nnoremap <leader>n :ALENextWrap<cr>zz

" Argument rewrapping, and add trailing commas.
nnoremap <leader>a :ArgWrap<cr>
let g:argwrap_tail_comma = 1

" Easier saving. Note that :update differs from :w in that we only write if
" the file has in fact changed.
nnoremap <leader>j :update<cr>
" inoremap <c-j> <c-o>:update<cr>

" Move cursor to bottom after yanking.
" https://stackoverflow.com/a/3806683/2601179
vmap y y`]

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

""" Allow spell check under current cursor, even if spell isn't set, which is
""" probably the case when editing code. This is useful for check spelling of
""" words within documentation.
"""
""" https://stackoverflow.com/a/22182089/2601179
""function! s:spell_check_current()
""  setlocal spell
""  normal z=
""  setlocal nospell
""endfunction
""nnoremap <c-s> :call <SID>spell_check_current()<CR>

" " Visual rulers, depending on the filetype.
" autocmd FileType go set colorcolumn=80,100

" autocmd FileType python set colorcolumn=80,100

"autocmd FileType go let b:vcm_tab_complete = 'tags'

"" autocmd Filetype yaml set cursorcolumn

" Show commands that are typed.
set showcmd

"" Make filename tab completion work more like it does in most shells, instead
"" of completing the filename to the first match with subsequent presses not
"" elicit any list of possible completions.
"if has("wildmenu")
"  set wildmenu
"  set wildmode=longest:list,full
"endif

" Enable spell checking during git commit.
autocmd FileType gitcommit setlocal spell
hi SpellBad ctermfg=red

" Show all matched highlights.
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
set hlsearch

" Nicer split window.
" https://stackoverflow.com/a/9001540/2601179
set fillchars+=vert:\ |

" Show line numbers.
set number

" I'd rather lose changes than have to navigate the interactive swap prompts.
set nobackup
set noswapfile

" Enable syntax, don't override color settings.
" https://stackoverflow.com/a/33380495/2601179
if !exists("g:syntax_on")
    syntax enable
endif

" No wrapping of lines.
set wrap!

" let g:ale_linters['go'] = ['gopls', 'revive', 'misspell']
let g:ale_linters = {
  \ 'go': ['gopls', 'misspell', 'revive', 'govet'],
\ }
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command='goimports'

" Prevent annoying popup loc list on errors
" https://github.com/fatih/vim-go/issues/1682
let g:go_fmt_fail_silently = 1

let g:ale_list_window_size = 6
let g:ale_sign_error = '✘'

" Make vim-go faster.
set ttyfast
set lazyredraw
syntax sync minlines=256

" change fzf colors to match color scheme.
let g:fzf_colors =
 \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Pink'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Markdown code fence syntax highlighting.
let g:markdown_fenced_languages = ['go', 'sh', 'py=python']

" Allow buffers with unsaved changes
set hidden

set nofoldenable

" nnoremap <c-p> :bnext<CR>
nnoremap <c-i> :bprev<CR>

" hidden characters
nmap <leader>l :set list!<CR>

" TODO: set this based on EDITOR_THEME
set background=dark
if (has("termguicolors"))
 set termguicolors
endif
colorscheme challenger_deep

