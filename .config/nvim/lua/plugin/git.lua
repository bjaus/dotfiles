return {
  {
    'ruifm/gitlinker.nvim',
    event = "VeryLazy",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local linker = require('gitlinker')
      linker.setup()
      require('config.keymaps').setup_git_linker_keymaps()
    end
  },
  {
    'f-person/git-blame.nvim',
    enabled = false,
    event = 'VeryLazy',
    config = function()
      vim.cmd ':GitBlameToggle' -- disable at startup
    end,
    -- keys = require('config.keymaps').setup_git_blame_keymaps(),
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
      require('config.keymaps').setup_lazygit_keymaps()
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    enabled = true,
    opts = {
      numhl = true,
      signs = {
        -- add = { text = '+' },
        -- change = { text = '~' },
        -- delete = { text = 'x' },
        -- topdelete = { text = '‾' },
        -- changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        require('config.keymaps').setup_git_signs_keymaps(bufnr)
      end,
    },
  },
}
