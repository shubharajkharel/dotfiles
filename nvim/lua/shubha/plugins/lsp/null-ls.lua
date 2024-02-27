---------------------------------------------------------------------------------------------------------------
--                             null_ls
---------------------------------------------------------------------------------------------------------------
local null_ls_status, null_ls = pcall(require, "null-ls")
if not null_ls_status then
	print("null_ls not found")
	return
end

-- sources of null-ls
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover
local completion = null_ls.builtins.completion

-- RUFF
local methods = require("null-ls.methods")
local helpers = require("null-ls.helpers")
local function ruff_fix()
	return helpers.make_builtin({
		name = "ruff",
		meta = {
			url = "https://github.com/charliermarsh/ruff/",
			description = "An extremely fast Python linter, written in Rust.",
		},
		method = methods.internal.FORMATTING,
		filetypes = { "python" },
		generator_opts = {
			command = "ruff",
			args = {},
			-- args = { "--fix", "-e", "-n", "--stdin-filename", "$FILENAME", "-" }
			to_stdin = true,
		},
		factory = helpers.formatter_factory,
	})
end

-- config guide: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
local sources = {

	-- snippet enignes
	completion.luasnip, -- Snippet engine for Neovim written in Lua. (installed seperatedly)
	-- completion.vsnip  -- Snippets managed by vim-vsnip.

	-- text, latex ..
	-- code_actions.shellcheck  -- Provides actions to disable ShellCheck errors/warnings either for the current line or for the entire file.
	-- diagnostics.misspell,  -- Checks commonly misspelled English words in source files.
	-- diagnostics.write_good,  -- English prose linter.
	-- diagnostics.proselint,  -- An English prose linter.
	-- formatting.bibclean  -- A portable program (written in C) that will pretty-print syntax check and generally sort out a BibTeX database file.
	-- formatting.textlint,  -- The pluggable linting tool for text and Markdown.
	-- diagnostics.chktex  -- `latex` semantic linter.
	-- diagnostics.mdl,  -- A tool to check Markdown files and flag style issues.
	diagnostics.markdownlint, -- Markdown style and syntax checker.
	-- diagnostics.markdownlint_cli,  -- Markdown style and syntax checker.
	-- code_actions.cspell, -- Injects actions to fix typos found by `cspell`.
	-- code_actions.proselint,  -- An English prose linter. Can fix some issues via code actions.
	-- hover.dictionary  -- Shows the first available definition for the current word under the cursor.
	-- formatting.bean_format,  -- This pure text processing tool will reformat `beancount` input to right-align all the numbers at the same minimal column.
	-- diagnostics.cspell, -- Injects actions to fix typos found by `cspell`.
	-- diagnostics.codespell,  -- Codespell finds common misspellings in text files.
	-- diagnostics.textlint,  -- The pluggable linting tool for text and Markdown.

	-- git
	-- code_actions.gitsigns,  -- Injects code actions for Git operations at the current cursor position (stage / preview / reset hunks blame etc.).
	-- diagnostics.gitlint  -- Linter for Git commit messages.
	-- diagnostics.commitlint  -- commitlint checks if your commit messages meet the conventional commit format.
	-- diagnostics.actionlint  -- Actionlint is a static checker for GitHub Actions workflow files.
	-- diagnostics.semgrep  -- Semgrep is a fast open-source static analysis tool for finding bugs and enforcing code standards at editor commit and CI time.

	-- general
	-- code_actions.refactoring,  -- The Refactoring library based off the Refactoring book by Martin Fowler.
	-- https://github.com/ThePrimeagen/refactoring.nvim#installation

	-- c++ devs
	-- diagnostics.gccdiag  -- gccdiag is a wrapper for any C/C++ compiler (gcc avr-gcc arm-none-eabi-gcc etc) that automatically uses the correct compiler arguments for a file in your project by parsing the `compile_commands.json` file at the root of your project.
	-- diagnostics.cppcheck  -- A tool for fast static analysis of C/C++ code.
	-- diagnostics.checkmake  -- `make` linter.
	-- diagnostics.clang_check  -- ClangCheck combines the LibTooling framework for running a Clang tool with the basic Clang diagnostics by syntax checking specific files in a fast command line interface.
	-- formatting.uncrustify  -- A source code beautifier for C C++ C# ObjectiveC D Java Pawn and Vala.
	-- formatting.clang_format  -- Tool to format C/C++/… code according to a set of rules and heuristics.
	-- formatting.astyle  -- Artistic Style is a source code indenter formatter and beautifier for the C C++ C++/CLI Objective‑C C# and Java programming languages. This formatter works well for [Arduino](https://www.arduino.cc/) project files and is the same formatter used in the Arduino IDE.

	-- cmake
	-- diagnostics.cmake_lint  -- Check cmake listfiles for style violations common mistakes and anti-patterns.
	-- formatting.gersemi  -- A formatter to make your CMake code the real treasure
	-- formatting.cmake_format  -- Parse cmake listfiles and format them nicely.

	-- sql
	-- formatting.sql_formatter  -- A whitespace formatter for different query languages
	-- formatting.sqlformat  -- The sqlformat command-line tool can reformat SQL files according to specified options.

	-- yaml
	-- formatting.yamlfmt, -- yamlfmt is an extensible command line tool or library to format yaml files.
	diagnostics.yamllint, -- A linter for YAML files.
	-- pretterd does formatting as well

	-- shell
	formatting.beautysh, -- A Bash beautifier for the masses.
	diagnostics.shellcheck, -- A shell script static analysis tool.

	-- json
	-- formatting.fixjson  -- A JSON file fixer/formatter for humans using (relaxed) JSON5.

	-- lua
	formatting.stylua, -- An opinionated code formatter for Lua.

	-- python
	-- formatting.yapf,  -- Formatter for Python.
	-- formatting.isort, -- Python utility / library to sort imports alphabetically and automatically separate them into sections and by type.
	-- formatting.blue,  -- Blue -- Some folks like black but I prefer blue.mason
	formatting.black, -- The uncompromising Python code formatter
	-- formatting.usort,  -- Safe minimal import sorting for Python projects.
	-- formatting.autopep8, -- A tool that automatically formats Python code to conform to the PEP 8 style guide.mason

	-- formatting.prettier, -- Prettier is an opinionated code formatter. It enforces a consistent style by parsing your code and re-printing it with its own rules that take the maximum line length into account wrapping code when necessary.
	-- formatting.prettier_standard,  -- Formats with Prettier and lints with ESLint+Standard! (✿◠‿◠)
	-- formatting.prettier_d_slim  -- Makes prettier fast.
	formatting.prettierd, -- prettier as a daemon for ludicrous formatting speed.
	-- formatting.prettier.with({
	-- 	filetype = { markdown },
	--        extra_args = { "--tab-width", "0" }
	-- }),

	-- diagnostics.mypy, -- Mypy is an optional static type checker for Python that aims to combine the benefits of dynamic (or "duck") typing and static typing.

	-- An extremely fast Python linter written in Rust.
	-- conig source: https://github.com/charliermarsh/ruff#installation-and-usage
	-- diagnostics.ruff,

	-- diagnostics.pyproject_flake8,  -- pyproject-flake8 is a flake8 wrapper to use with `pyproject.toml` configuration.
	-- diagnostics.pylama  -- Code audit tool for Python.
	-- diagnostics.pydocstyle  -- pydocstyle is a static analysis tool for checking compliance with Python docstring conventions.
	-- diagnostics.pycodestyle  -- pycodestyle is a tool to check your Python code against some of the style conventions in PEP 8.
	-- diagnostics.flake8  -- flake8 is a python tool that glues together pycodestyle pyflakes mccabe and third-party plugins to check the style and quality of Python code.

	-- formatting.mdformat, -- pip install mdformat

	-- An extremely fast Python linter written in Rust.
	-- conig source: https://github.com/charliermarsh/ruff#installation-and-usage
	-- ruff_fix(),
	diagnostics.ruff,
}

null_ls.setup({
	sources = sources,
	debug = true,
})

---------------------------------------------------------------------------------------------------------------
--                             set keymap here because lsp maynot attach to main file
--                             TODO: set attach for null-lsp as well
---------------------------------------------------------------------------------------------------------------

local keymap = vim.keymap

-- keybind options
local opts = {
	noremap = true,
	silent = true,
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
