local whichkey = require "which-key"
local ls = require "luasnip"

ls.setup {}

local keymap = {
    ["<C-K>"] = {function() ls.expand() end, "Expand Snippet"},
    ["<C-L>"] = {function() ls.jump(1) end, "Jump to Next Placeholder"},
    ["<C-J>"] = {function() ls.jump(-1) end, "Jump to Previous Placeholder"},
    ["<C-E>"] = {
        function() if ls.choice_active() then ls.change_choice(1) end end,
        "Change Choice"
    }
}

whichkey.register(keymap, {
    mode = {"i", "s"},
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false
})
