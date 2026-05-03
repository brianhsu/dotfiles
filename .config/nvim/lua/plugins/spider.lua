local M = {}

function M.setup()
  require("spider").setup {
    skipInsignificantPunctuation = true,
    consistentOperatorPending = true
  }
end

return M
