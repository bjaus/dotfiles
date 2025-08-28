return {
  -- Table of Contents for markdown
  {
    "richardbizik/nvim-toc",
    ft = "markdown",
    config = function()
      require("nvim-toc").setup({
        toc_header = "## Table of Contents",
      })
    end,
    keys = {
      { "<leader>mt", "<cmd>TOC<cr>", desc = "Generate/Update TOC" },
    },
  },

  -- Markdown preview with live updates
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
    },
    config = function()
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_theme = 'dark'
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_browser = ''  -- Use default browser
    end,
  },

  -- Floating table of contents window
  {
    "nvim-telekasten/telekasten.nvim",
    enabled = false,  -- Disabled by default, enable if you want full wiki features
    dependencies = { "nvim-telescope/telescope.nvim" },
  },

  -- Better markdown navigation with outline
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>mo", "<cmd>Outline<CR>", desc = "Toggle Markdown Outline" },
    },
    config = function()
      require("outline").setup({
        outline_window = {
          position = 'right',
          width = 25,
          relative_width = true,
          auto_close = false,
          show_numbers = false,
          show_relative_numbers = false,
        },
        outline_items = {
          show_symbol_details = true,
          show_symbol_lineno = false,
        },
        symbol_folding = {
          autofold_depth = 1,
        },
        preview_window = {
          auto_preview = true,
          open_hover_on_preview = true,
        },
      })
    end,
  },

  -- Markdown specific text objects and commands
  {
    "preservim/vim-markdown",
    ft = "markdown",
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_toc_autofit = 1
      vim.g.vim_markdown_follow_anchor = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_json_frontmatter = 1
      vim.g.vim_markdown_strikethrough = 1
      vim.g.vim_markdown_new_list_item_indent = 2
    end,
    keys = {
      { "]]", "<Plug>Markdown_MoveToNextHeader", ft = "markdown", desc = "Next Header" },
      { "[[", "<Plug>Markdown_MoveToPreviousHeader", ft = "markdown", desc = "Previous Header" },
      { "][", "<Plug>Markdown_MoveToNextSiblingHeader", ft = "markdown", desc = "Next Sibling Header" },
      { "[]", "<Plug>Markdown_MoveToPreviousSiblingHeader", ft = "markdown", desc = "Previous Sibling Header" },
      { "]u", "<Plug>Markdown_MoveToParentHeader", ft = "markdown", desc = "Parent Header" },
      { "ge", "<Plug>Markdown_EditUrlUnderCursor", ft = "markdown", desc = "Edit Link Under Cursor" },
    },
  },

  -- Bullets and checkboxes
  {
    "bullets-vim/bullets.vim",
    ft = { "markdown", "text" },
    config = function()
      vim.g.bullets_enabled_file_types = { "markdown", "text" }
      vim.g.bullets_set_mappings = 1
      vim.g.bullets_checkbox_markers = ' .oOx'
    end,
  },

  -- Table mode for markdown tables
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
    config = function()
      vim.g.table_mode_corner = "|"
      vim.g.table_mode_header_fillchar = "-"
    end,
    keys = {
      { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle Table Mode" },
      { "<leader>tr", "<cmd>TableModeRealign<cr>", desc = "Realign Table" },
    },
  },

  -- Markdown concealing for better readability
  {
    "preservim/vim-markdown",
    ft = "markdown",
    config = function()
      vim.opt.conceallevel = 2
      vim.g.vim_markdown_conceal = 1
      vim.g.vim_markdown_conceal_code_blocks = 0
    end,
  },

  -- Floating TOC window (alternative)
  {
    "AntonVanAssche/md-headers.nvim",
    lazy = false,
    version = "*",
    ft = "markdown",
    config = function()
      require("md-headers").setup({
        popup = {
          width = 60,
          height = 20,
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        toc = {
          indent_size = 2,
          indent_char = " ",
          marker = "-",
        },
      })
    end,
    keys = {
      { "<leader>mh", "<cmd>MarkdownHeaders<cr>", desc = "Show Markdown Headers" },
      { "<leader>mt", "<cmd>MarkdownHeadersClosest<cr>", desc = "Jump to Closest Header" },
    },
  },
}