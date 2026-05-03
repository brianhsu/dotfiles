local M = {}


function M.setup()

  local which_key = require('which-key')

  which_key.add({
    {'<Leader>w', desc = 'Windows...'},
    {'<Leader>ww', desc = 'Window Navigation Mode'},
  })

  vim.keymap.set({'n', 'x'}, '<Leader>wc', '<CMD>close<CR>', {desc = "Close focused window"})
  vim.keymap.set({'n', 'x'}, '<Leader>wo', '<CMD>only<CR>', {desc = "Keep only focused window"})
  vim.keymap.set({'n', 'x'}, '<Leader>wn', '<C-w>n', {desc = "Next window"})
  vim.keymap.set({'n', 'x'}, '<C-q>', '<C-w>')
end

return M
