-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	-- packer self-management
	use("wbthomason/packer.nvim")

	-- lua functions that many plugins use
	use("nvim-lua/plenary.nvim")

	-- tmux & split window navigation
	-- do it need it?
	-- use("christoomey/vim-tmux-navigator")

	-- maximizes and restores current window
	use("szw/vim-maximizer")

	-- surrounds text-objects with " ' } ] <tags>
	-- use ys.. to add surround
	-- use cs.. to change surround
	-- use ds.. to delete surround
	-- use("tpope/vim-surround") -- original plugin
	-- nvim port
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	-- replace the words/line/paragrah with the contents of the register
	-- useful because text being deleted has to be sent to null register
	-- this is difficult and/or risky
	-- alternative is to paste and delete, this need added motion as well
	-- you can specify register as well
	-- https://github.com/vim-scripts/ReplaceWithRegister
	use("vim-scripts/ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- comment using gccset
	-- determined by file extension
	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- icons in file explorer
	use("kyazdani42/nvim-web-devicons")

	-- fancy status line
	use("nvim-lualine/lualine.nvim")

	-- plugin: telescope
	-- fuzzy file and word search
	-- can search a lot more : buffers, tags, oldfiles and more
	-- https://github.com/nvim-telescope/telescope.nvim#pickers
	-- dependency for live grep feature: ripgrep (brew install ripgrep)

	--- dependency for better sorting performance
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	-- fuzzy finder
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
	-- ?
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-telescope/telescope-symbols.nvim" })

	-- install this font for icons
	-- NerdFontsSymbolsOnly.zip
	-- Look for latest release in https://github.com/ryanoasis/nerd-fonts/releases/tag/v3.0.2

	-- -- ---------------------------------------------------------------------------
	-- --                          LSP
	-- -- ---------------------------------------------------------------------------

	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		"neovim/nvim-lspconfig",

		"jose-elias-alvarez/null-ls.nvim",
		"jayp0521/mason-null-ls.nvim",

		-- "jayp0521/mason-nvim-dap.nvim",
	})

	use({ "glepnir/lspsaga.nvim", branch = "main" })

	-- ---------------------------------------------------------------------------
	--                          autocomletion
	-- ---------------------------------------------------------------------------
	-- autocompletion
	use("hrsh7th/cmp-nvim-lsp") -- cmp-nvim-lsp seems to have a breaking changes
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths
	use("hrsh7th/cmp-cmdline") -- source for file system paths
	use("hrsh7th/nvim-cmp") -- completion plugin

	-- ---------------------------------------------------------------------------
	--                          snippets
	-- ---------------------------------------------------------------------------
	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippetssni
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- ---------------------------------------------------------------------------

	-- treesitter configuration
	-- syntax highlighter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- powerful git diff view
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Nerdtree file explore
	use("preservim/nerdtree")

	-- allows Perl regex search in neovim
	use("othree/eregex.vim") -- show line modifications on left hand side

	-- nvim and jupyter notebook sync
	-- program works but vim plud doesnt
	-- use jupytext instead
	-- use("untitled-ai/jupyter_ascending.vim")

	-- color scheme
	-- use("bluz71/vim-nightfly-guicolors")
	use("folke/tokyonight.nvim")
	-- use("ellisonleao/gruvbox.nvim")
	use("morhetz/gruvbox")

	-- easy motion
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- firevim
	-- turns your browser into nvim client
	-- jupyter notebook and other online editor?
	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})

	-- toggle diagnostic option of lsp quickly
	-- seems to be useless
	-- it seems to auto turn on after edit
	-- maybe there is config for that
	-- or there is lsp setting to toggle itself
	-- use("WhoIsSethDaniel/toggle-lsp-diagnostics.nvim")

	-- adds vertical line for each indent level
	use("lukas-reineke/indent-blankline.nvim")

	-- shows marks on side
	use("chentoast/marks.nvim")

	-- interactive scratch pad
	-- evalue commands as you type
	-- supports many language including python
	-- a jupyter alternative
	use("metakirby5/codi.vim")

	-- smooth scorlling
	-- takes folds into account
	-- takes both number of liens as well as percent for file while scrolling
	-- WARNINING: Seem too slow esp with syntax highlighting turned on
	-- use("karb94/neoscroll.nvim")

	-- minimal scrollbar that shows useful information
	-- use({ "petertriho/nvim-scrollbar", require("scrollbar").setup() })

	-- focus mode: useful for non coding typing ?
	-- removes all clutter
	-- can focus on small block as well
	use({
		"Pocco81/true-zen.nvim",
		config = function()
			require("true-zen").setup({
				-- your config goes here
				-- or just leave it empty :)
			})
		end,
	})

	-- assign different colors to brackets
	-- so you can see it properly
	-- based on treesitter
	-- configuration is done in nvim-treesitter lua files
	use("p00f/nvim-ts-rainbow")

	-- shows context of code
	-- like which function you are in at top
	use("nvim-treesitter/nvim-treesitter-context")

	-- Highlights text on yank
	local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
	vim.api.nvim_create_autocmd("TextYankPost", {
		command = "silent! lua vim.highlight.on_yank()",
		group = yankGrp,
	})

	-- expands the text objects to many useful types
	use({ "echasnovski/mini.ai", branch = "stable" })

	-- REPL over selected text
	-- useful to send selected tex to ipython
	-- use {'hkupty/iron.nvim', tag = "<most recent tag>"}
	use({ "hkupty/iron.nvim" })

	-- WhichKey is a lua plugin for Neovim 0.5 that
	-- displays a popup with possible key bindings of
	-- the command you started typing.
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Debugging
	-- instructions
	-- https://alpha2phi.medium.com/neovim-for-beginners-debugging-using-dap-44626a767f57
	use({
		"mfussenegger/nvim-dap",
		opt = true,
		event = "BufReadPre",
		module = { "dap" },
		wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
		requires = {
			"Pocco81/DAPInstall.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"nvim-telescope/telescope-dap.nvim",
			-- { "leoluz/nvim-dap-go", module = "dap-go" },
			{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
		},
		config = function()
			require("shubha.plugins.dap").setup()
		end,
	})

	use({
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_list = {
				{
					-- path = '/Users/bnl/Downloads/test',
					syntax = "markdown",
					ext = ".md",
				},
			}
		end,
	})

	-- easy fold for python
	-- understands class and functions in python following seem to work after
	-- set foldmethod=manual
	-- use{ "https://github.com/tmhedberg/SimpylFold" }
	-- recommended by SimpylFold plugin
	-- to fast autofold
	-- use{ "Konfekt/FastFold"}

	--  fold preview
	--  fold customization
	-- use{ 'anuvyklack/pretty-fold.nvim',
	--    config = function()
	--       require('pretty-fold').setup()
	--    end
	-- }
	--

	-- use {"tools-life/taskwiki"}
	-- use {"powerman/vim-plugin-AnsiEsc"}
	-- mark files for easy switch
	-- compared to vim marks:
	--      marks can be easily swapped and deleted
	--      can be made project specific
	use({ "ThePrimeagen/harpoon" })

	-- autocompletion showing parameter type as well
	use({ "ray-x/lsp_signature.nvim" })

	-- copy over ssh
	-- todo: https://github.com/ojroques/vim-oscyank/issues/24
	-- use({"ojroques/vim-oscyank", branch= "main"})

	use({
		"beauwilliams/focus.nvim",
		config = function()
			require("focus").setup()
		end,
	})
	-- Or lazy load with `module` option. See further down for info on how to lazy load when using FocusSplit commands
	-- Or lazy load this plugin by creating an arbitrary command using the cmd option in packer.nvim
	-- use { 'beauwilliams/focus.nvim', cmd = { "FocusSplitNicely", "FocusSplitCycle" }, module = "focus",
	--     config = function()
	--         require("focus").setup({hybridnumber = true})
	--     end
	-- }

	-- The fastest Neovim colorizer
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	use({ "junegunn/goyo.vim" })

	-- Packer
	use({
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup()
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	})

	if packer_bcs then
		require("packer").sync()
	end
end)
