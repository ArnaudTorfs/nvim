local myplugin = {}

local error_lines = nil

function myplugin.find_error_lines()
    local search_pattern = vim.fn.escape(" %[Error%]", "\\")
    local error_lines = {}
    for line_num = 1, vim.fn.line("$") do
        local line = vim.api
                         .nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
        if line:find(search_pattern) then
            table.insert(error_lines, {line_num, line})
        end
    end
    return error_lines
end

function myplugin.move_to_error_line()
    local current_win = vim.api.nvim_get_current_win()
    local current_line_number = vim.api.nvim_win_get_cursor(current_win)[1]
    local error_line = vim.api.nvim_buf_get_lines(
                           vim.api.nvim_win_get_buf(current_win),
                           current_line_number - 1, current_line_number, false)[1]

    -- Close the floating window
    vim.api.nvim_command("close")

    local error_lines_keys = vim.tbl_values(error_lines)
    local line_number = error_lines_keys[current_line_number][1]

    vim.api.nvim_win_set_cursor(0, {line_number, 0})
end

function myplugin.display_error_count()
    error_lines = myplugin.find_error_lines()
    local max_lines = 10 -- Maximum number of lines to display in the floating window
    local content_buf = vim.api.nvim_create_buf(false, true)
    local content_width = 80 -- Fixed window width
    local content_height = math.min(max_lines, vim.tbl_count(error_lines)) -- Fixed window height based on the number of error lines

    -- Truncate lines to fit the fixed window width
    local truncated_error_lines = {}
    for line_num, line_table in pairs(error_lines) do
        local line = line_table[2]
        if #line > content_width - 2 then
            truncated_error_lines[line_num] =
                line:sub(1, content_width - 2) .. "⋯"
        else
            truncated_error_lines[line_num] = line
        end
    end

    local content_win_opts = {
        style = "minimal",
        relative = "editor",
        width = content_width,
        height = content_height,
        row = (vim.o.lines - content_height) / 2,
        col = (vim.o.columns - content_width) / 2
    }
    local content_win = vim.api.nvim_open_win(content_buf, true,
                                              content_win_opts)
    vim.api.nvim_buf_set_option(content_buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_lines(content_buf, 0, -1, true,
                               vim.tbl_values(truncated_error_lines))

    -- Border buffer and window
    local border_buf = vim.api.nvim_create_buf(false, true)
    local border_width = content_width + 2
    local border_height = content_height + 2
    local border_win_opts = {
        style = "minimal",
        relative = "editor",
        width = border_width,
        height = border_height,
        row = content_win_opts.row - 1,
        col = content_win_opts.col - 1
    }
    local border_win = vim.api.nvim_open_win(border_buf, false, border_win_opts)
    vim.api.nvim_buf_set_option(border_buf, 'bufhidden', 'wipe')

    -- Draw border lines
    local border_lines = {'╭' .. string.rep('─', content_width) .. '╮'}
    local middle_line = '│' .. string.rep(' ', content_width) .. '│'
    for _ = 1, content_height do table.insert(border_lines, middle_line) end
    table.insert(border_lines,
                 '╰' .. string.rep('─', content_width) .. '╯')
    vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

    -- Set window option
    vim.api.nvim_win_set_option(content_win, 'winhl', 'Normal:MyFloatNormal')

    -- Close both content and border buffers when the content window is closed
    vim.api.nvim_command(
        "autocmd WinClosed <buffer> silent! execute 'bwipeout! " .. content_buf ..
            " " .. border_buf .. "'")

    -- Close the floating window when 'q' is pressed
    vim.api.nvim_buf_set_keymap(content_buf, 'n', 'q', '<cmd>close<CR>',
                                {noremap = true, silent = true})

    -- Close the floating window and move to the corresponding line in the original document when Enter is pressed
    vim.api.nvim_buf_set_keymap(content_buf, 'n', '<CR>',
                                ':lua require("myplugin").move_to_error_line()<CR>',
                                {noremap = true, silent = true})
end

function myplugin.setup()
    vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>z',
                                ':lua require("myplugin").display_error_count()<CR>',
                                {noremap = true, silent = true})
end

function myplugin.attach_to_log_files()
    vim.cmd([[
    augroup MyPluginAutocmd
      autocmd!
      autocmd BufRead,BufNewFile *.log lua require("myplugin").setup()
    augroup END
  ]])
end

return myplugin
