local M = {}

function M.setKeyBindings()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end)

    for i = 1, 9 do
        vim.keymap.set("n", "<leader>hm" .. i, function()
            harpoon:list():replace_at(i, vim.fn.expand("%"))
        end, { desc = "Set Harpoon slot " .. i })

        vim.keymap.set("n", "<leader>h" .. i, function()
            harpoon:list():select(i)
        end, { desc = "Go to Harpoon slot " .. i })
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
end

local harpoon = require('harpoon')
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>hn", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

-- function M.setKeyBindings()
--     local keymap = {
--         h = {
--             name = "Harpoon",
--             m = {
--                 ["1"] = {
--                     "<cmd>lua require('harpoon.mark').set_current_at(1)<cr>",
--                     "[M]ark Files You Want to Revisit Later On"
--                 },
--                 ["2"] = {
--                     "<cmd>lua require('harpoon.mark').set_current_at(2)<cr>",
--                     "[M]ark Files You Want to Revisit Later On"
--                 },
--                 ["3"] = {
--                     "<cmd>lua require('harpoon.mark').set_current_at(3)<cr>",
--                     "[M]ark Files You Want to Revisit Later On"
--                 },
--                 ["4"] = {
--                     "<cmd>lua require('harpoon.mark').set_current_at(4)<cr>",
--                     "[M]ark Files You Want to Revisit Later On"
--                 },
--                 ["5"] = {
--                     "<cmd>lua require('harpoon.mark').set_current_at(5)<cr>",
--                     "[M]ark Files You Want to Revisit Later On"
--                 }
--             },
--             n = {
--                 "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
--                 "[N]avigate all project marks"
--             },
--             ["1"] = {
--                 "<cmd>:lua require('harpoon.ui').nav_file(1)<cr>",
--                 "navigates to file 1"
--             },
--             ["2"] = {
--                 "<cmd>:lua require('harpoon.ui').nav_file(2)<cr>",
--                 "navigates to file 2"
--             },
--             ["3"] = {
--                 "<cmd>:lua require('harpoon.ui').nav_file(3)<cr>",
--                 "navigates to file 3"
--             },
--             ["4"] = {
--                 "<cmd>:lua require('harpoon.ui').nav_file(4)<cr>",
--                 "navigates to file 4"
--             },
--             ["5"] = {
--                 "<cmd>:lua require('harpoon.ui').nav_file(5)<cr>",
--                 "navigates to file 5"
--             }
--         }
--     }
--
--     whichkey.register(keymap, {
--         mode = "n",
--         prefix = "<leader>",
--         buffer = nil,
--         silent = true,
--         noremap = true,
--         nowait = false
--     })
-- end
--
function M.setup() M.setKeyBindings(); end

--
return M
