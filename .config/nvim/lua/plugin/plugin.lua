return {                -- random plugins that don't need their own files
  {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    enabled = true,
  },
  {
    "David-Kunz/gen.nvim",
    cmd = "Gen",
    opts = {
      model = "mistral",      -- The default model to use.
      quit_map = "q",         -- set keymap to close the response window
      retry_map = "<c-r>",    -- set keymap to re-send the current prompt
      accept_map = "<c-cr>",  -- set keymap to replace the previous selection with the last result
      host = "localhost",     -- The host running the Ollama service.
      port = "11434",         -- The port on which the Ollama service is listening.
      display_mode = "split", -- The display mode. Can be "float" or "split" or "horizontal-split".
      show_prompt = false,    -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
      show_model = false,     -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false,  -- Never closes the window automatically.
      file = false,           -- Write the payload to a temporary file to keep the command short.
      hidden = false,         -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
      init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
      -- Function to initialize Ollama
      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      result_filetype = "markdown", -- Configure filetype of the result buffer
      debug = false                 -- Prints errors and the command which is run.
    }
  },
  {
    'kiddos/gemini.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    config = function()
      require('gemini').setup({
        api_key = vim.env.GEMINI_API_KEY,
      })
      require('config.keymaps').setup_gemini()
    end,
  },
  {
    'greggh/claude-code.nvim',
    cmd = { 'ClaudeCode', 'ClaudeCodeChat' },
    keys = {
      { '<leader>acc', '<cmd>ClaudeCode toggle<cr>', desc = 'Toggle Claude Code' },
      { '<leader>acr', '<cmd>ClaudeCode toggle --continue<cr>', desc = 'Resume Claude Code' },
      { '<leader>acf', '<cmd>ClaudeCode focus<cr>', desc = 'Focus Claude Code' },
    },
    config = function()
      require('claude-code').setup({
        -- Window settings
        window = {
          position = 'right',    -- 'left', 'right', 'top', 'bottom', or 'float'
          width = 80,            -- Width for vertical splits
          height = 20,           -- Height for horizontal splits
          relative = 'editor',   -- For float: 'editor' or 'cursor'
          border = 'rounded',    -- Border style for float
        },
        -- Behavior settings
        auto_focus = true,       -- Auto-focus when opening
        close_on_exit = false,   -- Close window when Claude Code exits
        -- File detection
        file_pattern = '**/*',   -- Pattern for detecting file changes
        -- Keybindings within the terminal
        terminal_keymaps = {
          close = '<C-q>',       -- Close the terminal
          toggle = '<C-\\><C-n>', -- Toggle between insert and normal mode
        },
      })
    end,
  },
}
