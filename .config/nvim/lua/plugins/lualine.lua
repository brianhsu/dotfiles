local M = {}

local function show_total_lines()
  local current = vim.fn.line(".")
  local total = vim.fn.line("$")

  return current .. "/" .. total
end

local function test()
  local submode = require("submode")
  local mode = require("lualine.utils.mode")
  if submode.mode() ~= nil then
    return submode.mode()
  else
    return mode.get_mode()
  end
end


function M.setup()
  require('lualine').setup({
    options = {
      theme = 'everforest',
      component_separators = { left = '', right = ''},
    },
    sections = {
      lualine_a = {test},
      lualine_y = {"progress", show_total_lines}
    }
  })
end

return M
