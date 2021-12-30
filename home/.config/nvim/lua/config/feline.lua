local gps = require("nvim-gps")

local components = {
    active = {},
    inactive = {}
}

components.active[1] = {
    {
        provider = 'vi_mode',
        icon = '',
        right_sep = ' ',
    },
    {
        provider = 'file_info',
        icon = '',
        opts = {
            type = 'relative',
            file_readonly_icon = 'ro',
            file_modified_icon = '*',
        },
    },
    {
        provider = 'position',
    },
    {
        provider = 'line_percentage',
    },
    {
        provider = 'diagnostic_errors',
        icon = ' E:',
        -- hl = {fg = 'red'},
    },
    {
        provider = 'diagnostic_warnings',
        icon = ' W:',
        -- hl = {fg = 'yellow'},
    },
    {
        provider = 'diagnostic_hints',
        icon = ' H:',
    },
    {
        provider = 'diagnostic_info',
        icon = ' I:',
        -- hl = {fg = 'blue'},
    },
    {
    	provider = function() return gps.get_location() end,
	    enabled = function() return gps.is_available() end,
      left_sep = ' ',
    },

}

components.active[2] = {
    {
        provider = 'git_branch',
        icon = '',
        right_sep = ' - ',
    },
    {
        provider = 'git_diff_added',
        icon = '+',
        -- hl = {fg = 'green'},
        left_sep = ' [',
    },
    {
        provider = 'git_diff_changed',
        icon = '~',
        -- hl = {fg = 'orange'}
    },
    {
        provider = 'git_diff_removed',
        icon = '-',
        -- hl = {fg = 'red'},
        right_sep = '] ',
    },
}

components.inactive[1] = {
    {
        provider = 'file_info',
        icon = '',
        opts = {
            type = 'relative',
            file_readonly_icon = 'ro',
            file_modified_icon = '*',
        },
    },
    -- Empty component to fix the highlight till the end of the statusline
    {},
}

local colors
if vim.g.light_theme then
  colors = {
      bg = '#ddf4ff',
      -- fg = '#0969da',
      fg = '#58a6ff',
      -- fg = 'black',
  }
else
  colors = {
      bg = '#051d4d',
      -- fg = '#388bfd',
      fg = '#58a6ff',
      -- fg = '#79c0ff',
      -- fg = 'black',
  }
end

require('feline').setup {
    colors = colors,
    -- preset = 'default',
    components = components,
	-- components = {
	-- 	active = {
      -- {
          -- provider = '▊ ',
          -- hl = {
              -- fg = 'skyblue'
          -- }
      -- },
      -- {
          -- provider = 'vi_mode',
          -- hl = function()
              -- return {
                  -- name = vi_mode_utils.get_mode_highlight_name(),
                  -- fg = vi_mode_utils.get_mode_color(),
                  -- style = 'bold'
              -- }
          -- end,
          -- right_sep = ' '
      -- },
	-- 	},
	-- 	inactive = {},
	-- },
}
