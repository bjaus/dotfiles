-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

M = {}

-- sort alphabetically
vim.keymap.set('v', '<leader>so', ':sort i<cr>', { desc = 'sort order alphabetically' })
vim.keymap.set('v', '<leader>su', ':sort ui<cr>', { desc = 'sort unique alphabetically' })

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>nohlsearch<cr><esc>', { desc = 'escape and clear hlsearch' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'quit terminal mode' })

-- keybinds to make split navigation easier
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'move to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'move to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'move to upper window' })

-- Move Lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'move down', silent = true })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'move up', silent = true })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'move down', silent = true })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'move up', silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'move down', silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'move up', silent = true })

-- buffers
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'prev buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'next buffer' })

-- windows
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = 'split window vertically' })
vim.keymap.set('n', '<leader>wh', '<cmd>split<cr>', { desc = 'split window horizontally' })

-- tabs
vim.keymap.set('n', '<tab>n', '<cmd>tabnew<cr>', { desc = 'new tab', silent = true })
vim.keymap.set('n', '<tab>x', '<cmd>tabclose<cr>', { desc = 'close tab', silent = true })
vim.keymap.set('n', ']<tab>', '<cmd>tabnext<cr>', { desc = 'next tab', silent = true })
vim.keymap.set('n', '[<tab>', '<cmd>tabprevious<cr>', { desc = 'next tab', silent = true })

-- files
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr', { desc = 'new file' })

-- save
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'save file' })

-- lists
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'previous quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'next quickfix' })

-- indentation
-- vim.keymap.set({ 'n', 'v' }, '<', '<gv', { desc = 'indent left' })
-- vim.keymap.set({ 'n', 'v' }, '>', '>gv', { desc = 'indent right' })

-- lazy
vim.keymap.set('n', '<leader>lc', '<cmd>Lazy clean<cr>', { desc = 'run clean' })
vim.keymap.set('n', '<leader>ld', '<cmd>Lazy debug<cr>', { desc = 'show debug info' })
vim.keymap.set('n', '<leader>lh', '<cmd>Lazy show<cr>', { desc = 'show home' })
vim.keymap.set('n', '<leader>li', '<cmd>Lazy install<cr>', { desc = 'run install' })
vim.keymap.set('n', '<leader>lk', '<cmd>Lazy check<cr>', { desc = 'check for updates' })
vim.keymap.set('n', '<leader>ll', '<cmd>Lazy log<cr>', { desc = 'show logs' })
vim.keymap.set('n', '<leader>lp', '<cmd>Lazy profile<cr>', { desc = 'show profile' })
vim.keymap.set('n', '<leader>lr', '<cmd>Lazy restore<cr>', { desc = 'restore to lockfile' })
vim.keymap.set('n', '<leader>ls', '<cmd>Lazy sync<cr>', { desc = 'run install, clean, and update' })
vim.keymap.set('n', '<leader>lu', '<cmd>Lazy update<cr>', { desc = 'run update' })

-- diagnostic
local function goto_diagnostic(next, sev)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  sev = sev and vim.diagnostic.severity[sev] or nil
  return function()
    go { severity = sev }
  end
end

vim.keymap.set('n', ']d', goto_diagnostic(true), { desc = 'next diagnostic', silent = true })
vim.keymap.set('n', '[d', goto_diagnostic(false), { desc = 'previous diagnostic', silent = true })
vim.keymap.set('n', ']e', goto_diagnostic(true, 'ERROR'), { desc = 'next error diagnostic', silent = true })
vim.keymap.set('n', '[e', goto_diagnostic(false, 'ERROR'), { desc = 'previous error diagnostic', silent = true })
vim.keymap.set('n', ']w', goto_diagnostic(true, 'WARN'), { desc = 'next warning diagnostic', silent = true })
vim.keymap.set('n', '[w', goto_diagnostic(false, 'WARN'), { desc = 'previous warning diagnostic', silent = true })

local function map_normal_mode(lhs, rhs, desc)
  -- default values:
  -- noremap: false
  -- silent: true
  vim.keymap.set('n', lhs, rhs, { desc = desc, noremap = false, silent = true })
end

-- function M.setup_trouble_keymaps()
--   return {
--     {
--       '<leader>xx',
--       '<cmd>Trouble diagnostics toggle<cr>',
--       desc = 'Diagnostics (Trouble)',
--     },
--     {
--       '<leader>xX',
--       '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
--       desc = 'Buffer Diagnostics (Trouble)',
--     },
--     {
--       '<leader>cs',
--       '<cmd>Trouble symbols toggle focus=false<cr>',
--       desc = 'Symbols (Trouble)',
--     },
--     {
--       '<leader>cl',
--       '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
--       desc = 'LSP Definitions / references / ... (Trouble)',
--     },
--     {
--       '<leader>xL',
--       '<cmd>Trouble loclist toggle<cr>',
--       desc = 'Location List (Trouble)',
--     },
--     {
--       '<leader>xQ',
--       '<cmd>Trouble qflist toggle<cr>',
--       desc = 'Quickfix List (Trouble)',
--     },
--   }
-- end

