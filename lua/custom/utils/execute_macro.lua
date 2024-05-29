-- ~/.config/nvim/lua/custom/utils/execute_macro.lua
local M = {}

-- Function to execute a macro over a visual range
M.execute_macro_over_visual_range = function()
  -- Get the macro character
  local macro_char = vim.fn.nr2char(vim.fn.getchar())

  -- Print the macro character (simulating echo)
  print('@' .. macro_char)

  -- Execute the macro over the selected visual range
  vim.cmd(string.format(":'<,'>normal @%s", macro_char))
end

return M
