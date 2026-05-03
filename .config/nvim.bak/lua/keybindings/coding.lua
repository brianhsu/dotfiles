local module = {}

function module.configure(actions_preview)
    vim.keymap.set({'n', 'x'}, '<LEADER>c', '', {desc = 'Conding Related.'})

    vim.keymap.set({'n', 'x'}, '<LEADER>ca', actions_preview.code_actions, {desc = 'Open code actions.'})
    vim.keymap.set('n', '<LEADER>cs', '<ESC><CMD>CLSPSignatureHelp<CR>', {desc = 'Shwo Signature Helper.'})

    vim.keymap.set('n', '<LEADER>cd', '', {desc = 'Show Diagnostic'})
    vim.keymap.set('n', '<LEADER>cdc', '<ESC><CMD>CLSPDiagnostic<CR>', {desc = 'Show current diagnostic.'})
    vim.keymap.set('n', '<LEADER>cdd', '<ESC><CMD>Trouble diagnostics filter.buf=0<CR>', {desc = 'Show all diagnostic in document.'})

    vim.keymap.set('n', '<LEADER>cD', '', {desc = 'Open Documentation...'})
    vim.keymap.set('n', '<LEADER>cDf', '<ESC><CMD>CLSPDocumentationFloating<CR>', {desc = 'Open Floating Documentation.'})
    vim.keymap.set('n', '<LEADER>cDs', '<ESC><CMD>CLSPDocumentationSide<CR>', {desc = 'Open Side Documentation.'})

    vim.keymap.set('n', '<LEADER>cF', '<ESC><CMD>CLSPFormat<CR>', {desc = 'Format code.'})
    vim.keymap.set('n', '<LEADER>cR', '<ESC><CMD>CLSPRename<CR>', {desc = 'Rename symbol.'})

    vim.keymap.set('n', '<LEADER>cf', '', {desc = 'Find...'})
    vim.keymap.set('n', '<LEADER>cfi', '<ESC><CMD>Trouble lsp_incoming_calls<CR>', {desc = 'Find incomming call.'})
    vim.keymap.set('n', '<LEADER>cfo', '<ESC><CMD>Trouble lsp_outgoing_calls<CR>', {desc = 'Find outcomming call.'})
    vim.keymap.set('n', '<LEADER>cfr', '<ESC><CMD>Trouble lsp_references<CR>', {desc = 'Find references.'})
    vim.keymap.set('n', '<LEADER>cfs', '<ESC><CMD>CLSPWorkspaceSymbol<CR>', {desc = 'Find symbols of current workspace.'})

    vim.keymap.set('n', '<LEADER>cg', '', {desc = 'Goto...'})
    vim.keymap.set('n', '<LEADER>cgd', '<ESC><CMD>CLSPDefinition<CR>', {desc = 'Goto definition.'})
    vim.keymap.set('n', '<LEADER>cgi', '<ESC><CMD>CLSPImplementation<CR>', {desc = 'Goto implementation.'})
    vim.keymap.set('n', '<LEADER>cgt', '<ESC><CMD>CLSPTypeDefinition<CR>', {desc = 'Goto type definition.'})

    vim.keymap.set('n', '<LEADER>ch', '<ESC><CMD>CLSPTypeHierarchy<CR>', {desc = 'Type hierarchy.'})

    vim.keymap.set('n', '<LEADER>ct', '', {desc = 'Unit Test (quiet)...'})
    vim.keymap.set('n', '<LEADER>cta', '<CMD>TestSuiteQuiet<CR>', {desc = 'Run all tests.'})
    vim.keymap.set('n', '<LEADER>ctf', '<CMD>TestFileQuiet<CR>', {desc = 'Run current test file.'})
    vim.keymap.set('n', '<LEADER>ctn', '<CMD>TestNearestQuiet<CR>', {desc = 'Run nearest test.'})
    vim.keymap.set('n', '<LEADER>ctl', '<CMD>TestLastQuiet<CR>', {desc = 'Run last test.'})
    vim.keymap.set('n', '<LEADER>ctv', '<CMD>TestVisit<CR>', {desc = 'Visit last test file.'})

    vim.keymap.set('n', '<LEADER>cT', '', {desc = 'Unit Test...'})
    vim.keymap.set('n', '<LEADER>cTa', '<CMD>TestSuite<CR>', {desc = 'Run all tests.'})
    vim.keymap.set('n', '<LEADER>cTf', '<CMD>TestFile<CR>', {desc = 'Run current test file.'})
    vim.keymap.set('n', '<LEADER>cTn', '<CMD>TestNearest<CR>', {desc = 'Run nearest test.'})
    vim.keymap.set('n', '<LEADER>cTl', '<CMD>TestLast<CR>', {desc = 'Run last test.'})
    vim.keymap.set('n', '<LEADER>cTv', '<CMD>TestVisit<CR>', {desc = 'Visit last test file.'})

end

return module

