local M = {}

function M.setup()
  vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<CMD>lua require('spider').motion('w')<CR>")
  vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<CMD>lua require('spider').motion('e')<CR>")
  vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<CMD>lua require('spider').motion('b')<CR>")
  vim.keymap.set({ 'n', 'o', 'x' }, 'ge', "<CMD>lua require('spider').motion('ge')<CR>")

  local textobjects = require("nvim-treesitter-textobjects.select")

  vim.keymap.set({ "x", "o" }, "am", function() textobjects.select_textobject("@function.outer", "textobjects") end, {desc = 'Method'})
  vim.keymap.set({ "x", "o" }, "im", function() textobjects.select_textobject("@function.inner", "textobjects") end, {desc = 'Method'})
  vim.keymap.set({ "x", "o" }, "ac", function() textobjects.select_textobject("@class.outer", "textobjects") end, {desc = 'Class'})
  vim.keymap.set({ "x", "o" }, "ic", function() textobjects.select_textobject("@class.inner", "textobjects") end, {desc = 'Class'})
  vim.keymap.set({ "x", "o" }, "as", function() textobjects.select_textobject("@local.scope", "locals") end, {desc = 'Scope'})
end

return M
