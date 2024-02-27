---------------------------------------------------------------------------
--                              configure diagnostic symbols
---------------------------------------------------------------------------------------------------------------

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- config diagnostic text
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
})

--------------------------------------------------------------------------------
--                              cmp_nvim_lsp
-------------------------------------------------------------------------------
-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    print("cmp_nvim_lsp not found")
    return
end
-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- ---------------------------------------------------------------------------------------------------------------
-- --                              keymaps for lsp
-- ---------------------------------------------------------------------------------------------------------------
-- enable keybinds only for when lsp server available
local keymap = vim.keymap
local on_attach = function(client, bufnr)
    -- autocompletion for function parameters
    -- require("lsp_signature").on_attach(opts)
    require("shubha.plugins.lsp_signature")

    -- keybind options
    local opts = {
        noremap = true,
        silent = true,
        buffer = bufnr,
    }

    -- set keybinds
    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references

    -- Peek Definition
    -- you can edit the definition file in this flaotwindow
    -- also support open/vsplit/etc operation check definition_action_keys
    -- support tagstack C-t jump back
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)

    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename

    keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
    keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions

    -- Diagnsotic jump can use `<c-o>` to jump back
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer

    -- Only jump to error
    keymap.set("n", "[E", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })
    keymap.set("n", "]E", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })

    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

    keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

    -- Float terminal
    keymap.set("n", "<C-x>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
    -- if you want pass somc cli command into terminal you can do like this
    -- open lazygit in lspsaga float terminal
    -- keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", opts)
    -- close floaterm
    keymap.set("t", "<C-x>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

    -- consider adding these later
    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)

    -- auto format buffer
    keymap.set("n", "<leader>F", function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

-- vim.lsp.buf.format({
-- 	filter = function(client)
-- 		return client.name == "null-ls"
-- 	end,
-- 	bufnr = bufnr,
-- }),
-- { silent = true }

---------------------------------------------------------------------------------------------------------------
--                              Install these lsp
---------------------------------------------------------------------------------------------------------------
local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}
-- configuration guide
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- Python LSP
require('lspconfig')['pyright'].setup{ capabilities = capabilities, on_attach = on_attach, flags = lsp_flags, }

-- require("lspconfig")["pyright"].setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = lsp_flags,
--     settings = {
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 diagnosticMode = "workspace",
--                 useLibraryCodeForTypes = true,
--             },
--         },
--     },
-- })

-- pylsp configs: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
-- lspconfig guide: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
-- pylsp is slow but seems to find the help definition
-- TODO: fix pylsp not finding help document

-- require("lspconfig")["pylsp"].setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = lsp_flags,
--     settings = {
--         pylsp = {
--             plugins = {
--                 maccabe = { -- checks complexity
--                     enabled = false,
--                     threshold = 15, -- default: 15
--                 },
--                 yapf = { -- formatter (doesnt seem to work. use null-ls)
--                     enabled = false,
--                 },
--                 rope_autoimport = {
--                     enabled = false,
--                     memory = true,
--                 },
--                 rope_completion = {
--                     enabled = true,
--                 },
--                 autopep8 = {
--                     enabled = false, -- use yapf istead
--                 },
--                 pycodestyle = {
--                     enabled = false,
--                 },
--             },
--         },
--     },
-- })


-- Other LSPs
require("lspconfig")["bashls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
})

require("lspconfig")["yamlls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    lags = lsp_flags,
})

-- require("lspconfig")["sumneko_lua"].setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = lsp_flags,
-- })

-- require('lspconfig')['marksman'].setup{
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }


-- require('lspconfig')['ltex'].setup{
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }

-- require('lspconfig')['cmake'].setup{
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }
