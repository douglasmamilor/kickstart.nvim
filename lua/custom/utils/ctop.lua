-- ~/.config/nvim/lua/custom/plugins/ctop.lua
local M = {}

-- Function to open ctop in a floating window
M.run_ctop = function()
  -- Define the floating window's size and position
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create a new buffer and set it to be scratch
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
  })

  -- Run ctop in the floating window
  vim.fn.termopen 'ctop'

  -- Enter terminal mode
  vim.cmd 'startinsert'

  -- Close the window when pressing escape
  vim.api.nvim_buf_set_keymap(buf, 't', '<Esc>', '<C-\\><C-n>:bd!<CR>', { noremap = true, silent = true })
end

return M
