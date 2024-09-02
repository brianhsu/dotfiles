local module = {}

function module.configure(actions_preview)
    vim.keymap.set({'n', 'x'}, '<LEADER>c', '', {desc = 'Conding Related.'})
    vim.keymap.set('n', '<LEADER>ca', actions_preview.code_actions, {desc = 'Open code actions.'})

    vim.keymap.set('n', '<LEADER>cd', '', {desc = 'Open Documentation...'})
    vim.keymap.set('n', '<LEADER>cdf', '<ESC><CMD>CLSPDocumentationFloating<CR>', {desc = 'Open Floating Documentation.'})
    vim.keymap.set('n', '<LEADER>cds', '<ESC><CMD>CLSPDocumentationSide<CR>', {desc = 'Open Floating Documentation.'})

    vim.keymap.set('n', '<LEADER>cs', '<ESC><CMD>CLSPSignatureHelp<CR>', {desc = 'Shwo Signature Helper.'})

    vim.keymap.set('n', '<LEADER>cs', '', {desc = 'Show symbols...'})
    vim.keymap.set('n', '<LEADER>csd', '<ESC><CMD>CLSPDocumentSymbol<CR>', {desc = 'Show symbols of current document.'})
    vim.keymap.set('n', '<LEADER>csw', '<ESC><CMD>CLSPWorkspaceSymbol<CR>', {desc = 'Show symbols of current workspace.'})

    vim.keymap.set('n', '<LEADER>cF', '<ESC><CMD>CLSPFormat<CR>', {desc = 'Format code.'})
    vim.keymap.set('n', '<LEADER>cR', '<ESC><CMD>CLSPRename<CR>', {desc = 'Rename symbol.'})

    vim.keymap.set('n', '<LEADER>cf', '', {desc = 'Find...'})
    vim.keymap.set('n', '<LEADER>cfi', '<ESC><CMD>CLSPIncommingCalls<CR>', {desc = 'Find incomming call.'})
    vim.keymap.set('n', '<LEADER>cfo', '<ESC><CMD>CLSPOutgoingCalls<CR>', {desc = 'Find outcomming call.'})
    vim.keymap.set('n', '<LEADER>cfr', '<ESC><CMD>CLSPReference<CR>', {desc = 'Find references.'})

    vim.keymap.set('n', '<LEADER>cg', '', {desc = 'Goto...'})
    vim.keymap.set('n', '<LEADER>cgd', '<ESC><CMD>CLSPDefinition<CR>', {desc = 'Goto definition.'})
    vim.keymap.set('n', '<LEADER>cgD', '<ESC><CMD>CLSPDeclaration<CR>', {desc = 'Goto declartion.'})
    vim.keymap.set('n', '<LEADER>cgi', '<ESC><CMD>CLSPImplementation<CR>', {desc = 'Goto implementation.'})
    vim.keymap.set('n', '<LEADER>cgt', '<ESC><CMD>CLSPTypeDefinition<CR>', {desc = 'Goto type definition.'})

    vim.keymap.set('n', '<LEADER>ch', '<ESC><CMD>CLSPTypeHierarchy<CR>', {desc = 'Type hierarchy.'})

end

return module

