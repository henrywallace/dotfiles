require('nvim-treesitter.configs').setup {
  playground = {
    enable = true
  },
  highlight = {
    enable = true
  },
  auto_install = true,
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
}

vim.cmd([[nnoremap <leader>h :TSHighlightCapturesUnderCursor<cr>]])

-- vim.cmd([[
--   set foldmethod=expr
--   set foldexpr=nvim_treesitter#foldexpr()
--   " https://stackoverflow.com/a/37542976
--   set nofoldenable
-- ]])
