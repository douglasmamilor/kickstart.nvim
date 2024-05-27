return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false, -- This plugin is already lazy
      },
      'nvim-neotest/neotest-jest',
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-go',
      'lawrence-laz/neotest-zig',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'rustaceanvim.neotest',
          require 'neotest-jest',
          require 'neotest-vitest' {
            -- Specify include and exclude patterns if needed
            include = { '**/__tests__/**/*.[cm]?[jt]sx?', '**/__tests__/?(*.)+(test|spec).[cm]?[jt]sx?', '**/?(*.)+(test|spec).[cm]?[jt]sx?' },
            exclude = { 'it/**', 'cypress/**', 'node_modules/**' },
            -- Path to your Vite configuration file
            vite_config_file = '/path/to/your/vite.config.ts',
          },
          require 'neotest-go',
          require 'neotest-zig',
        },
        log_level = vim.log.levels.DEBUG,
      }
      vim.api.nvim_set_keymap('n', '<leader>mr', ':lua require("neotest").run.run()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ms', ':lua require("neotest").run.stop()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>mo', ':lua require("neotest").output.open()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>mO', ':lua require("neotest").output.open({ enter = true })<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>mi', ':lua require("neotest").summary.toggle()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>mf', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { noremap = true, silent = true })
    end,
  },
}
