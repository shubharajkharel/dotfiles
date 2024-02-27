local opt = vim.opt -- for concisenessopt

-- opt.guifont = { "FiraCode-Retina.ttf'", "h12" }
opt.guifont = { "FiraCode Nerd Font Mono.ttf'", "h12" }

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4 -- no of space for tab (default is 8?)
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

--search settings
opt.ignorecase = true
opt.smartcase = true --does case sensitive search only if capital is written there

--cursor line
opt.cursorline = true -- highlights current cursor line

--appearance
opt.termguicolors = true -- make sure you are in iterm2
opt.background = "dark" -- selects dark theme if available
-- opt.signcolumn = "yes"

--backspace (i do not understand this)
-- By default, Ctrl-W only deletes previous words in the text
-- entered after last starting insert mode, and stops deleting
-- text at the beginning of a line.k
--opt.backspace = "indent,eol,start"

-- clipboard
-- use system clipboard as default register
opt.clipboard:append("unnamedplus")

-- split windows
-- seems like default option to me?
-- opt.splitright = true -- split vertical window to the right
-- opt.splitbelow = true -- split horizontal window to the bottom

-- add '-' as word
-- why would I do that?
-- opt.iskeyword:append("-")  -- eg: string-string is a single word

-- no text wrap
opt.wrap = false

-- folding method 
-- https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
opt.foldmethod="expr"
opt.foldexpr="nvim_treesitter#foldexpr()"
opt.foldtext="getline(v:foldstart).'...'.trim(getline(v:foldend))"
-- opt.fillchars="fold:\\"
opt.fillchars="fold: "
opt.foldnestmax=5

opt.foldminlines=0
-- opt.foldlevel=2
opt.foldlevel= 99 -- disables folding

function augroup(name, autocmds)
    vim.cmd("augroup " .. name)
    vim.cmd("autocmd!")
    for _, autocmd in pairs(autocmds) do
        autocmd()
    end
    vim.cmd("augroup END")
end

function autocmd()
    vim.cmd("autocmd BufReadPost * if line(\"'\\\"\") > 0 && line(\"'\\\"\") <= line(\"$\") && &ft !~# 'commit' | execute \"normal! g`\\\"\" | endif")
end

augroup("vimStartup", {
    autocmd
})

