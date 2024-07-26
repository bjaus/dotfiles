M = {}

-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt` and/or `:help option-list`

-- skip startup screen
vim.opt.shortmess:append 'I'

-- 24-bit color
vim.opt.termguicolors = true

-- fillchars
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

-- save undo history
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 250 -- save swap file and trigger CursorHold

-- lines numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- set table and indent defaults (can be overrideen by per-language configs)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- case-insensitive searching unless \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- incremental search
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- text wrap
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 120

-- format options
vim.opt.formatoptions = '1cjnpqr'

-- enable mouse support in all modes
vim.opt.mouse = 'a'

-- see keys pressed
vim.opt.showcmd = true

-- don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- sync clipboard between OS and Neovim
--  see `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- enable break indent
vim.opt.breakindent = true

-- keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- decrease mapped sequence wait time
-- displays which-key popup sooner
vim.opt.timeoutlen = 300

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- sets how neovim will display certain whitespace characters in the editor
--  see `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }

-- preview substitutions live
vim.opt.inccommand = 'split'

-- show which line the cursor is on
vim.opt.cursorline = true

-- minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8

vim.opt.smoothscroll = true

if not vim.g.vscode then
  vim.opt.timeoutlen = 300 -- lower than default (1000) to quickly trigger which-key
end

M.setup_folding_options = function()
  vim.opt.foldcolumn = '0'
  vim.opt.foldlevel = 99
  vim.opt.foldlevelstart = 99
  vim.opt.foldenable = true
end

return M
