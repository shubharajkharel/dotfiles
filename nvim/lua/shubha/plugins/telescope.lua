-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

-- import telescope actions safely
local builtin_setup, builtin = pcall(require, "telescope.builtin")
if not builtin_setup then
	return
end

local themes_setup, themes = pcall(require, "telescope.themes")
if not themes_setup then
	return
end

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
			},
		},
	},
})

telescope.load_extension("fzf") -- makes it faster
-- builtin.symbols({ sources = { "emoji", "gitmoji" } })
-- builtin.find_files(themes.get_dropdown())
