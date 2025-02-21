local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

print("TS");

-- Function to get the current filename without extension
local function get_filename()
    local filename = vim.fn.expand("%:t")
    return filename:gsub("%..+$", "")
end

local function getSymbol(symbol, _, _) return "" .. symbol[1][1] end

return {
    -- if statement snippet
    s("if", {t("if ("), i(1), t({") {", "\t"}), i(2), t({"", "}"})}),

    -- class snippet
    s("class", {
        t("class "), f(function() return get_filename() end),
        t({" {", "\tconstructor() {", "\t\t"}), i(1), t({"", "\t}", "", "\t"}),
        i(0), t({"", "}"})
    }), -- interface snippet
    s("interface", {
        t("interface "), f(function() return get_filename() end),
        t({" {", "\t"}), i(1), t({"", "}"})
    }), -- property snippet
    s("prop", {i(1, "propertyName"), t(": "), i(2, "Type"), t(";")}),

    -- function snippet
    s("func", {
        t("function "), i(1, "functionName"), t("("), i(2, "args"), t({"): "}),
        i(3, "ReturnType"), t({" {", "\t"}), i(4, "// function body"),
        t({"", "}"})
    }), -- forEach loop snippet
    s("foreach", fmt([[
{}.forEach(({}) => {{
    {}
}});
]], {i(1, "myArray"), i(2, "item"), i(3, "// loop body")})),

    -- console.log snippet
    s("cl", {
        t('console.log(`'), f(getSymbol, {1}), t(': ${'), i(1, "variable"),
        t('}`);')
    })
}
