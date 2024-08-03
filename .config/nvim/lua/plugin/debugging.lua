return {
  {
    'mfussenegger/nvim-dap',
    enabled = true,
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    keys = function(_, keys)
      return require('config.keymaps').setup_dap(keys)
    end,
    config = function()
      require('mason-nvim-dap').setup {
        automatic_installation = true,
        ensure_installed = {
          'delve',
        },
      }

      local dap = require 'dap'
      local dapui = require 'dapui'

      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
  {
    'leoluz/nvim-dap-go',
    enabled = true,
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('dap-go').setup()
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    enabled = true,
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    opts = {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        enabled = true,
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    },
    keys = require('config.keymaps').setup_dap_ui(),
    config = function(_, opts)
      require('dapui').setup(opts)
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    enabled = true,
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function(_, opts)
      require('nvim-dap-virtual-text').setup(opts)
    end,
  },
}
