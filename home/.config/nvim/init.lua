local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function()
  use 'wbthomason/packer.nvim'         -- package manager

  use 'google/vim-searchindex'         -- display match number k of n
  use 'FooSoft/vim-argwrap'            -- fold args surrounded by parentheses
  use 'tpope/vim-commentary'           -- comment lines visual regions
  use 'editorconfig/editorconfig-vim'  -- set tabshift based on editorconfig
  use 'sheerun/vim-polyglot'

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { }
      vim.api.nvim_set_keymap('', 'f', ":HopWord<cr>", {})
      -- vim.api.nvim_set_keymap('', 'F', ":HopPattern<cr>", {})
    end
  }

  -- use {
  --   "folke/which-key.nvim",
  --   config = function()
  --     require("which-key").setup { }
  --   end
  -- }

  use {
    'ethanholz/nvim-lastplace', -- return to last place in file on open
    config = function()
      require('nvim-lastplace').setup {
        lastplace_ignore_filetype = {"quickfix", "nofile", "help"},
      }
    end,
  }

  use({
    "mcauley-penney/tidy.nvim",
    config = function()
        require("tidy").setup()
    end
  })

  use {
    "SmiteshP/nvim-gps",         -- status line component for cursor's scope
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-gps").setup({
        disable_icons = true,
        separator = '.',
      })
    end,
  }

  use {
    'famiu/feline.nvim',         -- status line
    config = [[require('config.feline')]],
  }

  use {
    'projekt0n/github-nvim-theme',  -- github colorscheme
    config = [[require('config.github-theme')]]
  }

  use {
    'lewis6991/spellsitter.nvim',   -- spellcheck with treesitter support
    config = function()
      -- vim.o.spell = false
      require('spellsitter').setup {
        enable = {
          "gitcommit",
        }
      }
    end
  }

  use {
    'lewis6991/gitsigns.nvim',      -- git integration
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config.gitsigns')
    end,
  }

  use {
    'kyazdani42/nvim-tree.lua',     -- filesystem browser
    config = function()
      require('nvim-tree').setup{
        view = {
          side = 'right',
          width = 40,
          -- height = 20,
        },
        actions = {
          open_file = {
            quit_on_open = true,
            window_picker = {
              enable = false,
            },
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
      }
    end
  }

  use {
      'nvim-treesitter/nvim-treesitter',    -- beyond-regex syntax queries
      run = ':TSUpdate',
      config = [[require('config.treesitter')]],
  }
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
      }
    end
  }

  use {
    'nvim-telescope/telescope.nvim',        -- fuzzy finder, etc.
    requires = {'nvim-lua/plenary.nvim'},
    config = [[require('config.telescope')]],
  }

  use {
    'neovim/nvim-lspconfig',
    -- 'ray-x/lsp_signature.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',
    -- 'RRethy/vim-illuminate',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'onsails/lspkind-nvim',      -- lsp completion pictograms
    'nvim-lua/lsp-status.nvim',
    'creativenull/diagnosticls-configs-nvim',
    'https://gitlab.com/yorickpeterse/nvim-pqf',
    {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
    },
    config = function()
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Must be last.
  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd([[nnoremap <space>l :TroubleToggle<cr>]])
vim.diagnostic.config({
    virtual_text = false,
})
require('config.lspconfig')

vim.cmd([[nnoremap <space> <nop>]])
vim.g.mapleader = ' '

vim.g.light_theme = vim.env.EDITOR_THEME or false
vim.o.termguicolors = true

vim.o.hidden = true

-- Highlight the current row of the cursor.
-- https://neovim.io/doc/user/options.html#'cursorline'
vim.o.cursorline = true

-- -- Edit arg or word under cursor.
vim.cmd([[nnoremap F ciw]])

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

-- vim.o.list = true

vim.o.wrap = false

-- local new_profile = function()
--   return "profile.log"
-- end
-- vim.api.nvim_create_autocmd({"VimEnter"}, {
--   command = vim.cmd([[
--     profile start profile.log
--     profile func *
--     profile file *
--   ]])
-- })

-- Move cursor to bottom after yanking.
-- https://stackoverflow.com/a/3806683/2601179
vim.cmd([[
  vmap y y`]
]])

-- When there's more than one match, complete the longest common prefix among
-- them and show the rest of the options.
vim.o.wildmode = 'list:longest,full'
vim.o.completeopt = 'menu,menuone,noselect'

-- Split windows.
vim.cmd([[
  nnoremap <c-\> :vsplit<cr><c-w>w
  inoremap <c-\> <esc>:vsplit<cr><c-w>w
]])

-- Faster saving.
vim.cmd([[nnoremap <leader>j :wr<cr>]])

-- Open up file viewer.
vim.api.nvim_set_keymap("n", "<c-n>", ":NvimTreeFindFileToggle<cr>", {})

-- Shift up, down, left, and right with hjkl, without moving cursor.
vim.cmd([[
  nnoremap <s-j> <c-e>
  nnoremap <s-k> <c-y>
  nnoremap <s-h> zh
  nnoremap <s-l> zl
]])

-- Add a minimum bumper on edges for scrolling.
vim.o.scrolloff = 2
vim.o.sidescrolloff = 2

-- Argument rewrapping, and add trailing commas.
vim.cmd([[nnoremap <leader>a :ArgWrap<cr>]])
vim.g.argwrap_tail_comma = 1

-- Move line(s) up or down, for both normal and visual modes.
vim.cmd([[
  nnoremap <c-up> :m -2<cr>
  vnoremap <c-up> :m '<-2<cr>gv
  nnoremap <c-down> :m +1<cr>
  vnoremap <c-down>:m '>+1<cr>gv
]])

-- Continue comment sections on return, and format numbered lists.
-- https://stackoverflow.com/a/22577860/2601179
-- https://stackoverflow.com/a/4783237/2601179
vim.o.formatoptions = 'croqn1jp'
vim.o.textwidth = 79
vim.o.comments='fb:-,fb:*'

-- For compatibility with rg --vimgrep pipe output.
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.errorformat = '%f:%l:%c:%m'..','..vim.o.errorformat

-- Change window focus with hjkl keys.
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
