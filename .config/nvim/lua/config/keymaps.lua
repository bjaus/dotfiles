--  See `:help vim.keymap.set()`

M = {}

function M.setup_which_key()
  vim.keymap.set('n', '<leader>wk', '<cmd>WhichKey<cr>', { desc = 'show which key' })

  return {
    { '<leader>a', group = '[a]i tools' },
    { '<leader>ap', group = 'co[p]ilot' },
    { '<leader>ag', group = '[g]emini' },
    { '<leader>ac', group = '[c]laude' },
    -- { '<leader>d', group = '[d]ocument' },
    -- { '<leader>i', group = '[i]nspect' },
    -- { '<leader>k', group = '[k]ey' },
    { '<leader>l', group = '[l]sp actions' },
    { '<leader>b', group = 'de[b]ug' },
    { '<leader>e', group = '[e]xplore' },
    { '<leader>f', group = '[f]ind' },
    { '<leader>g', group = '[g]it', mode = { 'n', 'v' } },
    { '<leader>h', group = '[h]arpoon' },
    { '<leader>j', group = '[j]ump' },
    { '<leader>m', group = 'book[m]ark' },
    { '<leader>n', group = '[n]otes', mode = { 'n', 'v' } },
    { '<leader>o', group = 't[o]ggle' },
    { '<leader>r', group = '[r]un' },
    { '<leader>s', group = '[s]ession', mode = { 'n' } },
    { '<leader>t', group = '[t]est' },
    { '<leader>w', group = '[w]indow' },
  }
end

-- Smoother scrolling keymaps
vim.keymap.set('n', '<C-d>', '10<c-d>zz', { desc = 'scroll 10 lines down', noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '10<c-u>zz', { desc = 'scroll 10 lines up', noremap = true, silent = true })

-- Scroll down by half a page with centered cursor
vim.keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'scroll half-page down', noremap = true, silent = true })
-- Scroll up by half a page with centered cursor
vim.keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'scoll half-page up', noremap = true, silent = true })

-- Scroll down by one line and center the cursor
vim.keymap.set('n', '<C-e>', 'jzz', { desc = 'scroll down with center cursor', noremap = true, silent = true })
-- Scroll up by one line and center the cursor
vim.keymap.set('n', '<C-y>', 'kzz', { desc = 'scroll up with center cursor', noremap = true, silent = true })

-- stack navigation
vim.keymap.set('n', '<C-n>', '<C-i>', { desc = 'next frame in stack' })
vim.keymap.set('n', '<C-p>', '<C-o>', { desc = 'prev frame in stack' })

-- order alphabetically
-- vim.keymap.set('v', '<leader>os', '<cmd>sort<cr>', { desc = 'order' })
-- vim.keymap.set('v', '<leader>ou', '<cmd>sort u<cr>', { desc = 'order unique' })
-- vim.keymap.set('v', '<leader>oi', '<cmd>sort i<cr><esc>', { desc = 'order case-insensitive' })
-- vim.keymap.set('v', '<leader>ov', '<cmd>sort ui<cr><esc>', { desc = 'order alphabetically unique case-insensitive' })

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>nohlsearch<cr><esc>', { desc = 'escape and clear hlsearch' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostic quickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'quit terminal mode' })

-- keybinds to make split navigation easier
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'move to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'move to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'move to upper window' })

-- Move Lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'move line(s) down', silent = true })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'move line(s) up', silent = true })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'move line(s) down', silent = true })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'move line(s) up', silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'move line(s) down', silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'move line(s) up', silent = true })

-- buffers
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'next buffer' })
vim.keymap.set('n', '<leader>wx', '<cmd>bd!<cr>', { desc = 'close buffer' })

-- -- windows
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = 'split window vertically' })
vim.keymap.set('n', '<leader>ws', '<cmd>split<cr>', { desc = 'split window horizontally' })

-- -- tabs
vim.keymap.set('n', '<tab>n', '<cmd>tabnew<cr>', { desc = 'new tab', silent = true })
vim.keymap.set('n', '<tab>x', '<cmd>tabclose<cr>', { desc = 'close tab', silent = true })
vim.keymap.set({ 'n', 't' }, ']t', '<cmd>tabnext<cr>', { desc = 'next tab', silent = true })
vim.keymap.set({ 'n', 't' }, '[t', '<cmd>tabprevious<cr>', { desc = 'previous tab', silent = true })

-- -- files
-- vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr', { desc = 'new file' })

-- save
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'save file' })

