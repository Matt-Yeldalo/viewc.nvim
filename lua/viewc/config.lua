local M = {}

M.defaults = {
	buffer_scope = false,
}

--- <code>
--- </code
--- @param opts table: Configuration opts.
function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
