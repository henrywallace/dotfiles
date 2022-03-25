require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  },
  ensure_installed = {
    "go",
    "gomod",
    "lua",
    "html",
    "json",
    "python",
    "toml",
    "yaml",
    "vim",
    "bash",
  },
}

vim.cmd([[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  " https://stackoverflow.com/a/37542976
  set nofoldenable
]])
