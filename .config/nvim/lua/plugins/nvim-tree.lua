local M = {}

function M.setup()
  require('nvim-tree').setup({
    sort = { sorter = 'case_sensitive' },
    renderer = { group_empty = true },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
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

return M
