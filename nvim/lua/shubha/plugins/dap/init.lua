local M = {}

local function configure()

local test_runners = require('dap-python').test_runners
-- `test_runners` is a table. The keys are the runner names like `unittest` or `pytest`.
-- The value is a function that takes three arguments:
-- The classname, a methodname and the opts
-- (The `opts` are coming passed through from either `test_method` or `test_class`)
-- The function must return a module name and the arguments passed to the module as list.
test_runners.your_runner = function(classname, methodname, opts)
  local args = {classname, methodname}
  return 'modulename', args
end



-- local dap_install = require("dap-install")
-- dap_install.setup({
-- 	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
-- })


  -- local dap_install = require "dap-install"
  -- dap_install.setup {
  --   installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
  -- }

  local dap_breakpoint = {
    error = {
      text = "🟥",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "⭐️",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function configure_exts()
  require("nvim-dap-virtual-text").setup {
    commented = true,
  }

  local dap, dapui = require "dap", require "dapui"
  -- dapui.setup {} -- use default
  require("shubha.plugins.nvim-dap-ui")
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  -- dap.listeners.before.event_terminated["dapui_config"] = function()
  --   dapui.close()
  -- end
  -- dap.listeners.before.event_exited["dapui_config"] = function()
  --   dapui.close()
  -- end
end

local function configure_debuggers()
  -- require("lua").setup()
  -- require("dap.python").setup()
  require("shubha.plugins.dap.dap_python").setup()

end

function M.setup()
  configure() -- Configuration
  configure_exts() -- Extensions
  configure_debuggers() -- Debugger
  require("shubha.plugins.dap.dap_keymaps").setup()
  -- require("dap.keymaps").setup() -- Keymaps
end

configure_debuggers()

return M
