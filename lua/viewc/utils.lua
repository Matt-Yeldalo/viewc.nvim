local M = {}

function M.switch_to_buffer(filename)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_name(buf):match(filename) then
			vim.api.nvim_set_current_buf(buf)
			return
		end
	end
	print("Buffer not found: " .. filename)
end

-- @param opts table: Parameter description.
function opts_with_default(opts, key, defaults)
	return opts[key] or defaults[key]
end

-- TODO:
local function reverse_traverse() end

-- @param str string The string to traverse
-- @param terminator string The pattern to terminate
-- @param opts table
local function traverse_until(str, terminator, opts)
	if str == nil then
		return
	end

	local default_opts = { reverse = false, chop = false }
	opts = opts or {}

	local result = ""
	local reverse = opts_with_default(opts, "reverse", default_opts)

	if reverse then
		for i = #str, 1, -1 do
			local char = str:sub(i, i)
			if char == terminator then
				break
			end

			result = char .. result
		end
	else
		for i = 1, #str do
			local char = str:sub(i, i)
			if char == terminator then
				break
			end

			result = result .. char
		end
	end

	return result
end

function M.traverse_until(str, terminator, opts)
	return traverse_until(str, terminator, opts)
end

-- @param file string The component.html.erb file
local function fetch_ruby(file)
	local expected_file = traverse_until(file, ".")
	return expected_file .. ".rb"
end

-- @param file string The component.rb file
local function fetch_erb(file)
	local expected_file = traverse_until(file, ".")
	return expected_file .. ".html.erb"
end

function M.contains_component(current_file)
	return not not string.find(current_file, "component")
end

function M.has_valid_extensions(file_type)
	print(file_type)
	return file_type == "eruby" or file_type == "ruby"
end

function M.fetch_matching_view(current_file, file_type)
	local file
	if file_type == "ruby" then
		file = fetch_erb(current_file)
	else
		file = fetch_ruby(current_file)
	end
	return file
end

return M
