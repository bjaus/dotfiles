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
-- Organize imports with gopls (adds missing imports, removes unused)
-- Then conform.nvim will handle formatting (goimports-reviser + gofumpt)
autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params(0, 'utf-16')
    params.context = { only = { 'source.organizeImports' } }
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 3000)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    -- NOTE: Do NOT call vim.lsp.buf.format here - let conform.nvim handle formatting
  end,
})

-- Auto-remove vendor directory when gopls detects issues (once per session)
local vendor_checked = {}
autocmd('BufEnter', {
  pattern = '*.go',
  callback = function()
    -- Get project root
    local current_dir = vim.fn.expand('%:p:h')
    local go_mod = vim.fn.findfile('go.mod', current_dir .. ';')
    if go_mod == '' then
      return
    end
    
    local project_root = vim.fn.fnamemodify(go_mod, ':h')
    
    -- Only check once per project per session
    if vendor_checked[project_root] then
      return
    end
    vendor_checked[project_root] = true
    
    -- Check for vendor directory issues after a short delay (let gopls initialize)
    vim.defer_fn(function()
      local diagnostics = vim.diagnostic.get(0)
      for _, diagnostic in ipairs(diagnostics) do
        local message = diagnostic.message or ""
        -- Check for vendor-related errors from gopls
        if message:match("vendor") and (
          message:match("inconsistent") or 
          message:match("missing") or 
          message:match("out of date") or
          message:match("sync") or
          message:match("mismatch")
        ) then
          local vendor_dir = project_root .. '/vendor'
          if vim.fn.isdirectory(vendor_dir) == 1 then
            -- Remove vendor directory
            vim.fn.system('rm -rf ' .. vim.fn.shellescape(vendor_dir))
            vim.notify("Removed outdated vendor directory. Run 'go mod vendor' to regenerate.", vim.log.levels.INFO)
            -- Restart gopls to clear the diagnostics
            vim.cmd('LspRestart gopls')
            return -- Exit after first vendor issue found
          end
        end
      end
    end, 1000) -- Wait 1 second for gopls to initialize
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
