local M = {}

local function toggle_mouse()
  if vim.o.mouse == "" then
    vim.o.mouse = "nvi"
    vim.notify("Mouse enabled.")
  else
    vim.o.mouse = ""
    vim.notify("Mouse disabled.")
  end
end

function M.setup()
  vim.keymap.set({'n', 'x'}, '<Leader>t', '<CMD>Lspsaga term_toggle fish<CR>', {desc = ' Toggle Terminal.'})

  vim.keymap.set({'n', 'x'}, '<Leader>m', '', {desc = 'Mouse...'})
  vim.keymap.set({'n', 'x'}, '<Leader>mt', toggle_mouse, {desc = 'Toggle Mouse mode'})
  vim.keymap.set({'n', 'x'}, '<Leader>me', function() vim.o.mouse = "nvi" end, {desc = 'Enable Mouse'})
  vim.keymap.set({'n', 'x'}, '<Leader>md', function() vim.o.mouse = ""  end, {desc = 'Disable Mouse'})
end

return M
