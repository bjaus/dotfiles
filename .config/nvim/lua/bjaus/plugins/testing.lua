return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'fredrikaverpil/neotest-golang', -- Installation
    },
    config = function()
      local neotest_go_config = {
        go_test_args = {
          '-race',
          -- '-shuffle=on',
          '-cover',
          '-short',
          '-coverfile=' .. vim.fn.getcwd() .. '/coverage.out',
        },
      }

      require('neotest').setup {
        log_level = vim.log.levels.ERROR,
        adapters = {
          require 'neotest-golang'(neotest_go_config), -- Registration
        },
      }
    end,
  },
  {
    'klen/nvim-test',
    enabled = false,
    config = function()
      local test = require 'nvim-test'

      test.setup {
        run = true, -- run tests (using for debug)
        commands_create = true, -- create commands (TestFile, TestLast, ...)
        silent = true, -- less notifications
        term = 'toggleterm', -- a terminal to run ("terminal"|"toggleterm")
        termOpts = {
          direction = 'float', -- terminal's direction ("horizontal"|"vertical"|"float")
          width = 180, -- terminal's width (for vertical|float)
          height = 25, -- terminal's height (for horizontal|float)
          go_back = false, -- return focus to original window after executing
          stopinsert = 'auto', -- exit from insert mode (true|false|"auto")
          keep_one = true, -- keep only one terminal for testing
        },
        runners = { -- setup tests runners
          go = 'nvim-test.runners.go-test',
          javascript = 'nvim-test.runners.jest',
          lua = 'nvim-test.runners.busted',
          python = 'nvim-test.runners.pytest',
          rust = 'nvim-test.runners.cargo-test',
          typescript = 'nvim-test.runners.jest',
        },
      }

      require('nvim-test.runners.go-test'):setup {
        -- command = 'go',
        -- -- args = { 'test', '-p', '1', '-race', '-suffle=on', '-short', '-cover' },
        args = { 'test', '-cover' },
        -- file_pattern = '\\v([^.]+_test)\\.go$', -- determine whether a file is a testfile
        -- find_files = { '{name}_test.go' }, -- find testfile for a file
      }

      vim.keymap.set('n', '<leader>ts', '<cmd>TestSuite<cr>', { desc = '[T]est whole [S]uite' })
      vim.keymap.set('n', '<leader>tf', '<cmd>TestFile<cr>', { desc = '[T]est current [F]ile' })
      vim.keymap.set('n', '<leader>tn', '<cmd>TestNearest<cr>', { desc = '[T]est [N]earest to cursor' })
      vim.keymap.set('n', '<leader>tl', '<cmd>TestSuite<cr>', { desc = '[T]est [L]atest' })
      vim.keymap.set('n', '<leader>ti', '<cmd>TestSuite<cr>', { desc = '[T]est [I]nformation' })
    end,
  },
}
