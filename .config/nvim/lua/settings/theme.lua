local module = {}

function module.configure()
    vim.opt.number = true
    vim.opt.list = true
    vim.opt.listchars = { tab = '⭾_', trail = '·' }

    vim.g.seoul256_background = 234
    vim.cmd('silent! colorscheme seoul256')
end

return module
