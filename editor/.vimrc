" Remap leader first, in case loading plugins defines using the leader.
"
let mapleader = ' '
nnoremap <space> <nop>

" vim-plug: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'FooSoft/vim-argwrap'            " fold arguments
Plug 'airblade/vim-gitgutter'         " git diff gutter
Plug 'editorconfig/editorconfig-vim'  " configure vim based on the project
Plug 'majutsushi/tagbar'              " ctags sidebar
Plug 'roxma/vim-paste-easy'           " set paste off when pasting (typing at inhuman speeds).
Plug 'terryma/vim-multiple-cursors'   " multi-cursor ftw
Plug 'tpope/vim-commentary'           " toggle comment lines
Plug 'tpope/vim-eunuch'               " sudo write, rename file, mkdir, etc.
Plug 'tpope/vim-fugitive'             " git wrapper
Plug 'tpope/vim-sensible'             " sensible defaults for Vim.
Plug 'tpope/vim-sleuth'               " heuristically set buffer options
Plug 'w0rp/ale'                       " linting
Plug 'zivyangll/git-blame.vim'        " unintrusive git blame line
Plug 'wagnerf42/vim-clippy'
Plug 'the-lambda-church/coquille'
Plug 'wellle/targets.vim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Auto format
Plug 'google/vim-codefmt'
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" A e s t h e t i c s
Plug 'abnt713/vim-hashpunk'
Plug 'crusoexia/vim-monokai'
Plug 'dracula/vim', { 'as': 'dracula'}
Plug 'liuchengxu/space-vim-dark'
Plug 'morhetz/gruvbox'
Plug 'neutaaaaan/blaaark'
Plug 'pgdouyon/vim-yin-yang'
Plug 'treycucco/vim-monotonic'
Plug 'wolverian/minimal'

"" Syntax
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'flowtype/vim-flow'
Plug 'kylef/apiblueprint.vim'
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-markdown'

call plug#end()

" Color theme. We define this earlier on so that we can more freely customize
" colors later on.
set termguicolors
if $EDITOR_THEME == "LIGHT"
  colorscheme minimal
  " let g:airline_theme='minimalist'
  set background=light
  hi ColorColumn ctermbg=2 guibg=white
  hi StatusLine cterm=bold guifg=black guibg=lightcyan
  hi SignColumn none
  hi IncSearch cterm=bold guibg=blue guifg=white
  hi Search cterm=none guibg=yellow guifg=black
  hi String guifg=darkblue
  " hi rustFuncName cterm=bold guifg=darkblue
  hi Function cterm=bold guifg=darkblue
  hi Todo cterm=bold,italic guibg=NONE
  hi Error guifg=red guibg=NONE cterm=bold
  hi LineNr guifg=ivory
  hi StatusLineNC guibg=bg
  hi VertSplit guifg=bg
  " hi MatchParen guibg=lightcyan
  hi MatchParen guibg=yellow
  hi LineNr guifg=wheat2
  hi Normal guibg=white
  hi Comment guifg=seagreen
  " hi IncSearch  guifg=Black guibg=Red
else
  colorscheme Blaaark
  set background=dark
  " colorscheme space-vim-dark
  " colorscheme yin
  " " yin customizations
  hi MatchParen guifg=White guibg=Black cterm=bold
  hi Comment cterm=NONE guifg=#776587 guibg=NONE
  hi Search  cterm=bold  guifg=Pink guibg=Black
  hi GitGutterAdd  guibg=#212026
  hi GitGutterChange guibg=#212026
  hi GitGutterDelete guibg=#212026
  hi GitGutterChangeDelete guibg=#212026
  hi SignColumn guibg=#212026
  hi Boolean guifg=#c2bff2
  hi Todo cterm=bold guifg=#fdffbc
  " hi IncSearch  guifg=Black guibg=Red
  " hi Search     guifg=Orange guibg=Black
endif

let g:rustfmt_autosave = 1

" Allow SIGTSTP from within non-normal modes.
inoremap <c-z> <c-o><c-z>
vnoremap <c-z> <c-o><c-z>

" Read-line style beginning and end of line, within insert mode.
inoremap <c-e> <c-o><s-$>
inoremap <c-a> <c-o><s-^>

" Open godef into adjacent window.
nnoremap <leader>gd :vsplit<cr><c-w><c-w>:GoDef<cr>
nnoremap gr :GoReferrers<cr>


" Move between windows like hjkl, but with ctrl modifier.
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
nnoremap <c-r> :History:<cr>
nnoremap <c-c> :Commands<cr>
" nnoremap <c-g> :BCommits<cr>

" Edit arg or word under cursor.
nnoremap f ciw
nnoremap F BcE

" reformat paragraph?
" TODO: Make this is as good as emac's meta-Q
nnoremap Q <s-{><s-v><s-}>gq<c-o><c-o>

" Don't allow double spaces after sentences with rewrapping:
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

" Strip whitespaces on save: https://unix.stackexchange.com/a/75431/162041.
autocmd BufWritePre * :%s/\s\+$//e

" Open a file in the same location as it was opened last time.
" https://stackoverflow.com/a/774599/2601179
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Visual rulers, depending on the filetype.
autocmd FileType go set colorcolumn=80,100

" Show commands that are typed.
set showcmd

" Make filename tab completion work more like it does in most shells, instead
" of completing the filename to the first match with subsequent presses not
" elicit any list of possible completions.
if has("wildmenu")
  set wildmenu
  set wildmode=longest:list,full
endif

" Enable spell checking during git commit.
" TODO: Get this working.
autocmd FileType gitcommit setlocal spell
hi SpellBad ctermfg=red

" Show all matched highlights:
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches.
set hlsearch

" Nicer split window: https://stackoverflow.com/a/9001540/2601179.
set fillchars+=vert:\ |

" Show line numbers.
set number

" I'd rather lose changes than have to navigate the interactive swap prompts.
set nobackup
set noswapfile

" Enable syntax, don't override color settings:
" https://stackoverflow.com/a/33380495/2601179.
if !exists("g:syntax_on")
    syntax enable
endif

" No wrapping of lines.
set wrap!

" Autoformat
""https://github.com/google/vim-codefmt#autoformatting
call glaive#Install()
" Glaive codefmt google_java_executable="java -jar PATH...."
augroup autoformat_settings
  autocmd FileType java AutoFormatBuffer google-java-format
augroup END

let g:go_def_mode='gopls'
" let g:go_def_mode = 'godef'         " godef is so much faster
let g:go_fmt_command = 'goimports'  " https://github.com/sqs/goreturns
let g:go_fmt_fail_silently = 1
let g:ale_go_bingo_executable = 'gopls'

" Make vim-go faster.
" set re=1
" set ttyfast
" set lazyredraw
" set nocursorcolumn
" syntax sync minlines=256

" " " change fzf colors to match color scheme.
" let g:fzf_colors =
"  \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

" Markdown code fence syntax highlighting.
let g:markdown_fenced_languages = ['go', 'sh', 'py=python']

" Allow buffers with unsaved changes
set hidden

" nnoremap <c-p> :bnext<CR>
nnoremap <c-i> :bprev<CR>

" hidden characters
nmap <leader>l :set list!<CR>


let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-b>'
let g:UltiSnipsJumpBackwardTrigger = '<c-z>'
