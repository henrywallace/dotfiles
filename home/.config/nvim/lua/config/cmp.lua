local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

require("copilot").setup({
    suggestion = {enabled = false},
    panel = {enabled = false},
    settings = {advanced = {listCount = 100, inlineSuggestCount = 6}}
})

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match(
                   "^%s*$") == nil
end

-- local cmp_ai = require('cmp_ai.config')
-- cmp_ai:setup({
--   max_lines = 1000,
--   provider = 'openai',
--   model = 'gpt-4',
--   notify = true,
--   run_on_every_keystroke = true
-- })

-- local confirm =

cmp.setup {
    experimental = {ghost_text = {hl_group = 'Conceal'}},
    sources = cmp.config.sources({
        {name = 'copilot'}, -- { name = 'cmp_ai' },
        {name = 'nvim_lsp_signature_help'}, {name = 'nvim_lsp'},
        {name = 'luasnip'}, {name = 'path'}, {name = 'buffer'}
        -- { name = 'cmp-clippy',
        --   options = {
        --     model = "EleutherAI/gpt-neo-2.7B", -- check code clippy vscode repo for options
        --     key = "", -- huggingface.co api key
        --   }
        -- },

        -- { name = 'buffer-lines', option = {
        --     leading_whitespace = false,
        -- }},
    }),
    -- For debounce
    -- See https://github.com/hrsh7th/nvim-cmp/issues/598#issuecomment-984930668
    -- completion = {
    --   autocomplete = false,
    -- },
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    view = {entries = 'native'},
    mapping = cmp.mapping.preset.insert({
        ['<c-p>'] = cmp.mapping.select_prev_item(),
        ['<c-n>'] = cmp.mapping.select_next_item(),
        ['<c-k>'] = cmp.mapping.select_prev_item(),
        ['<c-j>'] = cmp.mapping.select_next_item(),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.close(),
        -- https://github.com/zbirenbaum/copilot-cmp/issues/45#issuecomment-1438687425
        ['<cr>'] = cmp.mapping.confirm {
            select = true,
            behavior = cmp.ConfirmBehavior.Replace
        },
        ['<right>'] = cmp.mapping.confirm {
            select = true,
            behavior = cmp.ConfirmBehavior.Replace
        },
        -- https://github.com/zbirenbaum/copilot-cmp#user-content-tab-completion-configuration-highly-recommended
        ['<tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
            else
                fallback()
            end
        end)
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
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        format = lspkind.cmp_format({
            -- with_text = true, -- do not show text alongside icons
            maxwidth = 100, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item) return vim_item end
        })
    }
}

-- -- https://github.com/hrsh7th/nvim-cmp/issues/598#issuecomment-984930668
-- vim.cmd([[
--   augroup CmpDebounce
--     au!
--     au TextChangedI * lua require("debounce").debounce()
--   augroup end
-- ]])
