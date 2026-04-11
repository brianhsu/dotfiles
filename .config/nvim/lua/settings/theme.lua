local module = {}

function module.configure()
    vim.opt.number = true
    vim.opt.list = true
    vim.opt.listchars = { tab = vim.g.tab_symbol, trail = '·' }

    vim.g.seoul256_background = 234
    vim.cmd('silent! colorscheme seoul256')

    vim.o.winborder = 'rounded'
    vim.o.updatetime = 500
    vim.api.nvim_create_autocmd("CursorHold", {
        callback = function ()
            local _, winid = vim.diagnostic.open_float(nil, {focus = false})
            if winid then
                vim.wo[winid].winblend = 15
            end
        end
    })

end

return module
