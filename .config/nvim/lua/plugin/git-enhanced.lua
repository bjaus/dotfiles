-- Enhanced git functionality for Neovim
-- Uncomment the plugins you want to add

return {
  -- 1. Fugitive - The ultimate git plugin (by tpope)
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    config = function()
      -- Git commands available everywhere
      vim.keymap.set('n', '<leader>gg', ':Git<CR>', { desc = 'Git status' })
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
      vim.keymap.set('n', '<leader>gP', ':Git push<CR>', { desc = 'Git push' })
      vim.keymap.set('n', '<leader>gpl', ':Git pull<CR>', { desc = 'Git pull' })
      vim.keymap.set('n', '<leader>gL', ':Git log --oneline<CR>', { desc = 'Git log' })
      -- Git blame is now handled by gitsigns: <leader>gb (popup) and <leader>gB (full)
      vim.keymap.set('n', '<leader>gdv', ':Gvdiffsplit<CR>', { desc = 'Git diff vertical' })
      vim.keymap.set('n', '<leader>gdh', ':Gdiffsplit<CR>', { desc = 'Git diff horizontal' })
      vim.keymap.set('n', '<leader>gm', ':Git merge<CR>', { desc = 'Git merge' })
      
      -- Advanced features
      vim.keymap.set('n', '<leader>g3', ':Gclog<CR>', { desc = 'Git log in quickfix' })
      vim.keymap.set('n', '<leader>ge', ':Gedit<CR>', { desc = 'Edit git index version' })
      vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>', { desc = 'Git add current file' })
    end,
  },

  -- 2. Diffview - Better diff and merge conflict resolution
  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('diffview').setup({
        use_icons = true,
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = "diff3_mixed",
          },
        },
      })
      
      vim.keymap.set('n', '<leader>gdo', ':DiffviewOpen<CR>', { desc = 'Open diff view' })
      vim.keymap.set('n', '<leader>gdc', ':DiffviewClose<CR>', { desc = 'Close diff view' })
      vim.keymap.set('n', '<leader>gdh', ':DiffviewFileHistory %<CR>', { desc = 'File history' })
      vim.keymap.set('n', '<leader>gdH', ':DiffviewFileHistory<CR>', { desc = 'Branch history' })
      vim.keymap.set('n', '<leader>gdt', ':DiffviewToggleFiles<CR>', { desc = 'Toggle file panel' })
      vim.keymap.set('n', '<leader>gdr', ':DiffviewRefresh<CR>', { desc = 'Refresh diff view' })
    end,
  },

  -- 3. Neogit - Magit-like interface (alternative to LazyGit)
  -- {
  --   "NeogitOrg/neogit",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "sindrets/diffview.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     require('neogit').setup({
  --       integrations = {
  --         telescope = true,
  --         diffview = true,
  --       },
  --     })
  --     vim.keymap.set('n', '<leader>gn', ':Neogit<CR>', { desc = 'Open Neogit' })
  --   end,
  -- },

  -- 4. Git conflict markers - Better conflict resolution
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('git-conflict').setup({
        default_mappings = false,
        default_commands = true,
        disable_diagnostics = false,
      })
      
      vim.keymap.set('n', '<leader>gxo', ':GitConflictChooseOurs<CR>', { desc = 'Choose our changes' })
      vim.keymap.set('n', '<leader>gxt', ':GitConflictChooseTheirs<CR>', { desc = 'Choose their changes' })
      vim.keymap.set('n', '<leader>gxb', ':GitConflictChooseBoth<CR>', { desc = 'Choose both changes' })
      vim.keymap.set('n', '<leader>gxn', ':GitConflictChooseNone<CR>', { desc = 'Choose none' })
      vim.keymap.set('n', '[x', ':GitConflictPrevConflict<CR>', { desc = 'Previous conflict' })
      vim.keymap.set('n', ']x', ':GitConflictNextConflict<CR>', { desc = 'Next conflict' })
      vim.keymap.set('n', '<leader>gxl', ':GitConflictListQf<CR>', { desc = 'List conflicts' })
    end,
  },

  -- 5. Octo - GitHub PRs and Issues in Neovim
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup({
        enable_builtin = true,
        suppress_missing_scope = {
          projects_v2 = true,
        },
      })
      
      -- PR and Issue Management
      vim.keymap.set('n', '<leader>ghi', ':Octo issue list<CR>', { desc = 'List GitHub issues' })
      vim.keymap.set('n', '<leader>ghp', ':Octo pr list<CR>', { desc = 'List GitHub PRs' })
      vim.keymap.set('n', '<leader>gho', ':Octo pr checkout<CR>', { desc = 'Checkout PR' })
      
      -- PR Review Commands
      vim.keymap.set('n', '<leader>ghr', ':Octo review start<CR>', { desc = 'Start PR review' })
      vim.keymap.set('n', '<leader>ghs', ':Octo review submit<CR>', { desc = 'Submit PR review' })
      vim.keymap.set('n', '<leader>ghc', ':Octo review comments<CR>', { desc = 'View review comments' })
      vim.keymap.set('n', '<leader>ghd', ':Octo pr diff<CR>', { desc = 'Show PR diff' })
      vim.keymap.set('n', '<leader>ghm', ':Octo pr merge<CR>', { desc = 'Merge PR' })
      
      -- Comment Management  
      vim.keymap.set('n', '<leader>gha', ':Octo comment add<CR>', { desc = 'Add comment' })
      vim.keymap.set('n', '<leader>ghD', ':Octo comment delete<CR>', { desc = 'Delete comment' })
      
      -- Quick PR actions
      vim.keymap.set('n', '<leader>ghb', ':Octo pr browser<CR>', { desc = 'Open PR in browser' })
      vim.keymap.set('n', '<leader>ghu', ':Octo pr url<CR>', { desc = 'Copy PR url' })
      vim.keymap.set('n', '<leader>ghl', ':Octo pr reload<CR>', { desc = 'Reload PR' })
      vim.keymap.set('n', '<leader>ghC', ':Octo pr close<CR>', { desc = 'Close PR' })
      vim.keymap.set('n', '<leader>ghO', ':Octo pr reopen<CR>', { desc = 'Reopen PR' })
    end,
  },

  -- 6. Git worktree integration with Telescope
  -- {
  --   'ThePrimeagen/git-worktree.nvim',
  --   config = function()
  --     require('git-worktree').setup()
  --     require('telescope').load_extension('git_worktree')
  --     
  --     vim.keymap.set('n', '<leader>gww', function()
  --       require('telescope').extensions.git_worktree.git_worktrees()
  --     end, { desc = 'List worktrees' })
  --     vim.keymap.set('n', '<leader>gwc', function()
  --       require('telescope').extensions.git_worktree.create_git_worktree()
  --     end, { desc = 'Create worktree' })
  --   end,
  -- },

  -- 7. Advanced git search with Telescope
  {
    'aaronhallaert/advanced-git-search.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'tpope/vim-fugitive',
      'sindrets/diffview.nvim',
    },
    config = function()
      require('telescope').load_extension('advanced_git_search')
      
      vim.keymap.set('n', '<leader>gas', ':AdvancedGitSearch<CR>', { desc = 'Advanced git search' })
      vim.keymap.set('n', '<leader>gal', ':AdvancedGitSearch diff_commit_line<CR>', { desc = 'Search line history' })
      vim.keymap.set('n', '<leader>gaf', ':AdvancedGitSearch diff_commit_file<CR>', { desc = 'Search file history' })
      vim.keymap.set('n', '<leader>gab', ':AdvancedGitSearch diff_branch_file<CR>', { desc = 'Diff branch file' })
      vim.keymap.set('v', '<leader>gal', ':AdvancedGitSearch diff_commit_line<CR>', { desc = 'Search line history' })
    end,
  },

  -- 8. Git messenger - Show commit messages in popup
  {
    'rhysd/git-messenger.vim',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set('n', '<leader>gm', ':GitMessenger<CR>', { desc = 'Show commit message' })
      vim.g.git_messenger_floating_win_opts = { border = 'rounded' }
      vim.g.git_messenger_no_default_mappings = true
    end,
  },
}