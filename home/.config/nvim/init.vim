runtime include/plugins.vim
runtime include/style.vim
runtime include/keybindings.vim
runtime include/autocmds.vim
runtime include/options.vim

"
" Generic settings
"

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
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:coc_global_extensions = [
    \'coc-diagnostic',
    \'coc-json',
    \'coc-python',
    \'coc-highlight',
    \'coc-yaml',
    \'coc-prettier',
    \'coc-rls',
\]
