local iron = require("iron.core")

local view = require("iron.view")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        command = {"zsh"}
      }
    },

    ---------------------------------------------------------------------------------
    --                  VIE LOCATION
    repl_open_cmd = view.split.vertical("33%"), -- ratio
    -- repl_open_cmd = require("iron.view").right(40),
        -- How the repl window will be displayed
        -- See below for more information
        -- currently there are four positions: left, right, bottom, top,
        -- the param is the width/height of the float window

    -- One can always use the default commands from vim directly
    -- repl_open_cmd = "vertical botright 80 split"
        -- It accepts:
        --   - vertical
        --   - leftabove/aboveleft
        --   - rightbelow/belowright
        --   - topleft
        --   - botright
    -- repl_open_cmd = view.split.vertical.botright(50)
    -- repl_open_cmd = view.split.vertical.botright(0.61903398875), -- ratio
    -- repl_open_cmd = view.split("40%")

    -- repl_open_cmd = view.split.topleft(function()
      -- if some_check then
        -- return vim.o.lines * 0.4
      -- end
      -- return 20
    -- end)
            -- The size parameter can be a number, a string or a function.
            -- When it's a *number*, it will be the size in rows/columns
            -- If it's a *string*, it requires a "%" sign at the end and is calculated
            -- as a percentage of the editor size
            -- If it's a *function*, it should return a number for the size of rows/columns

    -- repl_open_cmd = view.split("40%", {
      -- winfixwidth = false,
      -- winfixheight = false,
      -- any window-local configuration can be used here
      -- number = true
    -- })
            -- An optional set of options can be given to the split function if one
            -- wants to configure the window behavior.
            -- Note that, by default `winfixwidth` and `winfixheight` are set
            -- to `true`. If you want to overwrite those values,
            -- you need to specify the keys in the option map as the example below

    --------------------------------------------------------------------------------
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    -- send_motion = "<space>sc",
    visual_send = "<leader>rr",
    send_file = "<leader>rf",
    send_line = "<leader>rr",
    -- send_mark = "<leader>sm",
    -- mark_motion = "<leader>mc",
    -- mark_visual = "<leader>mc",
    -- remove_mark = "<leader>md",
    -- cr = "<leader>r<cr>",
    interrupt = "<leader>ri",
    -- exit = "<leader>rq", -- IronRestart seems to do better job
    clear = "<leader>rc",

    -- send_motion = "<space>sc",
    -- visual_send = "<space>sc",
    -- send_file = "<space>sf",
    -- send_line = "<space>sl",
    -- -- send_mark = "<space>sm",
    -- mark_motion = "<space>mc",
    -- mark_visual = "<space>mc",
    -- remove_mark = "<space>md",
    -- cr = "<space>s<cr>",
    -- interrupt = "<space>s<space>",
    -- exit = "<space>sq",
    -- clear = "<space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, checj nvim_set_hl
  highlight = {
    italic = false,
    -- italic = true
  },
} 

 -- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<leader>r<leader>', '<cmd>IronRepl<cr>') -- this does focus toggle already
vim.keymap.set('n', '<leader>rq', '<cmd>IronRestart<cr>')
-- vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
-- vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')
