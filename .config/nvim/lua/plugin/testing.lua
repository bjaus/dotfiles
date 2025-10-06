return {
  {
    'nvim-neotest/neotest',
    enabled = true,
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'klen/nvim-test',
      -- 'nvim-neotest/neotest-go',
      { 'fredrikaverpil/neotest-golang', version = '*' },
      'marilari88/neotest-vitest',
    },
    opts = {
      adapters = {
        -- ['neotest-go'] = {
        --   experimental = {
        --     test_table = true,
        --   },
        -- },
        -- ['neotest-golang'] = {
        --   -- args = {
        --   --
        --   -- },
        --   go_test_args = {
        --     '-count=1',
        --     '-race',
        --     '-cover',
        --     '-coverpkg=./...',
        --     '-coverprofile=coverage.out',
        --   },
        --   testify_enabled = true,
        --   warn_test_name_dupes = true,
        --   warn_test_not_executed = true,
        -- },
        ['neotest-vitest'] = {},
      },
      discovery = {
        enabled = true,
        concurrent = 0,
      },
      running = {
        concurrent = false,
      },
      summary = {
        enabled = true,
        follow = true,
        animated = true,
        expand_errors = true,
        mappings = {
          expand = { '<CR>', '<2-LeftMouse>' },
          stop = { 'x', '<Esc>' },
          run = { 'r' },
          debug = { 'd' },
          mark = { 'm' },
          clear_marked = { 'M' },
          next_failed = { ']' },
          prev_failed = { '[' },
        },
      },
      diagnostic = {
        enabled = true,
        severity = vim.diagnostic.severity.ERROR,
      },
      floating = {
        max_height = 0.9,
        max_width = 0.9,
        border = 'rounded',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      output = {
        enabled = true,
        open_on_run = 'short',
      },
      quickfix = {
        enabled = true,
        open = false,
      },
      run = {
        enabled = true,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace 'neotest'
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)

      opts.adapters = opts.adapters or {}
      -- table.insert(
      --   opts.adapters,
      --   require 'neotest-go' {
      --     experimental = {
      --       test_table = true,
      --     },
      --   }
      -- )
      table.insert(
        opts.adapters,
        require 'neotest-golang' {
          go_test_args = {
            '-v',
            '-count=1',
            '-race',
            '-cover',
            '-coverpkg=./...',
            '-coverprofile=/tmp/coverage.out',
          },
          testify_enabled = true,
          warn_test_name_dupes = false,
          warn_test_not_executed = false,
        }
      )
      require('neotest').setup(opts)
    end,
    keys = require('config.keymaps').setup_neotest(),
  },
  {
    'vim-test/vim-test',
    enabled = true,
    event = 'VeryLazy',
    cmd = { 'TestFile', 'TestNearest', 'TestSuite' },
    config = function()
      vim.g['test#strategy'] = 'neovim'
      vim.g['test#go#runner'] = 'gotest'
    end,
  },
  -- {
  --   'nvim-neotest/neotest',
  --   enabled = false,
  --   event = 'VeryLazy',
  --   dependencies = {
  --     'nvim-neotest/nvim-nio',
  --     'nvim-lua/plenary.nvim',
  --     'antoinemadec/FixCursorHold.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --
  --     'nvim-neotest/neotest-plenary',
  --     'nvim-neotest/neotest-vim-test',
  --     'fredrikaverpil/neotest-golang', -- Installation
  --   },
  --   opts = {
  --     -- See all config options with :h neotest.Config
  --     discovery = {
  --       -- Drastically improve performance in ginormous projects by
  --       -- only AST-parsing the currently opened buffer.
  --       enabled = true,
  --       -- Number of workers to parse files concurrently.
  --       -- A value of 0 automatically assigns number based on CPU.
  --       -- Set to 1 if experiencing lag.
  --       concurrent = 0,
  --     },
  --     running = {
  --       -- Run tests concurrently when an adapter provides multiple commands to run.
  --       concurrent = false,
  --     },
  --     summary = {
  --       -- Enable/disable animation of icons.
  --       animated = true,
  --     },
  --   },
  --   config = function(_, opts)
  --     if opts.adapters then
  --       local adapters = {}
  --       for name, config in pairs(opts.adapters or {}) do
  --         if type(name) == 'number' then
  --           if type(config) == 'string' then
  --             config = require(config)
  --           end
  --           adapters[#adapters + 1] = config
  --         elseif config ~= false then
  --           local adapter = require(name)
  --           if type(config) == 'table' and not vim.tbl_isempty(config) then
  --             local meta = getmetatable(adapter)
  --             if adapter.setup then
  --               adapter.setup(config)
  --             elseif adapter.adapter then
  --               adapter.adapter(config)
  --               adapter = adapter.adapter
  --             elseif meta and meta.__call then
  --               adapter(config)
  --             else
  --               error('Adapter ' .. name .. ' does not support setup')
  --             end
  --           end
  --           adapters[#adapters + 1] = adapter
  --         end
  --       end
  --       opts.adapters = adapters
  --     end
  --
  --     require('neotest').setup(opts)
  --   end,
  --   keys = require('config.keymaps').setup_neotest_keymaps(),
  -- },
}
