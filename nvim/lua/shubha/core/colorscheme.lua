-- set colorscheme to nightfly with protected call
-- in case it isn't installed
if vim.g.started_by_firenvim then
	-- local status, _ = pcall(vim.cmd, "colorscheme shine")
	-- if not status then
	-- 	print("Colorscheme not found when loading firevim!") -- print error if colorscheme not installed
	-- 	return
	-- end
else
	pcall(vim.cmd, "let g:gruvbox_italic=1")
	-- local status, _ = pcall(vim.cmd, "let g:gruvbox_contrast_dark = 'soft'")
	local status, _ = pcall(vim.cmd, "colorscheme gruvbox")
	-- local status, _ = pcall(vim.cmd, "colorscheme tokyonight")
	-- local status, _ = pcall(vim.cmd, "colorscheme nightfly")
	if not status then
		print("Colorscheme not found!") -- print error if colorscheme not installed
		return
	end
end
