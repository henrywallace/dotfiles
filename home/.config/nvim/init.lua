-- https://github.com/folke/lazy.nvim#-installation
-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "

require("lazy").setup({
    "lewis6991/impatient.nvim",
    "google/vim-searchindex",   -- display match number k of n
    "FooSoft/vim-argwrap",      -- fold args surrounded by parentheses
    "tpope/vim-commentary",     -- comment lines visual regions
    "gpanders/editorconfig.nvim",
    "sheerun/vim-polyglot",
    "earthly/earthly.vim",
    {
      "chrisgrieser/nvim-spider",
      enabled = false,
      config = function()
        vim.keymap.set({"n", "o", "x"}, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
        vim.keymap.set({"n", "o", "x"}, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
        vim.keymap.set({"n", "o", "x"}, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
        vim.keymap.set({"n", "o", "x"}, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
     end,
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
        config = function()
            require("hop").setup({})
            vim.api.nvim_set_keymap("", "f", ":HopWord<cr>", {})
        end,
    },
    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("config.scrollbar")
        end,
    },
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "dpayne/CodeGPT.nvim",
      enabled = false,
      config = function()
        vim.g["codegpt_commands_defaults"] = {
          ["code_edit"] = {
            temperature = 0.05,
            model = "gpt-4",
            language_instructions = {
              go = "Write in the style of Russ Cox.",
            },
          --   system_message_template = [[
          --     As an AI language model, you're here to help with programming tasks in {{language}}.
          --     You can answer questions, review code, or provide guidance on best practices.
          --     Feel free to ask anything related to the current file ({{filetype}}) or any other programming topic you out-of-band clarification on.
          --   ]],
          --   user_message_template = [[
          --     I am working on a {{filetype}} file in {{language}}. I have this code snippet:
          --     ```
          --     {{text_selection}}
          --     ```

          --     My question is: {{command_args}}

          --     {{language_instructions}}
          --   ]],
          --   callback_type = "replace_lines",
          },
        }
        vim.g["codegpt_commands"] = {
          ["testwith"] = {
              user_message_template =
                "Write tests for the following code: ```{{filetype}}\n{{text_selection}}```\n{{command_args}} " ..
                "Only return the code snippet and nothing else."
          }
        }

      end,
    },
    {
      'kevinhwang91/nvim-ufo',
      enabled = false,
      -- requires = 'kevinhwang91/promise-async',
    },
    {
        "ethanholz/nvim-lastplace", -- return to last place in file on open
        config = function()
            require("nvim-lastplace").setup({
                lastplace_ignore_filetype = {"quickfix", "nofile", "help"}
            })
        end,
    },
    {
        "mcauley-penney/tidy.nvim",
        config = function()
            require("tidy").setup()
        end,
    },
    {
        'famiu/feline.nvim',         -- status line
        enabled = false,
        config = [[require('config.feline')]],
    },
    {
        "nvim-lualine/lualine.nvim",
        -- requires = {"nvim-tree/nvim-web-devicons"},
        config = function() require("config.lualine") end
    },
    {
        "m-demare/hlargs.nvim",
        -- requires = {"nvim-treesitter/nvim-treesitter"},
        config = function()
            require("hlargs").setup({})
            vim.cmd([[hi link Hlargs @parameter]])
        end,
    },

    -- Themes
    {
        "EdenEast/nightfox.nvim",
        config = function() require("nightfox").compile() end
    },
    {
        "loctvl842/monokai-pro.nvim",
        config = function() require("monokai-pro").setup() end
    },
    {"projekt0n/github-nvim-theme"},
    {"Mofiqul/dracula.nvim"},
    {"folke/tokyonight.nvim"},
    {"catppuccin/nvim", as = "catppuccin"},
    {"rafamadriz/neon"},
    {"nyoom-engineering/oxocarbon.nvim"},
    {"rose-pine/neovim", as = "rose-pine"},
    {"kvrohit/mellow.nvim"},
    {"challenger-deep-theme/vim", as = "challenger-deep"},
    {"liuchengxu/space-vim-dark"},
    {"olivertaylor/vacme"},
    {"xero/miasma.nvim"},
    {"javiorfo/nvim-nyctophilia"},
    {"lmburns/kimbox"},
    {"jacoborus/tender.vim"},
    {"oxfist/night-owl.nvim"},
    {"colepeters/spacemacs-theme.vim"},
    {"nelstrom/vim-mac-classic-theme"},
    {"ajgrf/parchment"},
    {
      'lewis6991/spellsitter.nvim',   -- spellcheck with treesitter support
      enabled = false,
      config = function()
        -- vim.o.spell = false
        require('spellsitter').setup {
          enable = {
            "gitcommit",
          }
        }
      end
    },

    {
        "lewis6991/gitsigns.nvim", -- git integration
        -- requires = {"nvim-lua/plenary.nvim"},
        config = function() require("config.gitsigns") end,
    },

    {
        "nvim-neorg/neorg",
        ft = "norg",
        -- after = {"nvim-treesitter"},
        -- requires = "nvim-lua/plenary.nvim",
        -- run = ":Neorg sync-parsers",
        config = function()
            require("neorg").setup({
                load = {["core.defaults"] = {}},
            })
        end,
    },

    {
        "kyazdani42/nvim-tree.lua", -- filesystem browser
        cmd = "NvimTreeFindFileToggle",
        -- requires = {
        --     "nvim-tree/nvim-web-devicons" -- optional, for file icons
        -- },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            vim.opt.termguicolors = true
            require("nvim-tree").setup({
                renderer = {
                    add_trailing = true,
                    group_empty = true,
                    full_name = true,
                    highlight_git = true,
                    highlight_opened_files = "name",
                    icons = {
                        git_placement = "after",
                        glyphs = {
                            git = {
                                unstaged = "*",
                                staged = "+",
                                unmerged = "!",
                                renamed = "R",
                                untracked = "?",
                                deleted = "x",
                                ignored = "I"
                            }
                        }
                    },
                    symlink_destination = false
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
                    width = {max = 50},
                    centralize_selection = true,
                    -- width = 80,
                    side = "left",
                    preserve_window_proportions = true
                    --   -- height = 20,
                },
                actions = {
                    open_file = {
                        quit_on_open = true,
                        window_picker = {enable = false}
                    }
                },
                update_focused_file = {enable = true, update_cwd = true}
            })
        end
    },

    {
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({
                vim.cmd([[
                  nnoremap gp <cmd>lua require('goto-preview').goto_preview_definition()<CR>
                  nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
                  " nnoremap gT <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
                  " nnoremap gI <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
                  " nnoremap gR <cmd>lua require('goto-preview').goto_preview_references()<CR>
                ]])
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = [[require('config.treesitter')]],
    },
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = {
                                query = "@class.outer",
                                desc = "Next class start"
                            }
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer"
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer"
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer"
                        }
                    }
                }
            })
        end
    },

    {
        "RRethy/nvim-treesitter-textsubjects",
        config = function()
            require("nvim-treesitter.configs").setup({
                textsubjects = {
                    enable = true,
                    prev_selection = ",", -- (Optional) keymap to select the previous selection
                    keymaps = {
                        ["."] = "textsubjects-smart",
                        [";"] = "textsubjects-container-outer",
                        ["i;"] = "textsubjects-container-inner"
                    }
                }
            })
        end
    },

    -- use {
    --   'j-hui/fidget.nvim',
    --   config = function()
    --     require("fidget").setup{}
    --   end
    -- }

    {
        "folke/twilight.nvim",
        config = function() require("twilight").setup() end
    },

    {
        "nvim-telescope/telescope.nvim", -- fuzzy finder, etc.
        requires = {"nvim-lua/plenary.nvim"},
        config = [[require('config.telescope')]]
    },
    {"nvim-telescope/telescope-fzf-native.nvim", build = "make"},

    {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup({auto_close = true})
            vim.cmd([[nnoremap <leader>l :TroubleToggle<cr>]])
        end
    },

    {
        "hrsh7th/nvim-cmp",
        config = function()
          require('config.cmp')
        end,
    },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "onsails/lspkind-nvim",
    "lukas-reineke/cmp-under-comparator",

    {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup({
                -- background_colour = "NotifyBackground",
                -- fps = 30,
                -- icons = {
                --     DEBUG = "",
                --     ERROR = "",
                --     INFO = "",
                --     TRACE = "✎",
                --     WARN = ""
                -- },
                -- level = 2,
                -- minimum_width = 50,
                -- render = "wrapped-compact",
                render = "compact"
                -- stages = "fade_in_slide_out",
                -- timeout = 5000,
                -- top_down = true
            })
        end
    },
    -- use {'~/Documents/dev/cmp-ai'}

    {dir = '~/Documents/dev/ai.nvim'},

    {
      'abecodes/tabout.nvim',
      enabled = false,
      config = function()
        require('tabout').setup {
          tabkey = '<tab>',
          -- backwards_tabkey = '',
        }
      end,
    },

    {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      enabled = false,
      config = function()
        require("lsp_lines").setup()
      end,
    },

    {
        "neovim/nvim-lspconfig", "RRethy/vim-illuminate",
        "nvim-lua/lsp-status.nvim"
        -- config = function()
        --   require('config.lspconfig')
        -- end
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        dir = "~/Documents/dev/null-ls.nvim",
        dev = false,
        -- requires = {"nvim-lua/plenary.nvim"},
    },

    {"zbirenbaum/copilot.lua"},
    {
        "zbirenbaum/copilot-cmp",
        after = {"copilot.lua"},
        config = function()
            require("copilot_cmp").setup({
                formatters = {
                    insert_text = require("copilot_cmp.format").remove_existing
                }
            })
        end
    },

    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        branch = "v2",
        config = function()
            require("neodim").setup({
                refresh_delay = 75, -- time in ms to wait after typing before refresh diagnostics
                alpha = 0.75,
                blend_color = "#000000",
                hide = {underline = true, virtual_text = true, signs = true},
                disable = {} -- table of filetypes to disable neodim
            })
        end
    },

    {
      "utilyre/barbecue.nvim",
      enabled = false,
      -- requires = {
      --   "neovim/nvim-lspconfig",
      --   "smiteshp/nvim-navic",
      --   "kyazdani42/nvim-web-devicons", -- optional
      -- },
      config = function()
        require("barbecue").setup {
          symbols = {
            separator = ">"
          },
        }
        vim.cmd([[
          hi NavicText guifg=#8b949e
          hi NavicSeparator guifg=#6e7681
        ]])
      end,
    },
})

