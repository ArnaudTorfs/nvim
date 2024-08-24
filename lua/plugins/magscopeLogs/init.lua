local M = {}

function M.setup()
    local text = vim.fn.expand('%:p')
    print(text)
end

return M
