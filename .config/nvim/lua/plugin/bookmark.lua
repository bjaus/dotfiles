return {
  'crusj/bookmarks.nvim',
  branch = 'main',
  dependencies = {
    'nvim-web-devicons',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('bookmarks').setup {
      mapping_enabled = true,
      keymap = require('config.keymaps').setup_bookmarks(),
      virt_pattern = {
        '*.go',
        '*.js',
        '*.lua',
        '*.py',
        '*.rs',
        '*.sh',
        '*.sql',
        '*.ts',
      },
    }
    require('telescope').load_extension 'bookmarks'
  end,
}
