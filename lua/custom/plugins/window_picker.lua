return {
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
      require('window-picker').setup {
        -- Type of hints you want to get: 'statusline-winbar' or 'floating-big-letter'
        -- hint = 'statusline-winbar',
        hint = 'floating-big-letter',

        -- Characters to show in the statusline for window selection
        selection_chars = 'FJDKSLA;CMRUEIWOQP',

        -- Picker specific configurations
        picker_config = {
          statusline_winbar_picker = {
            -- Display string in status bar using '%'
            selection_display = function(char, windowid)
              return '%=' .. char .. '%='
            end,

            -- Use winbar instead of the statusline
            use_winbar = 'never', -- "always" | "never" | "smart"
          },

          floating_big_letter = {
            -- Font for big letter hints
            font = 'ansi-shadow',
          },
        },

        -- Show 'Pick window:' prompt
        show_prompt = true,

        -- Custom prompt message
        prompt_message = 'Pick window: ',

        -- Manual filtering function (if needed)
        filter_func = nil,

        -- Default filter rules
        filter_rules = {
          autoselect_one = true, -- Auto-select if only one window is available
          include_current_win = false, -- Exclude the current window

          bo = { -- Buffer options filtering
            filetype = { 'NvimTree', 'neo-tree', 'notify' }, -- Ignore these file types
            buftype = { 'terminal' }, -- Ignore terminal buffers
          },

          wo = {}, -- Window options filtering (if needed)

          file_path_contains = {}, -- Ignore windows with these file paths

          file_name_contains = {}, -- Ignore windows with these file names
        },

        -- Highlight configurations
        highlights = {
          statusline = {
            focused = {
              fg = '#ededed',
              bg = '#e35e4f',
              bold = true,
            },
            unfocused = {
              fg = '#ededed',
              bg = '#44cc41',
              bold = true,
            },
          },
          winbar = {
            focused = {
              fg = '#ededed',
              bg = '#e35e4f',
              bold = true,
            },
            unfocused = {
              fg = '#ededed',
              bg = '#44cc41',
              bold = true,
            },
          },
        },
      }

      -- Define <localleader>wW to pick a window
      vim.api.nvim_set_keymap(
        'n',
        '<leader>wW',
        [[:lua local picked_window_id = require'window-picker'.pick_window(); if picked_window_id then vim.api.nvim_set_current_win(picked_window_id) end<CR>]],
        { noremap = true, silent = true }
      )
    end,
  },
}
