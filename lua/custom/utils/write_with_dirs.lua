-- ~/.config/nvim/lua/custom/utils/write_with_dirs.lua
local M = {}

-- Function to create directories and write the file
M.create_dirs_and_write = function()
  -- Get the current file path
  local filepath = vim.fn.expand '%:p'

  -- Get the directory path
  local dirpath = vim.fn.fnamemodify(filepath, ':h')

  -- Create the directory if it doesn't exist
  vim.fn.mkdir(dirpath, 'p')

  -- Write the file
  vim.cmd 'write'
end

return M
