local M = {}

M.config = function()
	O.plugin.treesitter = {
		ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		highlight = {
			enable = true, -- false will disable the whole extension
		},
	}
end

M.setup = function()
	local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		print("Problem with treesitter")
		return
	end

	treesitter_configs.setup(O.plugin.treesitter)
end

return M
