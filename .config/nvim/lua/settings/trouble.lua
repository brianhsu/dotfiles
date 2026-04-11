local module = {}

function module.configure()
    require('trouble').setup({
        modes = {
            qflist = {
                win = {
                    position = 'right',
                    size = 0.3,
                    wo = {
                        wrap = true
                    }
                }
            }
        }
    })
end

return module
