return {
  -- Highlight todo, notes, etc in comments
  -- https://github.com/folke/todo-comments.nvim
  'folke/todo-comments.nvim',
  enabled = true,
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    signs = false,
  },
}
