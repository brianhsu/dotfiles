local module = {}

function module.configure()
    require('which-key').setup({
        preset = "helix",
        win = {
            wo = {
                winblend = 15
            }
        }
    })
end

return module

