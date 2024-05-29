-- ~/.config/nvim/lua/custom/utils/create_file.lua

local M = {}

function M.create_file()
  local current_dir = vim.fn.expand '%:p:h' .. '/' -- Get the current directory

  vim.ui.input({ prompt = 'Name new file: ', default = current_dir }, function(new_file)
    if new_file and new_file ~= '' then
      vim.cmd('edit ' .. new_file)
    end
  end)
end

return M
