local M = {}

function M.setup()
  vim.opt.list = true
  vim.opt.listchars = { tab = '⭾_', trail = '·' }
  vim.opt.number = true
end

return M
