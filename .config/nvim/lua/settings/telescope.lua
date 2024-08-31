local module = {}

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

function module.search_files_in_workding_dir()
    builtin.find_files()
end

function module.search_files_in_buffer_dir()
    builtin.find_files({cwd = utils.buffer_dir()})
end

function module.search_files_in_home_dir()
    builtin.find_files({cwd = '~/'})
end

function module.configure()
    telescope.setup {
      pickers = {
        find_files = {
          follow = true
        }
      }
    }

    vim.api.nvim_create_user_command('SearchFilesInWorkingDir', module.search_files_in_workding_dir, {})
    vim.api.nvim_create_user_command('SearchFilesInBufferDir', module.search_files_in_buffer_dir, {})
    vim.api.nvim_create_user_command('SearchFilesInHomeDir', module.search_files_in_home_dir, {})
    vim.api.nvim_create_user_command('SearchBuffers', builtin.buffers, {})
    vim.api.nvim_create_user_command('SearchGreps', builtin.live_grep, {})
end
module.telescope = telescope
return module
