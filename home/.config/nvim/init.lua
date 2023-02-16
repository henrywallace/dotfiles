-- https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'         -- package manager
  use 'lewis6991/impatient.nvim'
  use 'google/vim-searchindex'         -- display match number k of n

  use 'FooSoft/vim-argwrap'            -- fold args surrounded by parentheses

  use 'tpope/vim-commentary'           -- comment lines visual regions

  use 'gpanders/editorconfig.nvim'

  use 'sheerun/vim-polyglot'

  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require'hop'.setup { }
      vim.api.nvim_set_keymap('', 'f', ":HopWord<cr>", {})
    end
  }

  use {
    'petertriho/nvim-scrollbar',
    config = function()
      require('config.scrollbar')
    end
  }

  -- use {
  --   'kevinhwang91/nvim-ufo',
  --   requires = 'kevinhwang91/promise-async',
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

  -- use {
  --   'famiu/feline.nvim',         -- status line
  --   config = [[require('config.feline')]],
  -- }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('config.lualine')
    end,
  }

  use {
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('hlargs').setup {}
      vim.cmd([[hi link Hlargs @parameter]])
    end
  }

  -- Themes
  use {
    'projekt0n/github-nvim-theme',  -- github colorscheme
    -- config = [[require('config.github-theme')]]
  }
  use {
    'Mofiqul/dracula.nvim',
    -- config = [[require('config.dracula')]],
  }
  use {
    'folke/tokyonight.nvim',
    config = [[require('config.tokyonight')]],
  }
  use { "catppuccin/nvim", as = "catppuccin" }
  use {
    "EdenEast/nightfox.nvim",
    config = function()
      require('nightfox').compile()
    end
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
      "nvim-neorg/neorg",
      ft = "norg",
      after = {
        "nvim-treesitter",
      },
      requires = "nvim-lua/plenary.nvim",
      -- run = ":Neorg sync-parsers",
      config = function()
          require('neorg').setup {
            load = {
              ["core.defaults"] = {},
            },
          }
      end,
  }

  use {
    'kyazdani42/nvim-tree.lua',     -- filesystem browser
    config = function()
      require('nvim-tree').setup{
        renderer = {
          add_trailing = true,
          group_empty = true,
          full_name = true,
          highlight_git = true,
          highlight_opened_files = "name",
          icons = {
            git_placement = "after",
          },
        },
        view = {
          -- float = {
          --   enable = true,
          --   open_win_config = {
          --     width = 48,
          --     -- col = 80,
          --     relative = "cursor"
          --   },
          -- },
          adaptive_size = true,
          centralize_selection = true,
          -- width = 80,
          side = 'right',
          preserve_window_proportions = true,
        --   -- height = 20,
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
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        -- post_open_hook = function (_, win)
        --     -- Close the current preview window with <Esc>
        --     vim.keymap.set(
        --         'n',
        --         '<Esc>',
        --         function()
        --             vim.api.nvim_win_close(win, true)
        --         end,
        --         { buffer = true }
        --     )
        -- end,
        -- }
        vim.cmd([[
          nnoremap gp <cmd>lua require('goto-preview').goto_preview_definition()<CR>
          nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
          " nnoremap gT <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
          " nnoremap gI <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
          " nnoremap gR <cmd>lua require('goto-preview').goto_preview_references()<CR>
        ]])
      }
  end,
  }

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = [[require('config.treesitter')]],
  }
  use 'nvim-treesitter/playground'
  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      }
    end,
  }

  use {
    'RRethy/nvim-treesitter-textsubjects',
    config = function ()
      require'nvim-treesitter.configs'.setup {
        textsubjects = {
            enable = true,
            prev_selection = ',', -- (Optional) keymap to select the previous selection
            keymaps = {
              ['.'] = 'textsubjects-smart',
              [';'] = 'textsubjects-container-outer',
              ['i;'] = 'textsubjects-container-inner',
            },
         },
      }
    end
  }

  use {
    'j-hui/fidget.nvim',
    config = function()
      require("fidget").setup{}
    end
  }


  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup()
    end
  }

  use {
    'nvim-telescope/telescope.nvim',        -- fuzzy finder, etc.
    requires = {'nvim-lua/plenary.nvim'},
    config = [[require('config.telescope')]],
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }




  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require('trouble').setup {
        auto_close = true,
      }
      vim.cmd([[nnoremap <leader>l :TroubleToggle<cr>]])
    end,
  }

  use {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'onsails/lspkind-nvim',
    -- 'lukas-reineke/cmp-under-comparator',
    -- config = function()
    --   require('config.cmp')
    -- end,
  }

  -- use {
  --   'abecodes/tabout.nvim',
  --   -- wants = {'nvim-treesitter'}, -- or require if not used so far
	  -- -- after = {'nvim-cmp'}, -- if a completion plugin is using tabs load it before
  --   config = function()
  --     require('tabout').setup {
  --       tabkey = '<tab>',
  --       -- backwards_tabkey = '',
  --     }
  --   end
  -- }

  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })

  use {
    'neovim/nvim-lspconfig',
    'RRethy/vim-illuminate',
    'nvim-lua/lsp-status.nvim',
    'creativenull/diagnosticls-configs-nvim',
    -- config = function()
    --   require('config.lspconfig')
    -- end
  }

  -- use {
  --   "utilyre/barbecue.nvim",
  --   requires = {
  --     "neovim/nvim-lspconfig",
  --     "smiteshp/nvim-navic",
  --     "kyazdani42/nvim-web-devicons", -- optional
  --   },
  --   config = function()
  --     require("barbecue").setup {
  --       symbols = {
  --         separator = ">"
  --       },
  --     }
  --     vim.cmd([[
  --       hi NavicText guifg=#8b949e
  --       hi NavicSeparator guifg=#6e7681
  --     ]])
  --   end,
  -- }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Must be last.
  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.o.mouse = false

require('config.cmp')
require('config.lspconfig')

-- vim.cmd([[nnoremap <space>l :TroubleToggle<cr>]])
-- vim.diagnostic.config({
--     virtual_text = false,
-- })
-- require('config.lspconfig')

-- Load colors, and highlight fixes for treesitter.
require('colors')

vim.cmd([[nnoremap <space> <nop>]])
vim.g.mapleader = ' '

vim.g.light_theme = vim.env.EDITOR_THEME or false
vim.o.termguicolors = true

vim.o.hidden = true

-- Highlight the current row of the cursor.
-- https://neovim.io/doc/user/options.html#'cursorline'
vim.o.cursorline = true

-- -- Edit arg or word under cursor.
vim.cmd([[nnoremap R ciw]])

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

vim.cmd([[
  autocmd BufWritePre *.go :silent! lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
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

vim.cmd([[nnoremap <leader>h :TSHighlightCapturesUnderCursor<cr>]])

vim.cmd([[
  " hi TreesitterContext guibg=#30363d
  hi TreesitterContext guibg=none gui=none
  hi TreesitterContextBottom guibg=none gui=underline guisp=gray
]])
