local M = {}

function M.setup()
  require('lspsaga').setup({
    lightbulb = {
      sign = false
    },
    hover = {
      max_width = 0.8,
      max_height = 0.8
    }
  })
end

return M

