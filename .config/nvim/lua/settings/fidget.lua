local module = {}

function module.configure()
    require('fidget').setup({
        notification = {
            configs = {
                default = {
                    name = false,
                    icon = false,
                },
            },
            view = {
                group_separator = false,
            },
            window = {
                border = 'rounded',
                winblend = 15
            },
        },
    })
end

return module
