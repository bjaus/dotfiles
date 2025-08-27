return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require("oil")
      
      -- Custom yank function for oil buffers
      local function oil_yank()
        local mode = vim.fn.mode()
        
        if mode == 'v' or mode == 'V' or mode == '' then
          -- Visual mode - get selected range
          local start_line = vim.fn.line("v")
          local end_line = vim.fn.line(".")
          
          -- Ensure start is before end
          if start_line > end_line then
            start_line, end_line = end_line, start_line
          end
          
          local filenames = {}
          for line = start_line, end_line do
            local entry = oil.get_entry_on_line(0, line)
            if entry and entry.name then
              table.insert(filenames, entry.name)
            end
          end
          
          if #filenames > 0 then
            local text = table.concat(filenames, "\n")
            vim.fn.setreg('+', text)
            vim.fn.setreg('"', text)
            vim.cmd('normal! ')  -- Exit visual mode
            vim.notify("Copied " .. #filenames .. " filename(s)")
          end
        else
          -- Normal mode - yank current line
          local entry = oil.get_entry_on_line(0, vim.fn.line('.'))
          if entry and entry.name then
            vim.fn.setreg('+', entry.name)
            vim.fn.setreg('"', entry.name)
            vim.notify("Copied: " .. entry.name)
          end
        end
      end
      
      oil.setup({
        -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
        default_file_explorer = true,
        -- Id is automatically added at the beginning, and name at the end
        columns = {
          "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },
        -- Buffer-local options to use for oil buffers
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        -- Window-local options to use for oil buffers
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "nvic",
        },
        -- Send deleted files to the trash instead of permanently deleting them
        delete_to_trash = true,
        -- Skip the confirmation popup for simple operations
        skip_confirm_for_simple_edits = false,
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        prompt_save_on_select_new_entry = true,
        -- Oil will automatically delete hidden buffers after this delay
        cleanup_delay_ms = 2000,
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = false, -- Disable to preserve visual block mode
          ["gv"] = "actions.select_vsplit", -- Use gv for vertical split
          ["<C-h>"] = false, -- Disable to preserve navigation
          ["gh"] = "actions.select_split", -- Use gh for horizontal split
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
        -- Set to false to disable all of the above keymaps
        use_default_keymaps = true,
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = false,
          -- This function defines what is considered a "hidden" file
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, bufnr)
            return name == ".." or name == ".git"
          end,
          sort = {
            -- sort order can be "asc" or "desc"
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        -- Configuration for the floating window in oil.open_float
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          override = function(conf)
            return conf
          end,
        },
        -- Configuration for the actions floating preview window
        preview = {
          -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_width and max_width can be a single value or a list of mixed integer/float types.
          -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
          max_width = 0.9,
          -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
          min_width = { 40, 0.4 },
          -- optionally define an integer/float for the exact width of the preview window
          width = nil,
          -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_height and max_height can be a single value or a list of mixed integer/float types.
          -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
          max_height = 0.9,
          -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
          min_height = { 5, 0.1 },
          -- optionally define an integer/float for the exact height of the preview window
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        -- Configuration for the floating progress window
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
        },
      })
      
      -- Set up yank keybinding for oil buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.keymap.set({"n", "v"}, "y", oil_yank, { buffer = true, desc = "Yank filename(s) to clipboard" })
        end,
      })
    end,
    -- Open parent directory in current window
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
      { "<leader>-", function() require("oil").toggle_float() end, desc = "Open parent directory in float" },
    },
  },
}
