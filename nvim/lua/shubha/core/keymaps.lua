-- set leader key to space
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

--------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode

-- keymap.set("i", ":wq", "<ESC>:wq<CR>") -- i made this since i made mistake of closing pressing : before exiting insert m ode

-- keymap.set("i", "jk", "<ESC>") -- j k are unlikely to come in pair in text

keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "x", '"_x"') -- unlikely to copy single character during coding. so doesn't ruin the reg contents

-- increment/decrement numbers (defaults seems better)
-- keymap.set("n", "<leader>+", "<C-a>") -- increment
-- keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- -- Split window management
-- -- similar to shortcuts for iterm2
-- keymap.set("n", "<leader>S", "<C-w>v") -- split window vertically
-- keymap.set("n", "<leader>s", "<C-w>s") -- split window horizontally
-- keymap.set("n", "<leader>q", "<C-w>q") -- split window horizontally
-- keymap.set("n", "<leader>=", "<C-w>=") -- make split windows equal width & height

-- -- like orginal neovim but with cw exchanged with space
-- keymap.set("n", "<leader>h", "<C-w>h") -- goto left split
-- keymap.set("n", "<leader>l", "<C-w>l") -- goto right split
-- keymap.set("n", "<leader>j", "<C-w>j") -- goto  split
-- keymap.set("n", "<leader>k", "<C-w>k") -- goto upper split

keymap.set('n', '<leader>h', ':FocusSplitLeft<CR>', { silent = true })
keymap.set('n', '<leader>j', ':FocusSplitDown<CR>', { silent = true })
keymap.set('n', '<leader>k', ':FocusSplitUp<CR>', { silent = true })
keymap.set('n', '<leader>l', ':FocusSplitRight<CR>', { silent = true })


keymap.set('n', '<leader>=', ':FocusToggle<CR>', { silent = true })

-- Tab management
keymap.set('n', '<leader>l', ':FocusSplitRight<CR>', { silent = true })
-- just like iterm2
keymap.set("n", "<leader>t", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>q", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>]", ":tabn<CR>") --  go to next tab (this also just like iterm2)
keymap.set("n", "<leader>[", ":tabp<CR>") --  go to previous tab

------------------------
-- Plugin Keybinds
------------------------

-- maximize the split panes (vim-maximize plugin)
keymap.set("n", "<leader><CR>", ":MaximizerToggle<CR>") -- toggle split window maximization

-- NERDTree
keymap.set("n", "<leader>e", ":NERDTreeToggle<CR>") -- toggle file explorer

-- nvim-tree
-- keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer
------------------------------------------------
-- TELESCOPE
------------------------------------------------
-- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
-- find string in current working directory as you type
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
-- find string under cursor in current working directory
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
-- list open buffers in current neovim instance
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
-- list available help tags
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
------------------------------------------------

-- -- telescope git commands (not on youtube nvim video)
-- keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
-- keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
-- keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
-- keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
-- keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- hop commands
-- replace default behavior of f,F,t and T
local hop = require("hop")
local directions = require("hop.hint").HintDirection

-- keymap.set("", "f", function()
-- 	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, { remap = true })
-- keymap.set("", "F", function()
-- 	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, { remap = true })

-- keymap.set("", "t", function()
-- 	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, { remap = true })
-- keymap.set("", "T", function()
-- 	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, { remap = true })

-- search word in current line independent of direction
keymap.set("", "<leader>g", function()
    hop.hint_words({ current_line_only = true })
end)

-- keymap.set("", "<leader>n", function()
-- 	hop.hint_lines_skip_whitespace()
-- end)

keymap.set("", "<leader><leader>", function()
	hop.hint_words()
end)

-- keymap to update file
-- update saves file only if buffer has been modified
-- keymap.set("n", "<ESC><ESC>", "<cmd>update<cr>")

keymap.set("n", "] ", "<cmd>call append(line('.'), '')<cr>")
keymap.set("n", "[ ", "<cmd>call append(line('.')-1, '')<cr>")


keymap.set("n", "<leader>ch", "<cmd>ChatGPT<CR>")
--
-- nnoremap  :call append(line('.'), '')<CR>
-- nnoremap [<CR> :call append(line('.')-1, '')<CR>
