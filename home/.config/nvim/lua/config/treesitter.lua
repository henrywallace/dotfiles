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
