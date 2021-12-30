vim.g.coc_start_at_startup = 0

-- You can add extension names to the g:coc_global_extensions variable, and coc
-- will install the missing extensions after coc.nvim service started.
-- 
-- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#user-content-install-extensions
vim.g.coc_global_extensions = {
  'coc-diagnostic',
  'coc-docker',
  'coc-highlight',
  'coc-json',
  'coc-prettier',
  'coc-pyright',
  'coc-rls',
  'coc-sh',
  'coc-vimlsp',
  'coc-yaml',
}

vim.cmd([[
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>gd :vsplit <cr><c-w><c-w><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <leader>n <Plug>(coc-diagnostic-next)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh(

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

augroup coc
  au!
  " Highlight the symbol and its references when holding the cursor.
  au CursorHold *.go :silent call CocActionAsync('highlight')
  " Add missing imports on save
  " au BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup END

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)
]])
