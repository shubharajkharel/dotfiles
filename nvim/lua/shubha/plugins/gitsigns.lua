-- import gitsigns plugin safely
-- show the difference from git inline
local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
	return
end

-- configure/enable gitsigns
gitsigns.setup()
