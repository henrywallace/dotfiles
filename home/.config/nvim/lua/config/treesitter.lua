require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  },
  auto_install = true,
}

-- vim.cmd([[
--   set foldmethod=expr
--   set foldexpr=nvim_treesitter#foldexpr()
--   " https://stackoverflow.com/a/37542976
--   set nofoldenable
-- ]])
