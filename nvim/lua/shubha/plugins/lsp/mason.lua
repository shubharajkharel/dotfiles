---------------------------------------------------------------------------------------------------------------
--                             setup mason 
---------------------------------------------------------------------------------------------------------------
-- It's important that you set up the plugins in the following order:
    -- mason.nvim
    -- mason-lspconfig.nvim
    -- lsp saga
    -- lspconfig
    -- null_ls
    -- mason_null_ls

-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then print('mason not found') return end

-- enable mason
-- default config: https://github.com/williamboman/mason.nvim#configuration
mason.setup()


---------------------------------------------------------------------------------------------------------------
--                             setup mason-lspconfig
---------------------------------------------------------------------------------------------------------------
-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then print('mason-lpsconfig not found') return end

mason_lspconfig.setup({
    -- for some reason the esure option below is not working
    -- use lspconfig directly insteadmason
	ensure_installed = { },

	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--                             mason-nvim-dap
---------------------------------------------------------------------------------------------------------------
-- require("mason-nvim-dap").setup({
--     -- ensure_installed = { "python" }
--     ensure_installed = { "debugpy" }
-- })
