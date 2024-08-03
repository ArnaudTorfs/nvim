local M = {}

function M.setup()
  local codelldb_path     = '/home/arnaud/.local/share/nvim/mason/bin/codelldb'
  local dap               = require('dap')
  dap.adapters.lldb       = {
    type = "server",
    name = "lldb",
    port = "${port}",
    host = "127.0.0.1",
    executable = {
      command = codelldb_path,
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.cpp  = {
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
        return json["debugExecutable"]
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = function()
        local utils = require("utils")
        local projectRootDir = vim.fn.getcwd()
        local file = projectRootDir .. "/settings.json"
        local lines = utils.GetFileContent(file)
        local json = vim.json.decode(lines)
        return { json["args"] }
      end

      -- 💀
      -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
      --
      --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      --
      -- Otherwise you might get the following error:
      --
      --    Error on launch: Failed to attach to the target process
      --
      -- But you should be aware of the implications:
      -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
      -- runInTerminal = false,
    },
    {
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

  -- dap.configurations.cpp  = {
  --   {
  --     -- If you get an "Operation not permitted" error using this, try disabling YAMA:
  --     --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
  --     name = "Attach to process",
  --     type = 'cpp', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
  --     request = 'attach',
  --     pid = require('dap.utils').pick_process,
  --     args = {},
  --   },
  -- }

  -- If you want to use this for Rust and C, add something like this:

  dap.configurations.c    = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

return M
