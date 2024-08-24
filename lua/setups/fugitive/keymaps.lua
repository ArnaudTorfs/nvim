local M = {}

local whichkey = require "which-key"

function M.openGitLogs()
    local windowHeight = vim.api.nvim_win_get_height(0)
    local orientation = "vertical"
    if windowHeight > 60 then orientation = "horizontal" end
    local command = "tab " .. orientation .. " Git --paginate log --oneline"
    vim.cmd(command)
end

-- Function to close all Git-related tabs
function M.closeGitTabs()
    -- Get the total number of tabs
    local totalTabs = vim.fn.tabpagenr('$')

    -- Iterate through each tab
    for i = totalTabs, 1, -1 do
        vim.cmd('tabnext ' .. i)
        local bufName = vim.api.nvim_buf_get_name(0)
        print("Checking " .. bufName)
        if bufName:find("fugitive://") then
            print("Closing " .. bufName)
            vim.cmd("tabclose")
        end
    end
end

function M.openGitStatusAndLogs()
    -- Open Git status in a new tab
    vim.cmd("tab Git")
    -- Open Git logs in another new tab
    vim.cmd("bel vertical Git --paginate log --oneline")
end

function M.setup()
    local keymap = {
        g = {
            g = {M.openGitStatusAndLogs, "Fugitive"},
            b = {":Git blame<CR>", "Blame"},
            G = {":vert Git <CR>", "Fugitive"},
            l = {M.openGitLogs, "Git Log"},
            q = {M.closeGitTabs, "Close Git Tabs"}
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
