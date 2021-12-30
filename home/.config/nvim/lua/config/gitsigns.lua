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
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = true,
  },

  current_line_blame_formatter_opts = {
    relative_time = true,
  },
}

-- vim.cmd([[set statusline+=%{get(b:,'gitsigns_status','')}]])

vim.cmd([[nnoremap <leader>n :Gitsigns next_hunk<cr>]])
