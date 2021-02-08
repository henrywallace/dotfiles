augroup custom
  au!
  " Open a file in the same location as it was opened last time.
  " - https://stackoverflow.com/a/774599/2601179
  if &ft !=# 'gitcommit'
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  endif
  " Strip whitespaces on save.
  " - https://unix.stackexchange.com/a/75431/162041.
  au BufWritePre * :%s/\s\+$//e
augroup END

" Reload .vimrc on changes.
augroup custom_vim
  au!
  au BufWritePost $MYVIMRC source $MYVIMRC
augroup END

augroup custom_git
  au!
  " Enable spell checking during git commit.
  au FileType gitcommit setlocal spell
  " Commit subject lines get hacked off if more than 72.
  au FileType gitcommit set colorcolumn=72,80
augroup END

augroup custom_yaml
  au!
  au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup END
