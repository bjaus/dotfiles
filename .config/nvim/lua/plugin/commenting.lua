return { -- Highlight todo, notes, etc in comments
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  {
    'folke/todo-comments.nvim',
    enabled = true,
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = false,
    },
  },
}
