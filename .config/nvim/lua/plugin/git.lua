return {
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    config = function()
      vim.cmd ':GitBlameToggle' -- disable at startup
    end,
    keys = require('config.keymaps').setup_git_blame_keymaps(),
  },
  {
    'kdheepak/lazygit.nvim',
    event = 'VeryLazy',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('config.keymaps').setup_lazygit_keymaps()
    end,
  },
  { -- See `:help gitsigns`
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        require('config.keymaps').setup_git_signs_keymaps(bufnr)
      end,
    },
  },
}
