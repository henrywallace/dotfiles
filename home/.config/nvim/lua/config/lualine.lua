require('lualine').setup {
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
    theme = 'tokyonight',
  },
  extensions = {
    'nvim-tree',
    'symbols-outline',
  },
  sections = {
    -- lualine_a = {'mode'},
    lualine_a = {},
    lualine_b = {
      'branch',
      {'diff', colored = false},
      {
        'diagnostics',
        symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
      },
    },
    lualine_c = {
      {'filename', path = 1},
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
