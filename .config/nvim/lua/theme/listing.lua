local M = {}

local function get_tab_symbol()
  if jit.os == 'Linux' then
    return '⭾_'
  elseif jit.os == 'OSX' then
    return '↹_'
  end
end

function M.setup()
  vim.opt.list = true
  vim.opt.listchars = { tab = get_tab_symbol(), trail = '·' }
  vim.opt.number = true
end

return M
