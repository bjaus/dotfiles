--  See `:help vim.keymap.set()`

M = {}

function M.setup_which_key()
  vim.keymap.set('n', '<leader>wk', '<cmd>WhichKey<cr>', { desc = 'show which key' })

  return {
    -- { '<leader>c', group = '[c]ode' },
    -- { '<leader>d', group = '[d]ocument' },
    -- { '<leader>i', group = '[i]nspect' },
    -- { '<leader>k', group = '[k]ey' },
    -- { '<leader>l', group = '[l]azy' },
    -- { '<leader>n', group = '[n]otes' },
    -- { '<leader>r', group = '[r]ename' },
    -- { '<leader>w', group = '[w]indow' },
    { '<leader>a', group = '[a]ction' },
    { '<leader>b', group = 'de[b]ug' },
    { '<leader>e', group = '[e]xplore' },
    { '<leader>f', group = '[f]ind' },
    { '<leader>g', group = '[g]it', mode = { 'n', 'v' } },
    { '<leader>h', group = '[h]arpoon' },
    { '<leader>j', group = '[j]ump' },
    { '<leader>o', group = '[o]rder', mode = { 'v' } },
    { '<leader>s', group = '[s]ession', mode = { 'n' } },
    { '<leader>t', group = '[t]est' },
  }
end

-- stack navigation
vim.keymap.set('n', '<C-n>', '<C-i>', { desc = 'next frame in stack' })
vim.keymap.set('n', '<C-p>', '<C-o>', { desc = 'prev frame in stack' })

-- sort alphabetically
vim.keymap.set('v', '<leader>oi', '<cmd>sort i<cr>', { desc = 'sort order alphabetically' })
vim.keymap.set('v', '<leader>ou', '<cmd>sort ui<cr>', { desc = 'sort unique alphabetically' })

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
-- vim.keymap.set('n', '<leader>wx', '<cmd>bd!<cr>', { desc = 'close buffer' })

-- -- windows
-- vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = 'split window vertically' })
-- vim.keymap.set('n', '<leader>wh', '<cmd>split<cr>', { desc = 'split window horizontally' })

-- -- tabs
vim.keymap.set('n', '<tab>n', '<cmd>tabnew<cr>', { desc = 'new tab', silent = true })
vim.keymap.set('n', '<tab>x', '<cmd>tabclose<cr>', { desc = 'close tab', silent = true })
vim.keymap.set('n', ']t', '<cmd>tabnext<cr>', { desc = 'next tab', silent = true })
vim.keymap.set('n', '[t', '<cmd>tabprevious<cr>', { desc = 'previous tab', silent = true })

-- -- files
-- vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr', { desc = 'new file' })

-- save
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'save file' })

-- -- lists
-- vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'previous quickfix' })
-- vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'next quickfix' })

-- -- indentation
-- -- vim.keymap.set({ 'n', 'v' }, '<', '<gv', { desc = 'indent left' })
-- -- vim.keymap.set({ 'n', 'v' }, '>', '>gv', { desc = 'indent right' })

-- -- lazy
-- vim.keymap.set('n', '<leader>lc', '<cmd>Lazy clean<cr>', { desc = 'run clean' })
-- vim.keymap.set('n', '<leader>ld', '<cmd>Lazy debug<cr>', { desc = 'show debug info' })
-- vim.keymap.set('n', '<leader>lh', '<cmd>Lazy show<cr>', { desc = 'show home' })
-- vim.keymap.set('n', '<leader>li', '<cmd>Lazy install<cr>', { desc = 'run install' })
-- vim.keymap.set('n', '<leader>lk', '<cmd>Lazy check<cr>', { desc = 'check for updates' })
-- vim.keymap.set('n', '<leader>ll', '<cmd>Lazy log<cr>', { desc = 'show logs' })
-- vim.keymap.set('n', '<leader>lp', '<cmd>Lazy profile<cr>', { desc = 'show profile' })
-- vim.keymap.set('n', '<leader>lr', '<cmd>Lazy restore<cr>', { desc = 'restore to lockfile' })
-- vim.keymap.set('n', '<leader>ls', '<cmd>Lazy sync<cr>', { desc = 'run install, clean, and update' })
-- vim.keymap.set('n', '<leader>lu', '<cmd>Lazy update<cr>', { desc = 'run update' })

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

-- -- function M.setup_trouble_keymaps()
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

