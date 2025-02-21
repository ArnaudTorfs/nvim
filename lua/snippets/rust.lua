local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function get_filename()
    local filename = vim.fn.expand("%:t")
    return filename:gsub("%.rs$", "")
end

return {
    s("fn", {
        t("fn "), i(1, "function_name"), t("("), i(2, "args"), t({") -> ", ""}),
        i(3, "return_type"), t({" {", ""}), i(4, "// body"), t({"", "}"})
    }), s("struct", {
        t("struct "), f(get_filename, {}), t({" {", ""}), i(1, "// fields"),
        t({"", "}"})
    }), s("impl", {
        t("impl "), f(get_filename, {}), t(" {"), i(1, "// methods"),
        t({"", "}"})
    }), s("enum", {
        t("enum "), f(get_filename, {}), t({" {", ""}), i(1, "// variants"),
        t({"", "}"})
    }), s("trait", {
        t("trait "), f(get_filename, {}), t({" {", ""}), i(1, "// methods"),
        t({"", "}"})
    }), s("for", fmt([[
for {} in {}
{{
    {}
}}
]], {i(1, "item"), i(2, "iterable"), i(3, "// loop body")})),
    s("print", {t('println!("'), i(1, "Variable"), t('");')})
}
