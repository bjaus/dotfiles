-- NOTE: This file provides additional Flutter/Dart commands that complement flutter-tools.nvim
-- For core LSP and Flutter app running features, see lua/plugin/flutter.lua

local M = {}

-- Flutter build and utility commands (not provided by flutter-tools.nvim)
M.flutter = {

  pub_get = function()
    vim.cmd('TermExec cmd="flutter pub get"')
  end,

  pub_upgrade = function()
    vim.cmd('TermExec cmd="flutter pub upgrade"')
  end,

  clean = function()
    vim.cmd('TermExec cmd="flutter clean"')
  end,

  build_apk = function()
    vim.cmd('TermExec cmd="flutter build apk"')
  end,

  build_appbundle = function()
    vim.cmd('TermExec cmd="flutter build appbundle"')
  end,

  build_ios = function()
    vim.cmd('TermExec cmd="flutter build ios"')
  end,

  build_web = function()
    vim.cmd('TermExec cmd="flutter build web"')
  end,

  analyze = function()
    vim.cmd('TermExec cmd="flutter analyze"')
  end,

  test = function()
    vim.cmd('TermExec cmd="flutter test"')
  end,

  test_file = function()
    local file = vim.fn.expand('%:p')
    vim.cmd('TermExec cmd="flutter test ' .. file .. '"')
  end,

  doctor = function()
    vim.cmd('TermExec cmd="flutter doctor"')
  end,
}

-- Dart commands
M.dart = {
  fix = function()
    vim.cmd('TermExec cmd="dart fix --apply"')
  end,

  format = function()
    vim.cmd('TermExec cmd="dart format ."')
  end,

  analyze = function()
    vim.cmd('TermExec cmd="dart analyze"')
  end,

  pub_get = function()
    vim.cmd('TermExec cmd="dart pub get"')
  end,

  test = function()
    vim.cmd('TermExec cmd="dart test"')
  end,
}

-- Setup function
function M.setup()
  -- Create user commands for Flutter build/utility commands
  -- Note: Core Flutter commands (run, reload, etc.) are provided by flutter-tools.nvim
  vim.api.nvim_create_user_command('FlutterPubGet', M.flutter.pub_get, {})
  vim.api.nvim_create_user_command('FlutterPubUpgrade', M.flutter.pub_upgrade, {})
  vim.api.nvim_create_user_command('FlutterClean', M.flutter.clean, {})
  vim.api.nvim_create_user_command('FlutterBuildApk', M.flutter.build_apk, {})
  vim.api.nvim_create_user_command('FlutterBuildAppbundle', M.flutter.build_appbundle, {})
  vim.api.nvim_create_user_command('FlutterBuildIos', M.flutter.build_ios, {})
  vim.api.nvim_create_user_command('FlutterBuildWeb', M.flutter.build_web, {})
  vim.api.nvim_create_user_command('FlutterAnalyze', M.flutter.analyze, {})
  vim.api.nvim_create_user_command('FlutterTest', M.flutter.test, {})
  vim.api.nvim_create_user_command('FlutterTestFile', M.flutter.test_file, {})
  vim.api.nvim_create_user_command('FlutterDoctor', M.flutter.doctor, {})

  -- Create user commands for Dart
  vim.api.nvim_create_user_command('DartFix', M.dart.fix, {})
  vim.api.nvim_create_user_command('DartFormat', M.dart.format, {})
  vim.api.nvim_create_user_command('DartAnalyze', M.dart.analyze, {})
  vim.api.nvim_create_user_command('DartPubGet', M.dart.pub_get, {})
  vim.api.nvim_create_user_command('DartTest', M.dart.test, {})

  -- Keymaps for Flutter/Dart files (build and utility commands)
  -- Note: Core Flutter keymaps (run, reload, etc.) are set in lua/plugin/flutter.lua
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'dart',
    callback = function()
      local opts = { buffer = true, silent = true }

      -- Flutter build and utility keymaps (using <leader>F*)
      vim.keymap.set('n', '<leader>Fp', M.flutter.pub_get, vim.tbl_extend('force', opts, { desc = '[F]lutter [p]ub Get' }))
      vim.keymap.set('n', '<leader>FP', M.flutter.pub_upgrade, vim.tbl_extend('force', opts, { desc = '[F]lutter [P]ub Upgrade' }))
      vim.keymap.set('n', '<leader>Fc', M.flutter.clean, vim.tbl_extend('force', opts, { desc = '[F]lutter [c]lean' }))
      vim.keymap.set('n', '<leader>Fb', M.flutter.build_apk, vim.tbl_extend('force', opts, { desc = '[F]lutter [b]uild APK' }))
      vim.keymap.set('n', '<leader>Fa', M.flutter.analyze, vim.tbl_extend('force', opts, { desc = '[F]lutter [a]nalyze' }))
      vim.keymap.set('n', '<leader>Ft', M.flutter.test, vim.tbl_extend('force', opts, { desc = '[F]lutter [t]est' }))
      vim.keymap.set('n', '<leader>FT', M.flutter.test_file, vim.tbl_extend('force', opts, { desc = '[F]lutter [T]est File' }))

      -- Dart keymaps (using <leader>D*)
      vim.keymap.set('n', '<leader>Df', M.dart.fix, vim.tbl_extend('force', opts, { desc = '[D]art [f]ix' }))
      vim.keymap.set('n', '<leader>DF', M.dart.format, vim.tbl_extend('force', opts, { desc = '[D]art [F]ormat' }))
      vim.keymap.set('n', '<leader>Da', M.dart.analyze, vim.tbl_extend('force', opts, { desc = '[D]art [a]nalyze' }))
      vim.keymap.set('n', '<leader>Dp', M.dart.pub_get, vim.tbl_extend('force', opts, { desc = '[D]art [p]ub Get' }))
      vim.keymap.set('n', '<leader>Dt', M.dart.test, vim.tbl_extend('force', opts, { desc = '[D]art [t]est' }))
    end,
  })
end

-- Call setup when this file is loaded
M.setup()

-- Return empty table for Lazy.nvim (this file is imported as a plugin spec)
return {}
