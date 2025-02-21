local M = {}

local whichkey = require "which-key"

-- local function keymap(lhs, rhs, desc)
--   vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
-- end

function M.openGitLogs()
    local windowHeight = vim.api.nvim_win_get_height(0)
    local orientation = "vertical"
    if (windowHeight > 60) then orientation = "horizontal" end
    local command = ":bel " .. orientation ..
                        " Git --paginate log --oneline<cr>"
    return command
end

function M.setup()
    local keymap = {
        g = {
            g = {":tab Git <CR>", "Fugitive"},
            b = {":Git blame<CR>", "Blame"},
            G = {":vert Git <CR>", "Fugitive"},
            l = {M.openGitLogs(), "Git Log"}
        }
    }

    whichkey.register(keymap, {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false
    })
end

return M
