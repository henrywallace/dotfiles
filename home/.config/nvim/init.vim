runtime include/plugins.vim
runtime include/style.vim
runtime include/keybindings.vim
runtime include/autocmds.vim
runtime include/options.vim

" Temporary settings below:

let g:LanguageClient_serverCommands = {
    \ 'go': {
    \   'name': 'gopls',
    \   'command': ['gopls'],
    \   'initializationOptions': {
    \     'usePlaceholders': v:true,
    \   },
    \ },
    \}
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> gi <Plug>(lcn-implementation)
nmap <silent> gr <Plug>(lcn-references)
nmap <leader>gd :vsplit<cr><c-w><c-w><Plug>(lcn-definition)
nmap <silent>n <Plug>(lcn-diagnostics-next)
nmap <silent> <c-k> <Plug>(lcn-hover)
nnoremap <silent> <F2> <Plug>(lcn-rename)
" https://github.com/autozimu/LanguageClient-neovim/issues/550#issuecomment-463746495
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
    \ 'auto_complete_delay': 20,
    \ 'smart_case': v:true,
    \ 'max_list': 20,
    \ })
" complete on tab
" https://github.com/Shougo/deoplete.nvim/issues/816#issuecomment-409119497
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
