local M = {}

function M.setup()
  vim.keymap.set({'n', 'x'}, '<Leader>f', '<CMD>NvimTreeToggle<CR>', {desc = ' Toogle File Tree'})
end

return M
