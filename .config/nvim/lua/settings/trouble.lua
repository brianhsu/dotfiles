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

    vim.api.nvim_create_autocmd('DiagnosticChanged', {
        callback = function()
            local trouble = require('trouble')
            if trouble.is_open('diagnostics') and #vim.diagnostic.get(0) == 0 then
                trouble.close('diagnostics')
            end
        end,
    })
end

return module
