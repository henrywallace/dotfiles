" Remap leader first, in case loading plugins defines using the leader.

let mapleader = ' '
nnoremap <space> <nop>

" vim-plug: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" Miscellany
Plug 'FooSoft/vim-argwrap'            			" fold args
Plug 'tpope/vim-commentary'           			" toggle commented lines
Plug 'tpope/vim-eunuch'               			" rename, mkdir, sudo, etc.
Plug 'google/vim-searchindex'         			" search match [1/n]
Plug 'editorconfig/editorconfig-vim'                    " filetype format config
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	" fzf
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " language server
Plug 'terryma/vim-multiple-cursors' 			" multiple-cusors
Plug 'zivyangll/git-blame.vim'                          " simple git blame
Plug 'djoshea/vim-autoread' 				" autoreload buffers changed on disk
Plug 'tpope/vim-surround' 				" modify surrounding chars
Plug 'tpope/vim-sleuth'
Plug 'airblade/vim-gitgutter'

" Language specific
Plug 'rust-lang/rust.vim'                               " rust
Plug 'tpope/vim-markdown'                               " markdown
Plug 'cespare/vim-toml'   				" toml
Plug 'towolf/vim-helm'                                  " helm

" A e s t h e t i c s
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'olivertaylor/vacme'
Plug 'endel/vim-github-colorscheme'
Plug 'dracula/vim'
Plug 'phanviet/vim-monokai-pro'

call plug#end()

"
" Generic key-bindings
"

" " Move between windows like hjkl, with ctrl modifier.
" function! WinMove(key)
"     let t:curwin = winnr()
"     exec "wincmd ".a:key
"     if (t:curwin == winnr())
"         if (match(a:key,'[jk]'))
"             wincmd v
"         else
"             wincmd s
"         endif
"         exec "wincmd ".a:key
"     endif
" endfunction
" nnoremap <c-h> :call WinMove('h')<CR>
" nnoremap <c-j> :call WinMove('j')<CR>
" nnoremap <c-k> :call WinMove('k')<CR>
" nnoremap <c-l> :call WinMove('l')<CR>

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

" Open up file viewer.
nnoremap <c-m> :Explore<cr>

" Edit arg or word under cursor.
nnoremap f ciw

" Faster saving.
nnoremap <leader>j :wa<cr>

" Create new split windows faster.
" nnoremap <leader>b :bp<cr>
nnoremap <c-\> :vsplit<cr><c-w>w
inoremap <c-\> <esc>:vsplit<cr><c-w>w
" nnoremap <c-l> :split<cr><c-w>w
" inoremap <c-l> <esc>:split<cr><c-w>w

