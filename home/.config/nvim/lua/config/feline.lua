-- local gps = require("nvim-gps")

local components = {
    active = {},
    inactive = {}
}

-- @param opts table:
--   short (bool, default=true): Whether to shorten each part of path.
--   short_width (num, default=1): Max width of each path part, if short=true.
--   short_tail (num, default=2): Number of tail paths not to shorten.
local print_fname = function(_, opts)
    local filename = vim.api.nvim_buf_get_name(0)
    opts = opts or {}

    local git_matches
    if vim.b.gitsigns_status_dict then
        local gitroot = vim.b.gitsigns_status_dict.gitdir
        gitroot = vim.fn.fnamemodify(gitroot, ':h').."/"
        gitroot = gitroot:gsub("(%W)", "%%%1") -- quote non-alpha
        filename, git_matches = filename:gsub("^"..gitroot, "")
    end

    if git_matches == 0 then
        filename = vim.fn.fnamemodify(filename, ':~')
    end

    local t = opts.short_tail or 3
    if opts.short or true then
        local parts = vim.split(filename, "/")
        local w = opts.short_width or 1
        for i, part in pairs(parts) do
            if i > #parts - t then
                break
            end
            if string.find(part, "^%.") then
                parts[i] = string.sub(part, 1, w+1)
            else
                parts[i] = string.sub(part, 1, w)
            end
        end
        filename = table.concat(parts, "/")
    end

    return filename
end

components.active[1] = {
    {
        provider = 'vi_mode',
        icon = '',
        hl = {fg = require('colors').get('gray', 4)},
        right_sep = ' ',
    },
    {
        provider = print_fname,
        icon = '',
        hl = {
            fg = require('colors').get('red', 1),
            -- style = 'bold',
        },
        right_sep = ' ',
    },
    {
        provider = {
            name = 'position',
            opts = {padding = true},
        },
        hl = {fg = require('colors').get('gray', 3)},
        right_sep = ' ',
    },
    {
        provider = 'line_percentage',
        hl = {fg = require('colors').get('gray', 5)},
        right_sep = ' ',
    },
    {
        provider = 'diagnostic_errors',
        icon = 'E:',
        hl = {fg = require('colors').get('red', 4)},
        right_sep = ' ',
    },
    {
        provider = 'diagnostic_warnings',
        icon = 'W:',
        hl = {fg = require('colors').get('yellow', 4)},
        right_sep = ' ',
    },
    {
        provider = 'diagnostic_hints',
        icon = 'H:',
        hl = {fg = require('colors').get('blue', 4)},
        right_sep = ' ',
    },
    {
        provider = 'diagnostic_info',
        icon = 'I:',
        hl = {fg = require('colors').get('gray', 4)},
        right_sep = ' ',
    },
    {
        provider = 'git_branch',
        icon = '',
        hl = {fg = require('colors').get('purple', 4)},
        left_sep = ' ',
        right_sep = ' ',
    },
    {
        provider = 'git_diff_added',
        icon = '+',
        hl = {fg = require('colors').get('gray', 4)},
        right_sep = {str = ' '},
    },
    {
        provider = 'git_diff_removed',
        icon = '-',
        hl = {fg = require('colors').get('gray', 4)},
        right_sep = {str = ' '},
    },
    {
        provider = 'git_diff_changed',
        icon = '~',
        hl = {fg = require('colors').get('gray', 4)},
    },
    -- {
    --     provider = function() return gps.get_location() end,
    --     enabled = function() return gps.is_available() end,
    --     hl = {fg = require('colors').get('blue', 2)},
    --     left_sep = ' ',
    --     right_sep = ' ',
    -- },
}

components.inactive[1] = {
    {
        provider = print_fname,
        icon = '',
        -- hl = {
        --     fg = require('colors').get('gray', 4),
        -- },
    },
}

local theme
if vim.g.light_theme then
  theme = {
      bg = '#ddf4ff',
      fg = '#58a6ff',
  }
else
  theme = {
      bg = require('colors').get('gray', 7),
      fg = '#58a6ff',
  }
end

require('feline').setup({
    components = components,
    theme = theme,
})
