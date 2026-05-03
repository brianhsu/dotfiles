local M = {}

function M.setup()
  require('project').setup()
  require('telescope').load_extension('projects')
end

return M