-- lists
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'previous quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'next quickfix' })

-- indentation
vim.keymap.set({ 'n', 'v' }, '<', '<gv', { desc = 'indent left' })
vim.keymap.set({ 'n', 'v' }, '>', '>gv', { desc = 'indent right' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.keymap.set('n', '<leader>pi', function()
      require('config.paste_image').paste_image()
    end, { desc = 'paste screenshot', buffer = true })
  end,
})

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
vim.keymap.set('i', '<C-n>', goto_diagnostic(true), { desc = 'next diagnostic', silent = true })
vim.keymap.set('i', '<C-p>', goto_diagnostic(false), { desc = 'previous diagnostic', silent = true })
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

-- -- function M.setup_trouble()
-- --   return {
-- --     {
-- --       '<leader>xx',
-- --       '<cmd>Trouble diagnostics toggle<cr>',
-- --       desc = 'Diagnostics (Trouble)',
-- --     },
-- --     {
-- --       '<leader>xX',
-- --       '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
-- --       desc = 'Buffer Diagnostics (Trouble)',
-- --     },
-- --     {
-- --       '<leader>cs',
-- --       '<cmd>Trouble symbols toggle focus=false<cr>',
-- --       desc = 'Symbols (Trouble)',
-- --     },
-- --     {
-- --       '<leader>cl',
-- --       '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
-- --       desc = 'LSP Definitions / references / ... (Trouble)',
-- --     },
-- --     {
-- --       '<leader>xL',
-- --       '<cmd>Trouble loclist toggle<cr>',
-- --       desc = 'Location List (Trouble)',
-- --     },
-- --     {
-- --       '<leader>xQ',
-- --       '<cmd>Trouble qflist toggle<cr>',
-- --       desc = 'Quickfix List (Trouble)',
-- --     },
-- --   }
-- -- end

function M.setup_lsp(event)
  local builtin = require 'telescope.builtin'
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc, nowait = true })
  end

  -- Jump to the definition of the word under the cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('<leader>jd', builtin.lsp_definitions, 'jump to definition')

  -- Find references for the word under the cursor.
  map('<leader>jR', builtin.lsp_references, 'jump to references')
  map('<leader>jr', function()
    builtin.lsp_references {
      file_ignore_patterns = {
        '%_test.go',
      },
    }
  end, 'jump to references (no test files)')

  -- Jump to the implementation of the word under the cursor.
  --  Useful when the language has ways of declaring types without an actual implementation.
  map('<leader>ji', builtin.lsp_implementations, 'jump to implementation')

  -- Jump to the type of the word under the cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('<leader>jD', builtin.lsp_type_definitions, 'jump to definition')

  map('<leader>jC', vim.lsp.buf.declaration, 'jump to declaration')

  -- Fuzzy find all the symbols in current file.
  --  Symbols are things like variables, functions, types, etc.
  map('<leader>fsd', builtin.lsp_document_symbols, 'find document symbols')

  map('<leader>fm', function()
    builtin.lsp_document_symbols { symbols = 'method' }
  end, 'find method')

  map('<leader>fsw', builtin.lsp_workspace_symbols, 'find workspace symbols')

  -- Fuzzy find all the symbols in the current workspace.
  --  Similar to document symbols, except searches over the entire project.
  map('<leader>fsW', builtin.lsp_dynamic_workspace_symbols, 'find dynamic workspace symbols')

  -- Rename the variable under the cursor.
  --  Most Language Servers support renaming across files, etc.
  map('<leader>lr', vim.lsp.buf.rename, 'lsp rename')

  -- Execute a code action, usually the cursor needs to be on top of an error
  -- or a suggestion from the LSP for this to activate.
  map('<leader>lc', vim.lsp.buf.code_action, 'lsp code action')

  map('K', vim.lsp.buf.hover, 'read docs')

  local client = vim.lsp.get_client_by_id(event.data.client_id)

  -- The following autocommand is used to enable inlay hints in the
  -- code, if the language server you are using supports them
  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    map('<leader>oh', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, 'toggle inlay hints')
  end
end

function M.setup_conform()
  return {
    {
      '<leader>lf',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = 'format buffer',
    },
  }
end

function M.setup_coderunner()
  map_normal_mode('<leader>rf', ':RunFile term<CR>', 'run file')
end

