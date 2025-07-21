return {
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      { 'Bilal2453/luvit-meta', lazy = true },
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
    },

    config = function()
      local lspconfig = require 'lspconfig'
      local util = require 'lspconfig.util'

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          require('config.keymaps').setup_lsp(event)
          require('config.autocmds').setup_lsp_highlight(event)
        end,
      })

      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = '*.templ',
        callback = function()
          vim.bo.filetype = 'templ'
        end,
      })

      -- Custom LSP: golangci-lint-langserver
      -- vim.schedule(function()
      --   if not lspconfig.golangcilsp then
      --     require('lspconfig.configs').golangcilsp = {
      --       default_config = {
      --         cmd = { 'golangci-lint-langserver' },
      --         root_dir = util.root_pattern('.git', 'go.mod'),
      --         init_options = {
      --           command = {
      --             'golangci-lint',
      --             'run',
      --             '--out-format',
      --             'json',
      --             '--issues-exit-code=1',
      --           },
      --         },
      --       },
      --     }
      --   end
      -- end)

      -- Capabilities (e.g. for cmp)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Server configurations
      local servers = {
        gopls = {},
        pyright = {},
        rust_analyzer = {},
        intelephense = {},
        buf_ls = { filetypes = { 'proto' } },
        cmake = {},
        templ = {},
        emmet_ls = { filetypes = { 'html', 'css', 'templ' } },
        html = { filetypes = { 'html', 'templ' } },
        htmx = { filetypes = { 'html', 'templ' } },
        svelte = {},
        vtsls = {
          filetypes = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'vue',
          },
          settings = {
            vtsls = {
              enableVueSupport = true,
              takeOverMode = true,
            },
          },
        },
        -- vtsls = {
        --   filetypes = {
        --     'javascript',
        --     'javascriptreact',
        --     'typescript',
        --     'typescriptreact',
        --     'vue',
        --   },
        --   settings = {
        --     vtsls = {
        --       enableVueSupport = true,
        --     },
        --   },
        --   init_options = {
        --     languageFeatures = {
        --       references = true,
        --       definition = true,
        --       typeDefinition = true,
        --       callHierarchy = true,
        --       hover = true,
        --       rename = true,
        --       signatureHelp = true,
        --       codeAction = true,
        --       completion = {
        --         defaultTagNameCase = 'both',
        --         defaultAttrNameCase = 'kebabCase',
        --         getDocumentNameCasesRequest = true,
        --         getDocumentSelectionRequest = true,
        --       },
        --       schemaRequestService = true,
        --       documentHighlight = true,
        --       documentLink = true,
        --       codeLens = {
        --         showReferencesNotification = true,
        --       },
        --       semanticTokens = true,
        --     },
        --     vue = {
        --       features = {
        --         documentHighlight = true,
        --         documentLink = true,
        --         codeLens = { references = true, pugTools = true },
        --         codeActions = true,
        --         callHierarchy = true,
        --         rename = true,
        --         semanticTokens = true,
        --         diagnostics = true,
        --         completion = {
        --           defaultAttrNameCase = 'kebabCase',
        --           defaultTagNameCase = 'both',
        --         },
        --       },
        --     },
        --   },
        -- },
        --
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              -- diagnostics = { disable = { "missing-fields" } },
            },
          },
        },

        tailwindcss = {
          filetypes = { 'templ', 'astro', 'javascript', 'typescript', 'react' },
          settings = {
            tailwindCSS = {
              includeLanguages = {
                templ = 'html',
              },
            },
          },
        },

        yamlls = {
          settings = {
            yaml = {
              format = { enable = true },
              hover = true,
              completion = true,
              customTags = {
                '!And sequence',
                '!Base64',
                '!Cidr',
                '!Condition sequence',
                '!Equals sequence',
                '!FindInMap sequence',
                '!GetAtt sequence',
                '!GetAtt',
                '!GetAZs',
                '!If sequence',
                '!ImportValue sequence',
                '!Join sequence',
                '!Not sequence',
                '!Or sequence',
                '!Ref sequence',
                '!Ref',
                '!Select sequence',
                '!Split sequence',
                '!Sub sequence',
                '!Sub',
              },
            },
          },
        },
      }

      -- Install LSPs via mason-lspconfig
      local ensure_lsp_servers = vim.tbl_keys(servers)

      -- Extra non-LSP tools
      local ensure_tools = {
        'goimports-reviser',
        'delve',
        'stylua',
      }

      require('mason').setup {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }

      require('mason-tool-installer').setup {
        ensure_installed = vim.list_extend(vim.deepcopy(ensure_lsp_servers), ensure_tools),
        run_on_start = true,
        debounce_hours = 4,
      }

      require('mason-lspconfig').setup {
        auto_install = true,
        ensure_installed = ensure_lsp_servers,
        handlers = {
          function(server_name)
            local server_opts = servers[server_name] or {}
            server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
            lspconfig[server_name].setup(server_opts)
          end,
        },
      }
    end,
  },
}