vim.notify = require('notify')

vim.cmd([[nnoremap <space> <nop>]])
vim.g.mapleader = " "

-- How do I replace-paste yanked text in vim without yanking the deleted lines?
-- https://superuser.com/a/321726
vim.cmd([[
  " delete without yanking
  nnoremap <leader>d "_d
  vnoremap <leader>d "_d

  " replace currently selected text with default register
  " without yanking it
  vnoremap <leader>p "_dP
]])

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

-- Move line(s) up or down, for both normal and visual modes.
vim.cmd([[
  nnoremap <c-up> :m -2<cr>
  vnoremap <c-up> :m '<-2<cr>gv
  nnoremap <c-down> :m +1<cr>
  vnoremap <c-down>:m '>+1<cr>gv
]])

-- Shift up, down, left, and right with hjkl, without moving cursor.
vim.cmd([[
  nnoremap <s-k> <c-y>
  nnoremap <s-j> <c-e>
  nnoremap <s-h> zh
  nnoremap <s-l> zl
]])

-- Open up file viewer.
vim.api.nvim_set_keymap("n", "<c-n>", ":NvimTreeFindFileToggle<cr>", {})

-- Split windows.
vim.cmd([[
  nnoremap <c-\> :vsplit<cr><c-w>w
  inoremap <c-\> <esc>:vsplit<cr><c-w>w
]])

