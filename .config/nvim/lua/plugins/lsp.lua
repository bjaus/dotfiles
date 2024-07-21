return {
  {
    "williamboman/mason.nvim",
    enabled = true,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lsp = require("mason-lspconfig")
      local mason_tool = require("mason-tool-installer")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lsp.setup({
        auto_install = true,
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
          "volar",
          "vuels",
          "yamlls",
        },
      })

      mason_tool.setup({
        run_on_start = true,
        debounce_hours = 12,
        ensure_installed = {
          { "gofumpt", auto_update = false },
          { "goimports-reviser", auto_update = false },
          { "golangcilint", auto_update = false },
          { "golines", auto_update = false },
          { "gomodifytags", auto_update = false },
          { "gotests", auto_update = false },
          { "semgrep", auto_update = false },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    event = { "BufReadPre", "BufNewFile", },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {
        "antosha417/nvim-lsp-file-operations",
        config = true,
      },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
      },
    },
    config = function()
      local lspconf = require("lspconfig")
      local mason_lsp = require("mason-lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      mason_lsp.setup_handlers({
        function(server_name)
          lspconf[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["svelte"] = function()
          lspconf.svelte.setup({
            capabilities = capabilities,
            on_attach = function(client)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
            end,
          })
        end,
        ["emmet_ls"] = function()
          lspconf["emmet_ls"].setup({
            capabilities = capabilities,
            filetypes = {
              "css",
              "html",
              "javascriptreact",
              "less",
              "sass",
              "scss",
              "svelte",
              "typescriptreact",
            },
          })
        end,
        ["lua_ls"] = function()
          lspconf["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                  globals = {
                    "vim",
                  },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = {
            silent = true,
            buffer = ev.buf,
          }

          opts.desc = "Show LSP references"
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)

          opts.desc = "Go to declaration"
          vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)

          opts.desc = "Show LSP definitions"
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)

          opts.desc = "Go to implementation"
          vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)

          opts.desc = "Show LSP type definitions"
          vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts)

          opts.desc = "See available code actions"
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

          opts.desc = "Smart rename"
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

          opts.desc = "Show buffer diagnostics"
          vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

          opts.desc = "Show line diagnostics"
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

          opts.desc = "Go to previous diagnostic"
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

          opts.desc = "Go to next diagnostic"
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

          opts.desc = "Run formatter(s)"
          vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)

          opts.desc = "Show documentation"
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

          opts.desc = "Restart LSP"
          vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end,
      })

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
  },
}