function M.setup_neotree()
  return {
    { '<leader>eb', '<cmd>Neotree source=buffers reveal=true position=left action=focus<cr>', desc = 'explore buffers' },
    { '<leader>ec', '<cmd>Neotree action=close<cr>', desc = 'close explorer' },
    { '<leader>eo', '<cmd>Neotree source=filesystem reveal=true position=left action=focus<cr>', desc = 'explore filesystem' },
    { '<leader>eg', '<cmd>Neotree source=git_status reveal=true position=left action=focus<cr>', desc = 'explore git status' },
    { '<leader>es', '<cmd>Neotree source=document_symbols reveal=true position=left action=focus<cr>', desc = 'explore document symbols' },
  }
end

function M.setup_gitsigns(bufnr)
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
  map('v', '<leader>gs', function()
    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'stage git hunk' })
  map('v', '<leader>gr', function()
    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'reset git hunk' })
  map('v', '<leader>gu', function()
    gitsigns.undo_stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'git undo stage hunk' })

  -- normal mode
  map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git stage hunk' })
  map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git reset hunk' })
  map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git stage buffer' })
  map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'git undo stage hunk' })
  map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git reset buffer' })
  map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'git preview hunk' })
  map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git blame line' })
  map('n', '<leader>gd', gitsigns.diffthis, { desc = 'git diff against index' })
  map('n', '<leader>gD', function()
    gitsigns.diffthis '@'
  end, { desc = 'git diff against last commit' })

  -- Toggles
  map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = 'toggle git show blame line' })
  map('n', '<leader>gtd', gitsigns.toggle_deleted, { desc = 'toggle git show deleted' })
end

function M.setup_gitlinker()
  vim.keymap.set(
    'v',
    '<leader>go',
    '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    { desc = 'open in github' }
  )
  vim.keymap.set('v', '<leader>gy', '<cmd>lua require"gitlinker".get_buf_range_url("v")<cr>', { silent = true, desc = 'copy github link' })
  vim.keymap.set('n', '<leader>gy', '<cmd>lua require"gitlinker".get_repo_url()<cr>', { silent = true, desc = 'copy github link' })
  vim.keymap.set(
    'n',
    '<leader>go',
    '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    { silent = true, desc = 'open in github' }
  )
end

function M.setup_git_blame()
  return {
    -- toggle needs to be called twice; https://github.com/f-person/git-blame.nvim/issues/16
    { '<leader>gB', ':GitBlameToggle<CR>', desc = 'blame line (toggle)', silent = true },
    { '<leader>gcs', ':GitBlameCopySHA<CR>', desc = 'copy commit SHA', silent = true },
    { '<leader>gcu', ':GitBlameCopyCommitURL<CR>', desc = 'copy commit URL', silent = true },
    { '<leader>gcy', ':GitBlameCopyFileURL<CR>', desc = 'copy file URL', silent = true },
    { '<leader>gco', ':GitBlameOpenFileURL<CR>', desc = 'open file URL', silent = true },
  }
end

function M.setup_lazygit()
  --   "LazyGit",
  --   "LazyGitConfig",
  --   "LazyGitCurrentFile",
  --   "LazyGitFilter",
  --   "LazyGitFilterCurrentFile",

  map_normal_mode('<leader>gl', function()
    -- if keymap <Esc><Esc> is set in terminal mode, remove it.
    -- this is to enable <Esc> to navigate in LazyGit which otherwise
    -- is overridden for terminal usage.
    local terminal_keymaps = vim.api.nvim_get_keymap 't'
    for _, keymap in pairs(terminal_keymaps) do
      ---@diagnostic disable-next-line
      if keymap.lhs == '<Esc><Esc>' then
        vim.api.nvim_del_keymap('t', '<Esc><Esc>')
      end
    end
    vim.cmd 'LazyGit'
  end, 'open lazy git')
end

function M.setup_neotest()
  return {
    {
      '<leader>ta',
      function()
        require('neotest').run.attach()
      end,
      desc = 'attach test',
    },
    {
      '<leader>tf',
      function()
        vim.cmd 'write'
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'run test file',
    },
    {
      '<leader>tA',
      function()
        vim.cmd 'write'
        require('neotest').run.run(vim.uv.cwd())
      end,
      desc = 'run all test files',
    },
    {
      '<leader>tT',
      function()
        vim.cmd 'write'
        require('neotest').run.run { suite = true }
      end,
      desc = 'run test suite',
    },
    {
      '<leader>tn',
      function()
        vim.cmd 'write'
        require('neotest').run.run()
      end,
      desc = 'run nearest test',
    },
    {
      '<leader>tl',
      function()
        vim.cmd 'write'
        require('neotest').run.run_last()
      end,
      desc = 'run last test',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'toggle test summary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = 'show test output',
    },
    {
      '<leader>tO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'toggle test output panel',
    },
    {
      '<leader>tt',
      function()
        require('neotest').run.stop()
      end,
      desc = 'terminate test',
    },
    {
      '<leader>td',
      function()
        vim.cmd 'write'
        vim.cmd 'Neotree close'
        require('neotest').summary.close()
        require('neotest').output_panel.close()
        require('neotest').run.run { suite = false, strategy = 'dap' }
      end,
      desc = 'debug nearest test',
    },
  }
