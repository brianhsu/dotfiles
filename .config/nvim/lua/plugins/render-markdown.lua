
local M = {}

function M.setup()
  require('render-markdown').setup({
    anti_conceal = {
      enabled = false,
      disabled_modes = {'n'}
    }
  })
end

return M

