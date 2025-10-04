return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require('gitsigns')
    
    gitsigns.setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      signs_staged_enable = true,
      on_attach = function(bufnr)
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']g', function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end, {desc = 'Next hunk'})

        map('n', '[g', function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end, {desc = 'Previous hunk'})

        -- Actions - Stage
        map('n', '<leader>gs', gitsigns.stage_hunk, {desc = 'Stage hunk'})
        map('n', '<leader>gS', gitsigns.stage_buffer, {desc = 'Stage buffer'})
        map('v', '<leader>gs', function()
          gitsigns.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})
        end, {desc = 'Stage hunk'})
        
        -- Actions - Reset
        map('n', '<leader>gr', gitsigns.reset_hunk, {desc = 'Reset hunk'})
        map('n', '<leader>gR', gitsigns.reset_buffer, {desc = 'Reset buffer'})
        map('v', '<leader>gr', function()
          gitsigns.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})
        end, {desc = 'Reset hunk'})
        
        -- Actions - Other
        map('n', '<leader>gu', gitsigns.undo_stage_hunk, {desc = 'Undo stage hunk'})
        map('n', '<leader>gp', gitsigns.preview_hunk, {desc = 'Preview hunk'})
        -- Git blame: gb for quick popup, gB for full screen
        map('n', '<leader>gb', function()
          gitsigns.blame_line({full = true})
        end, {desc = 'Git blame line (popup)'})
        map('n', '<leader>gB', ':Git blame<CR>', {desc = 'Git blame full (explore)'})
        map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, {desc = 'Toggle blame'})
        map('n', '<leader>gd', gitsigns.diffthis, {desc = 'Diff this'})
        map('n', '<leader>gD', function()
          gitsigns.diffthis('~')
        end, {desc = 'Diff this ~'})
        map('n', '<leader>gtd', gitsigns.toggle_deleted, {desc = 'Toggle deleted'})
        
        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc = 'Select hunk'})
      end,
    })
  end,
}