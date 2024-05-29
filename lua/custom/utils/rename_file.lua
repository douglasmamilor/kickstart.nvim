-- ~/.config/nvim/lua/custom/utils/rename_file.lua

local M = {}

function M.rename_file()
  local old_name = vim.fn.expand '%:p' -- Full path to the current file
  local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Save the cursor position

  vim.ui.input({ prompt = 'Rename file to: ', default = old_name }, function(new_name)
    if new_name and new_name ~= '' and new_name ~= old_name then
      -- Save the file with the new name
      vim.cmd('saveas ' .. new_name)

      -- Close the old buffer
      vim.cmd('bdelete ' .. vim.fn.bufnr(old_name))

      -- Delete the old file
      vim.fn.delete(old_name)

      -- Restore the cursor position
      vim.api.nvim_win_set_cursor(0, cursor_pos)

      -- Redraw the screen
      vim.cmd 'redraw!'
    end
  end)
end

return M
