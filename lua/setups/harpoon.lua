local M = {}

local whichkey = require "which-key"

function M.setKeyBindings()
  local keymap = {
    h = {
      name = "Harpoon",
      m = {
        ["1"] = { "<cmd>lua require('harpoon.mark').set_current_at(1)<cr>", "[M]ark Files You Want to Revisit Later On" },
        ["2"] = { "<cmd>lua require('harpoon.mark').set_current_at(2)<cr>", "[M]ark Files You Want to Revisit Later On" },
        ["3"] = { "<cmd>lua require('harpoon.mark').set_current_at(3)<cr>", "[M]ark Files You Want to Revisit Later On" },
        ["4"] = { "<cmd>lua require('harpoon.mark').set_current_at(4)<cr>", "[M]ark Files You Want to Revisit Later On" },
        ["5"] = { "<cmd>lua require('harpoon.mark').set_current_at(5)<cr>", "[M]ark Files You Want to Revisit Later On" },
      },
      n = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "[N]avigate all project marks" },
      ["1"] = { "<cmd>:lua require('harpoon.ui').nav_file(1)<cr>", "navigates to file 1" },
      ["2"] = { "<cmd>:lua require('harpoon.ui').nav_file(2)<cr>", "navigates to file 2" },
      ["3"] = { "<cmd>:lua require('harpoon.ui').nav_file(3)<cr>", "navigates to file 3" },
      ["4"] = { "<cmd>:lua require('harpoon.ui').nav_file(4)<cr>", "navigates to file 4" },
      ["5"] = { "<cmd>:lua require('harpoon.ui').nav_file(5)<cr>", "navigates to file 5" },
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

function M.setup()
  M.setKeyBindings();
end

return M
