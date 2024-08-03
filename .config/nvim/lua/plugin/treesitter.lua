return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'cmake',
      'css',
      'csv',
      'dart',
      'diff',
      'dockerfile',
      'git_config',
      'gitignore',
      'go',
      'gomod',
      'gosum',
      'gowork',
      'graphql',
      'html',
      'http',
      'javascript',
      'jq',
      'json',
      'jsonc',
      'jsonnet',
      'lua',
      'luadoc',
      'make',
      'markdown',
      'markdown_inline',
      'mermaid',
      'nginx',
      'php',
      'printf',
      'proto',
      'python',
      'query',
      'requirements',
      'rust',
      'scala',
      -- 'sql',
      'svelte',
      'thrift',
      'tsv',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'vue',
      'yaml',
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(_, buf)
        local max_filesize = 100 * 1024
        ---@diagnostic disable-next-line: undefined-field
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)
    -- require('config.keymaps').setup_treesitter_keymaps()
  end,
}
