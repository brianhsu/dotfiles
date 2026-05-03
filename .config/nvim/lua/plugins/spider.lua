local M = {}

function M.setup()
  require("spider").setup {
    skipInsignificantPunctuation = false
  }
end

return M
