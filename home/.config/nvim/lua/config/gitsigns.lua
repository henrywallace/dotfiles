require('gitsigns').setup {
  signs = {
    add = { hl = 'DiffAdd', text = '+', numhl = 'GitSignsAddNr' },
    change = { hl = 'DiffChange', text = '~', numhl = 'GitSignsChangeNr' },
    delete = { hl = 'DiffDelete', text = '_', numhl = 'GitSignsDeleteNr' },
    topdelete = { hl = 'DiffDelete', text = '-', numhl = 'GitSignsDeleteNr' },
    changedelete = { hl = 'DiffChange', text = '*', numhl = 'GitSignsChangeNr' },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = false,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = true,
  },

  current_line_blame_formatter_opts = {
    relative_time = true,
  },
}

vim.cmd([[nnoremap <leader>h :Gitsigns preview_hunk<cr>]])
vim.cmd([[nnoremap <leader>b :Gitsigns blame_line<cr>]])
vim.cmd([[nnoremap ]c :Gitsigns next_hunk<cr>]])
vim.cmd([[nnoremap [c :Gitsigns prev_hunk<cr>]])
