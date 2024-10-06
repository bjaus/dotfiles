return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'vrischmann/tree-sitter-templ',
    },
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
    config = function(_, opts)
      require('treesitter-context').setup(opts)
      require('config.keymaps').setup_treesitter_context()
    end,
  },
  {
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
        'templ',
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
      fold = { enable = true },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
      -- require('config.keymaps').setup_treesitter_keymaps()
    end,
  },
}