end

function M.setup_go()
  local util = require 'util.go'
  vim.keymap.set('n', '<leader>ga', util.switch_go_test_file, { desc = 'switch between test file' })
end

function M.setup_telescope()
  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'

  local function get_current_dir()
    local buf = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(buf, ':p:h')
    return dir
  end

  local function live_grep_in_package()
    local dir = get_current_dir()
    builtin.live_grep {
      search_dirs = { dir },
    }
  end

  local function find_files_in_cur_dir()
    local dir = get_current_dir()
    builtin.find_files {
      search_dirs = { dir },
    }
  end

  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] find in buffers' })
  vim.keymap.set('n', '<leader>fcm', builtin.commands, { desc = 'find commands' })
  vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'find diagnostics' })
  vim.keymap.set('n', '<leader>fD', vim.diagnostic.setloclist, { desc = 'show diagnostics in loclist' })
  vim.keymap.set('n', '<leader>fF', builtin.find_files, { desc = 'find files' })
  vim.keymap.set('n', '<leader>ff', find_files_in_cur_dir, { desc = 'find files in pwd' })
  vim.keymap.set('n', '<leader>fgb', builtin.git_branches, { desc = 'find git branches' })
  vim.keymap.set('n', '<leader>fgc', builtin.git_commits, { desc = 'find git commits' })
  vim.keymap.set('n', '<leader>fgf', builtin.git_files, { desc = 'find git files' })
  vim.keymap.set('n', '<leader>fgS', builtin.git_stash, { desc = 'find git stash' })
  vim.keymap.set('n', '<leader>fgs', builtin.git_status, { desc = 'find git staus' })
  vim.keymap.set('n', '<leader>fH', builtin.help_tags, { desc = 'find help' })
  vim.keymap.set('n', '<leader>fhc', builtin.command_history, { desc = 'find history command' })
  vim.keymap.set('n', '<leader>fhs', builtin.search_history, { desc = 'find history search' })
  vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'find keymaps' })
  vim.keymap.set('n', '<leader>fmd', function()
    builtin.lsp_document_symbols { symbols = 'method' }
  end, { desc = 'find method' })
  vim.keymap.set('n', '<leader>fmk', builtin.marks, { desc = 'find marks' })
  vim.keymap.set('n', '<leader>fmp', builtin.man_pages, { desc = 'find man pages' })
  vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'find old files' })
  vim.keymap.set('n', '<leader>fP', builtin.live_grep, { desc = 'find by grep' })
  vim.keymap.set('n', '<leader>fp', live_grep_in_package, { desc = 'find by grep in current directory' })
  vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'find resume' })
  vim.keymap.set('n', '<leader>fS', builtin.spell_suggest, { desc = 'find select telescope' })
  vim.keymap.set('n', '<leader>fst', builtin.builtin, { desc = 'find select telescope' })
  vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'find todos' })
  vim.keymap.set('n', '<leader>fT', builtin.treesitter, { desc = 'find treesitter' })
  vim.keymap.set('n', '<leader>fvo', builtin.vim_options, { desc = 'find vim options' })
  vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'find word' })

  vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      previewer = false,
      layout_config = {
        preview_cutoff = 1, -- Preview should always show (unless previewer = false)

        width = function(_, max_columns, _)
          return math.min(max_columns, 120)
        end,

        height = function(_, _, max_lines)
          return math.min(max_lines, 25)
        end,
      },
    })
  end, { desc = '[/] fuzzily search in current buffer' })

  vim.keymap.set('n', '<leader>f/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'live grep in Open Files',
    }
  end, { desc = 'find [/] in open files' })

  -- Shortcut for searching Neovim configuration files
  vim.keymap.set('n', '<leader>fn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = 'find neovim files' })
end

function M.setup_dap_ui()
  -- keymaps: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt#L508
  return {
    {
      '<leader>bdu',
      function()
        require('dapui').toggle {}
      end,
      desc = 'dap ui',
    },
    {
      '<leader>bde',
      function()
        require('dapui').eval()
      end,
      desc = 'dap eval',
    },
  }
end

function M.setup_coverage()
  map_normal_mode('<leader>tc', ':Coverage<CR>', 'test coverage in gutter')
  map_normal_mode('<leader>tC', ':CoverageLoad<CR>:CoverageSummary<CR>', 'test coverage summary')
end

function M.setup_dap(keys)
  local dap = require 'dap'
  return {
    { '<leader>bb', dap.toggle_breakpoint, desc = 'toggle debug breakpoint' },
    {
      '<leader>bB',
      function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'debug breakpoint continue',
    },
    { '<leader>bc', dap.continue, desc = 'debug continue' },
    { '<leader>bl', dap.list_breakpoints, desc = 'debug list breakpoints' },
    { '<leader>bC', dap.run_to_cursor, desc = 'debug cursor' },
    { '<leader>bg', dap.goto_, desc = 'debug goto line' },
    { '<leader>bo', dap.step_over, desc = 'debug step over' },
    { '<leader>bO', dap.step_out, desc = 'debug step out' },
    { '<leader>bi', dap.step_into, desc = 'debug into' },
    { '<leader>bjd', dap.down, desc = 'debug jump down' },
    { '<leader>bju', dap.up, desc = 'debug jump up' },
    { '<leader>bL', dap.run_last, desc = 'debug last' },
    {
      '<leader>bM',
      function()
        dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      end,
      desc = 'debug log point message',
    },
    { '<leader>bp', dap.pause, desc = 'debug pause' },
    { '<leader>br', dap.repl.toggle, desc = 'debug repl' },
    { '<leader>bR', dap.clear_breakpoints, desc = 'debug remove breakpoints' },
    { '<leader>bs', dap.session, desc = 'debug session' },
    { '<leader>bt', dap.terminate, desc = 'debug terminate' },
    { '<leader>bw', require('dap.ui.widgets').hover, desc = 'debug widgets' },
    unpack(keys),
  }
end

function M.setup_cmp()
  local cmp = require 'cmp'
  local ls = require 'luasnip'
  return {
    -- Select the next item
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Select the previous item
    ['<C-p>'] = cmp.mapping.select_prev_item(),

    -- Scroll the documentation window back / forward
    ['<C-b>'] = cmp.mapping.scroll_docs(-5),
    ['<C-f>'] = cmp.mapping.scroll_docs(5),

    -- Accept (yes) the completion.
    --  This will auto-import if your LSP supports it.
    --  This will expand snippets if the LSP sent a snippet.
    ['<CR>'] = cmp.mapping.confirm { select = true },

    ['<C-x>'] = cmp.mapping.abort(),

    -- Manually trigger a completion from nvim-cmp.
    ['<C-Space>'] = cmp.mapping.complete {},

    -- Think of <c-l> as moving to the right of your snippet expansion.
    --  So if you have a snippet that's like:
    --  function $name($args)
    --    $body
    --  end
    --
    -- <c-l> will move you to the right of each of the expansion locations.
    -- <c-h> is similar, except moving you backwards.
    ['<C-l>'] = cmp.mapping(function()
      if ls.expand_or_locally_jumpable() then
        ls.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if ls.locally_jumpable(-1) then
        ls.jump(-1)
      end
    end, { 'i', 's' }),
    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    ['<C-c>'] = cmp.mapping(function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end),
  }
end

function M.setup_dadbod()
  vim.keymap.set('n', '<leader>wd', '<cmd>DBUI<cr>', { desc = 'open DB UI' })
  vim.keymap.set('n', '<leader>od', '<cmd>DBUIToggle<cr>', { desc = 'toggle DB UI' })
end

function M.setup_persistence()
  local persistence = require 'persistence'
  vim.keymap.set('n', '<leader>ss', persistence.save, { desc = 'save session' })
  vim.keymap.set('n', '<leader>sd', persistence.load, { desc = 'load session from pwd' })
  vim.keymap.set('n', '<leader>sv', persistence.select, { desc = 'select session to load' })
  vim.keymap.set('n', '<leader>sq', persistence.stop, { desc = 'do not save session on exit' })
  vim.keymap.set('n', '<leader>sl', function()
    persistence.load { last = true }
  end, { desc = 'load the last session' })
end

function M.setup_open(open)
  vim.keymap.set('n', 'gx', open.open_cword, { desc = 'open url' })
end

function M.setup_harpoon(harpoon)
  local conf = require('telescope.config').values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require('telescope.pickers')
      .new({}, {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table {
          results = file_paths,
        },
        previewer = conf.file_previewer {},
        sorter = conf.generic_sorter {},
      })
      :find()
  end

  vim.keymap.set('n', '<leader>hf', function()
    toggle_telescope(harpoon:list())
  end, { desc = 'find harpoon' })

  vim.keymap.set('n', '<leader>ha', function()
    harpoon:list():add()
  end, { desc = 'harpoon add' })
  vim.keymap.set('n', '<leader>hd', function()
    harpoon:list():remove()
  end, { desc = 'harpoon delete' })
  vim.keymap.set('n', '<leader>hc', function()
    harpoon:list():remove()
  end, { desc = 'harpoon clear' })
  vim.keymap.set('n', '<leader>hm', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = 'harpoon menu' })

  vim.keymap.set('n', '<leader>h1', function()
    harpoon:list():select(1)
  end, { desc = 'harpoon #1' })
  vim.keymap.set('n', '<leader>h2', function()
    harpoon:list():select(2)
  end, { desc = 'harpoon #2' })
  vim.keymap.set('n', '<leader>h3', function()
    harpoon:list():select(3)
  end, { desc = 'harpoon #3' })
  vim.keymap.set('n', '<leader>h4', function()
    harpoon:list():select(4)
  end, { desc = 'harpoon #4' })
  vim.keymap.set('n', '<leader>h5', function()
    harpoon:list():select(5)
  end, { desc = 'harpoon #5' })
  vim.keymap.set('n', '<leader>h6', function()
    harpoon:list():select(6)
  end, { desc = 'harpoon #6' })

  -- Toggle previous & next buffers stored within Harpoon list
  vim.keymap.set('n', '[h', function()
    harpoon:list():prev()
  end, { desc = 'previous harpoon' })
  vim.keymap.set('n', ']h', function()
    harpoon:list():next()
  end, { desc = 'next harpoon' })
