local module = {}


local function define_keymaps(telescope)

    vim.keymap.set('n', '<LEADER>cu', '<ESC><CMD>OmniSharpFixUsings<CR>', {desc = 'Fix usings.', buffer = true})

    vim.keymap.set('n', '<LEADER>cf', '', {desc = 'Find...', buffer = true})
    vim.keymap.set('n', '<LEADER>cfi', '<ESC><CMD>OmniSharpFindImplementations<CR>', {desc = 'Find implementations.', buffer = true})
    vim.keymap.set('n', '<LEADER>cfm', '<ESC><CMD>OmniSharpFindMembers<CR>', {desc = 'Find members.', buffer = true})
    vim.keymap.set('n', '<LEADER>cfs', '<ESC><CMD>OmniSharpFindSymbol<CR>', {desc = 'Find symbol.', buffer = true})
    vim.keymap.set('n', '<LEADER>cft', '<ESC><CMD>OmniSharpFindType<CR>', {desc = 'Find type.', buffer = true})
    vim.keymap.set('n', '<LEADER>cfu', '<ESC><CMD>OmniSharpFindUsages<CR>', {desc = 'Find usages.', buffer = true})

    vim.keymap.set('n', '<LEADER>cg', '', {desc = 'Go to...', buffer = true})
    vim.keymap.set('n', '<LEADER>cgd', '<ESC><CMD>OmniSharpGotoDefinition<CR>', {desc = 'Go to definition.', buffer = true})
    vim.keymap.set('n', '<LEADER>cgt', '<ESC><CMD>OmniSharpGotoTypeDefinition<CR>', {desc = 'Go to type definition', buffer = true})

    vim.keymap.set('n', '<LEADER>cn', '', {desc = 'Navigation to...', buffer = true})
    vim.keymap.set('n', '<LEADER>cnu', '<ESC><CMD>OmniSharpNavigateUp<CR>', {desc = 'Navigation up.', buffer = true})
    vim.keymap.set('n', '<LEADER>cnd', '<ESC><CMD>OmniSharpNavigateDown<CR>', {desc = 'Navigation down.', buffer = true})

    vim.keymap.set('n', '<LEADER>cp', '', {desc = 'Preview...', buffer = true})
    vim.keymap.set('n', '<LEADER>cpd', '<ESC><CMD>OmniSharpPreviewDefinition<CR>', {desc = 'Preview definition.', buffer = true})
    vim.keymap.set('n', '<LEADER>cnd', '<ESC><CMD>OmniSharpPreviewImplementation<CR>', {desc = 'Preview impelementation.', buffer = true})

    vim.keymap.set('n', '<LEADER>cr', '<ESC><CMD>OmniSharpRename<CR>', {desc = 'Rename...', buffer = true})
    vim.keymap.set('n', '<LEADER>ct', '<ESC><CMD>OmniSharpTypeLookup<CR>', {desc = 'Type lookup.', buffer = true})
    vim.keymap.set('n', '<LEADER>cs', '<ESC><CMD>OmniSharpSignatureHelp<CR>', {desc = 'Signature help.', buffer = true})
    vim.keymap.set('n', '<LEADER>cd', '<ESC><CMD>OmniSharpDocumentation<CR>', {desc = 'Open documentation.', buffer = true})

    vim.keymap.set({'n', 'x'}, '<leader>cR', telescope.extensions.refactoring.refactors, {desc = 'Refactor', buffer = true})
end

function module.configure(telescope)

    vim.api.nvim_create_augroup("csharp", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        group = "csharp",
        pattern = "cs",
        callback = function ()
            define_keymaps(telescope)

        end
    })
end

return module
