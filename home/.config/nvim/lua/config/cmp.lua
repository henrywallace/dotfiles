local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

cmp.setup {
  experimental = {
    ghost_text = { hl_group = 'TSNodeUnmatched' },
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
    -- { name = 'buffer-lines', option = {
    --     leading_whitespace = false,
    -- }},
  }),
  -- For debounce
  -- See https://github.com/hrsh7th/nvim-cmp/issues/598#issuecomment-984930668
  -- completion = {
  --   autocomplete = false,
  -- },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  view = {
    entries = 'native',
  },
  mapping = cmp.mapping.preset.insert({
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-k>'] = cmp.mapping.select_prev_item(),
    ['<c-j>'] = cmp.mapping.select_next_item(),
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ['<c-e>'] = cmp.mapping.close(),
    ['<cr>'] = cmp.mapping.confirm {select = true},
    ['<right>'] = cmp.mapping.confirm {select = true},
    ['<tab>'] = cmp.mapping.confirm {select = true},
    -- ['<Tab>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end,
    -- ['<S-Tab>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end,
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true, -- do not show text alongside icons
      maxwidth = 100, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
}

-- -- https://github.com/hrsh7th/nvim-cmp/issues/598#issuecomment-984930668
-- vim.cmd([[
--   augroup CmpDebounce
--     au!
--     au TextChangedI * lua require("debounce").debounce()
--   augroup end
-- ]])
