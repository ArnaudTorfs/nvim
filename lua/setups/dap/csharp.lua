local M = {}
local dap = require('dap')
local ddl_path = '/Users/arnaud/Documents/Source/DAD_SAAS/ContractInsight/ContractInsight/src/API/ContractInsight.API/bin/Debug/net8.0/ContractInsight.API'

function M.setup()
    dap.adapters.netcoredbg = {
        type = 'executable',
        command = '/Users/arnaud/.local/share/nvim/mason/bin/netcoredbg',
        args = {'--interpreter=vscode'}
    }

    vim.g.dotnet_build_project = function()
        local default_path = vim.fn.getcwd() .. '/'
        if vim.g['dotnet_last_proj_path'] ~= nil then
            default_path = vim.g['dotnet_last_proj_path']
        end
        local path = vim.fn.input('Path to your *proj file', default_path,
                                  'file')
        vim.g['dotnet_last_proj_path'] = path
        -- local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
        local cmd = 'dotnet build -c Debug ' .. path .. ' > ~/dap.log'
        print('')
        print('Cmd to execute: ' .. cmd)
        local f = os.execute(cmd)
        if f == 0 then
            print('\nBuild: ✔️ ')
        else
            print('\nBuild: ❌ (code: ' .. f .. ')')
        end
    end

    vim.g.dotnet_get_dll_path = function()
        local request = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/',
                                'file')
        end

        if vim.g['dotnet_last_dll_path'] == nil then
            vim.g['dotnet_last_dll_path'] = request()
        else
            if vim.fn.confirm('Do you want to change the path to dll?\n' ..
                                  vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) ==
                1 then vim.g['dotnet_last_dll_path'] = request() end
        end

        return vim.g['dotnet_last_dll_path']
    end

    local config = {
        {
            type = "netcoredbg",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
                print(ddl_path)
                if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) ==
                    1 then vim.g.dotnet_build_project() end
                -- return './bin/Debug/net8.0/temp'
                return ddl_path
                -- return vim.g.dotnet_get_dll_path()
            end,
            options = {log_file = "$HOME/dap.log", log_level = "TRACE"}
        }
    }

    dap.configurations.cs = config
    dap.configurations.fsharp = config
end

return M
