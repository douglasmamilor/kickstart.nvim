-- ~/.config/nvim/lua/custom/utils/sudo_write.lua
local M = {}

-- Function to write the file using sudo
M.sudo_write = function()
  -- Get the current file path
  local filepath = vim.fn.expand '%:p'
  -- Create the command to write the file with sudo
  local cmd = string.format('sudo tee %s > /dev/null', vim.fn.shellescape(filepath))
  -- Execute the command
  vim.fn.inputsave()
  local password = vim.fn.inputsecret 'Password: '
  vim.fn.inputrestore()
  if password == '' then
    print 'Operation canceled'
    return
  end
  vim.fn.system(string.format("echo '%s' | %s", password, cmd))
  -- Reload the file to make sure it's correctly written
  vim.cmd 'e!'
end

return M
