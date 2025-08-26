-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local util = require 'util'
local augroup = util.create_augroup
local autocmd = vim.api.nvim_create_autocmd

M = {}

-- Format on save for all file types with LSP support
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    -- Don't format if the buffer is not modifiable
    if not vim.bo[args.buf].modifiable then
      return
    end
    
    -- Check if any LSP client supports formatting
    local clients = vim.lsp.get_clients({ bufnr = args.buf })
    for _, client in ipairs(clients) do
      if client.supports_method('textDocument/formatting') then
        vim.lsp.buf.format({ bufnr = args.buf })
        return
      end
    end
  end,
})

-- Go-specific keymaps and features
autocmd({ 'FileType' }, {
  pattern = 'go',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Jump to function/method signature
    vim.keymap.set('n', 'gfs', function()
      -- Save current position
      local pos = vim.api.nvim_win_get_cursor(0)
      -- Search backwards for func keyword
      local found = vim.fn.search([[\v^func|^type\s+\w+\s+interface]], 'bcnW')
      if found == 0 then
        -- If not found backwards, we might be above the function, search forward
        found = vim.fn.search([[\v^func|^type\s+\w+\s+interface]], 'cnW')
      end
      if found == 0 then
        vim.notify("No function signature found", vim.log.levels.WARN)
      end
    end, { buffer = bufnr, desc = 'Go: Jump to function signature' })
    
    -- Jump to function return values
    vim.keymap.set('n', 'gfr', function()
      -- Save position
      local pos = vim.api.nvim_win_get_cursor(0)
      -- Find the function we're in
      local found = vim.fn.search([[\v^func]], 'bcnW')
      if found > 0 then
        -- Jump to that line
        vim.api.nvim_win_set_cursor(0, {found, 0})
        -- Find the opening paren
        vim.fn.search('(', 'c', found)
        -- Jump to matching paren
        vim.cmd('normal! %')
        -- Move right to get to return type
        vim.cmd('normal! l')
      else
        vim.notify("No function found", vim.log.levels.WARN)
      end
    end, { buffer = bufnr, desc = 'Go: Jump to function return type' })
    
    -- Show current function signature in floating window
    vim.keymap.set('n', 'gF', function()
      -- Find the function signature line
      local found_line = vim.fn.search([[\v^func]], 'bcn')
      if found_line == 0 then
        found_line = vim.fn.search([[\v^func]], 'cn')
      end
      
      if found_line > 0 then
        -- Get the function signature
        local lines = vim.api.nvim_buf_get_lines(bufnr, found_line - 1, found_line, false)
        if #lines > 0 then
          local signature = lines[1]
          
          -- Check if signature continues on next lines (multi-line signatures)
          local next_line = found_line
          local full_sig = signature
          while not full_sig:match('{') and next_line < vim.api.nvim_buf_line_count(bufnr) do
            next_line = next_line + 1
            local next = vim.api.nvim_buf_get_lines(bufnr, next_line - 1, next_line, false)[1]
            if next then
              full_sig = full_sig .. " " .. vim.trim(next)
              if next:match('{') then
                break
              end
            else
              break
            end
          end
          
          -- Clean up the signature (remove the opening brace)
          full_sig = full_sig:gsub('{.*', '')
          
          -- Create floating window
          local width = math.min(100, #full_sig + 4)
          local height = 1
          local buf = vim.api.nvim_create_buf(false, true)
          
          -- Set the content
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, {full_sig})
          
          -- Add syntax highlighting
          vim.api.nvim_buf_set_option(buf, 'filetype', 'go')
          
          -- Create the window
          local win = vim.api.nvim_open_win(buf, false, {
            relative = 'cursor',
            row = -2,
            col = 0,
            width = width,
            height = height,
            style = 'minimal',
            border = 'rounded',
          })
          
          -- Auto close after 3 seconds
          vim.defer_fn(function()
            if vim.api.nvim_win_is_valid(win) then
              vim.api.nvim_win_close(win, true)
            end
            if vim.api.nvim_buf_is_valid(buf) then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end, 3000)
        end
      else
        vim.notify("No function signature found", vim.log.levels.WARN)
      end
    end, { buffer = bufnr, desc = 'Go: Show function signature in popup' })
  end,
})

-- CloudFormation file detection
autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    'template.yaml',
    'template.yml',
    'template.json',
    '**/cloudformation/*.yaml',
    '**/cloudformation/*.yml',
    '**/cloudformation/*.json',
    '**/cfn/*.yaml',
    '**/cfn/*.yml',
    '**/cfn/*.json',
    '*-stack.yaml',
    '*-stack.yml',
    '*-stack.json',
    '*.cfn.yaml',
    '*.cfn.yml',
    '*.cfn.json',
  },
  callback = function()
    -- Set filetype to yaml.cloudformation for better detection
    if vim.fn.expand('%:e') == 'json' then
      vim.bo.filetype = 'json'
    else
      vim.bo.filetype = 'yaml'
    end
    -- Add a buffer variable to indicate this is a CloudFormation template
    vim.b.is_cloudformation = true
  end,
})

-- Spell checking for markdown, text, and git commits
autocmd({ 'FileType' }, {
  pattern = { 'markdown', 'text', 'gitcommit' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
  end,
})

-- Spell checking in comments for all programming languages
autocmd({ 'FileType' }, {
  pattern = { 'go', 'python', 'javascript', 'typescript', 'lua', 'rust', 'c', 'cpp' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.spelloptions = 'camel'  -- Recognize camelCase words
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

function M.setup_lsp_highlight(event)
  -- The following autocommands are used to highlight references of the
  -- word under the cursor when the cursor rests there for a little while.
  -- See `:help CursorHold` for information about when this is executed
  --
  -- When you move the cursor, the highlights will be cleared.
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
    autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
      end,
    })
  end
end

-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports-and-formatting
autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params(0, 'utf-16')
    params.context = { only = { 'source.organizeImports' } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format { async = false }
  end,
})

-- Lua reload
local write_source = augroup 'ConfigWritePostReload'
autocmd({ 'BufWritePost' }, {
  group = write_source,
  pattern = {
    '*/nvim/lua/config/*.lua',
    '*/nvim/lua/util/*.lua',
  },
  callback = function()
    if not util.diag_error() then
      util.reload_lua()
    end
  end,
})

return M
