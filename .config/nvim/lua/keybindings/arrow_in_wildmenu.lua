local M = {}

local function change_key_to(default, in_wildmenu)
  return function()
    if vim.fn.wildmenumode() == 1 then
      return in_wildmenu
    else
      return default
    end
  end
end

function M.setup()
  vim.opt.wildcharm = vim.api.nvim_replace_termcodes("<C-Z>", true, true, true):byte()
  vim.keymap.set("c", "<Up>", change_key_to("<Up>", "<Left>"), {expr = true})
  vim.keymap.set("c", "<Down>", change_key_to("<Down>", "<Right>"), {expr = true})
  vim.keymap.set("c", "<Left>", change_key_to("<Left>", "<Up>"), {expr = true})
  vim.keymap.set("c", "<Right>", change_key_to("<Right>", " <BS><C-Z>"), {expr = true})
end

return M
