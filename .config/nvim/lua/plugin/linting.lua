return {
  -- https://github.com/mfussenegger/nvim-lint
  'mfussenegger/nvim-lint',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      go = { 'golangcilint' },
      python = { 'ruff', 'mypy' },
      yaml = { 'yamllint' },
      json = { 'jsonlint' },
      toml = { 'taplo' },
    }

    -- Special handling for CloudFormation files
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      pattern = {
        '*/cloudformation/*.yaml',
        '*/cloudformation/*.yml',
        '*/cfn/*.yaml',
        '*/cfn/*.yml',
        '*-stack.yaml',
        '*-stack.yml',
        '*.cfn.yaml',
        '*.cfn.yml',
        'template.yaml',
        'template.yml',
      },
      callback = function()
        -- Use cfn-lint instead of yamllint for CloudFormation templates
        vim.b.lint_linters = { 'cfn_lint' }
      end,
    })

    -- Create autocommand which carries out the actual linting on the specified events.
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('lint', { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
