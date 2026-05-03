local M = {}

local function page_up(cmp)
  local items = require("blink.cmp.completion.list").items

  if #items == 0 then
    return false
  else
    cmp.select_prev({count = 8, auto_insert = false})
    return true
  end
end

local function page_down(cmp)
  local items = require("blink.cmp.completion.list").items

  if #items == 0 then
    return false
  else
    cmp.select_next({count = 8, auto_insert = false})
    return true
  end

end

function M.setup()
  local blink = require('blink.cmp')

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
      ['<PageUp>'] = { page_up, 'fallback' },
      ['<PageDown>'] = { page_down, 'fallback' },
      ['<Tab>'] = {'accept', 'fallback'},
      ['<C-p>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },
    cmdline = {
      enabled = false,
    },
  })

end

return M
