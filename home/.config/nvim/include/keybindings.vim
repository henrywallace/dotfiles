" Leader
let mapleader = ' '
nnoremap <space> <nop>

" Move between windows more easily.
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
nnoremap <leader>j :wr<cr>

" Split windows
nnoremap <c-\> :vsplit<cr><c-w>w
inoremap <c-\> <esc>:vsplit<cr><c-w>w

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
nnoremap <leader>l :echo getline(search('\v^[[:alpha:]$_]', "bn", 1, 100))<cr>

" Show git blame for current line. Simpler and less obtrusive.
nnoremap <leader>b :<C-u>call gitblame#echo()<cr>

" show highlight group under cursor
nnoremap <leader>hg :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" Argument rewrapping, and add trailing commas.
nnoremap <leader>a :ArgWrap<cr>
let g:argwrap_tail_comma = 1

" fzf mappings
nnoremap <c-g> :Rg<cr>
nnoremap <c-f> :BLines<cr>
nnoremap <c-r> :History<cr>
nnoremap <c-p> :Files<cr>
nnoremap <c-x> :Commands<cr>
