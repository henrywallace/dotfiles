local actions = require('telescope.actions')

local path_display = function(opts, path)
  -- Returns a modified version of the given path using the fnamemodify function from Vim.
  -- The ":~" modifier is used to shorten the path by replacing the home directory with a tilde (~).
  -- This is often done to make long paths more readable and concise.
  -- For more information, refer to the Vim documentation: https://neovim.io/doc/user/eval.html#fnamemodify()
  return vim.fn.fnamemodify(path, ":~")
end


require('telescope').setup {
  defaults = {
    -- sorting_strategy = 'ascending',
    path_display = path_display,
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      },
    }
  },
  extensions = {
    frecency = {
      show_scores = true,
      ignore_patterns = {"*.git/*", "*/tmp/*"},
    },
  },
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
}

require('telescope').load_extension('fzf')

-- vim.api.nvim_set_keymap(
--   'n',
--   '<l-r>',
--   ":lua require('telescope').extensions.frecency.frecency(require('telescope.themes').get_ivy{previewer=false})<cr>",
--   {noremap = true, silent = true}
-- )

-- vim.api.nvim_set_keymap(
--   'n',
--   '<c-b>',
--   ":lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy{previewer=false})<cr>",
--   {noremap = true, silent = true}
-- )

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local ivy_theme = themes.get_ivy({
  previewer=false,
  layout_config = {
    height = 10,
  },
})

vim.keymap.set({'n', 'i', 'v'}, '<c-b>', function()
  builtin.buffers(ivy_theme)
end)

vim.keymap.set({'n', 'v', 'i'}, '<c-r>', function()
  builtin.oldfiles(ivy_theme)
end)

-- vim.keymap.set({'n', 'v', 'i'}, '<c-f>', function()
--   builtin.current_buffer_fuzzy_find(ivy_theme)
-- end)

local search_dirs = function()
  local Job = require'plenary.job'
  local job = Job:new({
    command = 'git',
    args = {'rev-parse', '--show-toplevel'}
  })
  job:sync()
  local res = job:result()
  local git_root = res[1]
  -- print(vim.inspect(res))
  -- print(vim.inspect(git_root))
  return {
    git_root
  }
end

vim.api.nvim_set_keymap(
  'n',
  '<c-p>',
  [[:lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy{prompt_title = nil, previewer = false, search_dirs = search_dirs()})<cr>]],
  {noremap = true, silent = true}
)

vim.cmd([[
  nnoremap <c-f> :lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy{previewer=false})<cr>
  nnoremap <c-x> :lua require('telescope.builtin').commands(require('telescope.themes').get_ivy())<cr>
  nnoremap <c-g> :lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy())<cr>
  nnoremap <c-s> :Telescope lsp_document_symbols<cr>
  nnoremap <c-d> :lua require'telescope.builtin'.grep_string{shorten_path = true, word_match = "-w", only_sort_text = true, search = ''}<cr>
  " nnoremap <c-d> :lua require('telescope.builtin').live_grep{ search_dirs = {vim.fn.expand('%:p:h')} }<cr>
  " nnoremap <c-f> :Telescope current_buffer_fuzzy_find<cr>
]])

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

-- our picker function: colors
local colors = function(opts)
  local cmd = vim.tbl_flatten{"ls"}
  opts = opts or {}
  opts.entry_maker = opts.entry_maker or require("telescope.make_entry").gen_from_file(opts)
  pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_oneshot_job(vim.tbl_flatten(cmd), opts),
    sorter = conf.file_sorter(opts),
  }):find()
end

-- to execute the function
-- colors()
