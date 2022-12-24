local colors = require("tokyonight.colors").setup()

-- This is a test
require('tokyonight').setup({
  styles = {
    comments = { colors.fg0, italic = false },
  }
})

vim.cmd([[colorscheme tokyonight-moon]])
