require('github-theme').setup {
  theme_style = vim.g.light_theme and 'light' or 'dark',
  comment_style = 'NONE',
}

vim.cmd([[hi TODO gui=bold guibg=none guifg=gray]])

-- Customizations
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
    hi illuminatedWord guibg=#ffffdd
    hi illuminatedCurWord guibg=none
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
    hi GitSignsCurrentLineBlame guibg=none guifg=#484f58
    hi CocHighlightText gui=underline,bold guifg=none
    hi illuminatedWord guibg=#284566
    hi illuminatedCurWord guibg=none
    hi DiffAdd guifg=#2ea043 guibg=none
    hi DiffChange guifg=#e3b341 guibg=none
    hi DiffDelete guifg=#f85149 guibg=none
    hi NormalFloat guibg=#30363d gui=bold
  ]])
end
