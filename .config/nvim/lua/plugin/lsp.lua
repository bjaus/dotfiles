return {
  {
    'ray-x/lsp_signature.nvim',
    enabled = true,
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
  {
    -- LSP Configuration & Plugins
    -- https://github.com/neovim/nvim-lspconfig
    -- :checkhealth lsp
    'neovim/nvim-lspconfig',
    enabled = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSP.
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
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          require('config.keymaps').setup_lsp(event)
          require('config.autocmds').setup_lsp_highlight(event)
        end,
      })

      local lspconfig = require 'lspconfig'
      local configs = require 'lspconfig/configs'

      -- Ensure `templ` files are recognized
      vim.cmd [[
      autocmd BufRead,BufNewFile *.templ set filetype=templ
    ]]

      -- https://github.com/nametake/golangci-lint-langserver?tab=readme-ov-file#configuration-for-nvim-lspconfig
      if not configs.golangcilsp then
        configs.golangcilsp = {
          default_config = {
            cmd = { 'golangci-lint-langserver' },
            root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
            init_options = {
              command = {
                'golangci-lint',
                'run',
                '--enable-all',
                '--disable',
                'lll',
                '--out-format',
                'json',
                '--issues-exit-code=1',
              },
            },
          },
        }
      end

      -- LSP servers and clients are able to communicate to each other what features they support.
      -- So, create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        golangci_lint_ls = { auto_update = true },
        gopls = { auto_update = true },
        bufls = {
          auto_update = true,
          filetypes = { 'proto' },
          cmd = { 'bufls', 'serve' },
          root_dir = lspconfig.util.root_pattern('buf.work.yaml', 'buf.yaml', '.git'),
        },
        serve = { auto_update = true, filetypes = { 'proto' } },
        pyright = { auto_update = true },
        rust_analyzer = { auto_update = true },
        intelephense = { auto_update = true },
        cmake = { auto_update = true },
        templ = { auto_update = true },
        emmet_ls = {
          auto_update = true,
          filetypes = { 'html', 'css', 'templ' },
        },
        html = {
          auto_update = true,
          filetypes = { 'html', 'templ' },
        },
        htmx = {
          auto_update = true,
          filetypes = { 'html', 'templ' },
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
          auto_update = true,
          settings = {
            yaml = {
              format = {
                enable = true,
              },
              hover = true,
              completion = true,
              customTags = {
                '!And sequence',
                '!And',
                '!Base64',
                '!Cidr',
                '!Condition sequence',
                '!Condition',
                '!Equals sequence',
                '!Equals',
                '!FindInMap sequence',
                '!fn',
                '!GetAtt sequence',
                '!GetAtt',
                '!GetAZs',
                '!If sequence',
                '!If',
                '!ImportValue sequence',
                '!ImportValue',
                '!Join sequence',
                '!Not sequence',
                '!Not',
                '!Or sequence',
                '!Or',
                '!Ref Scalar',
                '!Ref sequence',
                '!Ref',
                '!Select sequence',
                '!Select',
                '!Split sequence',
                '!Split',
                '!Sub sequence',
                '!Sub',
              },
            },
          },
        },
        -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
        ts_ls = {},
        svelte = {},

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- Toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
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

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- { 'goimports',         auto_update = true },
        { 'goimports-reviser', auto_update = true },
        { 'delve', auto_update = true },
        { 'stylua', auto_update = true }, -- Used to format Lua code
      })
      require('mason-tool-installer').setup {
        run_on_start = true,
        debounce_hours = 4,
        ensure_installed = ensure_installed,
      }

      require('mason-lspconfig').setup {
        auto_install = true,
        ensure_installed = {
          'golangci_lint_ls',
          'gopls',
          'pyright',
          'yamlls',
          'intelephense',
        },
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            lspconfig[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
