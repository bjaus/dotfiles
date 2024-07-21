return {
  "nvimtools/none-ls.nvim",
  config = function()
    local lsp_formatting = function(bufnr)
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == "null-ls"
        end,
        bufnr = bufnr,
      })
    end

    -- if you want to set up formatting on save, you can use this as a callback
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- add to your shared on_attach callback
    local on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end,
        })
      end
    end

    local ls = require("null-ls")

    ls.setup({
      on_attach = on_attach,
      -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
      sources = {
        -- code actions
        ls.builtins.code_actions.gitsigns,
        ls.builtins.code_actions.gomodifytags,
        ls.builtins.code_actions.impl,
        ls.builtins.code_actions.refactoring,

        -- completion
        ls.builtins.completion.luasnip,
        ls.builtins.completion.spell,
        ls.builtins.completion.tags,
        ls.builtins.completion.vsnip,

        -- diagnostics
        -- ls.builtins.diagnostics.actionlint,
        -- ls.builtins.diagnostics.alex,
        -- ls.builtins.diagnostics.buf,
        -- ls.builtins.diagnostics.buildifier,
        -- ls.builtins.diagnostics.cfn_lint,
        -- ls.builtins.diagnostics.checkmake,
        -- ls.builtins.diagnostics.cmake_lint,
        -- ls.builtins.diagnostics.codespell,
        -- ls.builtins.diagnostics.commitlint,
        -- ls.builtins.diagnostics.djlint,
        -- ls.builtins.diagnostics.dotenv_linter,
        -- ls.builtins.diagnostics.erb_lint,
        -- ls.builtins.diagnostics.gitlint,
        -- ls.builtins.diagnostics.hadolint,
        -- ls.builtins.diagnostics.ltrs,
        -- ls.builtins.diagnostics.markdownlint,
        -- ls.builtins.diagnostics.markdownlint_cli2,
        -- ls.builtins.diagnostics.markuplint,
        -- ls.builtins.diagnostics.mdl,
        -- ls.builtins.diagnostics.mypy,
        -- ls.builtins.diagnostics.phpstan,
        -- ls.builtins.diagnostics.protolint,
        -- ls.builtins.diagnostics.pylint,
        -- ls.builtins.diagnostics.revive,
        -- ls.builtins.diagnostics.rstcheck,
        -- ls.builtins.diagnostics.selene,
        -- ls.builtins.diagnostics.semgrep,
        -- ls.builtins.diagnostics.spectral,
        -- ls.builtins.diagnostics.sqlfluff,
        -- ls.builtins.diagnostics.staticcheck,
        -- ls.builtins.diagnostics.stylelint,
        -- ls.builtins.diagnostics.swiftlint,
        -- ls.builtins.diagnostics.terraform_validate,
        -- ls.builtins.diagnostics.textlint,
        -- ls.builtins.diagnostics.tfsec,
        -- ls.builtins.diagnostics.tidy,
        -- ls.builtins.diagnostics.trail_space,
        -- ls.builtins.diagnostics.trivy,
        -- ls.builtins.diagnostics.vacuum,
        -- ls.builtins.diagnostics.vint,
        -- ls.builtins.diagnostics.yamllint,
        -- ls.builtins.diagnostics.zsh,
        ls.builtins.diagnostics.golangci_lint,
        ls.builtins.diagnostics.todo_comments,

        -- formatting
        -- ls.builtins.formatting.biome,
        -- ls.builtins.formatting.blackd,
        -- ls.builtins.formatting.buf,
        -- ls.builtins.formatting.buildifier,
        -- ls.builtins.formatting.cmake_format,
        -- ls.builtins.formatting.codespell,
        -- ls.builtins.formatting.djhtml,
        -- ls.builtins.formatting.djlint,
        -- ls.builtins.formatting.dxfmt,
        -- ls.builtins.formatting.gersemi,
        -- ls.builtins.formatting.gofumpt,
        -- ls.builtins.formatting.goimports,
        -- ls.builtins.formatting.isortd,
        -- ls.builtins.formatting.markdownlint,
        -- ls.builtins.formatting.mdformat,
        -- ls.builtins.formatting.nginx_beautifier,
        -- ls.builtins.formatting.ocdc,
        -- ls.builtins.formatting.opentofu_fmt,
        -- ls.builtins.formatting.pg_format,
        -- ls.builtins.formatting.pint,
        -- ls.builtins.formatting.prettier,
        -- ls.builtins.formatting.prettierd,
        -- ls.builtins.formatting.pretty_php,
        -- ls.builtins.formatting.protolint,
        -- ls.builtins.formatting.pyink,
        -- ls.builtins.formatting.remark,
        -- ls.builtins.formatting.rustywind,
        -- ls.builtins.formatting.scalafmt,
        -- ls.builtins.formatting.shellharden,
        -- ls.builtins.formatting.shfmt,
        -- ls.builtins.formatting.sqlfluff,
        -- ls.builtins.formatting.sqlfmt,
        -- ls.builtins.formatting.sqlformat,
        -- ls.builtins.formatting.stylelint,
        -- ls.builtins.formatting.swift_format,
        -- ls.builtins.formatting.swiftformat,
        -- ls.builtins.formatting.swiftlint,
        -- ls.builtins.formatting.terraform_fmt,
        -- ls.builtins.formatting.textlint,
        -- ls.builtins.formatting.tidy,
        -- ls.builtins.formatting.treefmt,
        -- ls.builtins.formatting.usort,
        -- ls.builtins.formatting.yamlfix,
        -- ls.builtins.formatting.yamlfmt,
        -- ls.builtins.formatting.yapf,
        ls.builtins.formatting.black,
        ls.builtins.formatting.gofmt,
        ls.builtins.formatting.goimports_reviser,
        ls.builtins.formatting.golines,
        ls.builtins.formatting.isort,
        ls.builtins.formatting.stylua,

        -- hover
        ls.builtins.hover.dictionary,
        ls.builtins.hover.printenv,
      },
    })
  end,
}
