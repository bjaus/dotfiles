return {
  "williamboman/mason.nvim",
  enabled = false,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
      ensure_installed = {
        "autotools_ls",
        "awk_ls",
        "bashls",
        "cmake",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "emmet_ls",
        "eslint",
        "golangci_lint_ls",
        "gopls",
        "grammarly",
        "graphql",
        "html",
        "jqls",
        "jsonls",
        "lua_ls",
        "marksman",
        "phpactor",
        "prismals",
        "pyright",
        "rust_analyzer",
        "sqlls",
        "svelte",
        "tailwindcss",
        "terraformls",
        "tsserver",
        "vacuum",
        "vuels",
        "yamlls",
        -- "htmx",
        -- "nginx_language_server",
      },
    })

    mason_tool_installer.setup({
      run_on_start = true,
      debounce_hours = 8,
      ensure_installed = {
        { "bash-language-server", auto_update = true },
        { "black", auto_update = true },
        { "cfn-lint", auto_update = true },
        { "eslint_d", auto_update = true },
        { "gofumpt", auto_update = true },
        { "goimports", auto_update = true },
        { "golangcilint", auto_update = true },
        { "golines", auto_update = true },
        { "gomodifytags", auto_update = true },
        { "gotests", auto_update = true },
        { "isort", auto_update = true },
        { "prettier", auto_update = true },
        { "pylint", auto_update = true },
        { "structslop", auto_update = true },
        { "stylua", auto_update = true },
      },
    })
  end,
}
