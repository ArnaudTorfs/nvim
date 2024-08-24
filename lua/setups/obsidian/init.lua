local M = {}
function M.getPath()
    local utils = require("utils")
    local vim_root_dir = vim.fn.stdpath('config')
    local file = vim_root_dir .. "/settings.json"
    local lines = utils.GetFileContent(file)
    local json = vim.json.decode(lines)
    return json["obsidianPath"]
end

function M.setup()
    require("obsidian").setup({
        dir = M.getPath(),
        completion = {
            nvim_cmp = true -- if using nvim-cmp, otherwise set to false
        }
    })
    require("setups.obsidian.keymaps").setup() -- Keymaps
end

return M
