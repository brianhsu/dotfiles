local M = {}


function M.setup()
  local which_key = require('which-key')

  which_key.setup({
    preset = "helix",
    icons = {
      rules = {
        { pattern = 'coding', icon ='', color = 'orange'},
        { pattern = 'mouse', icon = '🖱', color = 'white'}
      }
    },
    win = {
      wo = {
        winbled = 15
      }
    }
  })

  which_key.add({
    {'<Leader>', desc = 'Leader'},
    {'K', desc = 'Open LSP Documentation'},
  })

end

return M
