local M = {}

function M.setup()
    local dap = require('dap')

    dap.adapters.coreclr = {
        type = 'executable',
        command = '/home/arnaud/.local/share/nvim/mason/bin/netcoredbg',
        args = {'--interpreter=vscode'}
    }

    dap.configurations.cs = {
        {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
                local utils = require("utils")
                local projectRootDir = vim.fn.getcwd()
                local file = projectRootDir .. "/settings.json"
                local lines = utils.GetFileContent(file)
                local json = vim.json.decode(lines)
                return json["debugExecutable"]
            end,
            env = "ASPNETCORE_ENVIRONMENT=Development",
            args = {
                "/p:EnvironmentName=Development", -- this is a msbuild jk
                --  this is set via environment variable ASPNETCORE_ENVIRONMENT=Development
                "--urls=http://localhost:5180", "--environment=Development"
            }
            -- args = function()
            --   local utils = require("utils")
            --   local projectRootDir = vim.fn.getcwd()
            --   local file = projectRootDir .. "/settings.json"
            --   local lines = utils.GetFileContent(file)
            --   local json = vim.json.decode(lines)
            --   return { json["args"] }
            -- end,
        }
    }
end

return M
