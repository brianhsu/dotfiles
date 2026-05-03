local M = {}

function M.setup()
  vim.keymap.set({'n', 'x'}, '<Leader>c', '', {desc = 'Coding...'})

  vim.keymap.set({'n', 'x'}, '<Leader>ca', '<CMD>Lspsaga code_action<CR>', {desc = ' Code Actions.'})
  vim.keymap.set({'n', 'x'}, '<Leader>cr', '<CMD>Lspsaga rename<CR>', {desc = ' Rename'})
  vim.keymap.set({'n', 'x'}, '<Leader>cf', '<CMD>Lspsaga finder<CR>', {desc = ' Code Finder'})
  vim.keymap.set({'n', 'x'}, '<Leader>cD', '<CMD>Lspsaga hover_doc ++keep<CR>', {desc = ' Toggle Documentation'})

  vim.keymap.set({'n', 'x'}, '<Leader>cd', '', {desc = 'Diagnostic...'})
  vim.keymap.set({'n', 'x'}, '<Leader>cdi', vim.diagnostic.open_float, {desc = ' Show inline diagnostic.'})
  vim.keymap.set({'n', 'x'}, '<Leader>cda', '<CMD>Trouble diagnostics<CR>', {desc = ' Show all diagnostic.'})

  vim.keymap.set({'n', 'x'}, '<Leader>cp', '', {desc = 'Peak...'})
  vim.keymap.set({'n', 'x'}, '<Leader>cpd', '<CMD>Lspsaga peek_definition<CR>', {desc = 'Peak Definitions.'})
  vim.keymap.set({'n', 'x'}, '<Leader>cpt', '<CMD>Lspsaga peek_type_definition<CR>', {desc = 'Peak Type Definitions.'})

  vim.keymap.set({'n', 'x'}, '<Leader>cg', '', {desc = 'Go to...'})
  vim.keymap.set({'n', 'x'}, '<Leader>cgd', '<CMD>Trouble lsp_definitions<CR>', {desc = ' Definitions.'})
  vim.keymap.set({'n', 'x'}, '<Leader>cgD', '<CMD>Trouble lsp_declartions<CR>', {desc = ' Declartions.'})
  vim.keymap.set({'n', 'x'}, '<Leader>cgi', '<CMD>Trouble lsp_implementations<CR>', {desc = ' Implemention.'})
  vim.keymap.set({'n', 'x'}, '<Leader>cgI', '<CMD>Trouble lsp_incoming_calls<CR>', {desc = ' Incomming calls.'})
  vim.keymap.set({'n', 'x'}, '<Leader>cgo', '<CMD>Trouble lsp_outgoing_calls<CR>', {desc = ' Outogoing calls.'})
  vim.keymap.set({'n', 'x'}, '<Leader>cgr', '<CMD>Trouble lsp_references<CR>', {desc = ' References'})
  vim.keymap.set({'n', 'x'}, '<Leader>cgt', '<CMD>Trouble lsp_type_definitions<CR>', {desc = ' Type Definitions.'})
  vim.keymap.set({'n', 'x'}, '<Leader>cgs', '<CMD>Trouble lsp_document_symbols<CR>', {desc = ' Document Symbols.'})
end

return M
