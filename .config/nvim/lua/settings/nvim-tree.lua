local module = {}

function module.configure()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('nvim-tree').setup({
      sort = { sorter = 'case_sensitive' },
      view = { width = 32 },
      renderer = { group_empty = true },
      filters = {
        dotfiles = true,
        git_ignored = true
      },
      actions = {
        open_file = {
            quit_on_open = true
        }
      }
    })
end

return module
