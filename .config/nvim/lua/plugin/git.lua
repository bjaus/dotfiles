return {
  {
    'ruifm/gitlinker.nvim',
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
    -- https://github.com/f-person/git-blame.nvim
    'f-person/git-blame.nvim',
    enabled = false,
    event = 'VeryLazy',
    config = function()
      vim.cmd ':GitBlameToggle' -- disable at startup
    end,
    -- keys = require('config.keymaps').setup_git_blame_keymaps(),
  },
  {
    -- https://github.com/kdheepak/lazygit.nvim
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
    -- https://github.com/lewis6991/gitsigns.nvim
    -- See `:help gitsigns`
    'lewis6991/gitsigns.nvim',
    enabled = false,
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        -- require('config.keymaps').setup_git_signs_keymaps(bufnr)
      end,
    },
  },
}
