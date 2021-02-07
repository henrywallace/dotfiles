set colorcolumn=80,100
set termguicolors
set background=dark

colorscheme challenger_deep
highlight SignColumn ctermbg=232 guibg=#100E23
hi CocHighlightText guifg=#34b2ff
hi goComment ctermfg=243 gui=none guifg=#767676
hi IncSearch cterm=underline ctermfg=153 gui=underline guifg=#cbe3e7

" Disable Searchant highlight when incsearch.vim highlights also disable
autocmd CursorMoved * call SearchantStop()
function SearchantStop()
  :execute "normal \<Plug>SearchantStop"
endfunction
