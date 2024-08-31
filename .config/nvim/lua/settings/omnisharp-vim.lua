local module = {}

local function run_command(command)
    return function()
        vim.cmd(command)
    end
end

local function define_short_commands()
    vim.api.nvim_create_user_command('FindImplementations', run_command('OmniSharpFindImplementations'), {})
    vim.api.nvim_create_user_command('FindMembers', run_command('OmniSharpFindMembers'), {})
    vim.api.nvim_create_user_command('FindSymbol', run_command('OmniSharpFindSymbol'), {})
    vim.api.nvim_create_user_command('FindType', run_command('OmniSharpFindType'), {})
    vim.api.nvim_create_user_command('FindUsages', run_command('OmniSharpFindUsages'), {})
    vim.api.nvim_create_user_command('GotoDefinition', run_command('OmniSharpGotoDefinition'), {})
    vim.api.nvim_create_user_command('GotoTypeDefinition', run_command('OmniSharpGotoTypeDefinition'), {})
    vim.api.nvim_create_user_command('NavigateUp', run_command('OmniSharpNavigateUp'), {})
    vim.api.nvim_create_user_command('NavigateDown', run_command('OmniSharpNavigateDown'), {})
    vim.api.nvim_create_user_command('PreviewDefinition', run_command('OmniSharpPreviewDefinition'), {})
    vim.api.nvim_create_user_command('PreviewImplementation', run_command('OmniSharpPreviewImplementation'), {})
    vim.api.nvim_create_user_command('Rename', run_command('OmniSharpRename'), {})
    vim.api.nvim_create_user_command('TypeLookup', run_command('OmniSharpTypeLookup'), {})
    vim.api.nvim_create_user_command('SignatureHelp', run_command('OmniSharpSignatureHelp'), {})
    vim.api.nvim_create_user_command('Documentation', run_command('OmniSharpDocumentation'), {})
end

function module.configure()
    vim.g.OmniSharp_server_path = '/usr/bin/OmniSharp'
    vim.g.OmniSharp_selector_ui = ''
    vim.g.OmniSharp_popup_options = {
        winblend = 10,
        winhl = 'Normal:Normal,FloatBorder:Special',
        border = 'rounded'
    }
    vim.g.OmniSharp_popup_mappings = {
        sigNext = '<C-k>',
        sigPrev = '<C-i>',
        sigParamNext = '<C-l>',
        sigParamPrev = '<C-j>',
        pageDown = '<PageDown>',
        pageUp = '<PageUp>'
    }

    define_short_commands()
end

return module
