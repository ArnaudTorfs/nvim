local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Function to get the namespace based on the file path
local function get_namespace()
	local filepath = vim.fn.expand("%:p")
	local root = vim.fn.getcwd()
	local relative_path = filepath:sub(#root + 2)
	-- Remove the filename from the path
	local dir_path = relative_path:match("(.*/)")
	dir_path = dir_path:gsub("/", "."):gsub("%.$", ""):gsub("%.cs$", "")
	return "namespace " .. dir_path .. ";"
end
--
-- Function to get the current filename without extension
local function get_filename()
	local filename = vim.fn.expand("%:t")
	return filename:gsub("%.cs$", "")
end

local function getSymbol(symbol, _, _)
	return "" .. symbol[1][1]
end

return {
	s("if", {
		t("if ( "),
		i(1),
		t({ " )", "{" }),
		i(2),
		t({ "", "}" }),
	}),
	s("class", {
		f(function() return get_namespace() end),
		t({ "", "", "public class " }),
		f(function() return get_filename() end),
		t({ "", "{", "" }),
		i(1),
		t({ "", "}" }),
	}),
	s("interface", {
		f(function() return get_namespace() end),
		t({ "", "", "public interface " }),
		f(function() return get_filename() end),
		t({ "", "{", "" }),
		i(1),
		t({ "", "}" }),
	}),
	s("entity", {
		f(function() return get_namespace() end),
		t({ "", "", "public class " }),
		f(function() return get_filename() end),
		t({ "", "{", "    public int Id { get; set; }", "" }),
		i(1),
		t({ "", "}" }),
	}),
	s("filter", {
		f(function() return get_namespace() end),
		t({ "", "", "public class " }),
		f(function() return get_filename() end),
		t({ " : PagedFilter", "", "{", "    public int? Id { get; set; }", "" }),
		i(1),
		t({ "", "}" }),
	}),
	s("prop", {
		t("public "),
		i(1, "Type"),
		i(2, "Name"),
		t(" { get; set; }"),
	}),
	s("func", {
		t("public "),
		i(1, "Return"),
		i(2, "Name"),
		t(" ("),
		i(3, "args"),
		t({ ") {", "" }),
		i(4, "args"),
		t({ "", "}" }),
	}),
	s("foreach", fmt(
		[[
foreach (var item in {})
{{
{}
}}
]],
		{ i(1, "myList"), i(2, "// loop body") }
	)),
	s("wld", {
		t('Console.WriteLine($"'),
		f(getSymbol, { 1 }),
		t(': {'),
		i(1, "Variable"),
		t('}");'),
	}),

}

