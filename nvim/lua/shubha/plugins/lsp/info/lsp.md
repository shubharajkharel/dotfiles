# lsp setup
It's important that you set up the plugins in the following order:
    - mason.nvim
    - mason-lspconfig.nvim
    - lsp saga
    - lspconfig
    - null_ls
    - mason_null_ls

# Lsp options:
    - https://github.com/williamboman/mason-lspconfig.nvim#configuration
    - python:
        - python-lsp:
            - fork of spider ide
            - has extensions for black, mypy etc
        - pyright:
            - made by microsoft
            - so no extras non lsp feature like black or my py
# Lsp Plugins

1. nvim-lspconfig:
    - quickstart config for nvim lsp
    - example:
        - require'lspconfig'.pyright.setup{}
    - suggested configurations:
        - https://github.com/neovim/nvim-lspconfig#Suggested-configuration

2. cmp-nvim-lsp:
    - nvim-cmp source for builtin server client
    - " provide different completion results depending
        on the capabilities of the client. Neovim's
        default omnifunc has basic support for serving completion candidates.
        nvim-cmp supports more types of completion candidates, so users must
        override the capabilities sent to the server such that it can provide
        these candidates during a completion request. These capabilities are
        provided via the helper function require('cmp_nvim_lsp').default_capabilities"

3. lspsaga:
    - lsp plugin
    - built on nvim builtin lsp
    - but with high performant UI?
    - example configurations:
        - https://github.com/glepnir/lspsaga.nvim#configuration

4. nul-ls:
    - extends capabilittes of nvimp lsp servers
    - like by adding formatting capability to python server
    - umm... so lsp has no formatter?
    - https://www.reddit.com/r/neovim/comments/t0af8y/what_is_the_purpose_of_nulllsnvim_ive_read_the/
    - can adds code actions to python!
    - or like making grammer correction
    - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

5. lspkind:
    - adds icons type for suggestions list
    - can be configured in default lsp or nvim-cmp file

6. mason:
    1. main:
        - package manger for nvim
        - installs LSP, DAP, linters and formatters
        - recommended external packages for better integration:
            - LSP: lspconfig & mason-lspconfig.nvim
            - DAP: nvim-dap
            - Linters: null-ls.nvim or nvim-lint
            - Formatters: null-ls.nvim or formatter.nvim
    2. mason-support plugins:
        - mason-lspconfig:
            - bridges gap between mason and lsp config
            - see important setup guide
            - you can auto lsp config servers installed through mason as well:
                - :h mason-lspconfig-automatic-server-setup
        - mason-null-ls:
            - bridges gap in bween mason and null ls
            - see importatn setup config
