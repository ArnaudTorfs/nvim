local M = {}

local function executeCommandFromSettings(settingsKey)
    local utils = require("utils")
    local projectRootDir = vim.fn.getcwd()
    local file = projectRootDir .. "/settings.json"
    local lines = utils.GetFileContent(file)
    local json = vim.json.decode(lines)
    local command = json[settingsKey]
    if command then vim.cmd("vsplit term://" .. command) end
end

function M.BuildCommand() executeCommandFromSettings("buildCommand") end

function M.LaunchCommand() executeCommandFromSettings("launchCommand") end

function M.TestCommand() executeCommandFromSettings("testCommand") end

return M
