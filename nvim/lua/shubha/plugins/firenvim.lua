-- local toggle_diagnostics = require("toggle-lsp-diagnostics").init({start_on = false})
if vim.g.started_by_firenvim then
	-- different colorscheme for firevim
	local status, _ = pcall(vim.cmd, "colorscheme shine")
	if not status then
		print("Colorscheme not found when loading firevim!") -- print error if colorscheme not installed
		return
	end

	-- disable Diagnostic messages
	-- local status, toggle_diagnostics = pcall(require, "toggle-lsp-diagnostics")
	-- require("toggle_lsp_diagnostics").init({ start_on = false })
	-- local status, toggle_diagnostics = pcall(require, "toggle-lsp-diagnostics")
	-- toggle_diagnostics.init("start_on = false")
	require("toggle_lsp_diagnostics").init({ start_on = false })
	-- vim.call("ToggleDiagOff")
	-- local status, toggle_diagnostics = pcall(vim.cmd, "ToggleDiagOff")
	-- if not status then
	-- 	print("LSP diagnostic could not be disabled for the firevim.") -- print error if colorscheme not installed
	-- 	return
	-- end
	-- call(vim.cmd, "ToggleDiagOff")
	-- toggle_diagnostics.init({ start_on = false })
end
