-- https://github.com/nvim-treesitter/nvim-treesitter/commit/42ab95d5e11f247c6f0c8f5181b02e816caa4a4f#commitcomment-87014462
-- This code can be used to recover the highlights until themes are updated
local hl = function(group, opts)
    opts.default = true
    vim.api.nvim_set_hl(0, group, opts)
end

-- Misc {{{
hl('@comment', {link = 'Comment'})
-- hl('@error', {link = 'Error'})
hl('@none', {bg = 'NONE', fg = 'NONE'})
hl('@preproc', {link = 'PreProc'})
hl('@define', {link = 'Define'})
hl('@operator', {link = 'Operator'})
-- }}}

-- Punctuation {{{
hl('@punctuation.delimiter', {link = 'Delimiter'})
hl('@punctuation.bracket', {link = 'Delimiter'})
hl('@punctuation.special', {link = 'Delimiter'})
-- }}}

-- Literals {{{
hl('@string', {link = 'String'})
hl('@string.regex', {link = 'String'})
hl('@string.escape', {link = 'SpecialChar'})
hl('@string.special', {link = 'SpecialChar'})

hl('@character', {link = 'Character'})
hl('@character.special', {link = 'SpecialChar'})

hl('@boolean', {link = 'Boolean'})
hl('@number', {link = 'Number'})
hl('@float', {link = 'Float'})
-- }}}

-- Functions {{{
hl('@function', {link = 'Function'})
hl('@function.call', {link = 'Function'})
hl('@function.builtin', {link = 'Special'})
hl('@function.macro', {link = 'Macro'})

hl('@method', {link = 'Function'})
hl('@method.call', {link = 'Function'})

hl('@constructor', {link = 'Special'})
hl('@parameter', {link = 'Identifier'})
-- }}}

-- Keywords {{{
hl('@keyword', {link = 'Keyword'})
hl('@keyword.function', {link = 'Keyword'})
hl('@keyword.operator', {link = 'Keyword'})
hl('@keyword.return', {link = 'Keyword'})

hl('@conditional', {link = 'Conditional'})
hl('@repeat', {link = 'Repeat'})
hl('@debug', {link = 'Debug'})
hl('@label', {link = 'Label'})
hl('@include', {link = 'Include'})
hl('@exception', {link = 'Exception'})
-- }}}

-- Types {{{
hl('@type', {link = 'Type'})
hl('@type.builtin', {link = 'Type'})
hl('@type.qualifier', {link = 'Type'})
hl('@type.definition', {link = 'Typedef'})

hl('@storageclass', {link = 'StorageClass'})
hl('@attribute', {link = 'PreProc'})
hl('@field', {link = 'Identifier'})
hl('@property', {link = 'Identifier'})
-- }}}

-- Identifiers {{{
hl('@variable', {link = 'Normal'})
hl('@variable.builtin', {link = 'Special'})

hl('@constant', {link = 'Constant'})
hl('@constant.builtin', {link = 'Special'})
hl('@constant.macro', {link = 'Define'})

hl('@namespace', {link = 'Include'})
hl('@symbol', {link = 'Identifier'})
-- }}}

-- Text {{{
hl('@text', {link = 'Normal'})
hl('@text.strong', {bold = true})
hl('@text.emphasis', {italic = true})
hl('@text.underline', {underline = true})
hl('@text.strike', {strikethrough = true})
hl('@text.title', {link = 'Title'})
hl('@text.literal', {link = 'String'})
hl('@text.uri', {link = 'Underlined'})
hl('@text.math', {link = 'Special'})
hl('@text.environment', {link = 'Macro'})
hl('@text.environment.name', {link = 'Type'})
hl('@text.reference', {link = 'Constant'})

hl('@text.todo', {link = 'Todo'})
hl('@text.note', {link = 'SpecialComment'})
hl('@text.warning', {link = 'WarningMsg'})
hl('@text.danger', {link = 'ErrorMsg'})
-- }}}

-- Tags {{{
hl('@tag', {link = 'Tag'})
hl('@tag.attribute', {link = 'Identifier'})
hl('@tag.delimiter', {link = 'Delimiter'})
-- }}}

local M = {}

