local M = {}

function M.setup()
  local submode = require("submode")

  submode.create("Window", {
    mode = "n",
    show_mode = true,
    enter = "<Leader>ww",
    leave = { "<ESC>", "<CR>" },
    leave_when_mode_changed = true,
    hook = {
      on_enter = require('lualine').refresh,
      on_leave = require('lualine').refresh
    },
    default = function(register)
      register("n", "<C-w>w")

      register("w", "<C-w>k")
      register("s", "<C-w>j")
      register("a", "<C-w>h")
      register("d", "<C-w>l")

      register("i", "<C-w>k")
      register("k", "<C-w>j")
      register("j", "<C-w>h")
      register("l", "<C-w>l")

      register("<Up>", "<C-w>k")
      register("<Down>", "<C-w>j")
      register("<Left>", "<C-w>h")
      register("<Right>", "<C-w>l")

      register("w", "<C-w>k")
      register("s", "<C-w>j")
      register("a", "<C-w>h")
      register("d", "<C-w>l")

      register("+", "<C-w>+")
      register("-", "<C-w>-")
      register("<", "<C-w><")
      register(">", "<C-w>>")

      register("c", "<CMD>close<CR>")
      register("o", "<CMD>only<CR>")

    end
  })

  submode.create("Buffer", {
    mode = "n",
    show_mode = true,
    enter = "<Leader>bb",
    leave = { "<ESC>", "<CR>" },
    leave_when_mode_changed = true,
    hook = {
      on_enter = require('lualine').refresh,
      on_leave = require('lualine').refresh
    },
    default = function(register)
      register("j", "<CMD>BufferLineCyclePrev<CR>")
      register("l", "<CMD>BufferLineCycleNext<CR>")

      register("a", "<CMD>BufferLineCyclePrev<CR>")
      register("d", "<CMD>BufferLineCycleNext<CR>")

      register("<Left>", "<CMD>BufferLineCyclePrev<CR>")
      register("<Right>", "<CMD>BufferLineCycleNext<CR>")

      register("p", "<CMD>BufferLinePick<CR>")
    end
  })


end

return M
