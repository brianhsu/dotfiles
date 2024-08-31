local module = {}

function module.configure()
    vim.g.OmniSharp_server_path = '/usr/bin/OmniSharp'
    vim.g.OmniSharp_popup_options = {
        winblend = 30,
        winhl = 'Normal:Normal,FloatBorder:Special',
        border = 'rounded'
    }
end

return module
