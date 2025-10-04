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
          
          -- Enable inlay hints if supported
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          end
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
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
              usePlaceholders = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              semanticTokens = true,
            },
          },
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
        dartls = {
          settings = {
            dart = {
              analysisExcludedFolders = {
                vim.fn.expand('$HOME/.pub-cache'),
                vim.fn.expand('$HOME/flutter'),
              },
              updateImportsOnRename = true,
              completeFunctionCalls = true,
              showTodos = true,
              enableSnippets = true,
              lineLength = 120,
            },
          },
        },
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
        eslint = {
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
          settings = {
            workingDirectory = { mode = 'auto' },
            codeAction = {
              disableRuleComment = {
                enable = true,
                location = 'separateLine',
              },
              showDocumentation = {
                enable = true,
              },
            },
          },
        },
        vtsls = {
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
          settings = {
            vtsls = {
              enableVueSupport = false,
              takeOverMode = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                  entriesLimit = 75,
                },
              },
            },
            typescript = {
              suggest = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                includeAutomaticOptionalChainCompletions = true,
              },
              preferences = {
                importModuleSpecifier = 'relative',
                includePackageJsonAutoImports = 'auto',
                jsxAttributeCompletionStyle = 'auto',
                allowTextChangesInNewFiles = true,
                allowRenameOfImportPath = true,
              },
              format = {
                enable = true,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
                semicolons = 'insert',
              },
              inlayHints = {
                includeInlayParameterNameHints = 'literals',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              suggest = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                includeAutomaticOptionalChainCompletions = true,
              },
              preferences = {
                importModuleSpecifier = 'relative',
                includePackageJsonAutoImports = 'auto',
                jsxAttributeCompletionStyle = 'auto',
                allowTextChangesInNewFiles = true,
                allowRenameOfImportPath = true,
              },
              format = {
                enable = true,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
                semicolons = 'insert',
              },
              inlayHints = {
                includeInlayParameterNameHints = 'literals',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              -- diagnostics = { disable = { "missing-fields" } },
            },
          },
        },

        tailwindcss = {
          filetypes = {
            'templ',
            'astro',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'html',
            'css',
            'scss',
            'sass',
          },
          settings = {
            tailwindCSS = {
              includeLanguages = {
                templ = 'html',
                javascriptreact = 'javascript',
                typescriptreact = 'javascript',
              },
              experimental = {
                classRegex = {
                  -- Support for clsx, classnames, tw
                  { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "classnames\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "tw`([^`]*)`" },
                  { "tw=\"([^\"]*)\"" },
                  { "tw={'([^'}]*)'}" },
                  -- React Native styled-components
                  { "styled\\.[a-z]+`([^`]*)`" },
                  { "styled\\(.*\\)`([^`]*)`" },
                },
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
              validate = true,
              schemaStore = {
                enable = true,
                url = 'https://www.schemastore.org/api/json/catalog.json',
              },
              schemas = {
                ['https://raw.githubusercontent.com/awslabs/goformation/main/schema/cloudformation.schema.json'] = {
                  'template.yaml',
                  'template.yml',
                  'cloudformation.yaml',
                  'cloudformation.yml',
                  'cfn-template.yaml',
                  'cfn-template.yml',
                  '**/cloudformation/**/*.yaml',
                  '**/cloudformation/**/*.yml',
                  '**/cfn/**/*.yaml',
                  '**/cfn/**/*.yml',
                  '**/templates/**/*.yaml',
                  '**/templates/**/*.yml',
                  '**/infrastructure/**/*.yaml',
                  '**/infrastructure/**/*.yml',
                  '**/*-stack.yaml',
                  '**/*-stack.yml',
                  '**/*.cfn.yaml',
                  '**/*.cfn.yml',
                },
                kubernetes = '*.k8s.yaml',
                ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
                ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
                ['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
                ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
                ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
                ['http://json.schemastore.org/ansible-playbook'] = '**/playbooks/**/*.{yml,yaml}',
                ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
                ['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
                ['https://json.schemastore.org/gitlab-ci'] = '*gitlab-ci*.{yml,yaml}',
                ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] = '**/openapi/**/*.{yml,yaml}',
              },
              customTags = {
                '!And sequence',
                '!And scalar',
                '!Base64',
                '!Base64 scalar',
                '!Cidr',
                '!Cidr sequence',
                '!Condition sequence',
                '!Condition scalar',
                '!Equals sequence',
                '!Equals scalar',
                '!FindInMap sequence',
                '!FindInMap scalar',
                '!GetAtt sequence',
                '!GetAtt scalar',
                '!GetAtt',
                '!GetAZs',
                '!GetAZs scalar',
                '!If sequence',
                '!If scalar',
                '!ImportValue sequence',
                '!ImportValue scalar',
                '!ImportValue',
                '!Join sequence',
                '!Join scalar',
                '!Not sequence',
                '!Not scalar',
                '!Or sequence',
                '!Or scalar',
                '!Ref sequence',
                '!Ref scalar',
                '!Ref',
                '!Select sequence',
                '!Select scalar',
                '!Split sequence',
                '!Split scalar',
                '!Sub sequence',
                '!Sub scalar',
                '!Sub',
                '!Transform sequence',
                '!Transform scalar',
              },
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = {
                {
                  fileMatch = { '**/template.json', '**/cloudformation.json', '**/*.cfn.json' },
                  url = 'https://raw.githubusercontent.com/awslabs/goformation/main/schema/cloudformation.schema.json',
                },
              },
              validate = { enable = true },
            },
          },
        },
        taplo = {
          keys = {
            {
              'K',
              function()
                if vim.fn.expand '%:t' == 'Cargo.toml' and require('crates').popup_available() then
                  require('crates').show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = 'Show Crate Documentation',
            },
          },
        },
      }

      -- Install LSPs via mason-lspconfig
      local ensure_lsp_servers = vim.tbl_keys(servers)

      -- Extra non-LSP tools
      local ensure_tools = {
        'goimports-reviser',
        'goimports',
        'delve',  -- Go debugger for DAP
        'stylua',
        'prettier',
        'eslint_d',
        'ruff',
        'mypy',
        'yamllint',
        'jsonlint',
        'cfn-lint',
        'taplo',
        'rustfmt',
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
