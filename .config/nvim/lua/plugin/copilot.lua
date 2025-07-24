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
      { '<leader>apc', ':CopilotChat<CR>', mode = 'n', desc = 'Chat with Copilot' },
      { '<leader>apz', ':CopilotChatToggle<CR>', mode = 'n', desc = 'Toggle Chat Window' },
      { '<leader>apr', ':CopilotChatReset<CR>', mode = 'n', desc = 'Reset Chat' },

      -- 🤖 Visual selection prompts
      { '<leader>ape', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Explain Code' },
      { '<leader>apf', ':CopilotChatFix<CR>', mode = 'v', desc = 'Fix Code Issues' },
      { '<leader>apo', ':CopilotChatOptimize<CR>', mode = 'v', desc = 'Optimize Code' },
      { '<leader>apd', ':CopilotChatDocs<CR>', mode = 'v', desc = 'Generate Docs' },
      { '<leader>apn', ':CopilotChatReview<CR>', mode = 'v', desc = 'Review Code' },
      { '<leader>apt', ':CopilotChatTests<CR>', mode = 'v', desc = 'Generate Tests' },
      { '<leader>aps', ':CopilotChatCommit<CR>', mode = 'v', desc = 'Generate Commit for Selection' },

      -- 🧠 Agent/model tools
      { '<leader>apa', ':CopilotChatAgents<CR>', mode = 'n', desc = 'Select Agent' },
      { '<leader>apm', ':CopilotChatModels<CR>', mode = 'n', desc = 'Select Copilot Model' },

      -- 📝 Whole-buffer commit message
      { '<leader>apM', ':CopilotChatCommit<CR>', mode = 'n', desc = 'Generate Commit Message' },
    },
  },
}
