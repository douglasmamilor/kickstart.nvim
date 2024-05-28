-- ~/.config/nvim/lua/custom/utils/alternative_file.lua

local M = {}

function M.OpenAlternativeFile()
  local current_file = vim.fn.expand '%:r' -- file name with path
  local current_extension = vim.fn.expand '%:e'
  local file_name = vim.fn.expand '%:t' -- just file name with extension
  local current_dir = vim.fn.expand '%:p:h' -- Get the current directory
  local test_dir = current_dir .. '/__tests__'

  local function file_exists(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == 'file'
  end

  local function dir_exists(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == 'directory'
  end

  if current_extension == 'h' then
    vim.cmd('e ' .. current_file .. '.c')
  elseif current_extension == 'c' then
    vim.cmd('e ' .. current_file .. '.h')
  elseif current_extension == 'go' then
    if file_name:match '_test%.go$' then
      local equivalent_file = current_file:gsub('_test$', '') .. '.go'
      vim.cmd('e ' .. equivalent_file)
    else
      vim.cmd('e ' .. current_file .. '_test.go')
    end
  elseif current_extension == 'ts' then
    if file_name:match '%.test%.ts$' then
      local equivalent_file = current_file:gsub('%.test$', '') .. '.ts'
      if current_dir:match '/__tests__$' then
        equivalent_file = current_dir:gsub('/__tests__$', '') .. '/' .. file_name:gsub('%.test%.ts$', '') .. '.ts'
      end
      vim.cmd('e ' .. equivalent_file)
    else
      local test_file = ''
      local alt_dir = current_dir
      if dir_exists(test_dir) then
        alt_dir = test_dir
      end
      test_file = alt_dir .. '/' .. file_name:gsub('%.ts$', '') .. '.test.ts'
      vim.cmd('e ' .. test_file)
    end
  elseif current_extension == 'tsx' then
    if file_name:match '%.test%.tsx$' then
      local equivalent_file = current_file:gsub('%.test$', '') .. '.tsx'
      if current_dir:match '/__tests__$' then
        equivalent_file = current_dir:gsub('/__tests__$', '') .. '/' .. file_name:gsub('%.test%.tsx$', '') .. '.tsx'
      end
      vim.cmd('e ' .. equivalent_file)
    else
      local test_file = ''
      local alt_dir = current_dir
      if dir_exists(test_dir) then
        alt_dir = test_dir
      end
      test_file = alt_dir .. '/' .. file_name:gsub('%.tsx$', '') .. '.test.tsx'
      vim.cmd('e ' .. test_file)
    end
  else
    vim.cmd('e ' .. vim.fn.expand '%')
  end
end

return M
