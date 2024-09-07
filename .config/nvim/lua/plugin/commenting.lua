return { -- Highlight todo, notes, etc in comments
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  {
    'folke/todo-comments.nvim',
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = false,
    },
  },
}
