local M = {}

function M.setup()
  local codelldb_path     = '/Users/arnaud/.local/share/nvim/mason/bin/codelldb'
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

  local dap               = require('dap')
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
      args = {},

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
  }

  -- If you want to use this for Rust and C, add something like this:

  dap.configurations.c    = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

return M
