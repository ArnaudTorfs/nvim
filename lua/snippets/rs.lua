local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s("print", {
		fmt(
			[[println!("{:?}",{});]],
			i(1, "toPrint"))
	})

}
