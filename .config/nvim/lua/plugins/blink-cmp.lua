local M = {}

function M.setup()
  local blink = require('blink.cmp')
--  blink.build():wait(180000)


  blink.setup({
    fuzzy = { implementation = "lua" },
    signature = {
      enabled = true,
      window = {
        show_documentation = true
      }
    },
    completion = {
      keyword = { range = 'prefix' },
    },
    keymap = {
      preset = 'enter',
      ['<Tab>'] = {'accept', 'fallback'},
      ['<C-p>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },
    cmdline = {
      enabled = false,
    },
  })

end

return M
