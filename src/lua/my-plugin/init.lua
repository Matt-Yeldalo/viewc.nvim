local M = {}
local config = require("my-plugin.config")

-- Add functionality
M.myPlugin = function(opts)
	print(opts)
end

function M.setup(opts)
	config.setup(opts)

	vim.api.nvim_create_user_command("MyPlugin", function(opts)
		M.myPlugin(vim.split(opts.args, " "))
	end, { nargs = "*" })
end

return M
