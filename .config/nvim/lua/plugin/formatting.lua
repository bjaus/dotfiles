return {
  -- Autoformat
  -- https://github.com/stevearc/conform.nvim
  'stevearc/conform.nvim',
  enabled = true,
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = require('config.keymaps').setup_conform(),
  opts = {
    format_on_save = {
      timeout_ms = 5000,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      go = { 'goimports_reviser', 'gofmt' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      html = { 'prettier' },
      markdown = { 'prettier' },
      yaml = { 'prettier' },
      toml = { 'taplo' },
      lua = { 'stylua' },
      python = { 'ruff_format', 'ruff_organize_imports' },
      rust = { 'rustfmt' },
    },
    formatters = {
      goimports_reviser = {
        command = 'goimports-reviser',
        args = {
          '-imports-order=std,general,company',
          '-company-prefixes=rewardStyle',
          '-format',
          '$FILENAME',
        },
        stdin = false,
      },
    },
  },
  config = function(_, opts)
    local conform = require 'conform'

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        if vim.g.auto_format then
          conform.format {
            bufnr = args.buf,
            timeout_ms = 5000,
            lsp_format = 'fallback',
          }
        else
        end
      end,
    })

    -- set initial state to auto-format
    vim.g.auto_format = true
    conform.setup(opts)
  end,
}