function M.setup_lsp_keymaps(event)
  local builtin = require 'telescope.builtin'
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc, nowait = true })
  end

  -- Jump to the definition of the word under the cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('<leader>jd', builtin.lsp_definitions, 'jump to definition')

  -- Find references for the word under the cursor.
  map('<leader>jr', builtin.lsp_references, 'jump to references')

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

  -- Fuzzy find all the symbols in the current workspace.
  --  Similar to document symbols, except searches over the entire project.
  map('<leader>fsw', builtin.lsp_dynamic_workspace_symbols, 'find workspace symbols')

  -- Rename the variable under the cursor.
  --  Most Language Servers support renaming across files, etc.
  map('<leader>ar', vim.lsp.buf.rename, 'action rename')

  -- Execute a code action, usually the cursor needs to be on top of an error
  -- or a suggestion from the LSP for this to activate.
  map('<leader>ac', vim.lsp.buf.code_action, 'action code')

  local client = vim.lsp.get_client_by_id(event.data.client_id)

  -- The following autocommand is used to enable inlay hints in the
  -- code, if the language server you are using supports them
  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, '[T]oggle Inlay [H]ints')
  end
end

function M.setup_conform_keymaps()
  return {
    {
      '<leader>af',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = 'format buffer',
    },
  }
end

function M.setup_coderunner_keymaps()
  map_normal_mode('<leader>rf', ':RunFile term<CR>', 'run file')
end

