require("harpoon").setup()


local keymap = vim.keymap
local opts = { noremap = true, silent = true, }

-- set keybinds
keymap.set("n", "m<tab>", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap.set("n", "<leader><tab>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap.set("n", "<tab>", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", opts)

-- global_settings = {
--     -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
--     save_on_toggle = false,
--
--     -- saves the harpoon file upon every change. disabling is unrecommended.
--     save_on_change = true,
--
--     -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
--     enter_on_sendcmd = false,
--
--     -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
--     tmux_autoclose_windows = false,
--
--     -- filetypes that you want to prevent from adding to the harpoon list menu.
--     excluded_filetypes = { "harpoon" },
--
--     -- set marks specific to each git branch inside git repository
--     mark_branch = false,
-- } 
