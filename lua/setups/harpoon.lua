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

    -- Harpoon picker via Snacks
    vim.keymap.set("n", "<leader>hn", function()
        local harpoon_list = harpoon:list()
        local file_paths = {}
        for _, item in ipairs(harpoon_list.items) do
            table.insert(file_paths, item.value)
        end
        Snacks.picker({
            items = file_paths,
            title = "Harpoon",
            format = function(item, _)
                return vim.fn.fnamemodify(item, ":~:.")
            end,
            confirm = function(picker, item)
                picker:close()
                vim.cmd("edit " .. item)
            end,
        })
    end, { desc = "Harpoon picker" })
end

function M.setup() M.setKeyBindings(); end

return M
