local M = {}

function M.setup()
  require('fidget').setup({
    notification = {
      window = {
        border = 'rounded',
        winblend = 15
      }
    },
    progress = {
      ignore = {
        function(msg)
          return string.find(msg.title, "Validate documents") ~= nil
        end,
        function(msg)
          return string.find(msg.title, "Publish Diagnostics") ~= nil
        end,
      },
    }
  })
end

return M
