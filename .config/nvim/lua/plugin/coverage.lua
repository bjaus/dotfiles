return {
  'andythigpen/nvim-coverage',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    auto_reload = true,
    lang = {
      go = {
        coverage_file = '/tmp/coverage.out',
      },
    },
  },
  config = function(_, opts)
    require('coverage').setup(opts)
    require('config.keymaps').setup_coverage()
  end,
}
