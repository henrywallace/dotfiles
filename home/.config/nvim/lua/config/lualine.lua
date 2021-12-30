-- https://github.com/primer/primitives/blob/main/data/colors/themes/light.ts
local colors = {
  blue1 = '#ddf4ff',
  blue7 = '#0550ae',
  blue9 = '#0a3069',
  green1 = '#dafbe1',
  green7 = '#116329',
  purple1 = '#fbefff',
  purple7 = '#6639ba',
  red1 = '#FFEBE9',
  red7 = '#a40e26',
  yellow1 = '#fff8c5',
  yellow7 = '#7d4e00',
}

if vim.g.light_theme then
  custom_theme = {
    normal = {
      a = {bg = colors.blue1, fg = colors.blue7 },
      b = {bg = colors.blue1, fg = colors.blue9 },
      c = {bg = colors.blue1, fg = colors.blue9 },
    },
    insert = { a = { bg = colors.green1, fg = colors.green7 } },
    visual = { a = { bg = colors.yellow1, fg = colors.yellow7 } },
    replace = { a = { fg = colors.red1, fg = colors.red7 } },
  }
else
  -- TODO
end

-- function lsp_status()
--   if #vim.lsp.buf_get_clients() > 0 then
--     return require('lsp-status').status()
--   end
--   return ''
-- end


require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = custom_theme,
    component_separators = { left = '/', right = '/'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    -- lualine_b = {lsp_status, {'diagnostics', sources={'nvim_lsp'}}},
    lualine_b = {{'diagnostics', sources={'nvim_lsp'}}},
  },
  -- sections = {
  --   lualine_a = {'mode'},
  --   lualine_b = {'filename', 'location', 'progress'},
  --   lualine_c = {'g:coc_status', {'diagnostics', sources={'nvim_lsp', 'coc'}}},
  --   lualine_x = {'branch', 'diff'},
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
  -- inactive_sections = {},
}
