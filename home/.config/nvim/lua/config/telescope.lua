local actions = require('telescope.actions')

path_display = function(opts, path)
  -- local tail = require("telescope.utils").path_tail(path)
  -- return string.format("%s (%s)", tail, path)
  -- print(vim.inspect(path))
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
}

-- vim.api.nvim_set_keymap(
--   'n',
--   '<c-r>',
--   ":lua require('telescope').extensions.frecency.frecency(require('telescope.themes').get_ivy{previewer=false})<cr>",
--   {noremap = true, silent = true}
-- )
vim.api.nvim_set_keymap(
  'n',
  '<c-r>',
  ":lua require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy{previewer=false})<cr>",
  {noremap = true, silent = true}
)

search_dirs = function()
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

-- search_dirs()

vim.api.nvim_set_keymap(
  'n',
  '<c-p>',
  [[:lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy{prompt_title = nil, previewer = false, search_dirs = search_dirs()})<cr>]],
  {noremap = true, silent = true}
)

vim.cmd([[
  nnoremap <c-f> :lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy{previewer=false})<cr>
  nnoremap <c-d> :lua require('telescope.builtin').live_grep{ search_dirs = {vim.fn.expand('%:p:h')} }<cr>
  nnoremap <c-x> :lua require('telescope.builtin').commands(require('telescope.themes').get_ivy())<cr>
  nnoremap <c-g> :lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy())<cr>
]])
-- nnoremap <c-f> :Telescope current_buffer_fuzzy_find<cr>

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
