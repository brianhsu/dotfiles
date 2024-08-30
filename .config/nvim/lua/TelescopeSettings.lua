local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

require('telescope').setup {
  pickers = {
    find_files = {
      follow = true
    }
  }
}

function findFilesInCurrentDir()
    builtin.find_files()
end

function findFilesInBufferDir()
    builtin.find_files({cwd = utils.buffer_dir()})
end

function findFilesInHomeDir()
    builtin.find_files({cwd = "~/"})
end

vim.api.nvim_create_user_command('FindFilesInCurrentDir', findFilesInCurrentDir, {})
vim.api.nvim_create_user_command('FindFilesInBufferDir', findFilesInBufferDir, {})
vim.api.nvim_create_user_command('FindFilesInHomeDir', findFilesInHomeDir, {})
vim.api.nvim_create_user_command('FindBuffers', builtin.buffers, {})
vim.api.nvim_create_user_command('FindGreps', builtin.live_grep, {})
