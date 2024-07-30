return {
  {
    'nvim-neotest/neotest',
    enabled = true,
    event = 'VeryLazy',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',

      'nvim-neotest/neotest-plenary',
      'nvim-neotest/neotest-vim-test',
      'fredrikaverpil/neotest-golang', -- Installation
    },
    opts = {
      -- See all config options with :h neotest.Config
      discovery = {
        -- Drastically improve performance in ginormous projects by
        -- only AST-parsing the currently opened buffer.
        enabled = true,
        -- Number of workers to parse files concurrently.
        -- A value of 0 automatically assigns number based on CPU.
        -- Set to 1 if experiencing lag.
        concurrent = 0,
      },
      running = {
        -- Run tests concurrently when an adapter provides multiple commands to run.
        concurrent = false,
      },
      summary = {
        -- Enable/disable animation of icons.
        animated = true,
      },
    },
    config = function(_, opts)
      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == 'number' then
            if type(config) == 'string' then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == 'table' and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif adapter.adapter then
                adapter.adapter(config)
                adapter = adapter.adapter
              elseif meta and meta.__call then
                adapter(config)
              else
                error('Adapter ' .. name .. ' does not support setup')
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require('neotest').setup(opts)
    end,
    keys = require('config.keymaps').setup_neotest_keymaps(),
  },
  {
    'klen/nvim-test',
    enabled = false,
    config = function()
      local test = require 'nvim-test'

      test.setup {
        run = true,             -- run tests (using for debug)
        commands_create = true, -- create commands (TestFile, TestLast, ...)
        silent = true,          -- less notifications
        term = 'toggleterm',    -- a terminal to run ("terminal"|"toggleterm")
        termOpts = {
          direction = 'float',  -- terminal's direction ("horizontal"|"vertical"|"float")
          width = 180,          -- terminal's width (for vertical|float)
          height = 25,          -- terminal's height (for horizontal|float)
          go_back = false,      -- return focus to original window after executing
          stopinsert = 'auto',  -- exit from insert mode (true|false|"auto")
          keep_one = true,      -- keep only one terminal for testing
        },
        runners = {             -- setup tests runners
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
  }
}
