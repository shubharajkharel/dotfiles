-- local status, _ = pcall(require, "vimwiki")
-- if not status then
--     print("VimWiki not found")
-- 	return
-- end

local opt = vim.opt -- for conciseness
-- suggested on website
opt.filetype.plugin=true

-- autocommand that changes the filetype of md
-- from vimwiki to markdown, so that lsp can start 
-- when file is saved
vim.cmd([[ 
  augroup vimwiki_user_config
    autocmd!
    autocmd BufWritePost *.md set filetype=markdown
  augroup end
]])