end

function M.setup_undotree()
  return {
    { '<leader>ou', '<cmd>UndotreeToggle<cr>', desc = 'toggle undotree' },
  }
end

function M.setup_toggleterm(trim_spaces)
  vim.keymap.set('v', '<C-s>', function()
    require('toggleterm').send_lines_to_terminal('visual_lines', trim_spaces, { args = vim.v.count, desc = 'send lines to terminal' })
  end)
  vim.keymap.set('n', '<leader>ot', '<cmd>ToggleTerm<CR>', { desc = 'toggle terminal window' })
  vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'exit terminal mode' })
end

function M.setup_bookmarks()
  return {
    toggle = '<leader>om', -- Toggle bookmarks(global keymap)
    add = '<leader>ma', -- Add bookmarks(global keymap)
    add_global = '<leader>mA', -- Add global bookmarks(global keymap), global bookmarks will appear in all projects. Identified with the symbol '󰯾'
    show_desc = '<leader>ms', -- show bookmark desc(global keymap)
    delete_on_virt = '<leader>md', -- Delete bookmark at virt text line(global keymap)

    close = 'q', -- close bookmarks (buf keymap)
    delete = 'dd', -- Delete bookmarks(buf keymap)
    jump = '<cr>', -- Jump from bookmarks(buf keymap)
    order = '<space><space>', -- Order bookmarks by frequency or updated_time(buf keymap)

    focus_tags = 'h', -- focus tags window
    focus_bookmarks = 'l', -- focus bookmarks window
    toogle_focus = '<tab>', -- toggle window focus (tags-window <-> bookmarks-window)
  }
