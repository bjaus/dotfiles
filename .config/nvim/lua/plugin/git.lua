return {
  {
    'ruifm/gitlinker.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local linker = require 'gitlinker'
      linker.setup()
      require('config.keymaps').setup_gitlinker()
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    enabled = true,
    event = 'VeryLazy',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('config.keymaps').setup_lazygit()
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    enabled = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local gitsigns = require 'gitsigns'
      gitsigns.setup {
        numhl = true,
        signs = {
          -- add = { text = '+' },
          -- change = { text = '~' },
          -- delete = { text = 'x' },
          -- topdelete = { text = '‾' },
          -- changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          require('config.keymaps').setup_gitsigns(bufnr)
        end,
      }
    end,
  },
  {
    'f-person/git-blame.nvim',
    enabled = true,
    event = 'VeryLazy',
    config = function()
      vim.cmd ':GitBlameToggle' -- disable at startup
    end,
    keys = require('config.keymaps').setup_git_blame(),
  },
}
