local module = {}
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

function module.find_files_in_workding_dir()
    builtin.find_files()
end

function module.find_files_in_buffer_dir()
    builtin.find_files({cwd = utils.buffer_dir()})
end

function module.find_files_in_home_dir()
    builtin.find_files({cwd = '~/'})
end

function module.configure()
    require('telescope').setup {
      pickers = {
        find_files = {
          follow = true
        }
      }
    }

    vim.api.nvim_create_user_command('FindFilesInWorkingDir', module.find_files_in_workding_dir, {})
    vim.api.nvim_create_user_command('FindFilesInBufferDir', module.find_files_in_buffer_dir, {})
    vim.api.nvim_create_user_command('FindFilesInHomeDir', module.find_files_in_home_dir, {})
    vim.api.nvim_create_user_command('FindBuffers', builtin.buffers, {})
    vim.api.nvim_create_user_command('FindGreps', builtin.live_grep, {})
end

return module