end

function M.setup_peek(toggle)
  vim.keymap.set('n', '<leader>op', toggle, { desc = 'toggle markdown previewer' })
end

function M.setup_render_markdown()
  vim.keymap.set('n', '<leader>or', require('render-markdown').toggle, { desc = 'toggle markdown' })
end

function M.setup_obsidian()
  vim.keymap.set('n', '<leader>nC', '<cmd>ObsidianCheck<cr>', { desc = 'check note' })

  -- :ObsidianOpen [QUERY] to open a note in the Obsidian app. This command has one optional argument: a query used to resolve the note to open by ID, path, or alias. If not given, the note corresponding to the current buffer is opened.
  vim.keymap.set('n', '<leader>no', '<cmd>ObsidianOpen<cr>', { desc = 'open note in obsidian' })

  -- :ObsidianNew [TITLE] to create a new note. This command has one optional argument: the title of the new note.
  vim.keymap.set('n', '<leader>nn', '<cmd>ObsidianNew<cr>', { desc = 'create new note' })

  -- :ObsidianQuickSwitch to quickly switch to (or open) another note in your vault, searching by its name using ripgrep with your preferred picker (see plugin dependencies below).
  vim.keymap.set('n', '<leader>ns', '<cmd>ObsidianQuickSwitch<cr>', { desc = 'switch to note' })

  -- :ObsidianFollowLink [vsplit|hsplit] to follow a note reference under the cursor, optionally opening it in a vertical or horizontal split.
  vim.keymap.set('n', '<leader>nf', '<cmd>ObsidianFollowLink<cr>', { desc = 'follow link' })

  -- :ObsidianBacklinks for getting a picker list of references to the current buffer.
  vim.keymap.set('n', '<leader>nb', '<cmd>ObsidianBacklinks<cr>', { desc = 'open backlinks picker' })

  -- :ObsidianTags [TAG ...] for getting a picker list of all occurrences of the given tags.
  vim.keymap.set('n', '<leader>nt', '<cmd>ObsidianTags<cr>', { desc = 'open tags picker' })

  -- :ObsidianToday [OFFSET] to open/create a new daily note. This command also takes an optional offset in days, e.g. use :ObsidianToday -1 to go to yesterday's note. Unlike :ObsidianYesterday and :ObsidianTomorrow this command does not differentiate between weekdays and weekends.
  vim.keymap.set('n', '<leader>nD', '<cmd>ObsidianToday<cr>', { desc = "open today's daily note" })

  -- :ObsidianYesterday to open/create the daily note for the previous working day.
  vim.keymap.set('n', '<leader>nY', '<cmd>ObsidianYesterday<cr>', { desc = "open yesterday's daily note" })

  -- :ObsidianTomorrow to open/create the daily note for the next working day.
  vim.keymap.set('n', '<leader>nT', '<cmd>ObsidianTomorrow<cr>', { desc = "open tomorrow's daily note" })

  -- :ObsidianDailies [OFFSET ...] to open a picker list of daily notes. For example, :ObsidianDailies -2 1 to list daily notes from 2 days ago until tomorrow.
  vim.keymap.set('n', '<leader>nd', '<cmd>ObsidianDailies<cr>', { desc = 'open daily notes picker' })

  -- :ObsidianTemplate [NAME] to insert a template from the templates folder, selecting from a list using your preferred picker. See "using templates" for more information.
  vim.keymap.set('n', '<leader>nP', '<cmd>ObsidianTemplate<cr>', { desc = 'open notes template picker' })

  -- :ObsidianSearch [QUERY] to search for (or create) notes in your vault using ripgrep with your preferred picker.
  vim.keymap.set('n', '<leader>ng', '<cmd>ObsidianSearch<cr>', { desc = 'search in notes' })

  -- :ObsidianLink [QUERY] to link an inline visual selection of text to a note. This command has one optional argument: a query that will be used to resolve the note by ID, path, or alias. If not given, the selected text will be used as the query.

  -- :ObsidianLinkNew [TITLE] to create a new note and link it to an inline visual selection of text. This command has one optional argument: the title of the new note. If not given, the selected text will be used as the title.

  -- :ObsidianLinks to collect all links within the current buffer into a picker window.
  vim.keymap.set('n', '<leader>nl', '<cmd>ObsidianLinks<cr>', { desc = 'open note links picker' })

  -- :ObsidianExtractNote [TITLE] to extract the visually selected text into a new note and link to it.
  vim.keymap.set({ 'n', 'v' }, '<leader>nx', '<cmd>ObsidianExtractNote<cr>', { desc = 'extract selected into new note' })

  -- :ObsidianWorkspace [NAME] to switch to another workspace.
  vim.keymap.set('n', '<leader>nw', '<cmd>ObsidianWorkspace<cr>', { desc = 'switch note workspace' })

  -- :ObsidianPasteImg [IMGNAME] to paste an image from the clipboard into the note at the cursor position by saving it to the vault and adding a markdown image link. You can configure the default folder to save images to with the attachments.img_folder option.
  vim.keymap.set('n', '<leader>np', '<cmd>ObsidianPasteImg<cr>', { desc = 'paste image' })

  -- :ObsidianRename [NEWNAME] [--dry-run] to rename the note of the current buffer or reference under the cursor, updating all backlinks across the vault. Since this command is still relatively new and could potentially write a lot of changes to your vault, I highly recommend committing the current state of your vault (if you're using version control) before running it, or doing a dry-run first by appending "--dry-run" to the command, e.g. :ObsidianRename new-id --dry-run.
  vim.keymap.set('n', '<leader>nr', '<cmd>ObsidianRename<cr>', { desc = 'rename note' })

  -- :ObsidianToggleCheckbox to cycle through checkbox options.
  vim.keymap.set('n', '<leader>no', '<cmd>ObsidianToggleCheckbox<cr>', { desc = 'toggle checkbox options' })

  -- :ObsidianNewFromTemplate [TITLE] to create a new note from a template in the templates folder. Selecting from a list using your preferred picker. This command has one optional argument: the title of the new note.
  vim.keymap.set('n', '<leader>nN', '<cmd>ObsidianNewFromTemplate<cr>', { desc = 'new note from template' })

  -- :ObsidianTOC to load the table of contents of the current note into a picker list.
  vim.keymap.set('n', '<leader>nc', '<cmd>ObsidianTOC<cr>', { desc = 'table of contents' })

  local function delete_current_note()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file ~= '' and vim.fn.confirm('Delete ' .. current_file .. '?', '&Yes\n&No', 2) == 1 then
      vim.cmd 'bd!' -- Close the buffer
      os.remove(current_file) -- Delete the file
      print(current_file .. ' deleted.')
    else
      print 'Operation canceled.'
    end
  end

  vim.api.nvim_create_user_command('ObsidianDelete', delete_current_note, {})

  vim.api.nvim_set_keymap('n', '<leader>nd', '<cmd>ObsidianDelete<CR>', { noremap = true, silent = true, desc = 'Delete Obsidian note' })
end

function M.setup_treesitter_context()
  vim.keymap.set('n', '[c', function()
    require('treesitter-context').go_to_context(vim.v.count1)
  end, { desc = 'previous context', silent = true })

  -- vim.keymap.set('n', ']c', function()
  --   require('treesitter-context').go_to_context(-vim.v.count1)
  -- end, { desc = 'next context', silent = true })
end

-- AI Tools Keybindings
function M.setup_gemini()
  vim.keymap.set('n', '<leader>agc', ':GeminiChat<CR>', { desc = 'Gemini Chat' })
  vim.keymap.set('v', '<leader>age', ':GeminiExplain<CR>', { desc = 'Explain with Gemini' })
  vim.keymap.set('v', '<leader>agf', ':GeminiFix<CR>', { desc = 'Fix with Gemini' })
  vim.keymap.set('v', '<leader>ago', ':GeminiOptimize<CR>', { desc = 'Optimize with Gemini' })
  vim.keymap.set('v', '<leader>agt', ':GeminiTest<CR>', { desc = 'Generate Tests with Gemini' })
  vim.keymap.set('v', '<leader>agr', ':GeminiReview<CR>', { desc = 'Review with Gemini' })
end

function M.setup_claude()
  vim.keymap.set('n', '<leader>acc', ':ClaudeCode<CR>', { desc = 'Toggle Claude' })
  vim.keymap.set('n', '<leader>acf', ':ClaudeCodeFocus<CR>', { desc = 'Focus Claude terminal' })
  vim.keymap.set('n', '<leader>acr', ':ClaudeCodeResume<CR>', { desc = 'Resume Claude' })
  vim.keymap.set('n', '<leader>acC', ':ClaudeCodeContinue<CR>', { desc = 'Continue Claude' })
  vim.keymap.set('n', '<leader>acb', ':ClaudeCodeAdd<CR>', { desc = 'Add current buffer' })
  vim.keymap.set('v', '<leader>acs', ':ClaudeCodeSend<CR>', { desc = 'Send selection to Claude' })
  vim.keymap.set('n', '<leader>aca', ':ClaudeCodeDiffAccept<CR>', { desc = 'Accept diff changes' })
  vim.keymap.set('n', '<leader>acd', ':ClaudeCodeDiffDeny<CR>', { desc = 'Reject diff changes' })
end

-- function M.setup_treesitter()
--   -- There are additional nvim-treesitter modules that you can use to interact
--   -- with nvim-treesitter. You should go explore a few and see what interests you:
--   --
--   --  - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--   --  - Show the current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--   --  - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--   vim.keymap.set('n', '<leader>it', '<cmd>InspectTree<cr>', { desc = '[I]nspect [T]ree' })
-- end

return M