" Move cursor to bottom after yanking.
" https://stackoverflow.com/a/3806683/2601179
vmap y y`]

" Move line(s) up or down.
nnoremap <c-down> :m +1<cr>
nnoremap <c-up> :m -2<cr>
vnoremap <c-down>:m '>+1<cr>gv
vnoremap <c-up> :m '<-2<cr>gv

" Show current enclosing scope; usually.
" https://vi.stackexchange.com/a/12429
nnoremap <leader>l :echo getline(search('\v^[[:alpha:]$_]', "bn", 1, 100))<CR>

" Show git blame for current line. Simpler and less obtrusive.
nnoremap <leader>b :<C-u>call gitblame#echo()<CR>

" " https://github.com/ap/vim-buftabline
" set showtabline=2
" set hidden
" nnoremap <tab> :bnext<cr>
" nnoremap <s-tab> :bprev<cr>
" nnoremap <leader>w :bd<cr>

" show hilight group under cursor
nnoremap <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

"
" Generic settings
"

" Primary motivated by git gutter, and coc
" https://github.com/airblade/vim-gitgutter
" https://github.com/neoclide/coc.nvim
set updatetime=100

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

" Show the cursor line for ease of knowing what I'm doing in this life.
set cursorline

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
" https://stackoverflow.com/a/4783237/2601179
set formatoptions+=cront
set tw=79
set comments=fb:-,fb:*
" set formatlistpat="^\s*[\d*-]\+[\]:.)}\t ]\s*"

" Don't allow double spaces after sentences with rewrapping.
" https://stackoverflow.com/a/4760477/2528719
set nojoinspaces

" No wrapping of lines.
set nowrap

" List only up to 10 best spelling suggestions, instead of an entire
" buffer-filling selection.
"
" https://github.com/vim/vim/issues/4087#issue-418688650
set spellsuggest=best,10

nnoremap z0 1z=

" " Backspace can not work in some wird cases.
" set backspace=indent,eol,start

"
" Plugin Settings
"

" coc improvements
set cmdheight=2
set shortmess+=c
set signcolumn=yes
inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<tab>" :
      \ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
nmap gd <Plug>(coc-definition) zz
nmap gy <Plug>(coc-type-definition)
nmap <leader>gd :vsplit<cr><c-w><c-w><Plug>(coc-definition) zz
" Highlight current symbol under cursor.
" https://github.com/neoclide/coc-highlight#usage
autocmd CursorHold * silent call CocActionAsync('highlight')
" goimport on save
" https://github.com/josa42/coc-go#examples
" https://github.com/neoclide/coc.nvim/issues/888
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
nmap <leader>n <Plug>(coc-diagnostic-next-error)
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Argument rewrapping, and add trailing commas.
nnoremap <leader>a :ArgWrap<cr>
let g:argwrap_tail_comma = 1

" fzf mappings
nnoremap <c-g> :Rg<cr>
nnoremap <c-f> :BLines<cr>
nnoremap <c-r> :History<cr>
nnoremap <c-p> :Files<cr>
nnoremap <c-x> :Commands<cr>
nnoremap <leader>h :History:<cr>

nnoremap <leader>m noh

vnoremap <leader>p !par T8 'B=.,?_A_a' 79qrp13dh<cr>

" function! GitGutterNextHunkCycle()
"   let line = line('.')
"   silent! GitGutterNextHunk
"   if line('.') == line
"     1
"     GitGutterNextHunk
"   endif
" endfunction

nmap <leader>g :GitGutterNextHunk <cr>

" Markdown code fence syntax highlighting.
let g:markdown_fenced_languages = ['go', 'sh', 'py=python']

set timeoutlen=1000 ttimeoutlen=0

set colorcolumn=80,100

"
" Theme settings



" https://github.com/tmux/tmux/issues/1246
if (has("termguicolors"))
  set termguicolors
endif
" TODO: set this based on EDITOR_THEME

" colorscheme vacme
" hi CocHighlightText ctermfg=238 ctermbg=8 guifg=#424242 guibg=#EEEEA7

" hi SignColumn guibg=none
" hi StatusLine cterm=NONE gui=bold guibg=grey93 guifg=none
" hi StatusLineNC cterm=NONE gui=none guibg=grey93 guifg=none
" hi ColorColumn gui=none guibg=#f5fdff guifg=none ctermbg=NONE
" hi LineNr guifg=grey74
" hi CursorLineNr guifg=grey35 gui=bold
" " hi CocHighlightText gui=bold
" hi CocHighlightText guibg=lightyellow
" hi VertSplit gui=none cterm=NONE guibg=black guifg=black
" hi Visual guibg=yellow

set background=dark

" " gruvbox theme
" colorscheme gruvbox
" highlight SignColumn ctermbg=235 guibg=#282828

colorscheme challenger_deep
" Only do this if current theme is challenger_deep
highlight SignColumn ctermbg=232 guibg=#100E23
" hi CocHighlightText guifg=plum
" hi CocHighlightText guifg=#91ddff
" hi CocHighlightText guifg=pink
" hi CocHighlightText ctermbg=236 guibg=#565575
hi CocHighlightText guifg=#65b2ff
hi goComment ctermfg=243 gui=none guifg=#767676
hi IncSearch cterm=underline ctermfg=253 gui=underline guifg=#cbe3e7
" hi goComment ctermfg=243 gui=none guifg=#91ddff
" hi goComment ctermfg=243 gui=none guifg=#ffe9aa

" set background=light
" colorscheme vacme
" hi MatchParen ctermfg=238 ctermbg=8 guifg=#424242 guibg=#EEEEA7
" hi CocHighlightText ctermfg=238 ctermbg=8 guifg=#424242 guibg=#EEEEA7
" hi goComment ctermfg=195 guifg=#EEFEFF

" set background=light
" colorscheme summerfruit256
" hi SignColumn guibg=none
" hi LineNr guibg=none guifg=lightgray gui=none
" hi CursorLineNr cterm=underline ctermbg=153 guibg=#c0d9eb guifg=#438ec3 gui=none
" hi TabLine gui=none guibg=white
" hi TabLineSel gui=bold guifg=black guibg=white
" hi TabLineFill gui=none guibg=white
" hi Comment gui=none
" hi StatusLine guibg=white guifg=black gui=bold
" hi StatusLineNC guibg=white guifg=black gui=none
" hi CocHighlightText guibg=#ffe9aa

" hi Cursor guibg=red guifg=white

" hi Cursor ctermbg=red ctermfg=blue guibg=blue guifg=white

