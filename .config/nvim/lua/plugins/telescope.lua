local M = {}

function M.setup()
  local actions = require("telescope.actions")

  require('telescope').setup({
    pickers = {
      find_files = {
        follow = true
      }
    },
    defaults = {
      file_ignore_patterns = {
        "/target/",
        "./project/project",
        "./project/target",
        "**/*.class"
      },
      layout_config = {
        horizontal = { width = 0.95 }
      },
      mappings = {
        i = {
          ["<C-i>"] = actions.preview_scrolling_up,
          ["<C-k>"] = actions.preview_scrolling_down,
          ["<C-j>"] = actions.preview_scrolling_left,
          ["<C-l>"] = actions.preview_scrolling_right
        },
        n = {
          ["<C-i>"] = actions.preview_scrolling_up,
          ["<C-k>"] = actions.preview_scrolling_down,
          ["<C-j>"] = actions.preview_scrolling_left,
          ["<C-l>"] = actions.preview_scrolling_right
        }
      }
    }
  })
end

return M