function M.setup_neotree_keymaps()
  return {
    { '<leader>eb', ':Neotree source=buffers reveal=true position=left action=focus<cr>', desc = 'explore buffers' },
    { '<leader>ec', ':Neotree action=close<cr>', desc = 'close explorer' },
    { '<leader>eo', ':Neotree source=filesystem reveal=true position=left action=focus<cr>', desc = 'explore filesystem' },
    { '<leader>eg', ':Neotree source=git_status reveal=true position=left action=focus<cr>', desc = 'explore git status' },
    { '<leader>es', ':Neotree source=document_symbols reveal=true position=left action=focus<cr>', desc = 'explore document symbols' },
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
  map('n', '<leader>gtD', gitsigns.toggle_deleted, { desc = 'toggle git show deleted' })
end

function M.setup_git_linker_keymaps()
  -- TODO: Looks like copying github link to clipboard is mapped by default but
  -- I'd like to do that and open so I need look into how to make both happen.
  --
  -- vim.keymap.set('n', '<leader>gb',
  --   '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  --   { silent = true })
  -- vim.keymap.set('v', '<leader>gb',
  --   '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  --   {})
  -- vim.keymap.set('n', '<leader>gY', '<cmd>lua require"gitlinker".get_repo_url()<cr>', { silent = true })
  -- vim.keymap.set('n', '<leader>gB',
  --   '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  --   { silent = true })
end

-- function M.setup_git_blame_keymaps()
--   return {
--     -- toggle needs to be called twice; https://github.com/f-person/git-blame.nvim/issues/16
--     { '<leader>gbl', ':GitBlameToggle<CR>', desc = 'Blame line (toggle)', silent = true },
--     { '<leader>gbs', ':GitBlameCopySHA<CR>', desc = 'Copy SHA', silent = true },
--     { '<leader>gbc', ':GitBlameCopyCommitURL<CR>', desc = 'Copy commit URL', silent = true },
--     { '<leader>gbf', ':GitBlameCopyFileURL<CR>', desc = 'Copy file URL', silent = true },
--     { '<leader>gbo', ':GitBlameOpenFileURL<CR>', desc = 'Open file URL', silent = true },
--   }
-- end

function M.setup_lazygit_keymaps()
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

function M.setup_neotest_keymaps()
  return {
    {
      '<leader>ta',
      function()
        require('neotest').run.attach()
      end,
      desc = 'Attach',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run File',
    },
    {
      '<leader>tA',
      function()
        require('neotest').run.run(vim.uv.cwd())
      end,
      desc = 'Run All Test Files',
    },
    {
      '<leader>tT',
      function()
        require('neotest').run.run { suite = true }
      end,
      desc = 'Run Test Suite',
    },
    {
      '<leader>tn',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run Nearest',
    },
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = 'Run Last',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle Summary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = 'Show Output',
    },
    {
      '<leader>tO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'Toggle Output Panel',
    },
    {
      '<leader>tt',
      function()
        require('neotest').run.stop()
      end,
      desc = 'Terminate',
    },
    {
      '<leader>td',
      function()
        vim.cmd 'Neotree close'
        require('neotest').summary.close()
        require('neotest').output_panel.close()
        require('neotest').run.run { suite = false, strategy = 'dap' }
      end,
      desc = 'Debug nearest test',
    },

    -- -- map_normal_mode("<leader>td", ':lua require("neotest").run.run({vim.fn.expand("%"), strategy = "dap"})<CR>', "[t]est [d]ebug Nearest")
    -- map_normal_mode("<leader>td", ':lua require("neotest").run.run({ strategy = "dap" })<CR>', "[t]est [d]ebug Nearest")
    -- map_normal_mode("<leader>tg", function()
    --   -- FIXME: https://github.com/nvim-neotest/neotest-go/issues/12
    --   -- Depends on "leoluz/nvim-dap-go"
    --   require("dap-go").debug_test()
    -- end, "[d]ebug [g]o (nearest test)")
  }
end

function M.setup_go_keymaps()
  local util = require 'util.go'
  vim.keymap.set('n', '<leader>wgf', util.switch_go_test_file, { desc = 'switch between test file' })
  vim.keymap.set('n', '<leader>wgv', util.vsplit_go_test_file, { desc = 'switch between test file' })
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

  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'find help' })
  vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'find keymaps' })
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find files' })
  vim.keymap.set('n', '<leader>fF', find_files_in_cur_dir, { desc = 'find files in current directory' })
  vim.keymap.set('n', '<leader>fst', builtin.builtin, { desc = 'find select telescope' })
  vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'find word' })
  vim.keymap.set('n', '<leader>fp', builtin.live_grep, { desc = 'find by grep' })
  vim.keymap.set('n', '<leader>fP', live_grep_in_package, { desc = 'find by grep in current directory' })
  vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'find diagnostics' })
  vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'find resume' })
  vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'find todos' })
  vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'find old files' })
  vim.keymap.set('n', '<leader>fgb', builtin.git_branches, { desc = 'find git branches' })
  vim.keymap.set('n', '<leader>fgf', builtin.git_files, { desc = 'find git files' })
  vim.keymap.set('n', '<leader>fgs', builtin.git_stash, { desc = 'find git staus' })
  vim.keymap.set('n', '<leader>fgc', builtin.git_commits, { desc = 'find git commits' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] find in buffers' })

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

function M.setup_dap_ui_keymaps()
  -- keymaps: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt#L508
  return {
    {
      '<leader>du',
      function()
        require('dapui').toggle {}
      end,
      desc = 'DAP UI',
    },
    {
      '<leader>de',
      function()
        require('dapui').eval()
      end,
      desc = 'DAP Eval',
    },
  }
end

function M.setup_coverage_keymaps()
  map_normal_mode('<leader>tc', ':Coverage<CR>', 'test coverage in gutter')
  map_normal_mode('<leader>tC', ':CoverageLoad<CR>:CoverageSummary<CR>', 'test coverage summary')
end

function M.setup_dap_keymaps(keys)
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
    { '<leader>bC', dap.run_to_cursor, desc = 'debug cursor' },
    { '<leader>bg', dap.goto_, desc = 'debug goto line' },
    { '<leader>bo', dap.step_over, desc = 'debug step over' },
    { '<leader>bO', dap.step_out, desc = 'debug step out' },
    { '<leader>bi', dap.step_into, desc = 'debug into' },
    { '<leader>bjd', dap.down, desc = 'debug jump down' },
    { '<leader>bju', dap.up, desc = 'debug jump up' },
    { '<leader>bl', dap.run_last, desc = 'debug last' },
    {
      '<leader>bL',
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
    ['<C-y>'] = cmp.mapping.confirm { select = true },

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
  return {
    { 'n', '<leader>db', '<cmd>DBUI<cr>' },
  }
end

function M.setup_persistence()
  local persistence = require 'persistence'
  vim.keymap.set('n', '<leader>ss', persistence.save, { desc = 'save session' })
  -- vim.keymap.set('n', '<leader>sp', persistence.load, { desc = 'load session from pwd' })
  vim.keymap.set('n', '<leader>sv', persistence.select, { desc = 'select session to load' })
  vim.keymap.set('n', '<leader>sd', persistence.stop, { desc = 'do not save session on exit' })
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
  vim.keymap.set('n', '<leader>hr', function()
    harpoon:list():remove()
  end, { desc = 'harpoon remove' })
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

-- function M.setup_treesitter_keymaps()
--   -- There are additional nvim-treesitter modules that you can use to interact
--   -- with nvim-treesitter. You should go explore a few and see what interests you:
--   --
--   --  - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--   --  - Show the current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--   --  - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--   vim.keymap.set('n', '<leader>it', '<cmd>InspectTree<cr>', { desc = '[I]nspect [T]ree' })
-- end

return M
