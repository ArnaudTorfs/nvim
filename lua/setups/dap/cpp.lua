local M = {}

function M.setup()
    local codelldb_path = '/Users/arnaud/.local/share/nvim/mason/bin/codelldb'
    local dap = require('dap')

    dap.adapters.lldb = {
        type = "server",
        name = "lldb",
        port = "${port}",
        host = "127.0.0.1",
        executable = {command = codelldb_path, args = {"--port", "${port}"}}
    }

    dap.configurations.cpp = {
        {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
                local utils = require("utils")
                local projectRootDir = vim.fn.getcwd()
                local file = projectRootDir .. "/settings.json"
                local lines = utils.GetFileContent(file)
                local json = vim.json.decode(lines)
                return vim.fn.getcwd() .. json["debugExecutable"]
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = function()
                local utils = require("utils")
                local projectRootDir = vim.fn.getcwd()
                local file = projectRootDir .. "/settings.json"
                local lines = utils.GetFileContent(file)
                local json = vim.json.decode(lines)
                return {json["args"]}
            end

        }, {
            name = 'Attach to process',
            type = 'lldb',
            request = 'attach',
            pid = function()
                local input = vim.fn.input('Process ID: ')
                return tonumber(input)
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false
        }
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
end

return M
