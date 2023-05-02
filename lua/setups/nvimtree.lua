local M = {}

function M.setup()
  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true

  local whichkey = require "which-key"

  local keymaps = {
    name = "[T]ree",
    t = {
      t = { "<cmd>NvimTreeToggle<cr>", "[T]oggle NvimTree" },
      f = { "<cmd>NvimTreeFocus<cr>", "[F]ocus NvimTree" },
    }
  }

  whichkey.register(keymaps, {
    mode = { "n" },
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })
end

return M
