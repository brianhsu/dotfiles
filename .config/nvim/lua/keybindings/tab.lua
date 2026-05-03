local M = {}

local previous_local_shiftwidth = nil

local function default_to_spaces(filetypes, indent)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = function()
      vim.opt_local.shiftwidth = indent
      vim.opt_local_expandtab = false
    end
  })
end

function M.tab_as_spaces()
  if previous_local_shiftwidth ~= nil then
    vim.opt.shiftwidth = previous_local_shiftwidth
  else
    vim.opt.shiftwidth = 4
  end
  vim.opt.expandtab = true
end

function M.tab_as_tab()
  previous_local_shiftwidth = vim.opt_local.shiftwidth:get()

  vim.opt.shiftwidth=8
  vim.opt.expandtab=false
end


function M.setup()
  vim.api.nvim_create_user_command('TabAsSpaces', M.tab_as_spaces, {desc = 'Switch Tab to insert SPACEs'})
  vim.api.nvim_create_user_command('TabAsTabs', M.tab_as_tab, {desc = 'Switch Tab to insert TAB'})

  default_to_spaces({'lua', 'scala', 'html'}, 2)
  default_to_spaces({'java', 'groovy'}, 4)

  M.tab_as_spaces()
end

return M


