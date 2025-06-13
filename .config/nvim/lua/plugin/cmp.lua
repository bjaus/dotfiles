---@diagnostic disable: undefined-field
local source_mapping = {
  nvim_lsp = '[LSP]',
  nvim_lua = '[LUA]',
  luasnip = '[SNIP]',
  buffer = '[BUF]',
  path = '[PATH]',
  treesitter = '[TREE]',
  dap = '[DAP]',
  copilot = '[COP]',
}

local config = function()
  local cmp = require 'cmp'
  local lspkind = require 'lspkind'
  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

  cmp.setup {
    preselect = cmp.PreselectMode.Item,
    keyword_length = 2,
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    completion = {
      autocomplete = false, -- cmp won't auto-trigger, only with <C-Space>
      completeopt = 'menu,menuone,noinsert',
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    view = {
      entries = {
        name = 'custom',
        selection_order = 'near_cursor',
        follow_cursor = true,
      },
    },
    mapping = cmp.mapping.preset.insert(require('config.keymaps').setup_cmp()),
    sources = cmp.config.sources {
      {
        name = 'copilot',
        group_index = 1,
      },
      {
        name = 'nvim_lsp',
        group_index = 1,
      },
      {
        name = 'luasnip',
        group_index = 2,
        option = { use_show_condition = true },
        entry_filter = function()
          local context = require 'cmp.config.context'
          return not context.in_treesitter_capture 'string' and not context.in_syntax_group 'String'
        end,
      },
      {
        name = 'nvim_lua',
        group_index = 2,
      },
      {
        name = 'treesitter',
        keyword_length = 4,
        group_index = 3,
      },
      {
        name = 'path',
        keyword_length = 4,
        group_index = 3,
      },
      {
        name = 'buffer',
        keyword_length = 3,
        group_index = 3,
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end,
        },
      },
      {
        name = 'lazydev',
        keyword_length = 2,
        group_index = 4,
      },
    },
    ---@diagnostic disable-next-line: missing-fields
    formatting = {
      format = lspkind.cmp_format {
        mode = 'symbol_text',
        ellipsis_char = '...',
        menu = source_mapping,
      },
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        require('copilot_cmp.comparators').prioritize_tagged,
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.kind,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  }

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return {
  'hrsh7th/nvim-cmp',
  config = config,
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'windwp/nvim-autopairs',
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'ray-x/cmp-treesitter',
    'saadparwaiz1/cmp_luasnip',
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_vscode').load { paths = { '~/.config/nvim/snip' } }
      end,
    },
    {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      build = ':Copilot auth',
      opts = {
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            open = '<leader>cp',
            accept = '<CR>',
            jump_prev = '[[',
            jump_next = ']]',
            refresh = 'gr',
          },
          layout = {
            position = 'bottom',
            ratio = 0.5,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 50,
          trigger_on_accept = true,
          keymap = {
            accept = '<C-y>',
            accept_word = '<C-u>',
            accept_line = '<C-l>',
            next = '<C-n>',
            prev = '<C-p>',
            dismiss = '<C-d>',
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = true,
          ['*'] = true,
        },
      },
    },
    {
      'zbirenbaum/copilot-cmp',
      dependencies = { 'zbirenbaum/copilot.lua' },
      config = function()
        require('copilot_cmp').setup()
      end,
    },
  },
}
