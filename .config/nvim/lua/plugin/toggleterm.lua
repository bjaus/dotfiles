return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
    { "<leader>Tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" },
    { "<leader>Th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle horizontal terminal" },
    { "<leader>Tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Toggle vertical terminal" },
    { "<leader>Tt", "<cmd>ToggleTerm direction=tab<CR>", desc = "Toggle tab terminal" },
    { "<leader>Tl", "<cmd>ToggleTermSendCurrentLine<CR>", desc = "Send current line to terminal" },
    { "<leader>Ts", "<cmd>ToggleTermSendVisualSelection<CR>", mode = "v", desc = "Send selection to terminal" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    winbar = {
      enabled = false,
      name_formatter = function(term)
        return term.name
      end
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    
    -- Terminal keymaps
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end
    
    vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
    
    -- Custom terminals
    local Terminal = require("toggleterm.terminal").Terminal
    
    -- Lazygit terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
      end,
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })
    
    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end
    
    vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", {noremap = true, silent = true, desc = "Toggle Lazygit"})
  end,
}