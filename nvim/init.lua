if vim.g.vscode then
	require("shubha.vscode")
else
	-- following msoight be need for linux setup (over ssh)Ajj
	require("packer").startup(function(use)
		use("wbthomason/packer.nvim")
	end)

	require("shubha.plugins-setup")
	require("shubha.core.options")
	require("shubha.core.keymaps")
	require("shubha.core.colorscheme")
	require("shubha.plugins.comment")
	-- require("shubha.plugins.nvim-tree")
	require("shubha.plugins.lualine")
	require("shubha.plugins.telescope")
	require("shubha.plugins.autopairs")
	require("shubha.plugins.treesitter")
	require("shubha.plugins.gitsigns")
	require("shubha.plugins.firenvim")
	require("shubha.plugins.marks")
	require("shubha.plugins.iron")
	require("shubha.plugins.nvim-cmp") -- autocompletions

	-- LSP: keep order same to avoid unintended errors
	require("shubha.plugins.lsp.mason") -- package manager
	require("shubha.plugins.lsp.lspsaga") -- better lsp interface
	require("shubha.plugins.lsp.lspconfig") -- easy pre-configurations
	require("shubha.plugins.lsp.null-ls") -- enhances lsp
	require("shubha.plugins.lsp.mason_null_ls")

	require("shubha.plugins.harpoon")

	require("shubha.plugins.vimwiki")

	require("shubha.plugins.chatgpt")
end
