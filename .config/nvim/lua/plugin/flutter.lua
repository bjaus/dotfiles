return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    require('flutter-tools').setup {
      ui = {
        border = 'rounded',
        notification_style = 'nvim-notify',
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = true,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
        register_configurations = function(_)
          require('dap').configurations.dart = {}
          require('dap.ext.vscode').load_launchjs()
        end,
      },
      flutter_path = nil, -- Auto-detect from PATH
      flutter_lookup_cmd = 'which flutter',
      fvm = false, -- Set to true if using Flutter Version Management
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = 'Comment',
        prefix = '// ',
        enabled = true,
      },
      dev_log = {
        enabled = true,
        notify_errors = false,
        open_cmd = 'tabedit',
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      outline = {
        open_cmd = '30vnew',
        auto_open = false,
      },
      lsp = {
        color = {
          enabled = true,
          background = false,
          background_color = nil,
          foreground = false,
          virtual_text = true,
          virtual_text_str = '■',
        },
        on_attach = function(_, bufnr)
          -- LSP keymaps are handled by the global LspAttach autocmd
          -- in lua/plugin/lsp.lua
        end,
        capabilities = function(config)
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          }
          return capabilities
        end,
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = 'prompt',
          enableSnippets = true,
          updateImportsOnRename = true,
          analysisExcludedFolders = {
            vim.fn.expand('$HOME/.pub-cache'),
            vim.fn.expand('$HOME/flutter'),
          },
          lineLength = 120,
        },
      },
    }

    -- Flutter-tools specific keymaps
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dart',
      callback = function()
        local opts = { buffer = true, silent = true }

        -- Override some Flutter commands with flutter-tools equivalents
        vim.keymap.set('n', '<leader>Fr', '<cmd>FlutterRun<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [r]un' }))
        vim.keymap.set('n', '<leader>Fq', '<cmd>FlutterQuit<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [q]uit' }))
        vim.keymap.set('n', '<leader>Fh', '<cmd>FlutterReload<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [h]ot reload' }))
        vim.keymap.set('n', '<leader>FH', '<cmd>FlutterRestart<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [H]ot restart' }))
        vim.keymap.set('n', '<leader>Fd', '<cmd>FlutterDevices<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [d]evices' }))
        vim.keymap.set('n', '<leader>Fe', '<cmd>FlutterEmulators<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [e]mulators' }))
        vim.keymap.set('n', '<leader>Fo', '<cmd>FlutterOutlineToggle<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [o]utline toggle' }))
        vim.keymap.set('n', '<leader>Fl', '<cmd>FlutterDevTools<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter dev too[l]s' }))
        vim.keymap.set('n', '<leader>FL', '<cmd>FlutterDevToolsActivate<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter dev tools activate' }))
        vim.keymap.set('n', '<leader>Fv', '<cmd>FlutterVisualDebug<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter [v]isual debug' }))
        vim.keymap.set('n', '<leader>Fs', '<cmd>FlutterLspRestart<cr>', vim.tbl_extend('force', opts, { desc = '[F]lutter LSP re[s]tart' }))

        -- Keep custom commands from dart.lua for builds, pub, etc.
        -- These are defined in lua/lang/dart.lua
      end,
    })
  end,
}
