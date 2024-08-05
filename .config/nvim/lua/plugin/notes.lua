return {
  'epwalsh/obsidian.nvim',
  enabled = true,
  version = '*',
  -- ft = 'markdown',
  -- event = {
  --   'BufReadPre ' .. vim.fn.expand '~' .. '/vaults/*.md',
  --   'BufNewFile ' .. vim.fn.expand '~' .. '/vaults/*.md',
  -- },
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'hrsh7th/nvim-cmp',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter',
  },
  opts = {
    ui = { enable = false }, -- NOTE: ui does not work with MeanderingProgrammer/markdown.nvim
    workspaces = {
      { name = 'notes', path = '~/notes' },
    },
    -- notes_subdir = 'notes',
    -- new_notes_location = 'notes_subdir',
    sort_by = 'modified',
    sort_reversed = true,
    search_max_lines = 10000,
    open_notes_in = 'current',
    follow_url_func = function(url)
      vim.fn.jobstart { 'open', url }
    end,
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = 'daily',
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = '%Y-%m-%d',
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = '%B %-d, %Y',
      -- Optional, default tags to add to each new daily note created.
      default_tags = { 'daily-notes' },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
    -- templates = {
    --   folder = 'notes/templates',
    --   date_format = '%Y-%m-%d',
    --   time_format = '%H:%M',
    -- },
    note_id_func = function(title)
      -- Generate a filename based on the title
      return title:gsub(' ', '_'):lower() -- replace spaces with underscores and convert to lowercase
    end,
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ['<leader>ch'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = 'telescope.nvim',
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = '<C-x>',
        -- Insert a link to the selected note.
        insert_link = '<C-l>',
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = '<C-x>',
        -- Insert a tag at the current location.
        insert_tag = '<C-l>',
      },
    },
  },
  config = function(_, opts)
    require('obsidian').setup(opts)
    require('config.keymaps').setup_obsidian()
  end,
}
