local M = {}

-- Flutter commands
M.flutter = {
  run = function()
    vim.cmd('TermExec cmd="flutter run"')
  end,

  run_debug = function()
    vim.cmd('TermExec cmd="flutter run --debug"')
  end,

  run_profile = function()
    vim.cmd('TermExec cmd="flutter run --profile"')
  end,

  run_release = function()
    vim.cmd('TermExec cmd="flutter run --release"')
  end,

  hot_reload = function()
    vim.cmd('TermExec cmd="r"')
  end,

  hot_restart = function()
    vim.cmd('TermExec cmd="R"')
  end,

  devices = function()
    vim.cmd('TermExec cmd="flutter devices"')
  end,

  emulators = function()
    vim.cmd('TermExec cmd="flutter emulators"')
  end,

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
  -- Create user commands for Flutter
  vim.api.nvim_create_user_command('FlutterRun', M.flutter.run, {})
  vim.api.nvim_create_user_command('FlutterRunDebug', M.flutter.run_debug, {})
  vim.api.nvim_create_user_command('FlutterRunProfile', M.flutter.run_profile, {})
  vim.api.nvim_create_user_command('FlutterRunRelease', M.flutter.run_release, {})
  vim.api.nvim_create_user_command('FlutterHotReload', M.flutter.hot_reload, {})
  vim.api.nvim_create_user_command('FlutterHotRestart', M.flutter.hot_restart, {})
  vim.api.nvim_create_user_command('FlutterDevices', M.flutter.devices, {})
  vim.api.nvim_create_user_command('FlutterEmulators', M.flutter.emulators, {})
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

  -- Keymaps for Flutter/Dart files
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'dart',
    callback = function()
      local opts = { buffer = true, silent = true }

      -- Flutter keymaps (using <leader>F*)
      vim.keymap.set('n', '<leader>Fr', M.flutter.run, vim.tbl_extend('force', opts, { desc = '[F]lutter [r]un' }))
      vim.keymap.set('n', '<leader>FR', M.flutter.run_release, vim.tbl_extend('force', opts, { desc = '[F]lutter [R]un Release' }))
      vim.keymap.set('n', '<leader>Fh', M.flutter.hot_reload, vim.tbl_extend('force', opts, { desc = '[F]lutter [h]ot Reload' }))
      vim.keymap.set('n', '<leader>FH', M.flutter.hot_restart, vim.tbl_extend('force', opts, { desc = '[F]lutter [H]ot Restart' }))
      vim.keymap.set('n', '<leader>Fd', M.flutter.devices, vim.tbl_extend('force', opts, { desc = '[F]lutter [d]evices' }))
      vim.keymap.set('n', '<leader>Fe', M.flutter.emulators, vim.tbl_extend('force', opts, { desc = '[F]lutter [e]mulators' }))
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

return M
