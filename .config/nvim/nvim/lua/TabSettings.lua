function tabAsSpaces()
    vim.opt.tabstop=8
    vim.opt.softtabstop=4
    vim.opt.shiftwidth=4
    vim.opt.expandtab=true
end

function tabAsTabs()
    vim.opt.tabstop=8
    vim.opt.softtabstop=0
    vim.opt.shiftwidth=8
    vim.opt.expandtab=false
end

vim.api.nvim_create_user_command("TabAsSpaces", tabAsSpaces, {})
vim.api.nvim_create_user_command("TabAsTabs", tabAsTabs, {})

tabAsSpaces()

