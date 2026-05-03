local M = {}

local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

local function find_files_in_home()
  builtin.find_files({ cwd = '~/' })
end

local function find_files_in_buffer_dir()
    builtin.find_files({ cwd = utils.buffer_dir() })
end

function M.setup()

  vim.keymap.set({'n', 'x'}, '<Leader>s', '', {desc = 'Telescope search'})
  vim.keymap.set({'n', 'x'}, '<Leader>sf', '', {desc = 'Search files...'})
  vim.keymap.set({'n', 'x'}, '<Leader>sfw', builtin.find_files, {desc = 'Search files in working directory.'})
  vim.keymap.set({'n', 'x'}, '<Leader>sfh', find_files_in_home, {desc = 'Search files in home.'})
  vim.keymap.set({'n', 'x'}, '<Leader>sfb', find_files_in_buffer_dir, {desc = 'Search files in buffer directory.'})

  vim.keymap.set({'n', 'x'}, '<Leader>sg', builtin.live_grep, {desc = ' Live Grep.'})
  vim.keymap.set({'n', 'x'}, '<Leader>sb', builtin.buffers, {desc = ' Search buffers.'})
  vim.keymap.set({'n', 'x'}, '<Leader>sp', '<CMD>Telescope projects<CR>', {desc = ' Search projects.'})
end

return M
