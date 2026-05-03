local M = {}

function M.setup()
  require('bufferline').setup({
    options = {
      diagnostics = "nvim_lsp",
      numbers = "buffer_id",
      separator_style = "slant",
      close_command = function (buffer_id)
        require('mini.bufremove').delete(buffer_id)
      end,
      right_mouse_command = function (buffer_id)
        require('mini.bufremove').delete(buffer_id)
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Tree",
          text_align = "center",
          separator = false
        },
      },
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end
    }
  })
end

return M
