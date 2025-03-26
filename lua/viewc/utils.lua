local M = {}

local function fetch_ruby(file)
	return vim.fs.find
end

local function fetch_erb(file)
end

function M.contains_component(current_file)
	return not not string.find(current_file, "component")
end

function M.has_valid_extensions(file_type)
	return file_type == "eruby.html" or file_type == "ruby"
end

function M.fetch_matching_view(current_file, file_type)
	local file
	if file_type == 'ruby' then
		file = fetch_erb(current_file)
	else
		file = fetch_ruby(current_file)
	end
end


return M
