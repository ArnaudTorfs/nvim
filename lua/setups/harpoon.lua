local M = {}
--
-- local whichkey = require "which-key"
function M.setKeyBindings()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>hn", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    for i = 1, 9 do
        vim.keymap.set("n", "<leader>hm" .. i, function()
            print(vim.fn.expand("%"))
            harpoon:list():replace_at(i, vim.fn.expand("%"))
        end, { desc = "Set Harpoon slot " .. i })

        vim.keymap.set("n", "<leader>h"..i, function() harpoon:list():select(i) end)
    end
    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
end

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
