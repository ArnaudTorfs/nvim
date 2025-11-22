require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            {
                "harpoon2",
                icon = '♥',
                indicators = (function()
                    local t = {}; for i = 1, 9 do t[i] = tostring(i) end; return t
                end)(),
                active_indicators = (function()
                    local t = {}; for i = 1, 9 do t[i] = tostring(i) end; return t
                end)(),
                color_active = { fg = "#C7BFFF" },
                _separator = " ",
                no_harpoon = "Harpoon not loaded",
            },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
}
