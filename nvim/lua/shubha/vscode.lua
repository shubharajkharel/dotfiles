-- https://github.com/vscode-neovim/vscode-neovim/wiki/Plugins
vim.o.termguicolors = true


vim.api.nvim_set_keymap('n', 'j', 'gj', {})
vim.api.nvim_set_keymap('n', 'k', 'gk', {})

vim.api.nvim_set_keymap('x', 'gc', '<Plug>VSCodeCommentary', {})
vim.api.nvim_set_keymap('n', 'gc', '<Plug>VSCodeCommentary', {})
vim.api.nvim_set_keymap('o', 'gc', '<Plug>VSCodeCommentary', {})
vim.api.nvim_set_keymap('n', 'gcc', '<Plug>VSCodeCommentaryLine', {})

-- require("shubha.plugins-setup")
require("shubha.core.options")

local opt = vim.opt -- for concisenessopt
opt.clipboard:append("unnamedplus")


local opt = vim.opt -- for concisenessopt

-- opt.guifont = { "FiraCode-Retina.ttf'", "h12" }
-- opt.guifont = { "FiraCode Nerd Font Mono.ttf'", "h12" }

-- line numbers
-- opt.relativenumber = true
-- opt.number = true

-- vim.wo.relativenumber = true

-- tabs & indentation
opt.tabstop = 4 -- no of space for tab (default is 8?)
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

--search settings
opt.ignorecase = true
opt.smartcase = true --does case sensitive search only if capital is written there

--cursor line
-- opt.cursorline = true -- highlights current cursor line

--appearance
-- opt.termguicolors = true -- make sure you are in iterm2
-- opt.background = "dark" -- selects dark theme if available

-- set leader key to space
-- vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- keymap.set("n", "<leader>nh", ":nohl<CR>")


-- keymap.set('n', '<leader>h', ':FocusSplitLeft<CR>', { silent = true })
-- keymap.set('n', '<leader>j', ':FocusSplitDown<CR>', { silent = true })
-- keymap.set('n', '<leader>k', ':FocusSplitUp<CR>', { silent = true })
-- keymap.set('n', '<leader>l', ':FocusSplitRight<CR>', { silent = true })
-- keymap.set('n', '<leader>=', ':FocusToggle<CR>', { silent = true })

-- TODO:not working in vscode somehow
keymap.set("n", "x", '"_x"') -- unlikely to copy single character during coding. so doesn't ruin the reg contents

keymap.set("n", "] ", "<cmd>call append(line('.'), '')<cr>")
keymap.set("n", "[ ", "<cmd>call append(line('.')-1, '')<cr>")


-- Highlights text on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})


-- hop with neovim
local vim = vim

-- use plug instead of packer and assign to variable Plug
-- local Plug = vim.fn['plug#']

-- install plug.vim using the following command: curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
-- https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
-- vim.call('plug#begin', '~/.vim/autoload/plug.vim')

-- install hop
-- Plug("phaazon/hop.nvim")
-- vim.call('plug#end')
--
--
--

-- setup hop
local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup {
  keys = 'etovxqpdygfblzhckisuran'
}

local opts = { 
  silent = true, 
  noremap=true,
  callback=nil,
  desc=nil,
}

local keymap = vim.api.nvim_set_keymap
local directions = require('hop.hint').HintDirection

local bindings = {
    { 
      mode = 'n',
      mapping = 'f', 
      desc = '',
      func = function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end
    },
    { 
      mode = 'n', 
      mapping = 'F',
      desc = '',
      func = function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end
      -- func = function() hop.hint_char1({  current_line_only = false }) end
    },
    {
      mode = 'n', 
      mapping = 't',
      desc = '',
      -- func = function() hop.hint_char1({  current_line_only = false }) end
      func = function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end
    },
    {
      mode = 'n', 
      mapping = 'T',
      desc = '',
      func = function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end
    },
}


table.foreach(bindings, function(idx, binding) 
  opts.callback = binding.func
  opts.desc = binding.desc
  keymap(binding.mode, binding.mapping, '', opts)
end)
