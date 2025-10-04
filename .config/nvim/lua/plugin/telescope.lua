-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

local config = function()
  local telescope = require 'telescope'

  telescope.setup {
    defaults = {
      mappings = {
        i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--glob',
        '!ignore/**',
      },
      layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
        vertical = {
          preview_height = 0.4,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true, -- Show hidden files
        no_ignore = true, -- Don't ignore files from .gitignore
        no_ignore_parent = true, -- Don't ignore files from .gitignore in parent directories
      },
      diagnostics = {
        line_width = "full",
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = 0.9,
            height = 0.9,
            preview_cutoff = 0,
          },
        },
        attach_mappings = function(prompt_bufnr, map)
          map("i", "<C-f>", function()
            local selection = require("telescope.actions.state").get_selected_entry()
            if selection then
              vim.schedule(function()
                local message = selection.text or ""
                if selection.value and selection.value.message then
                  message = selection.value.message
                end

                local buf = vim.api.nvim_create_buf(false, true)
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(message, "\n"))

                local win = vim.api.nvim_open_win(buf, true, {
                  relative = "editor",
                  width = math.min(vim.o.columns - 4, 120),
                  height = math.min(vim.o.lines - 4, 20),
                  col = 2,
                  row = 2,
                  border = "rounded",
                  title = " Full Diagnostic Message ",
                  title_pos = "center",
                })

                vim.keymap.set('n', 'q', function()
                  vim.api.nvim_win_close(win, true)
                end, { buffer = buf })

                vim.keymap.set('n', '<Esc>', function()
                  vim.api.nvim_win_close(win, true)
                end, { buffer = buf })
              end)
            end
          end)
          return true
        end,
      },
    },
    -- path_display = 'shorten',
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  }

  pcall(telescope.load_extension, 'fzf')
  pcall(telescope.load_extension, 'ui-select')
  pcall(telescope.load_extension, 'frecency')

  require('config.keymaps').setup_telescope()
end

return {
  -- Fuzzy Finder (files, lsp, etc)
  -- https://github.com/nvim-tele
  'nvim-telescope/telescope.nvim',
  enabled = true,
  cmd = 'Telescope',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    'crusj/bookmarks.nvim',
    'ThePrimeagen/harpoon',
    {
      'nvim-telescope/telescope-frecency.nvim',
      dependencies = { 'kkharji/sqlite.lua' },
    },
  },
  config = config,
}
