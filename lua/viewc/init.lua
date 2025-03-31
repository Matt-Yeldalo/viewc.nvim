local M = {}
local config = require("viewc.config")
local utils = require("viewc.utils")

-- Add functionality
M.viewc = function(opts)
	local full_path = vim.api.nvim_buf_get_name(0)
	local current_file = vim.fn.expand("%:t")
	local current_file_type = vim.bo.filetype

	if not utils.contains_component(current_file) then
		vim.notify("Attempted to use in a non view component file", vim.log.levels.ERROR)
		return
	end

	if not utils.has_valid_extensions(current_file_type) then
		vim.notify("Incorrect file type", vim.log.levels.ERROR)
		return
	end

	local expected_file = utils.fetch_matching_view(current_file, current_file_type)

	if not expected_file then
		vim.notify("Something went wrong, unable to find matching file", vim.log.levels.ERROR)
	end

	print(full_path)
	local base_path = utils.traverse_until(full_path, "/", { reverse = true })
	print(base_path)
	if opts.buffer_scope then
		utils.switch_to_buffer(expected_file)
	else
		-- vim.cmd("edit " .. expected_file)
	end
end

function M.setup(opts)
	config.setup(opts)

	vim.api.nvim_create_user_command("Viewc", function(opts)
		M.viewc(vim.split(opts.args, " "))
	end, { nargs = "*" })
end

return M
