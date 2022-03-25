-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- vim.cmd [[
--   augroup HotReload
--     autocmd!
--     autocmd BufWritePost init.lua,lua/config/*.lua PackerCompile | so init.lua | echo hello
--   augroup end
-- ]]

vim.g.light_theme = vim.env.EDITOR_THEME or false

require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'FooSoft/vim-argwrap' -- Fold args surrounded by parentheses
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'google/vim-searchindex'
  use 'ggandor/lightspeed.nvim'
  use 'McAuleyPenney/tidy.nvim'
  use 'editorconfig/editorconfig-vim'
  -- use 'chaoren/vim-wordmotion'
  use {
    'ethanholz/nvim-lastplace',
    config = function()
      require('nvim-lastplace').setup {
        lastplace_ignore_filetype = {},
      }
    end,
  }
  -- use {
  --     'kyazdani42/nvim-tree.lua',
  --     requires = {
  --       'kyazdani42/nvim-web-devicons',
  --     },
  --     config = function()
  --       require'nvim-tree'.setup {
  --         hijack_cursor = true,
  --         update_cwd = true,
  --         update_focused_file = {
  --           enable = true,
  --           update_cwd = true,
  --         },
  --       }
  --     end
  -- }
  use {
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-gps").setup({
        disable_icons = true,
        separator = '.',
      })
    end,
  }
  use {
    'famiu/feline.nvim',
    config = [[require('config.feline')]],
  }
  use {
    'projekt0n/github-nvim-theme',
    config = [[require('config.github-theme')]]
  }
  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      vim.o.spell = false
      require('spellsitter').setup {
        enable = {
          "gitcommit",
        }
      }
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config.gitsigns')
    end,
  }
  -- use {
  --   "folke/which-key.nvim",
  --   config = function()
  --     require("which-key").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }
  -- use {
  --   'glepnir/dashboard-nvim',
  --   config = function()
  --     vim.g.dashboard_default_executive = 'telescope'
  --     vim.g.dashboard_preview_command = 'lolcat'
  --   end,
  -- }
  -- use {
  --   'romgrk/barbar.nvim',
  --   requires = {'kyazdani42/nvim-web-devicons'},
  --   config = function()
  --     -- vim.cmd([[nnoremap <c-l> :BufferNext<cr>]])
  --     -- vim.cmd([[nnoremap <c-h> :BufferPrevious<cr>]])
  --     -- vim.cmd([[nnoremap <c-s-l> :BufferMoveNext<cr>]])
  --     -- vim.cmd([[nnoremap <c-s-h> :BufferMovePrevious<cr>]])
  --     -- vim.cmd([[nnoremap <s-x> :BufferClose<cr>]])
  --   end,
  -- }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  -- use {
  --   'nvim-lualine/lualine.nvim',
  --   requires = {'kyazdani42/nvim-web-devicons', opt = true},
  --   config = [[require('config.lualine')]],
  -- }
  -- use {
  --   'norcalli/nvim-colorizer.lua',
  --   config = function()
  --     require('colorizer').setup({
  --       ['*'] = {
  --         RGB = false,
  --         names = false,
  --       },
  --     })
  --   end,
  -- }
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = [[require('config.treesitter')]],
  }
  -- use {
  --   'neoclide/coc.nvim',
  --   branch = 'release',
  --   config = [[require('config.coc')]],
  -- }
  use 'sheerun/vim-polyglot'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      use {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          require"telescope".load_extension("frecency")
        end,
        requires = {"tami5/sqlite.lua"}
      }
    },
    config = [[require('config.telescope')]],
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    'ray-x/lsp_signature.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'RRethy/vim-illuminate',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'onsails/lspkind-nvim',
    'nvim-lua/lsp-status.nvim',
    'creativenull/diagnosticls-configs-nvim',
    'https://gitlab.com/yorickpeterse/nvim-pqf',
    {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
    },
  }

  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons', -- optional, for file icon
  --   },
  --   config = function() require'nvim-tree'.setup {} end
  -- }
end)

-- -- From https://github.com/goolord/alpha-nvim/blob/baae95f0dfb5d7084bdc558bf5e4f3be0d986390/lua/alpha.lua#L412-L438
-- local function is_empty_startup()
--     -- don't start when opening a file
--     if vim.fn.argc() > 0 then return true end

--     -- Handle nvim -M
--     if not vim.o.modifiable then return true end

--     for _, arg in ipairs(vim.v.argv) do
--         -- whitelisted arguments
--         -- always open
--         if  arg == "--startuptime"
--             then return false
--         end

--         -- blacklisted arguments
--         -- always skip
--         if  arg == "-b"
--             -- commands, typically used for scripting
--             or arg == "-c" or vim.startswith(arg, "+")
--             or arg == "-S"
--             then return true
--         end
--     end

--     -- base case: don't skip
--     return false
-- end
-- function _G.on_startup()
--   if is_empty_startup() then
--     -- require('telescope').extensions.frecency.frecency()
--     print "on empty startup"
--   else
--     print "non-empty startup"
--   end

-- end
-- vim.cmd([[au VimEnter * nested v:lua on_startup()]])

vim.o.hidden = true

vim.cmd([[nnoremap <space>l :TroubleToggle<cr>]])

require('config.lspconfig')

vim.cmd([[nnoremap <space> <nop>]])
vim.g.mapleader = ' '

-- https://neovim.io/doc/user/options.html#'cursorline'
vim.o.cursorline = true

-- Edit arg or word under cursor.
vim.cmd([[nnoremap f ciw]])

-- https://neovim.io/doc/user/options.html#'number'
vim.o.number = true

-- Colorcolumn
vim.o.colorcolumn = '80' -- default
vim.cmd([[
augroup colorcolumn
  au!
  au FileType go set colorcolumn=80,100
  " Commit subject lines get hacked off if more than 72.
  au FileType gitcommit set colorcolumn=72
  " prefix: len('pick 6f684cf6fa ') = 16
  au Filetype gitrebase set colorcolumn=88
augroup END
]])

vim.o.termguicolors = true

vim.o.wrap = false

-- Move cursor to bottom after yanking.
-- https://stackoverflow.com/a/3806683/2601179
vim.cmd([[
  vmap y y`]
]])

-- When there's more than one match, complete the longest common prefix among
-- them and show the rest of the options.
vim.o.wildmode = 'list:longest,full'

vim.o.completeopt = 'menu,menuone,noselect'

vim.g.netrw_dirhistmax = 100

-- Split windows
vim.cmd([[
  nnoremap <c-\> :vsplit<cr><c-w>w
  inoremap <c-\> <esc>:vsplit<cr><c-w>w
]])

-- Faster saving.
vim.cmd([[nnoremap <leader>j :wr<cr>]])

-- Open up file viewer.
vim.cmd([[nnoremap <c-m> :Explore<cr>]])
-- vim.cmd([[nnoremap <c-m> :NvimTreeFindFileToggle<cr>]])

-- Move up and down with jk keys.
vim.cmd([[
  nnoremap <s-j> <c-e>
  nnoremap <s-k> <c-y>
  nnoremap <s-h> zh
  nnoremap <s-l> zl
]])

vim.o.scrolloff = 4
vim.o.sidescrolloff = 4

-- Argument rewrapping, and add trailing commas.
vim.cmd([[nnoremap <leader>a :ArgWrap<cr>]])
vim.g.argwrap_tail_comma = 1

-- Move line(s) up or down.
vim.cmd([[
  nnoremap <c-down> :m +1<cr>
  nnoremap <c-up> :m -2<cr>
  vnoremap <c-down>:m '>+1<cr>gv
  vnoremap <c-up> :m '<-2<cr>gv
]])

-- Continue comment sections on return, and format numbered lists.
-- - https://stackoverflow.com/a/22577860/2601179
--  - https://stackoverflow.com/a/4783237/2601179
vim.o.formatoptions = 'croqn1jp'
vim.o.textwidth = 79
vim.o.comments='fb:-,fb:*'

-- For compatibility with rg --vimgrep
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.errorformat = '%f:%l:%c:%m'..','..vim.o.errorformat

-- Move between windows more easily.
vim.cmd([[
  nnoremap <c-h> <c-w><left>
  nnoremap <c-l> <c-w><right>
  nnoremap <c-j> <c-w><down>
  nnoremap <c-k> <c-w><up>
  inoremap <c-h> <c-o><c-w><left>
  inoremap <c-l> <c-o><c-w><right>
  inoremap <c-j> <c-o><c-w><down>
  inoremap <c-k> <c-o><c-w><up>
]])

-- Read-line style beginning and end of line, within insert mode.
vim.cmd([[
  inoremap <c-e> <c-o><s-$>
  inoremap <c-a> <c-o><s-^>
]])

vim.diagnostic.config({
    virtual_text = false,
})

-- -- Open a file in the same location as it was opened last time.
-- -- https://stackoverflow.com/a/774599/2601179
-- vim.cmd([[
-- augroup custom
--   au!
--   if &filetype !=# 'gitcommit'
--     au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
--   endif
-- augroup END
-- ]])

-- vim.cmd([[nnoremap <c-l> :BufferNext<cr>]])
-- vim.cmd([[nnoremap <c-h> :BufferPrevious<cr>]])
-- vim.cmd([[nnoremap <c-s-l> :BufferMoveNext<cr>]])
-- vim.cmd([[nnoremap <c-s-h> :BufferMovePrevious<cr>]])
-- vim.cmd([[nnoremap <s-x> :BufferClose<cr>]])
