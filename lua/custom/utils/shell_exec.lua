-- ~/.config/nvim/lua/custom/utils/shell_exec.lua

local M = {}

M.execute_in_shell = function(command)
  command = table.concat(vim.fn.map(vim.fn.split(command), 'expand(v:val)'))
  local winnr = vim.fn.bufwinnr('^' .. command .. '$')
  if winnr < 0 then
    vim.cmd('botright new ' .. vim.fn.fnameescape(command))
  else
    vim.cmd(winnr .. 'wincmd w')
  end
  vim.cmd [[
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  ]]
  print('Execute ' .. command .. '...')
  vim.cmd('silent %!' .. command)
  vim.cmd('resize ' .. vim.fn.line '$')
  vim.cmd 'redraw'
  vim.cmd('au BufUnload <buffer> execute bufwinnr(' .. vim.fn.bufnr '#' .. ") .. 'wincmd w'")
  vim.cmd("nnoremap <silent> <buffer> <LocalLeader>r :lua require'utils.shell_exec'.execute_in_shell('" .. command .. "')<CR>")
  print('Shell command ' .. command .. ' executed.')
end

vim.api.nvim_create_user_command('Shell', function(opts)
  M.execute_in_shell(opts.args)
end, { nargs = '+', complete = 'shellcmd' })

return M
