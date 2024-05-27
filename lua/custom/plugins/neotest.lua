return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false, -- This plugin is already lazy
      },
      'nvim-neotest/neotest-jest',
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-go',
      'lawrence-laz/neotest-zig'
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('rustaceanvim.neotest'),
          require('neotest-jest')({
            -- Any Jest-specific configuration here
          }),
          require('neotest-vitest'),
          require('neotest-go'),
          require('neotest-zig'),
        },
        log_level = vim.log.levels.DEBUG
      })
      vim.keymap.set('n', '<leader>mr', ':lua require("neotest").run.run()<CR>', {noremap = true, silent = true})
      vim.keymap.set('n', '<leader>ms', ':lua require("neotest").run.stop()<CR>', {noremap = true, silent = true})
      vim.keymap.set('n', '<leader>mo', ':lua require("neotest").output.open()<CR>', {noremap = true, silent = true})
      vim.keymap.set('n', '<leader>mO', ':lua require("neotest").output.open({ enter = true })<CR>', {noremap = true, silent = true})
      vim.keymap.set('n', '<leader>mi', ':lua require("neotest").summary.toggle()<CR>', {noremap = true, silent = true})
      vim.keymap.set('n', '<leader>mf', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', {noremap = true, silent = true})
    end
  }
}
