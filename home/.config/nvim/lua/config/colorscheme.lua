local function tokyonight()
  local colors = require("tokyonight.colors").setup()

  require('tokyonight').setup({
    styles = { comments = { colors.fg0, italic = false } }
  })
  vim.cmd([[colorscheme tokyonight-moon]])
end

local function catpuccin() vim.cmd([[colorscheme catppuccin]]) end

local function carbonfox()
  -- local palette = require("nightfox.palette.carbonfox").palette
  vim.cmd([[colorscheme carbonfox]])
  -- vim.api.nvim_set_hl(0, "MatchParen", {
  --   fg = palette.pink.bright,
  --   bg = palette.sel0,
  --   bold = true,
  -- })
  vim.cmd([[
    hi MatchParen guibg=#16916e guifg=#9ff5dc gui=bold
    hi Search        guifg=#161616 guibg=#78a9ff gui=none
    hi IncSearch     guifg=#161616 guibg=#ff91c1 gui=bold
    hi Hlargs guifg= guibg= gui=bold
    hi Comment guifg=#969696
    hi IlluminatedWordText gui=underline guisp=#9ff5dc guibg=none
    hi IlluminatedWordRead gui=underline guisp=#9ff5dc guibg=none
    hi IlluminatedWordWrite gui=underline guisp=#9ff5dc guibg=none
    " hi Search        guifg=#ee5396 guibg=#361f29 gui=bold
    hi CursorLine guibg=#252525
    hi @keyword.operator guifg=#f0bdf0
  ]])
end

local function neon()
  vim.g.neon_style = "light"
  vim.g.neon_italic_comment = false
  vim.cmd([[colorscheme neon]])
end

local function github()
  require('github-theme').setup {
    -- theme_style = vim.g.light_theme and 'light' or 'dark',
    theme_style = 'dark',
    comment_style = 'NONE'
  }
  vim.cmd([[hi TODO gui=bold guibg=none guifg=gray]])
  vim.g.light_theme = false   -- TODO
  if vim.g.light_theme then
    -- hi illuminatedWord guibg=#ffffdd
    vim.cmd([[
      hi StatusLine guibg=#ddf4ff guifg=#0550ae gui=none
      hi StatusLineNC guibg=#eaeef2 guifg=#424a53 gui=none
      hi ColorColumn guibg=#fafbfc
      hi CursorLine guibg=#fafbfc
      hi GitSignsCurrentLineBlame guibg=#fafbfc guifg=#e1e4e8
      hi CocHighlightText gui=underline,bold guifg=none
      hi Comment guifg=#8c959f
      hi Visual guibg=#fff8c5 guifg=none
      hi CocMenuSel guibg=#fff8c5 guifg=none
      hi NormalFloat guibg=#ffffdd
      hi IlluminatedWordText gui=none guibg=#ffffdd
      hi IlluminatedWordRead gui=none guibg=#ffffdd
      hi IlluminatedWordWrite gui=none guibg=#ffffdd
      hi LspSignatureActiveParameter gui=bold guibg=none
      hi Search guibg=#dafbe1
      hi IncSearch gui=bold guibg=#dafbe1 guifg=none
      hi DiffAdd guifg=#22863a guibg=none
      hi DiffChange guifg=#b08800 guibg=none
      hi DiffDelete guifg=#cb2431 guibg=none
    ]])
  else
    vim.cmd([[
      " hi Comment guifg=#aff5b4
      " hi Comment guifg=#9ecbff

      hi Comment guifg=#8b949e
      hi StatusLine guibg=#284566
      hi ColorColumn guibg=#2c313a
      " hi GitSignsCurrentLineBlame guibg=none guifg=#484f58
      " hi CocHighlightText gui=underline,bold guifg=none
      hi IlluminatedWordText gui=none guibg=#284566
      hi IlluminatedWordRead gui=none guibg=#284566
      hi IlluminatedWordWrite gui=none guibg=#284566
      hi DiffAdd guifg=#2ea043 guibg=none
      hi DiffChange guifg=#e3b341 guibg=none
      hi DiffDelete guifg=#f85149 guibg=none
      " hi NormalFloat guibg=#30363d gui=bold
    ]])
  end
end

local function github_light_tritanopia()
  vim.cmd([[
    colorscheme github_light_tritanopia
    hi Hlargs gui=underline guifg= guibg=
  ]])
end

local setup_colorscheme = {
  ["carbonfox"] = carbonfox,
  ["github_light_tritanopia"] = github_light_tritanopia
  -- ["catppuccin"] = catpuccin,
  -- ["github"] = github,
  -- ["github-dark-colorblind"] = github_dark_colorblind,
  -- ["github-dark-tritanopia"] = github_dark_tritanopia,
  -- ["github-light-colorblind"] = github_light_colorblind,
  -- ["monokai-pro"] = monokai_pro,
  -- ["neon"] = neon,
  -- ["oxocarbon"] = oxocarbon,
  -- ["rose-pine-main"] = rose_pine_main,
  -- ["tokyonight"] = tokyonight,
}

local selected = "carbonfox"
-- local selected = "github_dark_colorblind"
-- local selected = "github_dark_tritanopia"
-- local selected = "github_light_colorblind"
-- local selected = "github_light_tritanopia"
-- local selected = "mellow"
-- local selected = "rose-pine_main"
-- local selected = "tokyonight"
-- local selected = "miasma"
-- local selected = "spacemacs-theme"

local cs = setup_colorscheme[selected]
if not cs then
  -- local msg = string.format("selected theme not configured q", selected)
  -- vim.notify(msg, vim.log.levels.ERROR)
  -- return
  cs = function() vim.cmd(string.format([[colorscheme %s]], selected)) end
end
cs()
