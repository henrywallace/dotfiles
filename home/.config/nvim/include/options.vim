" Primary motivated by git gutter, and coc
" - https://github.com/airblade/vim-gitgutter
" - https://github.com/neoclide/coc.nvim
set updatetime=50

" Show the cursor line for ease of knowing what I'm doing in this life.
set cursorline

" I am inordinately annoyed by previously saved file dialogs.
set nobackup
set noswapfile
set nowritebackup

" Show line numbers.
set number

" Continue comment sections on return, and format numbered lists.
" - https://stackoverflow.com/a/22577860/2601179
" - https://stackoverflow.com/a/4783237/2601179
" set formatoptions+=ront
set formatoptions=croqn1jp
set tw=79
set comments=fb:-,fb:*
" set formatlistpat="^\s*[\d*-]\+[\]:.)}\t ]\s*"
"
" Don't allow double spaces after sentences with rewrapping.
" https://stackoverflow.com/a/4760477/2528719
set nojoinspaces

" No wrapping of lines.
set nowrap

" List only up to 10 best spelling suggestions, instead of an entire
" buffer-filling selection.
" - https://github.com/vim/vim/issues/4087#issue-418688650
set spellsuggest=best,10

" Markdown code fence syntax highlighting.
let g:markdown_fenced_languages = ['go', 'sh', 'py=python']
