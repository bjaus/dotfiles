local config = function()
  local term = require 'toggleterm'

  term.setup {
    direction = 'float', -- 'horizontal', 'vertical', 'tab', 'float'
    size = function(t)
      if t.direction == 'horizontal' then
        return 20
      elseif t.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    shade_terminals = false,
    start_in_insert = true,
  }

  local trim_spaces = true
  require('config.keymaps').setup_toggleterm(trim_spaces)
  
  -- Setup Cursor Agent integration
  local Terminal = require("toggleterm.terminal").Terminal
  
  -- Main cursor-agent terminal
  local cursor_agent = Terminal:new({
    cmd = "cursor-agent",
    direction = "vertical",
    size = function()
      return vim.o.columns * 0.4
    end,
    on_open = function(term)
      vim.cmd("startinsert!")
      local opts = {buffer = term.bufnr, noremap = true, silent = true}
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end,
    on_close = function()
      vim.cmd("wincmd h")
    end,
  })
  
  -- Floating cursor-agent
  local cursor_float = Terminal:new({
    cmd = "cursor-agent",
    direction = "float",
    float_opts = {
      border = "curved",
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8),
    },
  })
  
  -- Helper function to send text to cursor
  local function send_to_cursor(text, terminal)
    terminal = terminal or cursor_agent
    if not terminal:is_open() then
      terminal:open()
      vim.wait(500)
    end
    local lines = vim.split(text, "\n")
    for _, line in ipairs(lines) do
      terminal:send(line)
    end
  end
  
  -- Global functions for cursor agent
  function _CURSOR_TOGGLE()
    cursor_agent:toggle()
  end
  
  function _CURSOR_FLOAT()
    cursor_float:toggle()
  end
  
  function _CURSOR_TAB()
    local cursor_tab = Terminal:new({
      cmd = "cursor-agent",
      direction = "tab",
    })
    cursor_tab:toggle()
  end
  
  function _CURSOR_SEND_FILE()
    local file_path = vim.api.nvim_buf_get_name(0)
    if file_path ~= "" then
      send_to_cursor("@" .. file_path)
    else
      vim.notify("No file to send", vim.log.levels.WARN)
    end
  end
  
  function _CURSOR_SEND_SELECTION()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
    if #lines > 0 then
      if #lines == 1 then
        lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
      else
        lines[1] = string.sub(lines[1], start_pos[3])
        lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
      end
      send_to_cursor(table.concat(lines, "\n"))
    end
  end
  
  function _CURSOR_SEND_LINE()
    local line = vim.api.nvim_get_current_line()
    send_to_cursor(line)
  end
  
  -- Simple workspace toggle using native vim commands
  local cursor_workspace_open = false
  local cursor_workspace_bufnr = nil
  
  function _CURSOR_WORKSPACE()
    if cursor_workspace_open then
      -- Close the cursor window if it's open
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if buf == cursor_workspace_bufnr then
          vim.api.nvim_win_close(win, false)
          cursor_workspace_open = false
          return
        end
      end
      cursor_workspace_open = false
    else
      -- Open cursor-agent on the left
      vim.cmd("vsplit")
      vim.cmd("wincmd H")  -- Move to left
      vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.4))
      
      -- Start cursor-agent in terminal
      vim.cmd("terminal cursor-agent")
      cursor_workspace_bufnr = vim.api.nvim_get_current_buf()
      
      -- Set up navigation keymaps for this buffer
      local opts = {buffer = cursor_workspace_bufnr, noremap = true, silent = true}
      vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
      vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      
      -- Auto-enter insert mode when switching to cursor terminal
      vim.api.nvim_create_autocmd("BufEnter", {
        buffer = cursor_workspace_bufnr,
        callback = function()
          -- Only enter insert mode if we're in a terminal buffer
          if vim.bo.buftype == "terminal" then
            vim.cmd("startinsert!")
          end
        end,
      })
      
      -- Enable autoread but don't poll - just use manual refresh
      vim.o.autoread = true
      
      -- Start in insert mode
      vim.cmd("startinsert!")
      
      -- Move back to the code window
      vim.cmd("wincmd l")
      
      cursor_workspace_open = true
    end
  end
  
  function _CURSOR_EXPLAIN_CONTEXT()
    local file_path = vim.api.nvim_buf_get_name(0)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local context = string.format("Explain the code at %s:%d:%d", file_path, row, col)
    send_to_cursor(context)
  end
  
  function _CURSOR_QUICK_FIX()
    local diagnostics = vim.diagnostic.get(0)
    if #diagnostics > 0 then
      local diag = diagnostics[1]
      local line = vim.api.nvim_buf_get_lines(0, diag.lnum, diag.lnum + 1, false)[1]
      local msg = string.format("Fix this issue:\n%s\n\nCode: %s", diag.message, line)
      send_to_cursor(msg)
    else
      vim.notify("No diagnostics found", vim.log.levels.INFO)
    end
  end
  
  function _CURSOR_PROMPT()
    vim.ui.input({ prompt = "Ask Cursor: " }, function(input)
      if input and input ~= "" then
        send_to_cursor(input)
      end
    end)
  end
  
  -- Setup cursor keymaps directly here since module loading has timing issues
  local function setup_cursor_keymaps()
    -- Register with which-key if available
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      which_key.add({
        { '<leader>au', group = 'c[u]rsor' },
      })
    end
    
    -- Set all cursor keymaps
    vim.keymap.set("n", "<leader>auc", ":lua _CURSOR_TOGGLE()<CR>", { desc = "Toggle cUrsor Agent" })
    vim.keymap.set("n", "<leader>auf", ":lua _CURSOR_FLOAT()<CR>", { desc = "cUrsor Agent (floating)" })
    vim.keymap.set("n", "<leader>aut", ":lua _CURSOR_TAB()<CR>", { desc = "cUrsor Agent (new tab)" })
    vim.keymap.set("n", "<leader>auw", ":lua _CURSOR_WORKSPACE()<CR>", { desc = "cUrsor AI Workspace" })
    vim.keymap.set("n", "<leader>aub", ":lua _CURSOR_SEND_FILE()<CR>", { desc = "Send buffer to cUrsor" })
    vim.keymap.set("v", "<leader>aus", ":lua _CURSOR_SEND_SELECTION()<CR>", { desc = "Send selection to cUrsor" })
    vim.keymap.set("n", "<leader>aul", ":lua _CURSOR_SEND_LINE()<CR>", { desc = "Send line to cUrsor" })
    vim.keymap.set("n", "<leader>aue", ":lua _CURSOR_EXPLAIN_CONTEXT()<CR>", { desc = "Explain with cUrsor" })
    vim.keymap.set("n", "<leader>aux", ":lua _CURSOR_QUICK_FIX()<CR>", { desc = "Quick fix with cUrsor" })
    vim.keymap.set("n", "<leader>aup", ":lua _CURSOR_PROMPT()<CR>", { desc = "Prompt cUrsor" })
    
    -- Quick access
    vim.keymap.set("n", "<M-c>", ":lua _CURSOR_TOGGLE()<CR>", { desc = "Quick toggle Cursor" })
    vim.keymap.set("v", "<M-c>", ":lua _CURSOR_SEND_SELECTION()<CR>", { desc = "Quick send selection" })
    
    -- Command palette
    vim.keymap.set("n", "<leader>au?", function()
      local actions = {
        { text = "Toggle Cursor (vertical)", cmd = "lua _CURSOR_TOGGLE()" },
        { text = "Open Cursor (floating)", cmd = "lua _CURSOR_FLOAT()" },
        { text = "Open Cursor (new tab)", cmd = "lua _CURSOR_TAB()" },
        { text = "Create AI Workspace", cmd = "lua _CURSOR_WORKSPACE()" },
        { text = "Send current file", cmd = "lua _CURSOR_SEND_FILE()" },
        { text = "Explain code at cursor", cmd = "lua _CURSOR_EXPLAIN_CONTEXT()" },
        { text = "Quick fix diagnostic", cmd = "lua _CURSOR_QUICK_FIX()" },
        { text = "Custom prompt", cmd = "lua _CURSOR_PROMPT()" },
      }
      
      vim.ui.select(actions, {
        prompt = "Cursor Agent Actions:",
        format_item = function(item) return item.text end,
      }, function(choice)
        if choice then vim.cmd(choice.cmd) end
      end)
    end, { desc = "Cursor command palette" })
  end
  
  -- Call the setup function
  setup_cursor_keymaps()
end

return {
  'akinsho/toggleterm.nvim',
  enabled = true,
  event = 'VeryLazy',
  version = '*',
  config = config,
}
