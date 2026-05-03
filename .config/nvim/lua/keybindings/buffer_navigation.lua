local M = {}

local function delete_buffer()
  require('mini.bufremove').delete()
end

function M.setup()

  local which_key = require('which-key')

  which_key.add({
    {'<Leader>b', desc = 'Buffers...'},
    {'<Leader>bb', desc = 'Buffer Mode'},
  })

  vim.keymap.set({'n'}, ']b', '<CMD>BufferLineCycleNext<CR>', {desc = 'Next buffer'})
  vim.keymap.set({'n'}, '[b', '<CMD>BufferLineCyclePrev<CR>', {desc = 'Previous buffer'})
  vim.keymap.set({'n', 'x'}, '<Leader>bp', '<CMD>BufferLinePick<CR>', {desc = 'Destroy Buffer'})
  vim.keymap.set({'n', 'x'}, '<Leader>bd', delete_buffer, {desc = 'Destroy Buffer'})
end

return M
