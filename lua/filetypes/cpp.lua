local M = {}

function M.switchHeaderFile()
    local bufname = vim.fn.bufname("%")

    -- Extract the file extension
    local ext = vim.fn.fnamemodify(bufname, ":e")

    -- Check if the current file is a C++ file
    print(ext)
    if ext == "cpp" or ext == "cxx" then
        -- Replace the extension with "h" to get the name of the header file
        local headername = vim.fn.fnamemodify(bufname, ":r") .. ".h"

        -- Check if the header file exists
        if vim.fn.filereadable(headername) ~= 0 then
            -- Open the header file in the current window
            vim.cmd("edit " .. headername)
        else
            -- If the header file doesn't exist, show an error message
            print("Header file " .. headername .. " not found")
        end
    elseif ext == "h" then
        local cppFile = vim.fn.fnamemodify(bufname, ":r") .. ".cpp"

        if vim.fn.filereadable(cppFile) ~= 0 then
            -- Open the header file in the current window
            vim.cmd("edit " .. cppFile)
        else
            print("Header file " .. cppFile .. " not found")
        end
    else
        print("Not a C++ file")
    end
end

return M
