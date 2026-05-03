local module = {}

function module.configure()
    local suppressed = {
        ['Validate documents'] = true,
        ['Publish Diagnostics'] = true,
    }

    require('fidget').setup({
        progress = {
            display = {
                format_message = function(msg)
                    if suppressed[msg.title] then
                        return nil
                    end
                    return require('fidget.progress.display').default_format_message(msg)
                end,
            },
        },
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
