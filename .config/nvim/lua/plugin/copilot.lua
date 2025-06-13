return {
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
        go = true,
        py = true,
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        ['*'] = true,
      },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      {
        'zbirenbaum/copilot.lua',
        -- 'github/copilot.vim',
      },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      prompts = {
        ExplainLike5 = {
          prompt = "Explain the code like I'm five years old.",
          description = 'ELI5 explanation',
        },
        BetterGo = {
          prompt = 'Refactor this to follow Go idioms.',
          description = 'Idiomatic Go refactor',
        },
        NoPanic = {
          prompt = 'Rewrite this to avoid panics and return errors properly.',
          description = 'Remove panics',
        },
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
      -- 🔁 Core actions
      { '<leader>zc', ':CopilotChat<CR>', mode = 'n', desc = 'Chat with Copilot' },
      { '<leader>zz', ':CopilotChatToggle<CR>', mode = 'n', desc = 'Toggle Chat Window' },
      { '<leader>zr', ':CopilotChatReset<CR>', mode = 'n', desc = 'Reset Chat' },

      -- 🤖 Visual selection prompts
      { '<leader>ze', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Explain Code' },
      { '<leader>zf', ':CopilotChatFix<CR>', mode = 'v', desc = 'Fix Code Issues' },
      { '<leader>zo', ':CopilotChatOptimize<CR>', mode = 'v', desc = 'Optimize Code' },
      { '<leader>zd', ':CopilotChatDocs<CR>', mode = 'v', desc = 'Generate Docs' },
      { '<leader>zn', ':CopilotChatReview<CR>', mode = 'v', desc = 'Review Code' },
      { '<leader>zt', ':CopilotChatTests<CR>', mode = 'v', desc = 'Generate Tests' },
      { '<leader>zs', ':CopilotChatCommit<CR>', mode = 'v', desc = 'Generate Commit for Selection' },

      -- 🧠 Agent/model tools
      { '<leader>za', ':CopilotChatAgents<CR>', mode = 'n', desc = 'Select Agent' },
      { '<leader>zm', ':CopilotChatModels<CR>', mode = 'n', desc = 'Select Copilot Model' },

      -- 📝 Whole-buffer commit message
      { '<leader>zM', ':CopilotChatCommit<CR>', mode = 'n', desc = 'Generate Commit Message' },
    },
  },
}
