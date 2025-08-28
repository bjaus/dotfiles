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
  -- Gitsigns moved to plugin/gitsigns.lua for better organization
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
