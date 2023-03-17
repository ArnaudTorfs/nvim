local M = {}

function M.setup()
  require("obsidian").setup({
    dir = "/Users/arnaud/Library/Mobile Documents/iCloud~md~obsidian/Documents/OBSIDIAN",
    completion = {
      nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    }
  })
  require("setups.obsidian.keymaps").setup() -- Keymaps
end

return M