function M.setup_lsp_keymaps(event)
  local builtin = require 'telescope.builtin'
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc, nowait = true })
  end

  -- Jump to the definition of the word under the cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')

  -- Find references for the word under the cursor.
  map('gr', builtin.lsp_references, '[G]oto [R]eferences')

  -- Jump to the implementation of the word under the cursor.
  --  Useful when the language has ways of declaring types without an actual implementation.
  map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')

  -- Jump to the type of the word under the cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')

  -- Fuzzy find all the symbols in current file.
  --  Symbols are things like variables, functions, types, etc.
  map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')

  -- Fuzzy find all the symbols in the current workspace.
  --  Similar to document symbols, except searches over the entire project.
  map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- Rename the variable under the cursor.
  --  Most Language Servers support renaming across files, etc.
  map('<leader>an', vim.lsp.buf.rename, '[A]lter [N]ame')

  -- Execute a code action, usually the cursor needs to be on top of an error
  -- or a suggestion from the LSP for this to activate.
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  -- For example, in C this would take you to the header
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  local client = vim.lsp.get_client_by_id(event.data.client_id)

  -- The following autocommand is used to enable inlay hints in the
  -- code, if the language server you are using supports them
  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, '[T]oggle Inlay [H]ints')
  end
end

function M.setup_neotree_keymaps()
  return {
    { '<leader>eb', ':Neotree source=buffers reveal=true position=left action=show<cr>', desc = 'explore buffers' },
    { '<leader>ec', ':Neotree action=close<cr>', desc = 'close explorer' },
    { '<leader>ee', ':Neotree source=filesystem reveal=true position=left action=show<cr>', desc = 'explore filesystem' },
    { '<leader>eg', ':Neotree source=git_status reveal=true position=left action=show<cr>', desc = 'explore git status' },
    { '<leader>es', ':Neotree source=document_symbols reveal=true position=left action=show<cr>', desc = 'explore document symbols' },
  }
end

function M.setup_git_signs_keymaps(bufnr)
  local gitsigns = require 'gitsigns'

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']g', function()
    if vim.wo.diff then
      vim.cmd.normal { ']h', bang = true }
    else
      gitsigns.nav_hunk 'next'
    end
  end, { desc = 'Jump to next git [c]hange' })

  map('n', '[g', function()
    if vim.wo.diff then
      vim.cmd.normal { '[h', bang = true }
    else
      gitsigns.nav_hunk 'prev'
    end
  end, { desc = 'Jump to previous git [c]hange' })

  -- Actions
  -- visual mode
  map('v', '<leader>hs', function()
    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'stage git hunk' })
  map('v', '<leader>hr', function()
    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'reset git hunk' })
  -- normal mode
  map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
  map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
  map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
  map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
  map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
  map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
  map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
  map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
  map('n', '<leader>hD', function()
    gitsigns.diffthis '@'
  end, { desc = 'git [D]iff against last commit' })
  -- Toggles
  map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
  map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
end

function M.setup_git_blame_keymaps()
  return {
    -- toggle needs to be called twice; https://github.com/f-person/git-blame.nvim/issues/16
    { '<leader>gbl', ':GitBlameToggle<CR>', desc = 'Blame line (toggle)', silent = true },
    { '<leader>gbs', ':GitBlameCopySHA<CR>', desc = 'Copy SHA', silent = true },
    { '<leader>gbc', ':GitBlameCopyCommitURL<CR>', desc = 'Copy commit URL', silent = true },
    { '<leader>gbf', ':GitBlameCopyFileURL<CR>', desc = 'Copy file URL', silent = true },
    { '<leader>gbo', ':GitBlameOpenFileURL<CR>', desc = 'Open file URL', silent = true },
  }
end

function M.setup_lazygit_keymaps()
  --   "LazyGit",
  --   "LazyGitConfig",
  --   "LazyGitCurrentFile",
  --   "LazyGitFilter",
  --   "LazyGitFilterCurrentFile",

  map_normal_mode('<leader>gl', function()
    -- -- if keymap <Esc><Esc> is set in terminal mode, remove it.
    -- -- this is to enable <Esc> to navigate in LazyGit which otherwise
    -- -- is overridden for terminal usage.
    -- local terminal_keymaps = vim.api.nvim_get_keymap 't'
    -- for _, keymap in pairs(terminal_keymaps) do
    --   if keymap.lhs == '<Esc><Esc>' then
    --     vim.api.nvim_del_keymap('t', '<Esc><Esc>')
    --   end
    -- end

    vim.cmd 'LazyGit'
  end)
end

return M