-- Faster saving.
vim.cmd([[nnoremap <leader>j :wr<cr>]])

-- Move cursor to bottom after yanking.
-- https://stackoverflow.com/a/3806683/2601179
vim.cmd([[
  vmap y y`]
]])

-- Edit arg or word under cursor.
vim.cmd([[nnoremap R "_ciw]])

vim.o.mouse = false

-- vim.g.light_theme = vim.env.EDITOR_THEME or false
vim.o.termguicolors = true

require("colors")
require("config.colorscheme")

require("config.cmp")
require("config.lspconfig")

-- vim.cmd([[nnoremap <space>l :TroubleToggle<cr>]])
-- vim.diagnostic.config({
--     virtual_text = false,
-- })
-- require('config.lspconfig')

-- Load colors, and highlight fixes for treesitter.

vim.o.hidden = true

-- Highlight the current row of the cursor.
-- https://neovim.io/doc/user/options.html#'cursorline'
vim.o.cursorline = true

-- https://neovim.io/doc/user/options.html#'number'
vim.o.number = true

-- Colorcolumn
vim.o.colorcolumn = "80" -- default
vim.cmd([[
augroup colorcolumn
  au!
  au FileType go set colorcolumn=80,100
  " Commit subject lines get hacked off if more than 72.
  au FileType gitcommit set colorcolumn=72
	au FileType gitcommit set spell
  " prefix: len('pick 6f684cf6fa ') = 16
  au Filetype gitrebase set colorcolumn=88
augroup END
]])

vim.o.wrap = false

-- It's too annoying for Go.

-- vim.o.list = true

-- Configures Neovim's clipboard to bridge the `*` (selection) and `+` (system)
-- clipboards across all platforms. This ensures seamless copy-pasting both
-- inside and outside of nvim. Ref: https://stackoverflow.com/a/30691754
vim.opt.clipboard:append({"unnamed", "unnamedplus"})

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

-- When there's more than one match, complete the longest common prefix among
-- them and show the rest of the options.
vim.o.wildmode = "list:longest,full"
vim.o.completeopt = "menu,menuone,noselect"

-- Add a minimum bumper on edges for scrolling.
vim.o.scrolloff = 2
vim.o.sidescrolloff = 2

-- Argument rewrapping, and add trailing commas.
vim.cmd([[nnoremap <leader>a :ArgWrap<cr>]])
vim.g.argwrap_tail_comma = 1

vim.cmd([[
  autocmd BufWritePre *.go :silent! lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
]])

-- Continue comment sections on return, and format numbered lists.
-- https://stackoverflow.com/a/22577860/2601179
-- https://stackoverflow.com/a/4783237/26011
-- :help fo-table
vim.o.formatoptions = "crqn1jpv"
vim.o.textwidth = 79
-- vim.o.comments='fb:-,fb:*'

-- For compatibility with rg --vimgrep pipe output.
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.errorformat = "%f:%l:%c:%m" .. "," .. vim.o.errorformat

vim.cmd([[
  " hi TreesitterContext guibg=#30363d
  hi TreesitterContext guibg=none gui=none
  hi TreesitterContextBottom guibg=none gui=underline guisp=gray
]])

vim.cmd([[
augroup FormatComments
    autocmd!
    autocmd FileType rust setlocal comments+=n:///<,fb:- | setlocal commentstring=///\ %s
    autocmd FileType sh setlocal comments+=b:# | setlocal commentstring=#\ %s
    autocmd FileType python setlocal comments+=b:# | setlocal commentstring=#\ %s
    autocmd FileType dockerfile setlocal comments+=b:# | setlocal commentstring=#\ %s
    autocmd FileType lua setlocal comments+=b:-- | setlocal commentstring=--\ %s
    autocmd FileType go setlocal comments+=b://,s1:/*,mb:*,ex:*/ | setlocal commentstring=//\ %s
augroup END
]])
