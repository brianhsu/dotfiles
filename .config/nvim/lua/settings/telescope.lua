local module = {}

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

function module.search_files_in_workding_dir()
    builtin.find_files()
end

function module.search_files_in_buffer_dir()
    builtin.find_files({ cwd = utils.buffer_dir() })
end

function module.search_files_in_home_dir()
    builtin.find_files({ cwd = '~/' })
end

function module.configure()
    local actions = require("telescope.actions")
    telescope.setup {
        defaults = {
            layout_config = {
                horizontal = { width = 0.95 }
            },
            mappings = {
                i = {
                    ["<C-u>"] = actions.results_scrolling_left,
                    ["<C-o>"] = actions.results_scrolling_right,
                    ["<C-i>"] = actions.preview_scrolling_up,
                    ["<C-k>"] = actions.preview_scrolling_down,
                    ["<C-j>"] = actions.preview_scrolling_left,
                    ["<C-l>"] = actions.preview_scrolling_right
                },
                n = {
                    ["<C-u>"] = actions.results_scrolling_left,
                    ["<C-o>"] = actions.results_scrolling_right,
                    ["<C-i>"] = actions.preview_scrolling_up,
                    ["<C-k>"] = actions.preview_scrolling_down,
                    ["<C-j>"] = actions.preview_scrolling_left,
                    ["<C-l>"] = actions.preview_scrolling_right
                }

            }
        },
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