local github = {
  -- https://github.com/primer/primitives/blob/main/data/colors/themes/dark.ts
  dark = {
    black = '#010409',
    white = '#f0f6fc',
    gray = {
      '#f0f6fc',
      '#c9d1d9',
      '#b1bac4',
      '#8b949e',
      '#6e7681',
      '#484f58',
      '#30363d',
      '#21262d',
      '#161b22',
      '#0d1117',
    },
    blue = {
      '#cae8ff',
      '#a5d6ff',
      '#79c0ff',
      '#58a6ff',
      '#388bfd',
      '#1f6feb',
      '#1158c7',
      '#0d419d',
      '#0c2d6b',
      '#051d4d',
    },
    green = {
      '#aff5b4',
      '#7ee787',
      '#56d364',
      '#3fb950',
      '#2ea043',
      '#238636',
      '#196c2e',
      '#0f5323',
      '#033a16',
      '#04260f',
    },
    yellow = {
      '#f8e3a1',
      '#f2cc60',
      '#e3b341',
      '#d29922',
      '#bb8009',
      '#9e6a03',
      '#845306',
      '#693e00',
      '#4b2900',
      '#341a00',
    },
    orange = {
      '#ffdfb6',
      '#ffc680',
      '#ffa657',
      '#f0883e',
      '#db6d28',
      '#bd561d',
      '#9b4215',
      '#762d0a',
      '#5a1e02',
      '#3d1300',
    },
    red = {
      '#ffdcd7',
      '#ffc1ba',
      '#ffa198',
      '#ff7b72',
      '#f85149',
      '#da3633',
      '#b62324',
      '#8e1519',
      '#67060c',
      '#490202',
    },
    purple = {
      '#eddeff',
      '#e2c5ff',
      '#d2a8ff',
      '#bc8cff',
      '#a371f7',
      '#8957e5',
      '#6e40c9',
      '#553098',
      '#3c1e70',
      '#271052',
    },
    pink = {
      '#ffdaec',
      '#ffbedd',
      '#ff9bce',
      '#f778ba',
      '#db61a2',
      '#bf4b8a',
      '#9e3670',
      '#7d2457',
      '#5e103e',
      '#42062a',
    },
    coral = {
      '#ffddd2',
      '#ffc2b2',
      '#ffa28b',
      '#f78166',
      '#ea6045',
      '#cf462d',
      '#ac3220',
      '#872012',
      '#640d04',
      '#460701',
    }
  },
  -- https://github.com/primer/primitives/blob/main/data/colors/themes/light.ts
  light =  {
    black = '#1b1f24',
    white = '#ffffff',
    gray = {
      '#f6f8fa',
      '#eaeef2',
      '#d0d7de',
      '#afb8c1',
      '#8c959f',
      '#6e7781',
      '#57606a',
      '#424a53',
      '#32383f',
      '#24292f',
    },
    blue = {
      '#ddf4ff',
      '#b6e3ff',
      '#80ccff',
      '#54aeff',
      '#218bff',
      '#0969da',
      '#0550ae',
      '#033d8b',
      '#0a3069',
      '#002155',
    },
    green = {
      '#dafbe1',
      '#aceebb',
      '#6fdd8b',
      '#4ac26b',
      '#2da44e',
      '#1a7f37',
      '#116329',
      '#044f1e',
      '#003d16',
      '#002d11',
    },
    yellow = {
      '#fff8c5',
      '#fae17d',
      '#eac54f',
      '#d4a72c',
      '#bf8700',
      '#9a6700',
      '#7d4e00',
      '#633c01',
      '#4d2d00',
      '#3b2300',
    },
    orange = {
      '#fff1e5',
      '#ffd8b5',
      '#ffb77c',
      '#fb8f44',
      '#e16f24',
      '#bc4c00',
      '#953800',
      '#762c00',
      '#5c2200',
      '#471700',
    },
    red = {
      '#ffebe9',
      '#ffcecb',
      '#ffaba8',
      '#ff8182',
      '#fa4549',
      '#cf222e',
      '#a40e26',
      '#82071e',
      '#660018',
      '#4c0014',
    },
    purple = {
      '#fbefff',
      '#ecd8ff',
      '#d8b9ff',
      '#c297ff',
      '#a475f9',
      '#8250df',
      '#6639ba',
      '#512a97',
      '#3e1f79',
      '#2e1461',
    },
    pink = {
      '#ffeff7',
      '#ffd3eb',
      '#ffadda',
      '#ff80c8',
      '#e85aad',
      '#bf3989',
      '#99286e',
      '#772057',
      '#611347',
      '#4d0336',
    },
    coral = {
      '#fff0eb',
      '#ffd6cc',
      '#ffb4a1',
      '#fd8c73',
      '#ec6547',
      '#c4432b',
      '#9e2f1c',
      '#801f0f',
      '#691105',
      '#510901',
    },
  },
}

M.get = function(color, index)
  local colors
  if vim.g.light_theme == nil or not vim.g.light_theme then
    colors = github.dark
  else
    colors = github.light
    return
  end
  local c = colors[color]
  if c == nil then
    error(string.format("failed to find color %s", color))
  end
  local hex = c[index]
  if hex == nil then
    error(string.format("failed to index %d of color %s", index, color))
  end
  return hex
end

return M
