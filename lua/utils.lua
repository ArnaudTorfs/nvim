local M = {}

function M.fileExists(file)
	local f = io.open(file, "rb")
	if f then f:close() end
	return f ~= nil
end

function M.GetFileContent(file)
	if not M.fileExists(file) then return {} end
	local f = assert(io.open(file, "rb"))
	local lines = f:read("*all")
	return lines
end

return M
