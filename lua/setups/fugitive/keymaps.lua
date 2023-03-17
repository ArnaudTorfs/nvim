local M = {}

local whichkey = require "which-key"

-- local function keymap(lhs, rhs, desc)
--   vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
-- end

function M.setup()
  local keymap = {
    g = {
      g = { ":tab Git <CR>", "Fugitive" },
      G = { ":vert Git <CR>", "Fugitive" },
      l = { ":vert Git --paginate log --oneline<cr>", "Git Log" },
    },
  }

  whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })
end

return M
